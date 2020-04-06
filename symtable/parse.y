%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
extern int yylex();
void yyerror();
extern void putkwd();
extern void createEntry(char* ,char*, char*);
extern char* getVal(char* name);
extern int getPos(char* name);
%}
%union {
	char* text;
    int intVal;
}
%token VAR
%token TRUE FALSE
%token RETURN FOR CONTINUE IF ELSE BREAK
%token<text> IDENTIFIER
%token	INC_OP DEC_OP AND_OP OR_OP L_OP G_OP TEQ_OP LE_OP GE_OP EQ_OP NE_OP
//%token<intVal> INT_LITERAL 
%token<text> STRING_LITERAL SC INT_LITERAL
%type<text> LITERAL OPERAND EXPRESSION NUM_EXPRESSION REL_EXPRESSION
%start STATEMENTS


%%

STATEMENTS : STATEMENT STATEMENTS |
	;
VARIABLE_DECLARATION
	: VAR VARIABLE_DECLARATOR SC
	
	;
//S
//	: VARIABLE_DECLARATOR 
	
//	;
LITERAL:
	INT_LITERAL
	| STRING_LITERAL
	;
	
VARIABLE_DECLARATOR
	:  IDENTIFIER E
	|  ASSIGNMENT E
	;	 
E
	: ',' VARIABLE_DECLARATOR
	|
	;

		

OPERAND : LITERAL {strcpy($$,$1);}
	| IDENTIFIER
	;	
		
STATEMENT
      : FOR_STATEMENT 
      |  BREAK  SC
      |  CONTINUE SC 
      | VARIABLE_DECLARATION
       | ASSIGNMENT SC		 
      | IF_STATEMENT
      | SC
      ;
ASSIGNMENT
	: IDENTIFIER '=' EXPRESSION {createEntry($1, "id", $3);}
      ;


	
FIRST 
	:
	SC
	| VARIABLE_DECLARATION
	|ASSIGNMENT SC	
	;
FOR_STATEMENT
	: FOR '(' FIRST  EXPRESSION SC EXPRESSION ')' BLOCK
	| error {printf("Production error\n");}
	
	;
BLOCK : 
	'{' STATEMENTS '}' | SC;
EXPRESSION
	: OPERAND
	| NUM_EXPRESSION 
	|REL_EXPRESSION 
	| SC
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
	printf("Parse Error\n");
	//exit(0);
}

int yywrap(){return 1;}

int main() {
	putkwd();
	if(yyparse()==0){printf("\nParse Success\n");}
	//printf("%d\n",yyparse());
}
