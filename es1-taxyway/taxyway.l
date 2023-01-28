%{
#include <stdio.h>
#include <string.h>

#include "y.tab.h"
%}

DIRECTION "UP"|"up"|"DOWN"|"down"|"RIGHT"|"right"|"LEFT"|"left"

%%

exit                    { exit(0); }

[0-9]+           { yylval.number = atoi(yytext); return TOK_NUMBER; }

{DIRECTION}             { yylval.string = strndup(yytext, yyleng); return TOK_DIRECTION; }


[ \t\r]

\n                      { return '\n'; }
.                       { return yytext[0]; }

%%
