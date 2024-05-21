#include "sinx_ispc.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <x86intrin.h>

void sinx(int N, int terms, float x[], float y[]);

int main(int argc, char** argv) {
    int MODE=0;
    int N = 1024;
    int terms = 5;

    int param_opt;
    
    while(-1 !=(param_opt = getopt(argc, argv, "n:"))){
		switch(param_opt){
			case 'n' : N = atoi(optarg);
		}
	}
    printf("\n\nN size: %d\n", N);
    
    float* x = new float[N];
    float* result = new float[N];
    
    long long int start = 0;
    long long int end = 0;

    start = __rdtsc();
    ispc::interleaved_sinx(N, terms, x, result);
    end = __rdtsc();
    printf("interleaved cylcetime: %lld\n", end - start);


    start = __rdtsc();
    ispc::blocked_sinx(N, terms, x, result);
    end = __rdtsc();
    printf("blocked cylcetime: %lld\n", end - start);

    start = __rdtsc();
    sinx(N, terms, x, result);
    end = __rdtsc();
    printf("scalar cylcetime: %lld\n", end - start);


    return 0;
}


void sinx(int N, int terms, float x[], float y[] )
{
    for (int i=0; i<N; i++)
    {
        float value = x[i];
        float numer = x[i] * x[i] * x[i];
        int denom = 6; //3!
        int sign = -1;
        for (int j=1; j<=terms; j++)
        {
            value += sign * numer / denom;
            numer *= x[i] * x[i];
            denom *= (2*j+2) * (2*j+3);
            sign *= -1;
        }
        y[i] = value;
    }

    
}