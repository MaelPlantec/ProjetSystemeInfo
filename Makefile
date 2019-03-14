compiler : y.tab.c lex.yy.c
	gcc lex.yy.c -o compiler -ly -ll

lex.yy.c : compiler.l
	flex compiler.l

y.tab.c : 
	yacc -d compiler.y

test : compiler
	/compiler < test
