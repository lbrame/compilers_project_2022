all:
		yacc -d ast.y -Wno-yacc
		lex ast.l
		gcc lex.yy.c y.tab.c -ll

clean:
		rm lex.yy.c y.tab.c a.out
