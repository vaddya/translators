%{
#include <stdlib.h>
#include <stdio.h>

int yylex();
void yyerror(char *);

int line = 1;
%}

%union
{
   int   ival;
   char* text;
};


%token <ival> NUM
%token <text> ID
%type <ival> list
%type <ival> sublist
%start lists

%%
lists: list             ;
     | list '\n' lists  
{
    printf("No. of items in line %d from from end: %d\n", line++, $1); 
}

list:                { $$ = 0; }
    | NUM            { $$ = 1; }
    | sublist        { $$ = $1; }
    | list ',' list  { $$ = $1 + $3; }
  

sublist:  '(' ID ':' list ')' 
{ 
    $$ = $4; 
    printf("No. of items in sublist \"%s\": %d\n", $2, $4);
    free($2);
}
%%


