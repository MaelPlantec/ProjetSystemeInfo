%{
	#include "ts.h"
	#include "ta.h"
	int yylex(void);
	void yyerror(char*);
%}

%union {
	int nb;
	char* str;
}

%token tOPE tNB
%type  <nb> tNB
%type <str> tOPE

%%
start : Assembleur {ta_init();}

Assembleur : Code {interpreteur_init(ta);}
	;

Code : tOPE tNB tNB tNB Suite {ta_add($1, $2, $3, $4);}
	| tOPE tNB tNB Suite {ta_add($1, $2, $3, -1);}
	| tOPE tNB Suite {ta_add($1, $2, -1, -1);}
	;

Suite : Code
	|
	;