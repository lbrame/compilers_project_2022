%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

    int yylex();
    int yyparse();
    void yyerror(const char *s);
%}

%define parse.error verbose

%token DIR_UP DIR_DOWN DIR_RIGHT DIR_LEFT

%union{
    int number;
    char* string;
}

%token <number> NUMBER;

%%

commands:
| commands command
;

command: direction NUMBER'\n'
;

direction: DIR_UP'\n' | DIR_DOWN'\n' | DIR_LEFT'\n' | DIR_RIGHT'\n'
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

void main() {
    yyparse();
}