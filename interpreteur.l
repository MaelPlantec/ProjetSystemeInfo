%{
	#include "y.tab.h"
%}
%%

[A-Z]+ {return tOPE;}
[0-9]+ {return tNB;} 
