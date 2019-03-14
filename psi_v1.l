%%
"main" {printf("tMAIN\n");}
"{" {printf("tACCO\n");}
"}" {printf("tACCF\n");}
"const" {printf("tCONST\n");}
"int" {printf("tINT\n");}
"printf" {printf("tPTF\n");}

[a-zA-Z][a-zA-Z0-9_]* {printf("tID:%s\n", yytext);}
[0-9]+ {printf("tVAL:%s\n", yytext);}

"+" {printf("tPLUS\n");}
"-" {printf("tMOINS\n");}
"*" {printf("tMUL\n");}
"/" {printf("tDIV\n");}
"=" {printf("tEGAL\n");}
"(" {printf("tPARO\n");}
")" {printf("tPARF\n");}

" " {}
"\t" {}
"\n" {}

"," {printf("tVIRG\n");}
";" {printf("tPV\n");}

.[a-zA-Z0-9_]* {printf("error\n");}

