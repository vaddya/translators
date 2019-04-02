%token NUM
%start lists

%%
lists: list             ;
     | list '\n' lists  { printf("No. of items: %d\n", $1); }

list:                   { $$ = 0; }
    | NUM               { $$ = 1; }
    | NUM ',' list      { $$ = 1 + $3; }
%%


