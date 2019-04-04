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
%token IF
%left '+' '-' '*' '/'
%type <ival> expr
%start statements

%%
statements: statement
	  | statement statements  ;

statement: if
	 | assignment  ;

if: IF '(' expr ')' '{' statements '}' { printf("if: %d\n", $3); }

assignment: ID '=' expr ';' { printf("\"%s\" = %d\n", $1, $3); }

expr: NUM            { $$ = $1; }
    | expr '+' expr  { $$ = $1 + $3; }
    | expr '-' expr  { $$ = $1 - $3; }
    | expr '*' expr  { $$ = $1 * $3; }
    | expr '/' expr  { $$ = $1 / $3; }
%%

