%option noyywrap

%{
	#include <stdio.h>
	#include "SmallCalculator.tab.h"
%}

%%

[ \t] 				;
\n 					{return TOKEN_NEWLINE;}
"(" 				{return TOKEN_BRACKET_LEFT;}
")" 				{return TOKEN_BRACKET_RIGHT;}
"+" 				{return TOKEN_PLUS;}
"-" 				{return TOKEN_MINUS;}
"*" 				{return TOKEN_MULTIPLY;}
"/" 				{return TOKEN_DIVIDE;}
[0-9]+\.[0-9]+ 		{yylval.floatNumber 	= atof(yytext); return TOKEN_FLOAT;}
[0-9]+ 				{yylval.decimalNumber	= atoi(yytext); return TOKEN_INT;}
"exit" 				{return TOKEN_QUIT;}

%%
