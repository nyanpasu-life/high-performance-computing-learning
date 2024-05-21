#include "glife.h"
using namespace std;

int gameOfLife(int argc, char *argv[]);
void sequentialGen(int);
void* workerThread(void *);
int nprocs;
GameOfLifeGrid* g_GameOfLifeGrid;

uint64_t dtime_usec(uint64_t start)
{
  timeval tv;
  gettimeofday(&tv, 0);
  return ((tv.tv_sec*USECPSEC)+tv.tv_usec)-start;
}

GameOfLifeGrid::GameOfLifeGrid(int rows, int cols, int gen)
{
  m_Generations = gen;
  m_Rows = rows;
  m_Cols = cols;

  m_Grid = (int**)malloc(sizeof(int*) * rows);
  if (m_Grid == NULL) 
    cout << "1 Memory allocation error " << endl;

  m_Temp = (int**)malloc(sizeof(int*) * rows);
  if (m_Temp == NULL) 
    cout << "2 Memory allocation error " << endl;

  m_Grid[0] = (int*)malloc(sizeof(int) * (cols*rows));
  if (m_Grid[0] == NULL) 
    cout << "3 Memory allocation error " << endl;

  m_Temp[0] = (int*)malloc(sizeof(int) * (cols*rows));	
  if (m_Temp[0] == NULL) 
    cout << "4 Memory allocation error " << endl;

  for (int i = 1; i < rows; i++) {
    m_Grid[i] = m_Grid[i-1] + cols;
    m_Temp[i] = m_Temp[i-1] + cols;
  }

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      m_Grid[i][j] = m_Temp[i][j] = 0;
    }
  }
}

// Entry point
int main(int argc, char* argv[])
{
  if (argc != 7) {
    cout <<"Usage: " << argv[0] << " <input file> <display> <nprocs>"
           " <# of generation> <width> <height>" << endl;
    cout <<"\n\tnprocs = 0: Running sequentiallyU" << endl;
    cout <<"\tnprocs =1: Running on a single thread" << endl;
    cout <<"\tnprocs >1: Running on multiple threads" << endl;
    cout <<"\tdisplay = 1: Dump results" << endl;
    return 1;
  }

  return gameOfLife(argc, argv);
}

int gameOfLife(int argc, char* argv[])
{
  int cols, rows, gen;
  ifstream inputFile;
  int input_row, input_col, display;
  uint64_t difft;
  pthread_t *threads;

  inputFile.open(argv[1], ifstream::in);

  if (inputFile.is_open() == false) {
    cout << "The "<< argv[1] << " file can not be opend" << endl;
    return 1;
  }

  display = atoi(argv[2]);
  nprocs = atoi(argv[3]);
  gen = atoi(argv[4]);
  cols = atoi(argv[5]);
  rows = atoi(argv[6]);

  g_GameOfLifeGrid = new GameOfLifeGrid(rows, cols, gen);

  while (inputFile.good()) {
    inputFile >> input_row >> input_col;
    if (input_row >= rows || input_col >= cols) {
      cout << "Invalid grid number" << endl;
      return 1;
    } else
      g_GameOfLifeGrid->setCell(input_row, input_col);
  }

  // Start measuring execution time
  difft = dtime_usec(0);

  // <README!!!!> 구현 용어 재정의: single thread의 호칭이 애매모호. pthread를 사용하지 않는 구현은 sequential version, (함수이름 sequentialGen)
  //  Pthread를 하나만 호출하는 경우 (nprocs==1인 경우도) parallel version (함수이름 workerThread) 로 간주.
  //  강의노트에서 주어진 것과 동일한 개념이지만 헷갈리는 호칭만 재정의.

  if (nprocs == 0) {
    // Running with your sequential version
    sequentialGen(gen);

  } else if (nprocs >0) {
    // Running multiple threads (pthread), (include single thread.)
    threads = (pthread_t*) malloc (sizeof(pthread_t)*nprocs);
    int width = rows*cols / nprocs;
    int margin = rows*cols % nprocs;
    int from=-1, to=-1;

    pthread_barrier_t wait_c_alloc;
    pthread_barrier_t wait_f_alloc;
    pthread_barrier_init(&wait_c_alloc, NULL, nprocs);
    pthread_barrier_init(&wait_f_alloc, NULL, nprocs);

    for(int i=0;i<nprocs;i++){
      from = to+1;
      to = from + width -1;
      if(i<margin) { to +=1;} //남은 부분이 양의 정수인 경우, 0부터 margin-1 까지의 thread가 1개 cell의 연산을 추가로 분담한다.

      struct workerThreadArg threadArg; //스레드 인자값 설정
      threadArg.from = from;
      threadArg.to = to;
      threadArg.gen = gen;
      threadArg.wait_cal = &wait_c_alloc;
      threadArg.wait_flush = &wait_f_alloc;

      pthread_create(&threads[i], NULL, workerThread, (void*)&threadArg);
    }

    for(int i=0;i<nprocs;i++){
      pthread_join(threads[i], NULL);
    }
    free(threads);

  } else { 
    // nprocs <0 is error
    return 1;

  }

  difft = dtime_usec(difft);

  // Print indices only for running on CPU(host).
  if (display) {
    g_GameOfLifeGrid->dump();
    g_GameOfLifeGrid->dumpIndex();
  }


  cout << "Execution time(seconds): " << difft/(float)USECPSEC << endl;

  inputFile.close();
  cout << "Program end... " << endl;
  return 0;
}

// TODO: YOU NEED TO IMPLMENT SINGLE THREAD
void sequentialGen(int gen)
{
    for(int g=0;g<gen;g++){
      g_GameOfLifeGrid->next();
      g_GameOfLifeGrid->flushGrid();
    }
}

// TODO: YOU NEED TO IMPLMENT PTHREAD
void* workerThread(void *arg)
{
  struct workerThreadArg * realArg = (struct workerThreadArg *)arg;
  int from = realArg->from;
  int to = realArg->to;
  int gen = realArg->gen;
  pthread_barrier_t * wait_c = realArg->wait_cal;
  pthread_barrier_t * wait_f = realArg->wait_flush;

  for(int i=0;i<gen;i++){
    g_GameOfLifeGrid->next(from, to); //각 스레드별 연산
    
    pthread_barrier_wait(wait_c); //모든 스레드가 연산이 종료될때까지 대기.

    if(from==0){ //0번 스레드가 flush (switch main and temp) 를 담당.
      g_GameOfLifeGrid->flushGrid();
    }

    pthread_barrier_wait(wait_f); //모든 스레드가 0번 스레드가 flush를 종료할때까지 대기.
  }

}

// HINT: YOU MAY NEED TO FILL OUT BELOW FUNCTIONS OR CREATE NEW FUNCTIONS
void GameOfLifeGrid::next(const int from, const int to)
{
  int i = from / m_Cols; int j = from % m_Cols;
  int f = from;
  while(f<=to){
    int nei = getNumOfNeighbors(i,j);
    if( (isLive(i,j)&&nei==2) || nei==3 ){ live(i, j); }
    else                                 { dead(i, j); }

    f++;
    j++;
    if(j==m_Cols) { j=0; i++; }
  }
}

void GameOfLifeGrid::next()
{
  for(int i=0;i<getRows(); i++){
    for(int j=0;j<getCols();j++){
      int nei = getNumOfNeighbors(i,j);
      if( (isLive(i,j)&&nei==2) || nei==3 ){ live(i, j); }
      else                                 { dead(i, j); }
    }
  }
}

// TODO: YOU MAY NEED TO IMPLMENT IT TO GET NUMBER OF NEIGHBORS 
int GameOfLifeGrid::getNumOfNeighbors(int rows, int cols)
{
  int numOfNeighbors = 0;


  if(rows>=1        && cols>=1        && isLive(rows-1, cols-1)){numOfNeighbors ++;}
  if(rows>=1        &&                   isLive(rows-1, cols  )){numOfNeighbors ++;}
  if(rows>=1        && cols<=m_Cols-2 && isLive(rows-1, cols+1)){numOfNeighbors ++;}
  if(                  cols>=1        && isLive(rows, cols-1))  {numOfNeighbors ++;}
  if(                  cols<=m_Cols-2 && isLive(rows, cols+1))  {numOfNeighbors ++;}
  if(rows<=m_Rows-2 && cols>=1        && isLive(rows+1, cols-1)){numOfNeighbors ++;}
  if(rows<=m_Rows-2 &&                   isLive(rows+1, cols))  {numOfNeighbors ++;}
  if(rows<=m_Rows-2 && cols<=m_Cols-2 && isLive(rows+1, cols+1)){numOfNeighbors ++;}

  return numOfNeighbors;
}

void GameOfLifeGrid::dump() 
{
  cout << "===============================" << endl;

  for (int i = 0; i < m_Rows; i++) {
    cout << "[" << i << "] ";
    for (int j = 0; j < m_Cols; j++) {
      if (m_Grid[i][j] == 1)
        cout << "*";
      else
        cout << "o";
    }
    cout << endl;
  }
  cout << "===============================\n" << endl;
}

void GameOfLifeGrid::dumpIndex()
{
  cout << ":: Dump Row Column indices" << endl;
  for (int i=0; i < m_Rows; i++) {
    for (int j=0; j < m_Cols; j++) {
      if (m_Grid[i][j]) cout << i << " " << j << endl;
    }
  }
}
