%{
#include<stdio.h>
#include<stdlib.h>
extern int yylex();
void yyerror();
extern void putkwd();
%}

%union {
    int intVal;
    char* charVal;
}
%token VAR
%token TRUE FALSE
%token RETURN FOR CONTINUE IF ELSE BREAK IDENTIFIER
%token	INC_OP DEC_OP AND_OP OR_OP LE_OP GE_OP EQ_OP NE_OP
%token INT_LITERAL STRING_LITERAL

%start STATEMENTS
%%


STATEMENTS : STATEMENT STATEMENTS |
	;
		

VARIABLE_DECLARATION
	: VAR S ';'
	
	;
S
	: VARIABLE_DECLARATOR 
	
	;
LITERAL:
	INT_LITERAL
	|STRING_LITERAL
	;
	
VARIABLE_DECLARATOR
	: IDENTIFIER '='LITERAL E
	| IDENTIFIER E
	; 
E
	: ',' S
	|
	;

		
		
STATEMENT
      : FOR_STATEMENT 
      |  BREAK  ';'
      |  CONTINUE ';' 
      | VARIABLE_DECLARATION 
      | IF_STATEMENT
      | ';'
      ;
FIRST 
	: EXPRESSION ';'
	| VARIABLE_DECLARATION
	;
FOR_STATEMENT
	: FOR '(' FIRST  EXPRESSION ';' EXPRESSION ')' BLOCK
	| error {printf("Production error\n");}
	
	;
BLOCK : 
	'{' STATEMENTS '}' |';';
EXPRESSION
	: IDENTIFIER  | NUM_EXPRESSION | ';'
	;
NUM_EXPRESSION : IDENTIFIER OP IDENTIFIER
	;
IF_STATEMENT
	: IF '(' EXPRESSION ')' BLOCK Q
	
	;
Q
	:
	ELSE BLOCK
	| ELSE IF_STATEMENT
	|
	;
OP: 
	'+'
	| '-'
	; 
%%

void yyerror()
{
	//printf("Parse Error\n");
	//exit(0);
}

int yywrap(){return 1;}

int main() {
	putkwd();
	if(yyparse()==0){printf("Parse Success\n");}
	//printf("%d\n",yyparse());
}
