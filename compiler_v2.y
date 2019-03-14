%{
	int yylex(void);
	void yyerror(char*);
%}

%union {
	int nb;
	char* str;
}

%token <nb> tNB
%type <nb> E
%token tMAIN tACCO tACCF tCONST tINT tPTF tID tVAL tPLUS tMOINS tMUL tDIV tEGAL tINF tSUPP tINFEG tSUPPEG tPARO tPARF tVIRG tPV tERR
%right tEGAL
%left tPLUS tMOINS
%left tMUL tDIV

%%
start : Code

Code : tINT tMAIN tPARO tPARF Body
    ;

Body : tACCO Instructions tACCF
    ;

Instructions : Instruction Instructions
|
    ;

Instruction : Declaration tPV
		| Affectation tPV
    | E tPV
    ;

Declaration : tINT tID tEGAL E
    | tINT Identites
    | tCONST tINT tID tNB
    ;

Identites : tID | Identites
	;

Affectation : tID tEGAL E
	;

E : E tPLUS E
    | E tMOINS E
    | E tMUL E
    | E tDIV E
    | tMOINS E  {$$ = $2;}
    | tNB
		| tID {$$ = 0;}
    ;
