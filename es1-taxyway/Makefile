all:
		yacc -d taxyway.y -Wno-yacc
		lex taxyway.l
		gcc lex.yy.c y.tab.c -ll -o taxyway

clean:
		rm lex.yy.c y.tab.c y.tab.h taxyway
