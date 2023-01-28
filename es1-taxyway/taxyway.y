%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

    int yylex();
    int yyparse();
    int yyerror(const char *s);
%}

%define parse.error verbose

%%

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s)
}

void main() {
    yyparse();
}