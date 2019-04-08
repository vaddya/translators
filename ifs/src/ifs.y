%{
#include <stdlib.h>
#include <stdio.h>

int yylex();
void yyerror(char *);
void push(int);
int pop();

int size = 0;
int stack[100];
int tcount = 1;
int lcount = 1;

%}

%union
{
   int   ival;
   char* text;
};

%token <text> NUM
%token <text> ID
%left <text> OP
%token IF
%type <text> expr
%start statements

%%
statements: statement
	  | statement statements  ;

statement: if
	 | assignment  ;

if: IF '(' expr ')' start statements end { /*printf("if: %d\n", $3)*/; }

start: '{'  { push(lcount++); printf("ZJ T%d L%d\n", tcount - 1, lcount - 1); }

end: '}'  { int i = pop(); printf("L%d:\n", i); }

assignment: ID '=' expr ';' { printf("T%d: = %s %s\n", tcount++, $1, $3); }

expr: NUM           { $$ = $1; }
    | expr OP expr  {
        char *buffer = (char *) malloc(sizeof(char) * 4);
        sprintf(buffer, "T%d", tcount++);
        $$ = buffer;
        printf("%s: %s %s %s\n", $$, $2, $1, $3); 
    }
%%

void push(int i) {
    stack[size++] = i;
}

int pop() {
    return stack[--size];
}


