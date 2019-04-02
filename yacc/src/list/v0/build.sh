rm -f y.* a.out lex.yy.c
yacc -vtd $1.y
lex -s $2.l
cc *.c

