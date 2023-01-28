%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include "y.tab.h"
%}

%%

[ \t\r]

\n                      { return '\n'; }

%%
