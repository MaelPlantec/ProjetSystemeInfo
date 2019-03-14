compiler : y.tab.c lex.yy.c
	gcc lex.yy.c y.tab.c -o compiler -ly -ll

lex.yy.c : psi_v2.l Makefile
	flex psi_v2.l

y.tab.c : compiler.y Makefile
	yacc -d -t compiler.y

test : compiler
	./compiler < input_string

clear :
	rm lex.yy.c
	rm y.tab.*
	rm compiler
