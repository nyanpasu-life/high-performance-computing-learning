
#include <stdio.h>
#include <cmath>

#define KERNEL_SIZE 3   // change this to kernel size
#define TILE_SIZE 5
#define BLOCK_SIZE ( TILE_SIZE + (KERNEL_SIZE-1) )

__constant__ float Mc[KERNEL_SIZE][KERNEL_SIZE][KERNEL_SIZE];

__global__ 
void MatrixConv(float* N, float* P, int x, int y, int z)
{   
    int tx = threadIdx.x, ty = threadIdx.y, tz = threadIdx.z; 
    int y_o = blockIdx.y*TILE_SIZE + ty;
    int x_o = blockIdx.x*TILE_SIZE + tx;
    int z_o = blockIdx.z*TILE_SIZE + tz;

    int move_size = (KERNEL_SIZE -1) / 2;
    int x_i = x_o - move_size, y_i = y_o - move_size, z_i = z_o - move_size;

    float output = 0.0f;
    __shared__ float Ns[TILE_SIZE+KERNEL_SIZE-1][TILE_SIZE+KERNEL_SIZE-1][TILE_SIZE+KERNEL_SIZE-1];


    if((x_i >= 0) && (x_i < x) && (y_i >= 0) && (y_i < y) && (z_i >= 0) && (z_i < z)) {
        Ns[tz][ty][tx] = N[z_i*y*x + y_i*x + x_i];
    }
    else {
        Ns[tz][ty][tx] = 0.0f;
    }
    __syncthreads();
    
    if(ty < TILE_SIZE && tx < TILE_SIZE && tz < TILE_SIZE){
        for(int k = 0; k < KERNEL_SIZE; k++) {
            for(int i = 0; i < KERNEL_SIZE; i++) {
                for(int j = 0; j < KERNEL_SIZE; j++) {
                    output += Mc[k][i][j] * Ns[k+tz][i+ty][j+tx];
                }
            }
        }
        // some threads do not write output
        if (y_o < y && x_o < x && z_o < z) {
            P[z_o*y*x + y_o*x + x_o] = output;
        }
    }
    
}

void verification(const float *P, const char* sample_file) {
    int x, y, z, idx=0;
    float n;
    bool equal = true;
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
            equal = false;
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

int main(int argc, char** argv) {
    float time_ms = 0;
    cudaEvent_t t1, t2;
    int z, y, x;
    float n;
    float *h_N, *h_M, *h_P;
    float *N, *P;
    int kernel_size;

    if(argc != 5) {
        fprintf(stderr, "%s", "Execution Error. Command example : \
                './matconv [input] [kernel] [output] [sample]'.\n\n");
        return 1;
    }

    //read input file
    FILE *input = fopen(argv[1], "r");
    fscanf(input, "%d %d %d", &z, &y, &x);
    // printf("z:%d, y:%d, x:%d\n",z ,y, x);

    h_N = (float*)malloc(sizeof(float)* z*y*x);
    int idx=0;
    while (fscanf(input, "%f ", &n) == 1) {
        h_N[idx++] = n;
    }

    //read kernel
    FILE *kernel = fopen(argv[2], "r");
    fscanf(kernel, "%d", &kernel_size);
    // printf("kernel size:%d\n", kernel_size);
    h_M = (float*)malloc(sizeof(float)* kernel_size * kernel_size * kernel_size);
    idx = 0;
    while (fscanf(kernel, "%f ", &n) == 1) {
        h_M[idx++] = n;
    }

    //malloc
    h_P = (float*)malloc(sizeof(float)* z*y*x);
    cudaMalloc((void**)&N, sizeof(float) * z*y*x);
    cudaMalloc((void**)&P, sizeof(float) * z*y*x);
    cudaMemcpy(N, h_N, sizeof(float) * z*y*x, cudaMemcpyHostToDevice);
    cudaMemset(P, 0, sizeof(float)* z*y*x);
    cudaMemcpyToSymbol(Mc, h_M, sizeof(float) * kernel_size*kernel_size*kernel_size);

    //execute convolution
    dim3 dimGrid(
        ceil(x/(TILE_SIZE*1.0)), 
        ceil(y/(TILE_SIZE*1.0)), 
        ceil(z/(TILE_SIZE*1.0)));
    dim3 dimBlock(BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);

    //measure time
    cudaEventCreate(&t1);
	cudaEventCreate(&t2);
    
    cudaEventRecord(t1, 0);
    MatrixConv<<<dimGrid, dimBlock>>>(N, P, x, y, z);
    cudaEventRecord(t2, 0);

	cudaEventSynchronize(t2);
	cudaEventElapsedTime(&time_ms, t1, t2);

    cudaMemcpy(h_P, P, sizeof(float) * z*y*x, cudaMemcpyDeviceToHost);

    //write output file
    FILE *output = fopen(argv[3], "w");
    fprintf(output, "%d %d %d ", z, y, x);
    for(int i=0; i<z; i++) {
        for(int j=0; j<y; j++) {
            for(int k=0; k<x; k++) {
                fprintf(output, "%.6f ", h_P[i*y*x + j*x + k]);
            }
        }
    }
    verification(h_P, argv[4]);
    printf("CUDA GPU execution time : %.5f ms\n\n", time_ms);

    cudaFree(N); cudaFree(P);
    free(h_N); free(h_M); free(h_P);
    fclose(input); fclose(kernel); fclose(output);

    cudaError_t err = cudaGetLastError();
    if(cudaSuccess != err)
        printf("*cudaErr(%d): %s \n",err,cudaGetErrorString(err));
    return 0;
}