    int lineno = 0;
%%
\n  lineno++;
.   ;
%%

#ifndef yywrap
int yywrap() { return( 1 ); }
#endif

void main() { 
    while( yylex() ); 
    printf( "%d lines\n", lineno );    
}

