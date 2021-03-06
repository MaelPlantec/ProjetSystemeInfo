%{
	#include "ts.h"
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

Body : tACCO {ts_profondeur_actuelle++;} Instructions tACCF {ts_profondeur_actuelle--;}
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
DConstSuite : tID tEGAL tNB
		;
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

Affectation : tID tEGAL E
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

%%

int main() {
	ts_init();

	yyparse();

	ts_text();
}
