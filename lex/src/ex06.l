%%
(.)+    { 
            printf(">%s\n", yytext); 
            if (yyleng > 1) yyless(yyleng/2); 
        }
%%

#include "yy.c"

