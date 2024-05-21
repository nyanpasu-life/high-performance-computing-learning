
#define threads num for avx multi-threads
THREADS_NUM = 5

single = ./matconv_avx ./sample/$@/input.txt ./sample/$@/kernel.txt ./sample/$@/output_single.txt ./sample/$@/output.txt 1
multi = ./matconv_avx ./sample/$@/input.txt ./sample/$@/kernel.txt ./sample/$@/output_multi.txt ./sample/$@/output.txt ${THREADS_NUM}
gpu = ./matconv_gpu ./sample/$@/input.txt ./sample/$@/kernel.txt ./sample/$@/output_gpu.txt ./sample/$@/output.txt

default: matconv_avx matconv_gpu

matconv_avx : main.c
	gcc -mavx2 -pthread main.c -o matconv_avx

matconv_gpu : matconv.cu
	nvcc matconv.cu -o matconv_gpu

test1 : matconv_gpu matconv_avx
	@${single}
	@${multi}
	@${gpu}

test2 : matconv_gpu matconv_avx
	@${single}
	@${multi}
	@${gpu}

test3 : matconv_gpu matconv_avx
	@${single}
	@${multi}
	@${gpu}

test4 : matconv_gpu matconv_avx
	@${single}
	@${multi}
	@${gpu}

test5 : matconv_gpu matconv_avx
	@${single}
	@${multi}
	@${gpu}

clean :
	rm matconv_* ./sample/test*/output_*