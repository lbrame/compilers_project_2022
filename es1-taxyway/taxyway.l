%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include "y.tab.h"
%}

%%

^[1-9][0-9]*$           { yylval.number = atoi(yytext); return NUMBER;
                          /* Match a single positive int and then end of line */}

UP|up                   { yylval.string = yytext; return DIR_UP; }

DOWN|down               { yylval.string = yytext; return DIR_DOWN; }

RIGHT|right             { yylval.string = yytext; return DIR_RIGHT; }

LEFT|left               { yylval.string = yytext; return DIR_LEFT; }

[ \t\r]

\n                      { return '\n'; }

%%
