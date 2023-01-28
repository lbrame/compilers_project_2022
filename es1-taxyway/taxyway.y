%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

    int yylex();
    int yyparse();
    void yyerror(const char *s);
%}

%define parse.error verbose
%start lines

%union{
    int number;
    char* string;
}

%token <number> TOK_NUMBER;
%token <string> TOK_DIRECTION;

%%

lines : line lines
| line
;

line : expr'\n'
;

expr : command expr
| command
;

command : TOK_DIRECTION TOK_NUMBER
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

void main() {
    yyparse();
}
