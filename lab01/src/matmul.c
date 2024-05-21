#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <immintrin.h>
#include <time.h>
#include <x86intrin.h>

void seq_mulmat(float * target, float * A, int A_size, int Aysize, float *B, int Bxsize, int Bysize);
void parall_mulmat(float * C, float * A, int Axsize, int Aysize, float *B, int Bxsize, int Bysize);
int compare_matrix(float * matrix1, float * matrix2, int totalsize);
void print_matrix(float * matrix, int x, int y);
void print_m256i(__m256 target);
void matrix_init_rand(float * matrix, int size);
void matrix_init_zero(float * matrix, int size);


int main(int argc, char** argv){
	int MODE =0;
	int TEST_IN=0;
	int An = 4; int Am = 4;
	int Bn = 4; int Bm = 4; //n is x(raw), m is y(col)
	int param_opt;

	while(-1 !=(param_opt = getopt(argc, argv, "v:t:"))){
		switch(param_opt){
			case 'v' : MODE = atoi(optarg);
		}
		switch(param_opt){
			case 't' : TEST_IN = atoi(optarg);
		}
	}
	if(TEST_IN >0){
		An = TEST_IN; Am=TEST_IN; Bn=TEST_IN; Bm = TEST_IN;
	}

	float * A = aligned_alloc(32, sizeof(float) * An*Am);
	float * B = aligned_alloc(32, sizeof(float) * Bn*Bm + 8);
	float * C = aligned_alloc(32, sizeof(float) * Am*Bn);
	
	srand((unsigned)time(NULL) );
	matrix_init_rand(A, An*Am);
	matrix_init_rand(B, Bn*Bm);
	matrix_init_zero(C, Bn*Am);
	
	long long int start; long long int end;

	if(MODE ==1){
		start = __rdtsc();
		parall_mulmat(C, A, An, Am, B, Bn, Bm);
		end = __rdtsc();
		printf("excution cycle: %lld\n", end - start);
	}
	
	if(MODE ==0){
		start = __rdtsc();
		seq_mulmat(C, A, An, Am, B, Bn, Bm);
		end = __rdtsc();
		printf("excution cycle: %lld\n", end - start);
	}

	if(MODE ==2){
		
		parall_mulmat(C, A, An, Am, B, Bn, Bm);
		float * D = aligned_alloc(32, sizeof(float) * Am*Bn);
		seq_mulmat(D, A, An, Am, B, Bn, Bm);

		printf("-----A matrix: \n");
		print_matrix(A, An, Am);
		printf("-----B matrix: \n"); 
		print_matrix(B, Bn, Bm);

		printf("--Vector out matrix: \n");
		print_matrix(C, Bn, Am);
		
		printf("--Scalar out matrix: \n");
		print_matrix(D, Bn, Am);
		
		printf("validation result: ");
		if(compare_matrix(C, D, Bn*Am) == 1){
			printf("True\n");
		}
		else{
			printf("False\n");
		}

		free(D);
	}
	
	free(A); free(B); free(C);

}

void seq_mulmat(float * C, float * A, int Axsize, int Aysize, float *B, int Bxsize, int Bysize){
	
	for(int Ay=0; Ay<Aysize; Ay++){
		for (int Ax=0;Ax<Axsize;Ax++){
			float Avalue = A[Ay*Axsize + Ax];
			for(int Bx=0;Bx<Bxsize;Bx++){
				C[(Ay)*Bxsize + Bx] += Avalue * B[(Ax)*Bxsize + Bx];
			}
		}
	}	
	
}


void parall_mulmat(float * C, float * A, int Axsize, int Aysize, float *B, int Bxsize, int Bysize){
	int margin = Bxsize%8;
	for(int Ay=0;Ay<Aysize;Ay++){
		for (int Ax=0;Ax<Axsize;Ax++){
			__m256 first = _mm256_broadcast_ss((const float *) & A[Ay*Axsize + Ax]);
		
			for (int Bx=0;Bx<Bxsize;Bx+=8){
				__m256 second = _mm256_loadu_ps(& B[Ax*Bxsize + Bx]);
				__m256 muled = _mm256_mul_ps(first,second);
				__m256 temp = _mm256_loadu_ps(&C[Ay*Bxsize + Bx]);
				__m256 added = _mm256_add_ps(temp, muled);

				if(Bx+8 < Bxsize){
					_mm256_storeu_ps(&C[ (Ay*Bxsize) +Bx ] , added);
				}
				else{
					float * nyanpasu = aligned_alloc(32, sizeof(float) * 8);
					_mm256_storeu_ps(nyanpasu, added);
					for(int i=0;i<margin;i++){
						C[(Ay*Bxsize) + Bx + i] = nyanpasu[i];
					}
				}

			}
			
		}
	}
}


void print_m256(__m256 target){
	float * ar = aligned_alloc(32, sizeof(float) * 8);
      	_mm256_storeu_ps(ar, target);
	print_matrix(ar, 8,1);
	target = _mm256_loadu_ps(ar);
	free(ar);
}

void matrix_init_rand(float * matrix, int size){

	for(int i=0;i<size;i++){
		matrix[i] = (float) ((rand()%1000) -500) / 100.0 ;
		//matrix[i] = 3.1; //for debug
	}
}

void matrix_init_zero(float * matrix, int size){
	for(int i=0;i<size;i++){
		matrix[i] = 0.0;
	}
}


	
int compare_matrix(float * matrix1, float * matrix2, int totalsize){
	for (int i=0; i<totalsize;i++){
		if(matrix1[i] != matrix2[i]){
			return 	0;
		}
	}
	return 1;
}
void print_matrix(float * matrix, int x, int y){
	for (int i=0;i<y;i++){
		for (int j=0;j<x;j++){
			printf("%f ", matrix[i*x + j]);	
		}
		printf("\n");
	}
}
