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

[a-zA-Z][a-zA-Z0-9_]* {return tID;}
[0-9]+ {return tVAL;}

"+" {return tPLUS;}
"-" {return tMOINS;}
"*" {return tMUL;}
"/" {return tDIV;}
"=" {return tEGAL;}
"(" {return tPARO;}
")" {return tPARF;}

" " {}
"\t" {}
"\n" {}

"," {return tVIRG;}
";" {return tPV;}

. {return tERR;}

