%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "y.tab.h"
%}

/* Lex declarations */
WHITESPACE  [ \t\r]
NUMBER [0-9]+[1-9]*

%%

exit                    { exit(EXIT_SUCCESS); }

{NUMBER}                { yylval.string = strndup(yytext, yyleng);
                          return NUMBER; }

{WHITESPACE}

\n                      { return '\n'; }

.                       { return yytext[0]; }

%%
