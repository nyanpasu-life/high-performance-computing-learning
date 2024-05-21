#include <stdio.h>
#include <math.h>
#include <immintrin.h>
#include <x86intrin.h>
#include <pthread.h>

#include <sys/time.h> 
// #include <time.h>
//#include <stdint.h>

#define USECPMSEC 1000ULL
#define USECPSEC 1000000ULL
int DIV = 5;

void print_matrix(float * matrix, int x, int y);
void cpu_conv3d(float *inputArr, float *kernel, float *outputArr, int Depths, int Rows, int Columns, int kernelwidth);
void thread_conv3d(float *inputArr, float *kernelArr, float *outputArr,
			int Depths, int Rows, int Columns, int kernelwidth, int div);
void print_m256(__m256 target);

void * conv3d_runnable(void* voidarg);

typedef struct __Arg{
	float *inputArr, *outputArr;
	__m256 * kernelVectors;
	int Depths, z_from, z_to;
	int Rows, y_from, y_to;
	int Columns, x_from, x_to;
	int kernelwidth, pad, tempiter, tempsize;
} ThreadArg;

void verification(const float *P, const char* sample_file) {
    int x, y, z, idx=0;
    float n;
    int equal = 1;
    FILE *sample = fopen(sample_file, "r");
    fscanf(sample, "%d %d %d", &z, &y, &x);

	while (equal) {
        if(idx == x*y*z) break;
        if(fscanf(sample, "%f ", &n) != 1) {
            printf("Error while verification!\n");
            fclose(sample);
            return;
        }
        if(fabs((double)(P[idx++] - n)) > 0.0001) {
            equal = 0;
        }
    }

	if (equal) {
		printf("Results are equal!\n");
	}
	else {
		printf("Results are NOT equal!\n");
	}
    fclose(sample);
	return;
}

int main (int argc, char **argv){
    int z, y, x, kernel_size;
    float n;

    //read input file
    FILE *input = fopen(argv[1], "r");
    fscanf(input, "%d %d %d", &z, &y, &x);

    float *inputarr = (float*)malloc(sizeof(float)* z*y*x);
	float *outputarr = (float*)malloc(sizeof(float)* z*y*x);

    int idx=0;
    while (fscanf(input, "%f ", &n) == 1) {
        inputarr[idx++] = n;
    }
	
    
    //read kernel
    FILE *kernel = fopen(argv[2], "r");
    fscanf(kernel, "%d", &kernel_size);
    float *kernelarr = (float*)malloc(sizeof(float)* kernel_size * kernel_size * kernel_size);
    int idx2=0;
    while (fscanf(kernel, "%f ", &n) == 1) {
        kernelarr[idx2++] = n;
    }

	// #define DIV 5
	DIV = atoi(argv[5]);
	//measure time 
	struct timeval start, end;
	long secs_used,micros_used;
	gettimeofday(&start, NULL);
		
	if(DIV == 1) {
		cpu_conv3d(inputarr, kernelarr, outputarr, z, y, x, kernel_size);
	}
	else if(DIV > 1) {
		thread_conv3d(inputarr, kernelarr, outputarr, z, y, x, kernel_size, DIV);
	}
	else {
		printf("thread number error!\n");
	}
	gettimeofday(&end, NULL);
	secs_used=(end.tv_sec - start.tv_sec);
    micros_used= ((secs_used*1000000) + end.tv_usec) - (start.tv_usec);

    //write output file
    FILE *output = fopen(argv[3], "w");
	
    fprintf(output, "%d %d %d ", z, y, x);
    for(int i=0; i<idx; i++) {
        fprintf(output, "%f ", outputarr[i]);
    }

	verification(outputarr, argv[4]);

	if(DIV == 1) printf("single thread avx execution time : %.5f ms\n\n", micros_used/1000.0);
	else printf("%d multi-threads avx execution time : %.5f ms\n\n", DIV, micros_used/1000.0);

    free(inputarr); free(kernelarr); free(outputarr);
    fclose(input); fclose(kernel); fclose(output);

   return 0;   
}

void cpu_conv3d(float *inputArr, float *kernelArr, float *outputArr, int Depths, int Rows, int Columns, int kernelwidth) {

	//inputarr의 정보를 담을 temparr를 준비한다.
	int total_kernel_size = kernelwidth * kernelwidth * kernelwidth;
	//int tempiter = ceil(total_kernel_size/(8.0));
	int tempiter = total_kernel_size / 8;
	if(total_kernel_size % 8 != 0) tempiter++;
	int tempsize = tempiter * 8;
	float * temparr = (float *) aligned_alloc(32, sizeof(float) * tempsize);
	
	//커널을 벡터로 쪼갠다.
	__m256 * kernelVectors = (__m256 *) aligned_alloc(256, sizeof(float) * tempsize);
	for(int i=0;i<tempiter;i++){
		kernelVectors[i] = _mm256_loadu_ps(&kernelArr[i*8]);
	}
	
	//처음 3개의 반복문은 커널의 이동 (으로 인해 커널의 0,0,0 좌표와 만나는 지점) 을 의미한다.
	int pad = ((kernelwidth - 1) / 2);
	for (int z=0;z<Depths;z++){
		int out_z_move = z*Rows*Columns;
		for (int y=0;y<Rows;y++) {
			int out_y_move = y*Columns;
			for (int x=0;x<Columns;x++) {	
				//temparr에 커널 연산에 필요한 값을 넣는다.
				int counter =0;
				for (int kz = 0;kz<kernelwidth;kz++){
					int now_z = z-pad+kz;
					int z_move = now_z*Rows*Columns;
					for (int ky = 0;ky<kernelwidth;ky++){
						int now_y = y-pad+ky;
						int y_move = now_y*Columns;
						for (int kx = 0;kx<kernelwidth;kx++){
							int now_x = x-pad+kx;

							if(0<=now_x && now_x<Columns && 0<=now_y && now_y<Rows && 0<=now_z && now_z<Depths)
								temparr[counter] = inputArr[z_move + y_move + now_x];
							else{
								temparr[counter] = 0;
							}
							counter ++;
						}
					}
				}

				//temparr를 벡터로 쪼개고 커널벡터와 곱셈을 한다음, 결과를 다시 tempArr에 저장한다.
				for(int i=0;i<tempiter;i++){
					float * p = &temparr[i*8];
					__m256 m256Temp = _mm256_loadu_ps(p);
					_mm256_storeu_ps(p, _mm256_mul_ps(kernelVectors[i],m256Temp));
				}
				
				//인풋과 커널과의 곱셈들이 들어있는 temparr의 모든 값을 더해서 아웃풋에 저장한다.
				float sum = 0;
				for(int i=0;i<tempsize;i++){
					sum += temparr[i];
				}
				outputArr[out_z_move + out_y_move + x] = sum;
			}
		}
	}
	
	
	free(kernelVectors);
	free(temparr);
	return;
}

void thread_conv3d(float *inputArr, float *kernelArr, float *outputArr,
			int Depths, int Rows, int Columns, int kernelwidth, int div) {
	int total_kernel_size = kernelwidth * kernelwidth * kernelwidth;
	int tempiter = total_kernel_size / 8;
	if(total_kernel_size % 8 != 0) tempiter++;
	int tempsize = tempiter * 8;

	__m256 * kernelVectors = (__m256 *) aligned_alloc(256, sizeof(float) * tempsize);
	for(int i=0;i<tempiter;i++){
		kernelVectors[i] = _mm256_loadu_ps(&kernelArr[i*8]);
	}
	int pad = ((kernelwidth - 1) / 2);

	int div_width = Depths/div;
	pthread_t * threads = malloc(sizeof(pthread_t)* div);

	int from = -div_width; int to = 0;
	for(int i=0;i<div;i++){
		from = from+div_width;
		to = to+div_width;
		if(i<Depths%div) {to+=1;}

		// printf("from:%d,  to:%d \n",from, to);
		if(i+div_width > Depths) { to = Depths;}

		
		ThreadArg * arg = malloc(sizeof(ThreadArg));
		arg->inputArr = inputArr, arg->outputArr = outputArr, arg->kernelVectors = kernelVectors;
		arg->z_from = from, arg->z_to = to, arg->Depths = Depths, arg->Rows = Rows, arg->Columns = Columns;
		arg->kernelwidth = kernelwidth, arg->pad = pad, arg->tempiter = tempiter, arg->tempsize = tempsize;
		

		pthread_create(&threads[i], NULL, conv3d_runnable, (void*)arg);
  	}
	
	
	for(int i=0;i<div;i++){
		pthread_join(threads[i], NULL);
  	}
	


	free(threads);
	free(kernelVectors);
		
}

void * conv3d_runnable(void* voidarg) {
	ThreadArg * arg = (ThreadArg*) voidarg;
	float * inputArr= arg->inputArr, *outputArr=arg->outputArr;
	__m256 * kernelVectors = arg->kernelVectors;
	int Depths = arg->Depths, z_from=arg->z_from, z_to=arg->z_to;
	int Rows=arg->Rows, Columns=arg->Columns;
	int kernelwidth=arg->kernelwidth, pad=arg->pad, tempiter=arg->tempiter, tempsize=arg->tempsize;
	//printf("%d is args address\n", arg);
	free(arg);

	float * temparr = (float *) aligned_alloc(32, sizeof(float) * tempsize);
	
	//처음 3개의 반복문은 커널의 이동 (으로 인해 커널의 0,0,0 좌표와 만나는 지점) 을 의미한다.
	for (int z=z_from;z<z_to;z++){
		int out_z_move = z*Rows*Columns;
		for (int y=0;y<Rows;y++) {
			int out_y_move = y*Columns;
			for (int x=0;x<Columns;x++) {	
				//temparr에 커널 연산에 필요한 값을 넣는다.
				int counter =0;
				for (int kz = 0;kz<kernelwidth;kz++){
					int now_z = z-pad+kz;
					int z_move = now_z*Rows*Columns;
					for (int ky = 0;ky<kernelwidth;ky++){
						int now_y = y-pad+ky;
						int y_move = now_y*Columns;
						for (int kx = 0;kx<kernelwidth;kx++){
							int now_x = x-pad+kx;

							if(0<=now_x && now_x<Columns && 0<=now_y && now_y<Rows && 0<=now_z && now_z<Depths)
								temparr[counter] = inputArr[z_move + y_move + now_x];
							else
								temparr[counter] = 0;
							
							counter ++;
						}
					}
				}

				//temparr를 벡터로 쪼개고 커널벡터와 곱셈을 한다음, 결과를 다시 tempArr에 저장한다.
				for(int i=0;i<tempiter;i++){
					float * p = &temparr[i*8];
					__m256 m256Temp = _mm256_loadu_ps(p);
					_mm256_storeu_ps(p, _mm256_mul_ps(kernelVectors[i],m256Temp));
				}
				
				//인풋과 커널과의 곱셈들이 들어있는 temparr의 모든 값을 더해서 아웃풋에 저장한다.
				float sum = 0;
				for(int i=0;i<tempsize;i++){
					sum += temparr[i];
				}
				outputArr[out_z_move + out_y_move + x] = sum;
			}
		}
	}

	free(temparr);
}

void print_matrix(float * matrix, int x, int y){
	for (int i=0;i<y;i++){
		for (int j=0;j<x;j++){
			printf("%f ", matrix[i*x + j]);	
		}
		printf("\n");
	}
}

void print_m256(__m256 target){
	float * ar = aligned_alloc(32, sizeof(float) * 8);
      	_mm256_storeu_ps(ar, target);
	print_matrix(ar, 8,1);
	target = _mm256_loadu_ps(ar);
	free(ar);
}