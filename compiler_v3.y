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
%type <str> E

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
	char addr_id[6] = ts_declaration($1, CONST_INT);
	if(strcmp(addr_id, "0")) {
		printf("Erreur : Déclaration, variable déjà créée.");
		exit(0); }
	ta_add("LOAD", "R0", $3, "");
	ta_add("STORE", addr_id, "R0", "");
	ts_pop();
	}
	;


DConstSuite2 : tVIRG DConstSuite DConstSuite2
		|
		;

DInt : tINT DIntSuite DIntSuite2
		;

DIntSuite : tID {
	if(strcmp(ts_declaration($1, CONST_INT), "0")) {
		printf("Erreur : Déclaration, variable déjà créée.");
		exit(0); }
	}
	| tID tEGAL tNB {
		char * addr_id = ts_declaration($1, CONST_INT);
		if(strcmp(addr_id, "0")) {
			printf("Erreur : Déclaration, variable déjà créée.");
			exit(0); }
		char nb[6];
		sprintf(nb, "%d", $3);
		ta_add("AFC", "R0", nb, "");
		ta_add("STORE", addr_id, "R0", "");
		}
	;

DIntSuite2 : tVIRG DIntSuite DIntSuite2
		|
		;

Affectation : tID tEGAL E {
	char * addr_id = ts_get_addr($1);
	if(strcmp(addr_id, "0")) {
		printf("Erreur : Déclaration, variable non déclarée.");
		exit(0); }
	ta_add("LOAD", $3, "R0", "");
	ta_add("STORE", addr_id, "R0", "");
	}
		;

Condition : tPARO Comparaison tPARF
		;

Comparaison : E tINF E
		| E tSUP E
		| E tINFEG E
		| E tSUPEG E
		;

E : E tPLUS E {
	$$ = $1;
	ta_add("LOAD", "R0", $1, "");
	ta_add("LOAD", "R1", $3, "");
	ta_add("ADD", "R0", "R0", "R1");
	ts_pop();
	}
    | E tMOINS E

    | E tMUL E
    | E tDIV E
    | tMOINS E {$$ = $2;}
		| tPARO E tPARF
    | tNB {
			char addr_tmp[6] = ts_add_tmp();
			char nb[6];
			sprintf(nb, "%d", $1);
			ta_add("AFC", "R0", nb, "");

		}
		| tID {
			char addr_id[6] = ts_get_addr($1);
			ta_add("LOAD", "R0", addr_id, "");

			char addr_tmp[6] = ts_add_tmp();
			ta_add("STORE", addr_tmp, "R0", "");
			$$ = addr_tmp;
			}
    ;

Print : tPTF tPARO E tPARF
		;

If : tIF Condition Body IfSuite
	;

IfSuite : tELSE Body
	| tELSE tIF Body IfSuite
	|
	;

While : tWHILE Condition Body
	;
