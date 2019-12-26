all: SmallCalculator

SmallCalculator.tab.c SmallCalculator.tab.h:	SmallCalculator.y
	bison -d SmallCalculator.y

lex.yy.c: SmallCalculator.l SmallCalculator.tab.h
	flex SmallCalculator.l

SmallCalculator: lex.yy.c SmallCalculator.tab.c SmallCalculator.tab.h
	gcc -o SmallCalculator main.c SmallCalculator.tab.c lex.yy.c

clean:
	rm SmallCalculator SmallCalculator.tab.c lex.yy.c SmallCalculator.tab.h
