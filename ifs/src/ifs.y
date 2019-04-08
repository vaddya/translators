%{
#include <stdlib.h>
#include <stdio.h>

#define STACK_SIZE 100

int yylex();
void yyerror(char *);
void push(int);
int pop();

int size = 0;
int stack[STACK_SIZE];
int tcount = 1;
int lcount = 1;
char *last;
%}

%union {
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

if: IF '(' expr ')' start statements end  ;

if: IF '(' ')'  {
    fprintf(stderr, "Empty condition!\n");
    exit(1);
}

if: IF '(' expr ')' statements  { 
    fprintf(stderr, "Braces are required!\n");
    exit(1);
}

start: '{'  { 
    push(lcount++);
    printf("JZ %s L%d\n", last, lcount - 1);
}

end: '}'  { 
    int i = pop();
    printf("L%d:\n", i);
}

assignment: ID '=' expr ';'  { 
    printf("T%d: = %s %s\n", tcount++, $1, $3); 
}

expr: NUM           { $$ = last = $1; }
    | expr OP expr  {
        char *buffer = (char *) malloc(sizeof(char) * 5);
        sprintf(buffer, "T%d", tcount++);
        $$ = last = buffer;
        printf("%s: %s %s %s\n", $$, $2, $1, $3); 
    }
%%

void push(int i) {
    if (size >= STACK_SIZE) {
        fprintf(stderr, "StackOverflow\n");
        exit(1);
    } 
    stack[size++] = i;
}

int pop() {
    if (size <= 0) {
        fprintf(stderr, "Stack is empty!\n");
        exit(1);
    }
    return stack[--size];
}


