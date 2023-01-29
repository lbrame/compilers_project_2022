%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define XSTART 0
#define YSTART 0
#define XEND 5
#define YEND 6

    // Lex-Yacc specific function declarations
    int yylex();
    int yyparse();
    void yyerror(const char *s);

    // Custom functions
    void move(char *direction, int movement);
    void validate();
    void suggest_new_path();

    // Coordinates of the previous position
    // Initialized to the starting point
    int x_start = XSTART;
    int y_start = YSTART;

    // Coordinates of the destination
    int x_end = XEND;
    int y_end = YEND;
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

line : expr'\n'                         { validate(); }
;

expr : command expr
| command
;

command : TOK_DIRECTION TOK_NUMBER      { move($1, $2); }
;

%%

/**
Only called when final path is not reached.
Tries to suggest a couple of moves that would bring the player to
the expected end point.
*/
void suggest_new_path() {
    printf(" \033[0;31m");
    printf("Perhaps, you could add the following moves next time to reach the destination:\n");
    printf("\033[0m");

    if (x_start < x_end) {
        printf("RIGHT %d ", x_end - x_start);
    }
    else if (x_start > x_end) {
        printf("LEFT %d ", x_start - x_end);
    }
    
    if (y_start < y_end) {
        printf("UP %d ", y_end - y_start);
    }
    else if (y_start > y_end) {
        printf("DOWN %d ", y_start - y_end);
    }

    printf("\n");
}

/**
Check if player has moved from starting point to expected end point
*/
void validate() {
    if (x_start == x_end && y_start == y_end) {
        printf("\033[1;32m");
        printf("Correct!\n");
        printf("\033[0m");
        exit(EXIT_SUCCESS);
    } else {
        printf(" \033[1;31m");
        printf("Wrong path! You did not reach destination (%d; %d).\nYou are at: (%d; %d)\n",
            x_end, y_end, x_start, y_start);
        printf("\033[0m");
        suggest_new_path();
        exit(EXIT_FAILURE);
    }
}

/**
Move the player from the starting point to the command parsed
by yacc
*/
void move (char *direction, int movement) {
    if (!strcmp(direction, "up") || !strcmp(direction, "UP")) {
        y_start += movement;
    }
    else if (!strcmp(direction, "down") || !strcmp(direction, "DOWN")) {
        y_start -= movement;
    }
    else if (!strcmp(direction, "right") || !strcmp(direction, "RIGHT")) {
        x_start += movement;
    }
    else if (!strcmp(direction, "left") || !strcmp(direction, "LEFT")) {
        x_start -= movement;
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

void main() {
    yyparse();
}
