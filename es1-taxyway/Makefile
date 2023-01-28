all:
		yacc -d taxyway.y -Wno-yacc
		lex taxyway.l
		gcc lex.yy.c y.tab.c -ll

clean:
		rm lex.yy.c y.tab.c a.out
