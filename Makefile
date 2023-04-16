test : test.c
	gcc test.c -lfftw3 -lm -lsndfile -o test -Os -march=corei7-avx

correl : correl.c Makefile
	gcc correl.c -lm -lsndfile -o correl -O3 -fopenmp -march=corei7-avx


geom : geom.c Makefile
	gcc geom.c -lm -lsndfile -o geom -O3 -fopenmp -march=corei7-avx
