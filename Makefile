compiler : y.tab.c lex.yy.c
	gcc lex.yy.c y.tab.c ts.c ta.c -o compiler_v4 -ly -ll

lex.yy.c : lex_v3.l Makefile
	flex lex_v3.l

y.tab.c : compiler_v4.y Makefile
	yacc -d -t compiler_v4.y

test : compiler
	./compiler_v4 < input_string

clear :
	rm lex.yy.c
	rm y.tab.*
	rm compiler_v4
