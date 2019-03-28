%{
	#include "ts.h"
	int yylex(void);
	void yyerror(char*);
%}

%union {
	int nb;
	char* str;
}

%token tMAIN tACCO tACCF tCONST tINT tID tNB tPTF tPLUS tMOINS tMUL tDIV tEGAL tINF tSUP tINFEG tSUPEG tPARO tPARF tVIRG tPV tIF tELSE tWHILE tERR
%type  <nb> tNB
%type <str> tID
%type <nb> E

%right tEGAL
%left tPLUS tMOINS
%left tMUL tDIV

%%
start : Code {ts_init();}

Code : tINT tMAIN tPARO tPARF Body
    ;

Body : tACCO {ts_depth_incr();} Instructions tACCF {ts_depth_decr();}
    ;

Instructions : Instruction Instructions
		|
    ;

Instruction : Declaration tPV
		| Affectation tPV
		| Print tPV
		| If tPV
		| While tPV
    ;

Declaration : DConst
		|	DInt
		;

DConst : tCONST tINT DConstSuite DConstSuite2
		;

DConstSuite : tID tEGAL E {
	unsigned int addr;
	if((addr = ts_declaration($1, CONST_INT))==0) {
		printf("Erreur : Déclaration, variable déjà créée.");
		exit(0); }
	char addr_E[6];
	sprintf(addr_E, "%d", $3);
	ta_add("LOAD", "R0", addr_E, "");
	char addr_S[6];
	sprintf(addr_S, "%d"; addr);
	ta_add("STORE", addr_S, "R0", ""); }
	// Il faut penser à décrémenter l'index de la table des symboles car on n'a plus besoin de la variable temporaire associée à E.
	;


DConstSuite2 : tVIRG DConstSuite DConstSuite2
		|
		;

DInt : tINT DIntSuite DIntSuite2
		;

DIntSuite : tID {
	unsigned int addr;
	if((addr = ts_declaration($1, CONST_INT))==0) {
		printf("Erreur : Déclaration, variable déjà créée.");
		exit(0); }
	}
	| tID tEGAL tNB {
		unsigned int addr;
		if((addr = ts_declaration($1, CONST_INT))==0) {
			printf("Erreur : Déclaration, variable déjà créée.");
			exit(0); }
		char addr_E[6];
		sprintf(addr_E, "%d", $3);
		ta_add("LOAD", "R0", addr_E, "");
		char addr_S[6];
		sprintf(addr_S, "%d"; addr);
		ta_add("STORE", addr_S, "R0", ""); }
	;

DIntSuite2 : tVIRG DIntSuite DIntSuite2
		|
		;

Affectation : tID tEGAL E {
	unsigned int addr;
	if((addr = ts_get_addr($1))==0) {
		printf("Erreur : Déclaration, variable non déclarée.");
		exit(0); }
	char addr_E[6];
	sprintf(addr_E, "%d", $3);
	ta_add("LOAD", "R0", addr_E, "");
	char addr_S[6];
	sprintf(addr_S, "%d"; addr);
	ta_add("STORE", addr_S, "R0", ""); }
		;

Condition : tPARO Comparaison tPARF
		;

Comparaison : E tINF E
		| E tSUP E
		| E tINFEG E
		| E tSUPEG E
		;

E : E tPLUS E
    | E tMOINS E
    | E tMUL E
    | E tDIV E
    | tMOINS E {$$ = $2;}
		| tPARO E tPARF
    | tNB
		| tID {$$ = ts_get_addr($1);}
    ;

Print : tPTF tPARO E tPARF
		;

If : tIF Condition Body IfSuite
	;

IfSuite : tELSE Body
	| tELSE tIF Body IfSuite
	|
	;

While : tWHILE Conditions Body
	;
