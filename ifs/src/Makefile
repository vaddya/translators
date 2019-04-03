all: clean yacc lex c

yacc: ifs.y
	yacc -vd ifs.y
	
lex: ifs.l
	lex ifs.l

c: *.c
	gcc -o ifs.o *.c

clean:
	rm -f y.* *.o

