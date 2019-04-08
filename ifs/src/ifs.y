%{
#include <stdlib.h>
#include <stdio.h>

#define STACK_SIZE 100

int yylex();
void yyerror(char *);
int push(int);
int pop();

int size = 0;
int stack[STACK_SIZE];
int tcount = 1;
int lcount = 1;
char *last;
%}

%union { char *text; };
%token <text> NUM
%token <text> ID
%token IF
%left <text> OP
%type <text> expr
%start statements

%%

statements: statement
          | statement statements ;

statement: branch
         | assignment ;

branch: IF '(' expr ')' start statements end ;
      | IF '(' ')' { yyerror("Empty condition!"); }
      | IF '(' expr ')' statement { yyerror("Braces are required!"); }

start: '{' { printf("JZ %s L%d\n", last, push(lcount++)); }

end: '}' { printf("L%d:\n", pop()); }

assignment: ID '=' expr ';' { printf("T%d: = %s %s\n", tcount++, $1, $3); }

expr: NUM { $$ = last = $1; }
    | expr OP expr {
        char *buffer = (char *) malloc(sizeof(char) * 5);
        sprintf(buffer, "T%d", tcount++);
        $$ = last = buffer;
        printf("%s: %s %s %s\n", $$, $2, $1, $3); 
    }
%%

int push(int i) {
    if (size >= STACK_SIZE) {
        fprintf(stderr, "StackOverflow\n");
        exit(1);
    } 
    return stack[size++] = i;
}

int pop() {
    if (size <= 0) {
        fprintf(stderr, "Stack is empty!\n");
        exit(1);
    }
    return stack[--size];
}


