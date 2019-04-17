%{
	#include "y.int.h"
%}
%%

[A-Z]+ {yylval.str = strdup(yytext); return tOPE;}
[0-9]+ {yylval.nb = atoi(yytext); return tNB;}
" " {}
"\t" {}
"\n" {}

. {return tERR;}
