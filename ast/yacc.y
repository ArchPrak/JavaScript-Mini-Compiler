%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
%}
%code requires {
	#include "ast.h"
	extern int yylineno;
	extern Symbol *s;
	extern int yyerror(const char *);
	extern void putkwd(void);
	extern int yylex (void);
}
%union {
	AST *node;
	char* text;
}

%token VAR
%token TRUE FALSE
%token RETURN FOR CONTINUE IF ELSE BREAK
%token	INC_OP DEC_OP AND_OP OR_OP L_OP G_OP LE1_OP GE1_OP EQ1_OP NE1_OP NOT_OP
%token<node> IDENTIFIER SC STRING_LITERAL INT_LITERAL
%type<node> LITERAL OPERAND EXPRESSION NUM_EXPRESSION REL_EXPRESSION ASSIGNMENT
%start STATEMENTS

%%

STATEMENTS
	: STATEMENT STATEMENTS
	|
	;

STATEMENT
	: FOR_STATEMENT 
	| BREAK  SC
	| CONTINUE SC 
	| VARIABLE_DECLARATION SC
	| ASSIGNMENT SC	{printAST($1);}	 
	| IF_STATEMENT
	| SC
	;

VARIABLE_DECLARATION
	: VAR VARIABLE_DECLARATOR
	;

LITERAL
	: INT_LITERAL
	| STRING_LITERAL
	;
	
VARIABLE_DECLARATOR
	:  IDENTIFIER MULTI_VAR
	|  ASSIGNMENT MULTI_VAR
	;	 

MULTI_VAR
	: ',' VARIABLE_DECLARATOR
	|
	;

OPERAND
	: LITERAL
	| IDENTIFIER
	;

ASSIGNMENT
	: IDENTIFIER '=' EXPRESSION {$$ = makeAST(EX_EQ, $1, $3);}
    ;
	  
LOOP_INIT 
	:
	SC
	| VARIABLE_DECLARATION SC
	| ASSIGNMENT SC	
	;

LOOP_COND
	: SC
	| EXPRESSION SC
	;

FOR_STATEMENT
	: FOR '(' LOOP_INIT LOOP_COND EXPRESSION ')' BLOCK
	| error {printf("Production error\n");}
	;

BLOCK
	: '{' STATEMENTS '}'
	| SC
	;

EXPRESSION
	: OPERAND
	| NUM_EXPRESSION 
	| REL_EXPRESSION
	;
NUM_EXPRESSION
	: OPERAND OP OPERAND {}
	;
REL_EXPRESSION
	: OPERAND RELOP OPERAND {}
	;
IF_STATEMENT
	: IF '(' EXPRESSION ')' BLOCK Q
	;
Q
	: ELSE BLOCK
	|
	;
OP
	: '+'
	| '-'
	| '/'
	| '*'
	; 
RELOP
	: G_OP	
	| L_OP	
	| GE1_OP
	| LE1_OP	
	| EQ1_OP
	| NE1_OP
	| AND_OP
	| OR_OP
	;
%%

int yyerror( const char *msg)
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
