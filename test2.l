%%
"adore" {printf("tADORE\n");}
"le" {printf("tLE\n");}
"PSI" {printf("tPSI\n");}
" " {}
[a-z,ë]+ {printf("tPRENOM:%s\n", yytext);}
. {printf("error\n");}

