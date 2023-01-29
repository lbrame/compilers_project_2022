%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

    // Lex/Yacc-specific declarations
    extern int yyparse();
    extern int yylex();
    int yyerror(const char *s);

    // Abstract Syntax Tree
    typedef struct ast {
        char* node;
        int nchild;
        struct ast *left;
        struct ast *right;
    } ast;

    // Functions to handle the AST
    void ast_print();
    void ast_init();
    void ast_add_child();

%}

%define parse.error verbose
%start input

%union{
    char *string;
}

/* NUMBER is a string and not an integer. We do not need to actually
perform a calculation, just
- Parse a valid infix calculator input
- Convert it to an Abstract Syntax tree
*/
%token <string> NUMBER

%%

input : E'\n'
;

E : E '+' T
| E '-' T
| T
;

T : T '*' F
| T '/' F
| T '%' F
| F
;

F : NUMBER
| '-' F
| '+' F
| '('E')'
;

%%

/**
Outputs the AST. Unless redirected, it will print to stdout.
*/
void ast_print() {

}

/**
Initializes the AST into memory
*/
void ast_init() {

}

/**
Adds a child note to the AST
*/
void ast_add_child() {

}

/**
Prints error related to the parsing process to stderr
*/
int yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

void main(int argc, char *argv[]) {
    yyparse();
}
