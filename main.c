#include <stdio.h> // printf
extern FILE* yyin;
extern int yyparse();

void yyerror(const char* message) {
	fprintf(stderr, "Error: %s\n", message);
}

int main(int argc, char** argv) {
	printf("Welcome to SmallCalculator\nRepository: GitHub.com/BaseMax/SmallCalculator\n\n> ");
	yyparse();
	return 0;
}
