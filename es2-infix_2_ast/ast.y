%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

    // Lex/Yacc-specific declarations
    extern int yyparse();
    extern int yylex();
    int yyerror(const char *s);
    extern FILE* yyin;

    // Abstract Syntax Tree
    typedef struct AbstractSyntaxTree {
        char* string;
        struct AbstractSyntaxTree *left;
        struct AbstractSyntaxTree *right;
    } AbstractSyntaxTree;

    // Functions to handle the AST
    void ast_print(AbstractSyntaxTree *ast, int indent);
    char *allocate(char *string);
    struct AbstractSyntaxTree* ast_create(char* string);
    void ast_append(
        AbstractSyntaxTree *ast,
        AbstractSyntaxTree *left_child,
        AbstractSyntaxTree *right_child
    );
    void ast_clean(AbstractSyntaxTree *ast);

%}

%define parse.error verbose
%start input

%union{
    char *string;
    struct AbstractSyntaxTree *ast;
}

/* NUMBER is a string and not an integer. We do not need to actually
perform a calculation, just
- Parse a valid infix calculator input
- Convert it to an Abstract Syntax tree
*/
%token <string> NUMBER

%type <ast> E T F

%%

input : E'\n'           { ast_print($1,0);
                          printf("\n");
                          ast_clean($1);
                          exit(EXIT_SUCCESS); }
;

E : E '+' T             { $$ = ast_create("+"); ast_append($$, $1, $3); }
| E '-' T               { $$ = ast_create("-"); ast_append($$, $1, $3); }
| T                     { $$ = $1; }
;

T : T '*' F             { $$ = ast_create("*"), ast_append($$, $1, $3); }
| T '/' F               { $$ = ast_create("/"), ast_append($$, $1, $3); }
| T '%' F               { $$ = ast_create("%"), ast_append($$, $1, $3); }
| F                     { $$ = $1; }
;

F : NUMBER              { $$ = ast_create($1); }
| '-' F                 { $$ = ast_create("(-)"), ast_append($$, $2, NULL); }
| '+' F                 { $$ = ast_create("(+)"), ast_append($$, $2, NULL); }
| '('E')'               { $$ = $2; }
;

%%

/*
Print contents of AST. By default, this is to stdout, unless redirected.
**/
void ast_print(AbstractSyntaxTree *ast, int indent) {    
    int i = 0;

    // print current indent level
    for (i = 0; i < indent; i++) printf("\t");
    
    // visit node
    printf("%s", ast->string);

    // visit left subtree
    if (ast->left != NULL) {
        printf("\n");
        ast_print(ast->left, indent+1);
    }

    // visit right subtree
    if (ast->right != NULL) {
        printf("\n");
        ast_print(ast->right, indent+1);
    }
}

/**
Statically allocates memory for a string in such a way that there is enough memory to store
the string and its null-terminator, and then returns the pointer.
It is meant to be used for the string field of an AbstractSyntaxTree, which requires
properly allocated memory to work.
*/
char *allocate(char *string) {
    return strcpy((char *)malloc(strlen(string)+1), string);
}

/**
Creates a new abstract syntax tree initialized with an input string
and with no children, then returns it
*/
struct AbstractSyntaxTree* ast_create(char* string) {
    struct AbstractSyntaxTree *ast;
    ast = ((AbstractSyntaxTree *)malloc(sizeof(AbstractSyntaxTree)));

    ast->string = allocate(string);
    ast->left = NULL;
    ast->right = NULL;
    
    return ast;
}

/**
Adds left and right children subtrees to a node ast.
C does not supprot optional arguments. Please pass NULL to the corresponding child if
you only want to add the other.
*/
void ast_append(
        AbstractSyntaxTree *ast,
        AbstractSyntaxTree *left_child,
        AbstractSyntaxTree *right_child
    )
{
    ast->left = left_child;
    ast->right = right_child;
}

/**
Be polite and free up the allocated memory that isn't needed anymore ;)
Visits the tree with a Depth-First Search algorithm to free up every node.
*/
void ast_clean(AbstractSyntaxTree *ast) {
    if (ast != NULL) {
        ast_clean(ast->right);
        free(ast->string);
        ast_clean(ast->left);
        free(ast);
    }
}

/**
Prints error related to the parsing process to stderr
*/
int yyerror(const char *s) {
    fprintf(stderr, "Parsing error: %s\n", s);
}

void main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
    }
    else {
        printf("Nothing passed to command line, reading from stdin:\n");
        yyin = stdin;
    }

    yyparse();
}
