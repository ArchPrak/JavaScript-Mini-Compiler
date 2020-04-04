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
%token	INC_OP DEC_OP AND_OP OR_OP L_OP G_OP TEQ_OP LE_OP GE_OP EQ_OP NE_OP
%token INT_LITERAL STRING_LITERAL

%start STATEMENTS
%%


STATEMENTS : STATEMENT STATEMENTS |
	;
VARIABLE_DECLARATION
	: VAR VARIABLE_DECLARATOR ';'
	
	;
//S
//	: VARIABLE_DECLARATOR 
	
//	;
LITERAL:
	INT_LITERAL
	|STRING_LITERAL
	;
	
VARIABLE_DECLARATOR
	:  IDENTIFIER E
	|  ASSIGNMENT E
	;	 
E
	: ',' VARIABLE_DECLARATOR
	|
	;

		

OPERAND : LITERAL | IDENTIFIER
	;	
		
STATEMENT
      : FOR_STATEMENT 
      |  BREAK  ';'
      |  CONTINUE ';' 
      | VARIABLE_DECLARATION
       | ASSIGNMENT ';'		 
      | IF_STATEMENT
      | ';'
      ;
ASSIGNMENT
	:IDENTIFIER '=' EXPRESSION 
      ;


	
FIRST 
	:
	';'
	| VARIABLE_DECLARATION
	|ASSIGNMENT ';'	
	;
FOR_STATEMENT
	: FOR '(' FIRST  EXPRESSION ';' EXPRESSION ')' BLOCK
	| error {printf("Production error\n");}
	
	;
BLOCK : 
	'{' STATEMENTS '}' |';';
EXPRESSION
	: OPERAND | NUM_EXPRESSION |REL_EXPRESSION | ';'
	;
NUM_EXPRESSION : OPERAND OP OPERAND
	;
REL_EXPRESSION : OPERAND RELOP OPERAND
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
	|'/'
	|'*'
	; 
RELOP:
	G_OP	
	|L_OP	
	|GE_OP
	|LE_OP	
	|EQ_OP
	|NE_OP
	|TEQ_OP
	|AND_OP
	|OR_OP
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
