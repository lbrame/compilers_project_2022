%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

    // Lex/Yacc-specific declarations
    extern int yyparse();
    extern int yylex();
    int yyerror(const char *s);

    // Abstract Syntax Tree
    typedef struct AbstractSyntaxTree {
        char* string;
        struct AbstractSyntaxTree *left;
        struct AbstractSyntaxTree *right;
    } AbstractSyntaxTree;

    // Functions to handle the AST
    void ast_print(AbstractSyntaxTree *tree);
    struct AbstractSyntaxTree *ast_create();
    void ast_init(AbstractSyntaxTree *ast);
    void ast_add_child(
        AbstractSyntaxTree *ast,
        AbstractSyntaxTree *left_child,
        AbstractSyntaxTree *right_child
    );

%}

%define parse.error verbose
%start input

%union{
    char *string;
    struct AbstractSyntaxTree *ast;
}

%type <ast> E T F

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

/*
Print contents of AST. By default, this is to stdout, unless redirected.
**/
void ast_print(AbstractSyntaxTree *tree) {
    printf("TODO");
}

/**
Creates the abstract syntax tree
*/
struct AbstractSyntaxTree *ast_create() {
    struct AbstractSyntaxTree *ast;
    ast = ((AbstractSyntaxTree *)malloc(sizeof(AbstractSyntaxTree)));
    return ast;
}

/**
Initializes an existing AbstractSyntaxTree node to empty values
Needed to avoid garbage in memory!
*/
void ast_init(AbstractSyntaxTree *ast) {
    ast->string = "";
    ast->left = NULL;
    ast->right = NULL;
}

/**
Creates a new empty subtree and returns it
*/
struct AbstractSyntaxTree* ast_new_node(char* string) {
    struct AbstractSyntaxTree *ast = ast_create();
    ast_init(ast);
    return ast;
}

/**
Adds left and right child nodes to an AST
*/
void ast_add_child(
        AbstractSyntaxTree *ast,
        AbstractSyntaxTree *left_child,
        AbstractSyntaxTree *right_child
    )
{
    ast->left = left_child;
    ast->right = right_child;
}

/**
Prints error related to the parsing process to stderr
*/
int yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

void main() {
    yyparse();
}
