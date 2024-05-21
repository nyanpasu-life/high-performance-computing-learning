all: sinx_ispc.o sinx_ispc.asm sinx_ispc.h main.o sinx

sinx_ispc.o : sinx.ispc
	ispc sinx.ispc -o sinx_ispc.o

sinx_ispc.asm: sinx.ispc
	ispc sinx.ispc -o sinx_ispc.asm --emit-asm

sinx_ispc.h: sinx.ispc
	ispc sinx.ispc -h sinx_ispc.h


main.o: main.cpp
	g++ -c main.cpp -o main.o

sinx: main.o sinx_ispc.o
	g++ main.o sinx_ispc.o -o sinx





clean:
	rm *.o ; rm *.asm ; rm sinx ; rm sinx_ispc.h
