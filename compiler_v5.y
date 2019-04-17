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

%token tMAIN tACCO tACCF tCONST tINT tID tNB tPTF tPLUS tMOINS tMUL tDIV tEGAL tINF tSUP tINFEG tSUPEG tPARO tPARF tVIRG tPV tIF tELSE tWHILE tRET tERR
%type  <nb> tNB
%type <str> tID
%type <nb> E
%type <nb> Comparaison
%type <nb> Condition
%type <nb> tIF
%type <nb> tWHILE
%type <nb> Vide

%right tEGAL
%left tPLUS tMOINS
%left tMUL tDIV

%%
start : Code

Code : tINT tMAIN tPARO tPARF Body
    ;

Body : tACCO {ts_depth_incr();} Instructions tACCF {ts_depth_decr();}
    ;

BodyF : tACCO {ts_depth_incr();} Instructions Return tACCF {ts_depth_decr();}
		;

Return : tRET E {$$ = $2;}
		;

Instructions : Instruction Instructions
		|
    ;
Instruction : Declaration tPV
		| Affectation tPV
		| Print tPV
		| If
		| While
		| DFonction
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
		printf("Erreur : Déclaration, variable déjà créée.\n");
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

DFonction: tINT tID tPAR0 DParams tPARF BodyF
	;
DParam: tINT tID
	;
DParams: DParam DParamSuite
	|
	;
DParamSuite: tVIRG DParam DParamSuite
	|
	;

AFonction: tID
	tPARO AParams tPARF tPV
	;
AParam: E
	;
AParams: AParam AParamSuite
	|
	;
AParamSuite: tVIRG AParam AParamSuite
	|
	;

Affectation : tID tEGAL E {
	ts_pop();
	int addr_id = ts_get_addr($1);
	if(addr_id == -1) {
		printf("Erreur : Déclaration, variable non déclarée.");
		exit(0);
  }
	ta_add("LOAD", $3, 0, -1);
	ta_add("STORE", addr_id, 0, -1);
	}
		;

Condition : tPARO Comparaison tPARF {
	$$ = $2;
	}
		;

Comparaison : E tEGAL tEGAL E {
	ta_add("LOAD", 0, $1, -1);
	ta_add("LOAD", 1, $4, -1);
	ta_add("EQU", 0, 0, 1);
	ta_add("STORE", $1, 0, -1);
	$$ = $1;
	ts_pop();
	}
	| E tINF E {
	ta_add("LOAD", 0, $1, -1);
	ta_add("LOAD", 1, $3, -1);
	ta_add("INF", 0, 0, 1);
	ta_add("STORE", $1, 0, -1);
	$$ = $1;
	ts_pop();
	}
		| E tSUP E {
		ta_add("LOAD", 0, $1, -1);
		ta_add("LOAD", 1, $3, -1);
		ta_add("SUP", 0, 0, 1);
		ta_add("STORE", $1, 0, -1);
		$$ = $1;
		ts_pop();
		}
		| E tINFEG E {
		ta_add("LOAD", 0, $1, -1);
		ta_add("LOAD", 1, $3, -1);
		ta_add("INFE", 0, 0, 1);
		ta_add("STORE", $1, 0, -1);
		$$ = $1;
		ts_pop();
		}
		| E tSUPEG E {
		ta_add("LOAD", 0, $1, -1);
		ta_add("LOAD", 1, $3, -1);
		ta_add("SUPE", 0, 0, 1);
		ta_add("STORE", $1, 0, -1);
		$$ = $1;
		ts_pop();
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
			$$ = addr_nb;
		}
		| tID {
			int addr_id = ts_get_addr($1);
			if(addr_id == -1) {
				printf("Erreur : Déclaration, variable non déclarée.");
				exit(0);
		  }
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

If : tIF Condition
		{
			ta_add("LOAD", 0, $2, -1);
			ta_add("JMPC", 0, 0, -1);
			ts_pop();
			$1 = ta_index - 1;
		}
	Body
		{
			ta_add("JMP", 0, -1, -1);
			ta_update_jmp($1, ta_index);
			$1 = ta_index - 1;
		}
	IfSuite
		{
			ta_update_jmp($1, ta_index);
		}
	;

IfSuite :
 	tELSE Body
	| tELSE If
	|
	;

While : tWHILE Vide
    {
        $2 = ta_index;
    }
    Condition
    {
        ta_add("LOAD", 0, $4, -1);
        ta_add("JMPC", 0, 0, -1);
        ts_pop();
        $1 = ta_index-1;
    }
    Body
    {
        ta_add("JMP", $2, -1, -1);
        ta_update_jmp($1, ta_index);
    }
        ;

Vide:
	{$$ = 0;}
	;

%%

int main() {
	ta_init();
	ts_init();

	yyparse();

	ta_text();
	ts_text();
}
