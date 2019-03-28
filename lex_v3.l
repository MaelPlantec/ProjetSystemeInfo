%{
	#include "y.tab.h"
%}
%%
"main" {return tMAIN;}
"{" {return tACCO;}
"}" {return tACCF;}
"const" {return tCONST;}
"int" {return tINT;}
"printf" {return tPTF;}

"if" {return tIF;}
"while" {return tWHILE;}
"else" {return tELSE;}

[a-zA-Z][a-zA-Z0-9_]* {yylval.str = strdup(yytext); return tID;}
[0-9]+ {yylval.nb = atoi(yytext); return tNB;}

"+" {return tPLUS;}
"-" {return tMOINS;}
"*" {return tMUL;}
"/" {return tDIV;}
"=" {return tEGAL;}
"<" {return tINF;}
">" {return tSUP;}
"<=" {return tINFEG;}
">=" {return tSUPEG;}
"(" {return tPARO;}
")" {return tPARF;}
"" {}

" " {}
"\t" {}
"\n" {}

"," {return tVIRG;}
";" {return tPV;}

. {return tERR;}
