#include <iostream>
#include <fstream>
#include <pthread.h>
#include <stdlib.h>
#include <sys/time.h>
#include <unistd.h>

#define LIVE 1
#define DEAD 0
#define DISPLAY 0
#define USECPSEC 1000000ULL

// HINT: YOU CAN ADD MORE MEMBERS IF YOU NEED
class GameOfLifeGrid {
public:
	GameOfLifeGrid(int rows, int cols, int gen);
	
	void next();
	void next(const int from, const int to);
	
	int isLive(int rows, int cols) { return (m_Grid[rows][cols] ? LIVE : DEAD); }
	int getNumOfNeighbors(int rows, int cols);
	
	void dead(int rows, int cols) { m_Temp[rows][cols] = 0; }
	void live(int rows, int cols) { m_Temp[rows][cols] = 1; }

	int decGen() { return m_Generations--; }
	void setGen(int n) { m_Generations = n; }
	void setCell(int rows, int cols) { m_Grid[rows][cols] = true; }
	
	void dump();
	void dumpIndex();
	int* getRowAddr(int row) { return m_Grid[row]; }
	int* getAddr(int ind) { return m_Grid[0]+ind; }

	int getCols() { return m_Cols; }
	int getRows() { return m_Rows; }
	int getGens() { return m_Generations; }

    int** getGrid() { return m_Grid; }

    void flushGrid() {
		int ** tmp = m_Grid;
		m_Grid = m_Temp;
		m_Temp = tmp;
    }
  

private:
	int** m_Grid;
	int** m_Temp;
	int m_Rows;
	int m_Cols;
	int m_Generations;

};
uint64_t runCUDA(int rows, int cols, int gen, 
             GameOfLifeGrid* g_GameOfLifeGrid, int display);
uint64_t dtime_usec(uint64_t start);


struct workerThreadArg{
	int from;
	int to;
	int gen;
	pthread_barrier_t * wait_cal;
	pthread_barrier_t * wait_flush;
	
};
