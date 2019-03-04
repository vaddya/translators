all: lex c

lex: $(file).l
	lex -o $(file).c $(file).l

c: $(file).c
	gcc $(file).c -o $(file).o

clean:
	rm *.c *.o

cleanall: clean
	rm *.out
