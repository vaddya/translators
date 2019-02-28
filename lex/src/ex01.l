%%
^[ \t]+    ;
%%

#ifndef yywrap
int yywrap() { return 1; }
#endif    

void main() { while (yylex()); }

