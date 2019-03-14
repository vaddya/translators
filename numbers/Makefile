all: lex c

lex: numbers.l
	lex -o numbers.c numbers.l

c: numbers.c
	gcc numbers.c -o numbers.o

clean:
	rm *.c *.o
	git checkout yy.c

cleanall: clean
	rm *.out
