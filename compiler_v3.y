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

%token tMAIN tACCO tACCF tCONST tINT tID tNB tPTF tPLUS tMOINS tMUL tDIV tEGAL tINF tSUP tINFEG tSUPEG tPARO tPARF tVIRG tPV tIF tELSE tWHILE tERR
%type  <nb> tNB
%type <str> tID
%type <nb> E

%right tEGAL
%left tPLUS tMOINS
%left tMUL tDIV

%%
start : Code {ts_init();}

Code : tINT tMAIN tPARO tPARF Body {ta_text(); ts_text();}
    ;

Body : tACCO {ts_depth_incr();} Instructions tACCF {ts_depth_decr();}
    ;

Instructions : Instruction Instructions
		|
    ;

Instruction : Declaration tPV
		| Affectation tPV
		| Print tPV
    ;

Declaration : DConst
		|	DInt
		;

DConst : tCONST tINT DConstSuite DConstSuite2
		;

DConstSuite : tID tEGAL E {
	ts_pop();
	int addr_id = ts_declaration($1, CONST_INT);
	if(addr_id == -1) {
		printf("Erreur : Déclaration, variable déjà créée 1.");
		exit(0); }
	ta_add("LOAD", 0, $3, -1);
	ta_add("STORE", addr_id, 0, -1);
	}
	;


DConstSuite2 : tVIRG DConstSuite DConstSuite2
		|
		;

DInt : tINT DIntSuite DIntSuite2
		;

DIntSuite : tID {
	if(ts_declaration($1, INT) == -1) {
		printf("Erreur : Déclaration, variable déjà créée 2.");
		exit(0); }
	}
	| tID tEGAL E {
		ts_pop();
		int addr_id = ts_declaration($1, INT);
		if(addr_id == -1) {
			printf("Erreur : Déclaration, variable déjà créée 3.");
			exit(0); }
			ta_add("LOAD", 0, $3, -1);
			ta_add("STORE", addr_id, 0, -1);
		}
	;

DIntSuite2 : tVIRG DIntSuite DIntSuite2
		|
		;

Affectation : tID tEGAL E {
	ts_pop();
	int addr_id = ts_get_addr($1);
	if(addr_id == -1) {
		printf("Erreur : Déclaration, variable non déclarée.");
		exit(0); }
	ta_add("LOAD", $3, 0, -1);
	ta_add("STORE", addr_id, 0, -1);
	}
		;

E : E tPLUS E {
	$$ = $1;
	ta_add("LOAD", 0, $1, -1);
	ta_add("LOAD", 1, $3, -1);
	ta_add("ADD", 0, 0, 1);
	ta_add("STORE", $1, 0, -1);
	ts_pop();
	}
    | E tMOINS E {
			$$ = $1;
			ta_add("LOAD", 0, $1, -1);
			ta_add("LOAD", 1, $3, -1);
			ta_add("SOU", 0, 0, 1);
			ta_add("STORE", $1, 0, -1);
			ts_pop();
		}
    | E tMUL E {
			$$ = $1;
			ta_add("LOAD", 0, $1, -1);
			ta_add("LOAD", 1, $3, -1);
			ta_add("MUL", 0, 0, 1);
			ta_add("STORE", $1, 0, -1);
			ts_pop();
		}
    | E tDIV E {
			$$ = $1;
			ta_add("LOAD", 0, $1, -1);
			ta_add("LOAD", 1, $3, -1);
			ta_add("DIV", 0, 0, 1);
			ta_add("STORE", $1, 0, -1);
			ts_pop();
		}
    | tMOINS E {
			ta_add("LOAD", 0, $2, -1);
			ta_add("AFC", 1, 0, -1);
			ta_add("SOU", 0, 1, 0);
			ta_add("STORE", $2, 0, -1);
			$$ = $2;
			}
		| tPARO E tPARF {
			$$ = $2;
		}
    | tNB {
			ta_add("AFC", 0, $1, -1);
			int addr_nb = ts_add_tmp();
			ta_add("STORE", addr_nb, 0, -1);
		}
		| tID {
			int addr_id = ts_get_addr($1);
			ta_add("LOAD", 0, addr_id, -1);
			int addr_tmp = ts_add_tmp();
			ta_add("STORE", addr_tmp, 0, -1);
			$$ = addr_tmp;
			}
    ;

Print : tPTF tPARO E tPARF {
	ta_add("PRT", $3, -1, -1, -1);
	}
		;
