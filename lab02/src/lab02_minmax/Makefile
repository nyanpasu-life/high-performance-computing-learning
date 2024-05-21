all: minmax_ispc.o minmax_ispc.asm minmax_ispc.h main.o minmax

minmax_ispc.o : minmax.ispc
	ispc minmax.ispc -o minmax_ispc.o

minmax_ispc.asm: minmax.ispc
	ispc minmax.ispc -o minmax_ispc.asm --emit-asm

minmax_ispc.h: minmax.ispc
	ispc minmax.ispc -h minmax_ispc.h


main.o: main.cpp
	g++ -c main.cpp -o main.o

minmax: main.o minmax_ispc.o
	g++ main.o minmax_ispc.o -o minmax





clean:
	rm *.o ; rm *.asm ; rm minmax ; rm minmax_ispc.h
