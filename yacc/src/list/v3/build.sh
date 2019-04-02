rm -f y.* a.out lex.yy.c
yacc -vtd c.y
lex -s c.l
cc *.c

