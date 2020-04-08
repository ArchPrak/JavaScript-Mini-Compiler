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
%token	INC_OP DEC_OP AND1_OP OR1_OP L_OP G_OP LE1_OP GE1_OP EQ1_OP NE1_OP NOT_OP
%token<node> IDENTIFIER STRING_LITERAL INT_LITERAL
%type<node> LITERAL OPERAND EXPRESSION NUM_EXPRESSION REL_EXPRESSION ASSIGNMENT VARIABLE_DECLARATION
%type<node> VARIABLE_DECLARATOR LOOP_INIT LOOP_COND BLOCK FOR_STATEMENT STATEMENT STATEMENTS SC IF_STATEMENT ELSE_BLOCK
%start STATEMENTS

%%
STATEMENTS
	: STATEMENT STATEMENTS {$$ = addLast($1, $2);}
	| {$$ = makeStr("");}
	;

STATEMENT
	: FOR_STATEMENT {printAST($1);}
	| BREAK  SC { $$ = $2;}
	| CONTINUE SC { $$ = $2;}
	| VARIABLE_DECLARATION SC {printAST($1);}
	| ASSIGNMENT SC	{printAST($1);}	 
	| IF_STATEMENT {printAST($1);}
	| SC
	;

VARIABLE_DECLARATION
	: VAR VARIABLE_DECLARATOR {$$=$2;}
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
	| EXPRESSION SC
	;

LOOP_COND
	: SC
	| EXPRESSION SC
	;

FOR_STATEMENT
	: FOR '(' LOOP_INIT LOOP_COND EXPRESSION ')' BLOCK {$$ = makeAST(FOR_STATEMENT, makeList3($3, $4, $5), $7);}
	| error {printf("Production error\n");}
	;

BLOCK
	: '{' STATEMENTS '}' { $$ = makeStr("not working");}
	| SC
	;

EXPRESSION
	: OPERAND
	| NUM_EXPRESSION 
	| REL_EXPRESSION
	;
NUM_EXPRESSION
	: OPERAND '+' OPERAND { $$ = makeAST(PLUS_OP, $1, $3);}
	| OPERAND '-' OPERAND { $$ = makeAST(MINUS_OP, $1, $3);}
	| OPERAND '*' OPERAND { $$ = makeAST(MUL_OP, $1, $3);}
	| OPERAND '/' OPERAND { $$ = makeAST(DIV_OP, $1, $3);}
	;
REL_EXPRESSION
	: OPERAND G_OP OPERAND { $$ = makeAST(GT_OP, $1, $3); }
	| OPERAND L_OP OPERAND { $$ = makeAST(LT_OP, $1, $3); }
	| OPERAND GE1_OP OPERAND { $$ = makeAST(GE_OP, $1, $3); }
	| OPERAND LE1_OP OPERAND { $$ = makeAST(LE_OP, $1, $3); }
	| OPERAND EQ1_OP OPERAND { $$ = makeAST(EQ_OP, $1, $3); }
	| OPERAND NE1_OP OPERAND { $$ = makeAST(NE_OP, $1, $3); }
	| OPERAND AND1_OP OPERAND { $$ = makeAST(AND_OP, $1, $3); }
	| OPERAND OR1_OP OPERAND { $$ = makeAST(OR_OP, $1, $3); }
	;
IF_STATEMENT
	: IF '(' EXPRESSION ')' BLOCK ELSE_BLOCK {$$ = makeAST(IF_STATEMENT, $3, makeList2($5, $6));}
	;
ELSE_BLOCK
	: ELSE BLOCK { $$=$2;}
	| {$$ = NULL;}
	;

SC 
	: ';' {$$ = makeStr(";");}
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
