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

%token tMAIN tACCO tACCF tCONST tINT tID tNB tPTF tPLUS tMOINS tMUL tDIV tEGAL tPARO tPARF tVIRG tPV tERR
%type  <nb> tNB
%type <str> tID
%type <nb> E

%right tEGAL
%left tPLUS tMOINS
%left tMUL tDIV

%%
start : Code

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
		| If
		| While
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
		printf("Erreur : Déclaration, variable déjà créée.");
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
		printf("Erreur : Déclaration, variable déjà créée.");
		exit(0); }
	}
	| tID tEGAL E {
		ts_pop();
		int addr_id = ts_declaration($1, INT);
		if(addr_id == -1) {
			printf("Erreur : Déclaration, variable déjà créée.");
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
	ts_pop();
	}
    | E tMOINS E {
			$$ = $1;
			ta_add("LOAD", 0, $1, -1);
			ta_add("LOAD", 1, $3, -1);
			ta_add("SOU", 0, 0, 1);
			ts_pop();
		}
    | E tMUL E {
			$$ = $1;
			ta_add("LOAD", 0, $1, -1);
			ta_add("LOAD", 1, $3, -1);
			ta_add("MUL", 0, 0, 1);
			ts_pop();
		}
    | E tDIV E {
			$$ = $1;
			ta_add("LOAD", 0, $1, -1);
			ta_add("LOAD", 1, $3, -1);
			ta_add("DIV", 0, 0, 1);
			ts_pop();
		}
    | tMOINS E {
			ta_add("LOAD", 0, $2, -1);
			ta_add("AFC", 1, 0, -1);
			ta_add("SOU", 0, 1, 0);
			$$ = $2;
			}
		| tPARO E tPARF {
			$$ = $2;
		}
    | tNB {
			ta_add("AFC", 0, $1, -1);
			int addr_nb = ts_add_tmp();
			ta_add("STORE", addr_nb, 0, -1);
			$$ = addr_nb;
		}
		| tID {
			int addr_id = ts_get_addr($1);
			ta_add("LOAD", 0, addr_id, -1);
			int addr_tmp = ts_add_tmp();
			ta_add("STORE", addr_tmp, 0, -1);
			$$ = addr_tmp;
			printf("Id : %s\n", $1);
			printf("Addr tmp : %d\n", addr_tmp);
			printf("Addr id : %d\n", addr_id);
			}
    ;

	Print : tPTF tPARO E tPARF {
		ts_pop();
		ta_add("PRT", $3, -1, -1);
		}
			;

%%

int main() {
	ta_init();
	ts_init();

	yyparse();

	ta_text();
	ts_text();
}
