#Project 2. 3D matrix convolution with AVX and CUDA

###About
This project is about 3D matrix convolution program with AVX and CUDA. 
You can test 3 different ways of calculating convolution with 5 sample data. : using single threaded AVX, multi threaded AVX, and CUDA GPU.

The output file will be saved at test directory.
ex) ./sample/test1/output_single.txt

The 'sample' directory must be in the same directory as the source code.
Before you test 'test3' or 'test4', you have to change the value 'KERNEL_SIZE' to 5 in 'matconv.cu' file. In other tests, the value of 'KERNEL_SIZE' should be 3.

You can change the number of threads when testing multi threaded AVX, to change the value of 'THREADS_NUM' in 'Makefile'.

###Command
* to build
```
make
```
* to execute
```
make test1    //test1, 'KERNEL_SIZE' should be 3
make test2    //test2, 'KERNEL_SIZE' should be 3
make test3    //before this, you have to change the value 'KERNEL_SIZE' to 5 in 'matconv.cu'
make test4    //before this, you have to change the value 'KERNEL_SIZE' to 5 in 'matconv.cu'
make test5    //test5, 'KERNEL_SIZE' should be 3

/*--- test other samples ---*/
//avx
./matconv_avx [input] [kernel] [output] [sample output] [threads num]

//gpu, after change the value of 'KERNEL_SIZE'
./matconv_gpu [input] [kernel] [output] [sample output]
```
* to clean (including output files)
```
make clean
```
###Info
201521032 Han Taehui
201720733 Shin Seungheon