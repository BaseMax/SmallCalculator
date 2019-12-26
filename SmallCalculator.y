%{
	#include <stdio.h> // printf
	#include <stdlib.h> // exit

	extern int yylex();
	extern void yyerror(const char* message);
%}

%union {
	int decimalNumber;
	float floatNumber;
}

%token<decimalNumber> TOKEN_INT
%token<floatNumber> TOKEN_FLOAT

%token TOKEN_NEWLINE TOKEN_QUIT
%token TOKEN_PLUS TOKEN_MINUS TOKEN_MULTIPLY TOKEN_DIVIDE TOKEN_BRACKET_LEFT TOKEN_BRACKET_RIGHT

%left TOKEN_PLUS TOKEN_MINUS
%left TOKEN_MULTIPLY TOKEN_DIVIDE

%start start

%type<decimalNumber> expression
%type<floatNumber> expressions

%%

start:
			| start command
;

command:	  TOKEN_NEWLINE 							{}
			| TOKEN_QUIT TOKEN_NEWLINE 					{ exit(0); }
			| expression TOKEN_NEWLINE 					{ printf("%i\n> ", $1); }
			| expressions TOKEN_NEWLINE 				{ printf("%f\n> ", $1);}
;

expressions:  TOKEN_FLOAT 								{ $$ = $1; }
			// ()
			| TOKEN_BRACKET_LEFT expressions TOKEN_BRACKET_RIGHT{ $$ = $2; }

			// +
			// float, float
			| expressions TOKEN_PLUS expressions 		{ $$ = $1 + $3; }
			// int, float
			| expression TOKEN_PLUS expressions 		{ $$ = $1 + $3; }
			// float, int
			| expressions TOKEN_PLUS expression 		{ $$ = $1 + $3; }

			// -
			// float, float
			| expressions TOKEN_MINUS expressions 		{ $$ = $1 - $3; }
			// int, float
			| expression TOKEN_MINUS expressions 		{ $$ = $1 - $3; }
			// float, int
			| expressions TOKEN_MINUS expression 		{ $$ = $1 - $3; }

			// *
			// float, float
			| expressions TOKEN_MULTIPLY expressions 	{ $$ = $1 * $3; }
			// int, float
			| expression TOKEN_MULTIPLY expressions 	{ $$ = $1 * $3; }
			// float, int
			| expressions TOKEN_MULTIPLY expression 	{ $$ = $1 * $3; }

			// /
			// float, float
			| expressions TOKEN_DIVIDE expressions 		{ $$ = $1 / $3; }
			// int, float
			| expression TOKEN_DIVIDE expressions 		{ $$ = $1 / $3; }
			// float, int
			| expressions TOKEN_DIVIDE expression 		{ $$ = $1 / $3; }
;

expression:   TOKEN_INT									{ $$ = $1; }
			// ()
			| TOKEN_BRACKET_LEFT expression TOKEN_BRACKET_RIGHT{ $$ = $2; }
			// +
			| expression TOKEN_PLUS expression			{ $$ = $1 + $3; }
			// -
			| expression TOKEN_MINUS expression			{ $$ = $1 - $3; }
			// *
			| expression TOKEN_MULTIPLY expression		{ $$ = $1 * $3; }
			// /
			| expression TOKEN_DIVIDE expression 		{ $$ = $1 / $3; }
;

%%
