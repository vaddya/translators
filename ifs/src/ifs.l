%{
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}

A [A-Za-z_]
L [0-9A-Za-z_]

%%
if        { return IF; }
[+\-/\*]  { yylval.text = strdup(yytext); return OP; }
[0-9]+    { yylval.text = strdup(yytext); return NUM; }
{A}{L}+   { yylval.text = strdup(yytext); return ID; }
[ \t\n]   ;
.         { return yytext[0]; }
%%

#ifndef yywrap
int yywrap () { return 1; }
#endif

