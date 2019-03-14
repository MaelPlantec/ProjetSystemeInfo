%{
	int yylex(void);
	void yyerror(char*);
%}
%token tMAIN tACCO tACCF tCONST tINT tPTF tID tVAL tPLUS tMOINS tMUL tDIV tEGAL tPARO tPARF tVIRG tPV tERR
%%
start: tMAIN tPARO tPARF Body;
Body: tACCO Instruction tACCF;
Instruction: E | E + Instruction;
E: 
