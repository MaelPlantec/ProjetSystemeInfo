all: compiler interpreteur

compiler : y.tab.c lex.yy.c ts.c ta.c
	gcc lex.yy.c y.tab.c ts.c ta.c -o compiler_v4 -ly -ll

inter: y.int.c lex_int.yy.c ta.c interpreteur.c
	gcc y.int.c lex_int.yy.c ta.c interpreteur.c -o interpreteur -ly -ll

lex.yy.c : lex_v3.l Makefile
	flex lex_v3.l

y.tab.c : compiler_v4.y Makefile
	yacc -d -t compiler_v4.y

lex_int.yy.c : interpreteur.l Makefile
	flex -o lex_int.yy.c interpreteur.l

y.int.c : interpreteur.y Makefile
	yacc -d -t interpreteur.y -o y.int.c


test : compiler input_string inter
	./compiler_v4 < input_string
	./interpreteur < instructions.asm

clear :
	rm lex*
	rm y.*
	rm compiler_v4
	rm interpreteur
