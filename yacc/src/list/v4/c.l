%{
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}

A [A-Za-z_]
L [0-9A-Za-z_]

%%
[0-9]+    { yylval.ival = atoi(yytext); return NUM; }
{A}+{L}+  { yylval.text = strdup(yytext); return ID; }
[ \t]     ;
.|\n      { return yytext[0]; }
%%

#ifndef yywrap
int yywrap () { return 1; }
#endif

