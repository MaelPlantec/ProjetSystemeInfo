all: compiler interpreteur

compiler : y.tab.c lex.yy.c
	gcc lex.yy.c y.tab.c ts.c ta.c -o compiler_v4 -ly -ll

interpreteur: y.int.c lex_int.yy.c ta.c
	gcc y.int.c lex_int.yy.c ta.c interpreteur.c -o interpreteur -ly -ll

lex.yy.c : lex_v3.l Makefile
	flex lex_v3.l

y.tab.c : compiler_v4.y Makefile
	yacc -d -t compiler_v4.y


lex_int.yy.c : interpreteur.l Makefile
	flex -o lex_int.yy.c interpreteur.l

y.int.c : interpreteur.y Makefile
	yacc -d -t interpreteur.y -o y.int.c


test : compiler
	./compiler_v4 < input_string

clear :
	rm lex.yy.c
	rm lex_int.yy.c
	rm y.int.*
	rm y.tab.*
	rm compiler
