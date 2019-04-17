%{
	#include "ta.h"
	#include "interpreteur.h"
	int yylex(void);
	void yyerror(char*);
%}

%union {
	int nb;
	char* str;
}

%token tOPE tNB tERR
%type  <nb> tNB
%type <str> tOPE

%%
start : Assembleur 

Assembleur : Suite Assembleur
	|
	;

Suite : tOPE tNB tNB tNB {ta_add($1, $2, $3, $4);}
	| tOPE tNB tNB {ta_add($1, $2, $3, -1);}
	| tOPE tNB {ta_add($1, $2, -1, -1);}
	;

%%
int main() {
	ta_init();

	yyparse();
	
	interpreteur_init(ta, ta_index);
}

