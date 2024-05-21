#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <cmath>
#include <sys/time.h>
#include <stdint.h>

#define USECPMSEC 1000ULL
#define USECPSEC 1000000ULL
#define TILE_SIZE 10
#define KERNEL_SIZE 3
#define BLOCK_SIZE ( TILE_SIZE + (KERNEL_SIZE-1) )

__constant__ float Mc [KERNEL_SIZE][KERNEL_SIZE]; //커널

__global__ void Conv2D(float* P, float* N, int hegiht, int width);
void verification(const float *N, const float *M, const float *P, int Rows, int Columns);
void matrix_init_rand(float * matrix, int x, int y);
void print_matrix(float * matrix, int x, int y);



int main (int argc, char **argv){
    srand((unsigned)time(NULL) );
    int rows, columns;
    rows = atoi(argv[1]);
    columns = atoi(argv[2]);
    size_t ARRSIZE = sizeof(float)*rows*columns;
    size_t KSIZE = sizeof(float)*KERNEL_SIZE*KERNEL_SIZE;
    
    //호스트 메모리에 인풋, 아웃풋 공간 할당 및 값 입력
    float * intputArr = (float*) malloc(ARRSIZE);
    float * outputArr = (float*) malloc(ARRSIZE);
    matrix_init_rand(intputArr, rows, columns);
    memset(outputArr, 0.0, ARRSIZE);
    
    //GPU 메모리에 인풋, 아웃풋 공간 할당 및 카피
    float * cu_inputArr, * cu_outputArr;
    cudaMalloc((void**)&cu_inputArr, ARRSIZE);
    cudaMalloc((void**)&cu_outputArr, ARRSIZE);
    cudaMemcpy(cu_inputArr, intputArr, ARRSIZE, cudaMemcpyHostToDevice);
    cudaMemcpy(cu_outputArr, outputArr, ARRSIZE, cudaMemcpyHostToDevice);

    //커널 할당 및 값 입력. (최종적으로 __CONST__ 변수 Mc에 할당)
    float * kernel;
    kernel = (float*) malloc(KSIZE);
    matrix_init_rand(kernel, KERNEL_SIZE, KERNEL_SIZE);
    float * cu_temp;
    cudaMalloc((void**)&cu_temp, KSIZE);
    cudaMemcpy(cu_temp, kernel, KSIZE, cudaMemcpyHostToDevice);
    cudaMemcpyToSymbol(Mc, cu_temp, KSIZE);
    cudaFree(cu_temp);

    //int BLOCK_SIZE = TILE_SIZE + (KERNEL_SIZE – 1);
    dim3 dimGrid( ceil(columns/(TILE_SIZE*1.0)), ceil(rows/(TILE_SIZE*1.0)), 1);
    dim3 dimBlock(BLOCK_SIZE, BLOCK_SIZE);
    Conv2D<<<dimGrid, dimBlock>>>(cu_outputArr, cu_inputArr, columns, rows);
    cudaDeviceSynchronize();
    
    cudaMemcpy(outputArr, cu_outputArr, ARRSIZE, cudaMemcpyDeviceToHost);

    verification(intputArr, kernel, outputArr, rows, columns);
    //N: 인풋 데이터 //M: 커널 //P: CUDA 연산 결과
    
    free(outputArr); free(intputArr);
    free(kernel);
    cudaFree(cu_inputArr); cudaFree(cu_outputArr);
    
    cudaError_t err = cudaGetLastError();
    if(cudaSuccess != err)
        printf("*cudaErr(%d): %s \n",err,cudaGetErrorString(err));
    return 0;
    
    
}

__global__ void Conv2D(float* P, float* N, int hegiht, int width){
    int tx = threadIdx.x;
    int ty = threadIdx.y;
    int row_o = blockIdx.y * TILE_SIZE + ty;
    int col_o = blockIdx.x * TILE_SIZE + tx;

    int row_i = row_o - ((KERNEL_SIZE - 1) / 2);
    int col_i = col_o - ((KERNEL_SIZE - 1) / 2);

    float output = 0.0f;
    __shared__ float Ns[TILE_SIZE+KERNEL_SIZE-1][TILE_SIZE+KERNEL_SIZE-1];
    if((row_i >= 0) && (row_i < hegiht) && (col_i >= 0) && (col_i < width))
        Ns[ty][tx] = N[row_i*width + col_i];
    else
        Ns[ty][tx] = 0.0f;

    __syncthreads();
    
    if(ty < TILE_SIZE && tx < TILE_SIZE){
        for(int i = 0; i < KERNEL_SIZE; i++)
            for(int j = 0; j < KERNEL_SIZE; j++)
                output += Mc[i][j] * Ns[i+ty][j+tx];

        if (row_o < hegiht && col_o < width)
        P[row_o * width + col_o] = output;
    }
    
}


void verification(const float *N, const float *M, const float *P, int Rows, int Columns) {
	int r, c, h, w;
	int row_i, col_i;
	bool equal;
	float* results;

	results = (float*)malloc(Rows * Columns * sizeof(float));
	memset(results, 0, Rows * Columns * sizeof(float));

	for (r = 0; r < Rows; r++) {
		for (c = 0; c < Columns; c++) {
			for (h = 0; h < KERNEL_SIZE; h++) {
				for (w = 0; w < KERNEL_SIZE; w++) {
					row_i = r - ((KERNEL_SIZE - 1) / 2) + h;
					col_i = c - ((KERNEL_SIZE - 1) / 2) + w;
					if ((row_i >= 0) && (row_i < Rows) && (col_i >= 0) && (col_i < Columns)) {
						results[r*Columns + c] += (M[h*KERNEL_SIZE + w] * N[row_i*Columns + col_i]);
					}
				}
			}
		}
	}

	equal = true;
	for (int i = 0; i < Rows * Columns && equal; i++) {
		if (abs(results[i] - P[i]) >= 0.001f) {
			equal = false;
			printf("NOT EQUAL!\n");
		}
	}

	if (equal) {
		printf("Results are equal!\n");
	}
	else {
		printf("Results are NOT equal!\n");
	}

	free(results);
	return;
}


void matrix_init_rand(float * matrix, int x, int y){
    int size = x*y;
	for(int i=0;i<size;i++){
		//matrix[i] = (float) ((rand()%1000) -500) / 100.0 ;
		matrix[i] = i; //for debug
	}
}

void print_matrix(float * matrix, int x, int y){
	for (int i=0;i<y;i++){
		for (int j=0;j<x;j++){
			printf("%f ", matrix[i*x + j]);	
		}
		printf("\n");
	}
}