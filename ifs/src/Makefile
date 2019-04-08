all: clean yacc lex c

yacc: ifs.y
	yacc -vd ifs.y
	
lex: yacc ifs.l
	lex ifs.l

c: yacc lex *.c
	gcc -o ifs.o *.c

clean:
	rm -f y.* *.o lex.yy.c ifs.c

