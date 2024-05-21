#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <cmath>
#include <sys/time.h>
#include <stdint.h>

#define USECPMSEC 1000ULL
#define USECPSEC 1000000ULL

void matrix_init_rand(float * matrix, int x, int y);
__global__ void MatrixMulKernel(float* d_M, float* d_N, float* d_P, int M_row, int Mul_line, int N_col);
__global__ void MatrixTiledMulKernel(float* d_M, float* d_N, float* d_P, int M_row, int MUL_line, int N_col, int TILE_WIDTH);
void print_matrix(float * matrix, int x, int y);
uint64_t dtime_usec(uint64_t start);


int main (int argc, char **argv){
    srand((unsigned)time(NULL) );
    int M_row = 4; int MUL_line = 4; int N_col = 4;
    int TILE_WIDTH = 1;
    int EQUAL_MODE = 0;
    int TILE_CACHING_MODE = 0;
    int PRINT_MATRIX_MODE = 0;

    int param_num = 0;

    int param_opt;
    while(-1 !=(param_opt = getopt(argc, argv, "ntp"))){

	    switch(param_opt){
	        case 'n' : 
                EQUAL_MODE = 1;
                param_num ++;
                break;
            case 't' : 
                TILE_CACHING_MODE = 1;
                param_num ++;
                break;
            case 'p' :
                PRINT_MATRIX_MODE = 1;
                param_num ++;
                break;
		}
        
	}

    if(EQUAL_MODE ==0){
        M_row = atoi(argv[1+param_num]);
        MUL_line = atoi(argv[2+param_num]);
        N_col = atoi(argv[3+param_num]);
        if(argc ==5+param_num) TILE_WIDTH = atoi(argv[4+param_num]);
    }
    else{ //EQUAL_MODE ==1
        M_row = atoi(argv[1+param_num]);
        MUL_line = M_row;
        N_col = M_row;
        if(argc ==3+param_num) TILE_WIDTH = atoi(argv[2+param_num]);
    }

    float * M, *N, *P; // MN = P
    cudaHostAlloc((void**)&M, sizeof(float)*M_row*MUL_line, cudaHostAllocDefault);
    cudaHostAlloc((void**)&N, sizeof(float)*MUL_line*N_col, cudaHostAllocDefault);
    cudaHostAlloc((void**)&P, sizeof(float)*M_row*N_col, cudaHostAllocDefault);

    matrix_init_rand(M, M_row,MUL_line);
    matrix_init_rand(N, MUL_line,N_col);
    memset(P, 0.0, sizeof(float)*M_row*N_col);

    float * cu_M, * cu_N, * cu_P;
    cudaMalloc((void**)&cu_M, sizeof(float)*M_row*MUL_line);
    cudaMalloc((void**)&cu_N, sizeof(float)*MUL_line*N_col);
    cudaMalloc((void**)&cu_P, sizeof(float)*M_row*N_col);
    
    cudaMemcpy(cu_M, M, sizeof(float)*M_row*MUL_line, cudaMemcpyHostToDevice);
    cudaMemcpy(cu_N, N, sizeof(float)*MUL_line*N_col, cudaMemcpyHostToDevice);
    cudaMemcpy(cu_P, P, sizeof(float)*M_row*N_col, cudaMemcpyHostToDevice);

    if(PRINT_MATRIX_MODE ==1){
        printf("M Matrix:::\n");
        print_matrix(M, MUL_line, M_row);
        printf("\nN Matrix:::\n");
        print_matrix(N, N_col, MUL_line);
        printf("\n\n");
    }
    cudaFreeHost(M); cudaFreeHost(N);

    uint64_t difft = dtime_usec(0);
    if(TILE_CACHING_MODE ==1){
        dim3 dimGrid( ceil(N_col/(TILE_WIDTH*1.0)), ceil(M_row/(TILE_WIDTH*1.0)), ceil(MUL_line/(TILE_WIDTH*1.0)) );
        dim3 dimBlock(TILE_WIDTH, TILE_WIDTH, 1);
        MatrixTiledMulKernel<<<dimGrid, dimBlock, sizeof(float)*TILE_WIDTH*TILE_WIDTH*2>>>(cu_M, cu_N, cu_P, M_row, MUL_line, N_col, TILE_WIDTH);

    }
    else if(TILE_CACHING_MODE ==0){
        dim3 dimGrid(ceil(N_col/(TILE_WIDTH*1.0)),  ceil(M_row/(TILE_WIDTH*1.0)), 1 );
        dim3 dimBlock(TILE_WIDTH, TILE_WIDTH, 1);
        MatrixMulKernel<<<dimGrid,dimBlock>>>(cu_M, cu_N, cu_P, M_row, MUL_line, N_col);
    }
    cudaDeviceSynchronize();
    difft = dtime_usec(difft);

    cudaMemcpy(P, cu_P, sizeof(float)*M_row*N_col, cudaMemcpyDeviceToHost);

    if(PRINT_MATRIX_MODE ==1){
        printf("P Matrix:::\n");
        print_matrix(P, N_col, M_row);
    }
    else{ //print time only print matrix mode is deactivated.
        printf("GPU COMPUTE TIME(ms): %f\n", difft/(float)USECPMSEC);
    }
    
    cudaFreeHost(P); cudaFree(cu_M); cudaFree(cu_N); cudaFree(cu_P); 
    
    cudaError_t err = cudaGetLastError();
    if(cudaSuccess != err)
        printf("*cudaErr(%d): %s \n",err,cudaGetErrorString(err));
    return 0;
}

__global__ void MatrixTiledMulKernel(float* d_M, float* d_N, float* d_P, int M_row, int MUL_line, int N_col, int TILE_WIDTH)
{
    int local_col = threadIdx.x;
    int local_row = threadIdx.y;

    int Z = blockIdx.z*blockDim.z;
    int Col = blockIdx.x*blockDim.x+local_col;
    int Row = blockIdx.y*blockDim.y+local_row;

    extern __shared__ float sharedCache[];
    
    //캐시에 데이터 업로드
    int local_index = TILE_WIDTH*local_row + local_col;
    int arr_jump = TILE_WIDTH * TILE_WIDTH;
    int global_col = (Z*TILE_WIDTH) +local_col;
    int global_row = (Z*TILE_WIDTH) + local_row;


    sharedCache[local_index] = d_M[MUL_line * (Row) + global_col];
    sharedCache[arr_jump + local_index] = d_N[N_col* global_row + Col];

    __syncthreads();

    float Pvalue = 0;
    if ((Row < M_row) && (Col < N_col)) {

        for (int k = 0; k < TILE_WIDTH; ++k){

            if( (global_col + k > N_col) || (global_row + k > M_row)) break; 

            Pvalue += sharedCache[ local_row*TILE_WIDTH +k ] * sharedCache[ arr_jump + k*TILE_WIDTH + local_col];           
        }
    }

    atomicAdd(&d_P[Row*N_col+Col], Pvalue);
}

__global__ void MatrixMulKernel(float* d_M, float* d_N, float* d_P, int M_row, int Mul_line, int N_col)
{
    // Calculate the row index of the d_P element and d_M
    int Row = blockIdx.y*blockDim.y+threadIdx.y;
    // Calculate the column idenx of d_P and d_N
    int Col = blockIdx.x*blockDim.x+threadIdx.x;
    if ((Row < M_row) && (Col < N_col)) {
        float Pvalue = 0;
        // each thread computes one element of the block sub-matrix
            for (int k = 0; k < Mul_line; ++k)
                Pvalue += d_M[Row*Mul_line+k] * d_N[k*N_col+Col];
            d_P[Row*N_col+Col] = Pvalue;
    }
}


void matrix_init_rand(float * matrix, int x, int y){
    int size = x*y;
	for(int i=0;i<size;i++){
		matrix[i] = (float) ((rand()%1000) -500) / 100.0 ;
		//matrix[i] = i; //for debug
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

uint64_t dtime_usec(uint64_t start)
{
  timeval tv;
  gettimeofday(&tv, 0);
  return ((tv.tv_sec*USECPSEC)+tv.tv_usec)-start;
}
