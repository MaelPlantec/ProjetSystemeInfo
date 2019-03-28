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
DConstSuite : tID tEGAL tNB {ts_declaration($1, CONST_INT); $1 = ts_index-1; char name[50]; sprintf(name, "%d", $3); char addr[6]; ta_add("AFC", "R0", name); sprintf(addr, "%d", ts_get_addr()); ta_add("STORE",addr, "R0");}
DConstSuite2 : tVIRG DConstSuite DConstSuite2
		|
		;

DInt : tINT DIntSuite DIntSuite2
		;
DIntSuite : tID
		| tID tEGAL tNB
		;
DIntSuite2 : tVIRG DIntSuite DIntSuite2
		|
		;

Affectation : tID tEGAL E {unsigned int addr = }
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
    | tMOINS E  {$$ = $2;}
		| tPARO E tPARF
    | tNB
		| tID {$$ = 0;}
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
