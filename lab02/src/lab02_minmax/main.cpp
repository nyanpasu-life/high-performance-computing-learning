#include "minmax_ispc.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <immintrin.h>
#include <x86intrin.h>
#include <time.h>

void matrix_init_rand(float * matrix1, float * matrix2, float * matrix3, float * matrix4, int size);
float sequentialmin(float * array, int size);
float sequentialmax(float * array, int size);

int main(int argc, char** argv) {
    srand((unsigned)time(NULL) );
    int N = 1024;

    int param_opt;
    while(-1 !=(param_opt = getopt(argc, argv, "n:"))){
		switch(param_opt){
			case 'n' : N = atoi(optarg);
		}
	}
    printf("\n\nN size: %d\n", N);

    float* x1 = new float[N];
    float* x2 = new float[N];
    float* x3 = new float[N];
    float* x4 = new float[N];

    long long int start;
    long long int end;
    float * a, b;

    matrix_init_rand(x1, x2, x3, x4, N);
    
    start = __rdtsc();
    float result = ispc::parallelmin(x1, N);
    end = __rdtsc();
    printf("Vector min result: %f, cyclie:%lld\n", result, end-start);

    start = __rdtsc();
    result = sequentialmin(x2, N);
    end = __rdtsc();
    printf("Scalar min  result: %f, cyclie:%lld\n", result, end-start);
    
    start = __rdtsc();
    result = ispc::parallelmax(x3, N);
    end = __rdtsc();
    printf("Vector max result: %f, cyclie:%lld\n", result, end-start);

    start = __rdtsc();
    result = sequentialmax(x4, N);
    end = __rdtsc();
    printf("Scalar max result: %f, cyclie:%lld\n\n\n", result, end-start);



    return 0;
}

void matrix_init_rand(float * matrix1, float * matrix2, float * matrix3, float * matrix4, int size){

	for(int i=0;i<size;i++){
		matrix1[i] = ((float) ((rand()%1000000) -500000)) / 1000.0 ;
        matrix2[i] = matrix1[i];
        matrix3[i] = matrix1[i];
        matrix4[i] = matrix1[i];
		//matrix[i] = 3.1; //for debug
	}
}


float sequentialmin(float * array, int size){
    for(int i=1;i<size;i++){
        if(array[i] < array[0]){
            array[0] = array[i];
        }
    }
    return array[0];

}

float sequentialmax(float * array, int size){
    for(int i=1;i<size;i++){
        if(array[i] > array[0]){
            array[0] = array[i];
        }
    }
    return array[0];

}