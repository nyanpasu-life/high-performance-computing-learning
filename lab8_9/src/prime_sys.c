#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <time.h>
#include <stdlib.h>

#define MAX_NUM 100000
#define NR_my_syscall 548

void array_init_rand(int * array, int size);

int main(int argc, char** argv) {

	srand(time(NULL));

    int NSIZE = 1;

    int param_opt=0;
    while(-1 !=(param_opt = getopt(argc, argv, "n:"))){
		switch(param_opt){
			case 'n' : NSIZE = atoi(optarg);
		}
	}

    int * arr = malloc(sizeof(int)*NSIZE);
    array_init_rand(arr, NSIZE);

    struct timeval start;
    struct timeval end;

	int prime_count =0;
	gettimeofday(&start, NULL); //-----------------------------
	prime_count = syscall(NR_my_syscall, arr, NSIZE);
	gettimeofday(&end, NULL); //-----------------------------
	

	printf("The number of total random numbers: %d\n", NSIZE);
    printf("The number of Prime number %d\n", prime_count);
    
	if (end.tv_sec - start.tv_sec >0){
		double diffTime = ( end.tv_sec - start.tv_sec ) +(( end.tv_usec - start.tv_usec )/1000000.0);
		printf("Processing time: %lf sec\n", diffTime);
	}
	else{
		long long diffTime = end.tv_usec - start.tv_usec;
		printf("Processing time: %lld usec\n", diffTime);
	}

    free(arr);
	return 0;
}

void array_init_rand(int * matrix, int size){

	for(int i=0;i<size;i++){
		matrix[i] = rand() % (MAX_NUM-1) + 2;
	}
}