%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <ctype.h>
  #include "ast.c"
  void yyerror(char *);  
  //extern FILE *yyin;
  #define COUNT 10 
  //#define YYSTYPE char*
  int count = 0;
%}

%union{
	char * text;
	struct AST* astnode;	
}

%start S
%token T_lt T_gt T_lteq T_gteq T_neq T_eqeq T_teq T_and T_or  T_eq FLOAT BREAK CONTINUE IF ELSE FOR VAR 

%token<text> ID STRING NUM
%token T_pl T_min T_mul T_div
%left T_lt T_gt
%left T_pl T_min
%left T_mul T_div

%type<text> RELOP
%type<astnode> LOOPS LOOPC LOOPBODY EXP ASSIGN_EXPR statement COND LIT FACTOR ADDSUB TERM START


%%
S
	: START {printf("Input accepted.\n");}
	;

	
 
START
	: START statement ';' {printTree($2);printf("\n");printf("----------------------------------------------------------------\n");}
	| START LOOPS {printTree($2);printf("\n");printf("----------------------------------------------------------------\n");}
	| statement ';' {printTree($1);printf("\n");printf("----------------------------------------------------------------\n");}
	| LOOPS {printTree($1);printf("\n");printf("----------------------------------------------------------------\n");}
	;

LOOPS
	: FOR '(' ASSIGN_EXPR ';' COND ';' statement ')' LOOPBODY
	| IF '(' COND ')' LOOPBODY ELSE LOOPBODY 
	| IF '(' COND ')' LOOPBODY {$$=buildTree("IF",$3,$5);}
	
	;


LOOPBODY
  	  : '{' LOOPC '}' {$$=$2;}
  	  | ';'
  	  | statement ';'
  	  ;

LOOPC
	: LOOPC statement ';' {$$=buildTree("SEQ",$1,$2);}
	| LOOPC LOOPS {$$=buildTree("SEQ",$1,$2);}
	| statement ';' {$$=$1;}
	| LOOPS {$$=$1;}
	;

statement
	: ASSIGN_EXPR {$$ = $1;}
	| EXP {$$=$1;}
	 
	;
 
COND
	: LIT RELOP LIT {$$=buildTree($2,$1,$3);}
	| LIT {$$=$1;}
	| LIT RELOP LIT bin_boolop LIT RELOP LIT
	| un_boolop '(' LIT RELOP LIT ')'
	| un_boolop LIT RELOP LIT
	| LIT bin_boolop LIT
	| un_boolop '(' LIT ')'
	| un_boolop LIT
	;

ASSIGN_EXPR
	: LIT T_eq EXP {$$=buildTree("=",$1,$3);}
	| VAR LIT T_eq EXP {$$=buildTree("=",$2,$4);}
	|VAR LIT 
	;

EXP
	  : ADDSUB {$$=$1;}
	  | EXP T_lt ADDSUB {$$=buildTree("<",$1,$3);}
	  | EXP T_gt ADDSUB {$$=buildTree(">",$1,$3);}
	  ;
	  
ADDSUB
	: TERM {$$=$1;}
	| EXP T_pl TERM {$$=buildTree("+",$1,$3);}
	| EXP T_min TERM {$$=buildTree("-",$1,$3);}
	;

TERM
	  : FACTOR {$$=$1;}
	| TERM T_mul FACTOR {$$=buildTree("*",$1,$3);}
	| TERM T_div FACTOR {$$=buildTree("/",$1,$3);}
	;
	
FACTOR
	  : LIT {$$=$1;}
	  | '(' EXP ')' {$$ = $2;}
  	  ;
	

LIT
	: ID {$$ = buildTree((char *)yylval.text,0,0);}
	| NUM {$$ = buildTree((char *)yylval.text,0,0);}
	|STRING {$$ = buildTree((char*)yylval.text,0,0);}
	;

RELOP
	: T_lt { $$ = "<";}
	| T_gt { $$ = ">";}
	| T_lteq{ $$ = "<=";}
	| T_gteq { $$ = ">=";}
	| T_neq { $$ = "!=";}
	| T_eqeq { $$ = "==";}
	| T_teq {$$ = "===";}
	
	;
bin_boolop
	: T_and 
	| T_or 
	;


un_boolop
	: T_neq 
	;


%%
int main(int argc,char *argv[])
{
  //yyin = fopen("phase2_input.c","r");
  /*
  node *root,*temp;
  root = (node*)malloc(sizeof(node));
  temp = (node*)malloc(sizeof(node));
  */
  if(!yyparse())  //yyparse-> 0 if success
  {
    printf("Parsing Complete\n");
  }
  else
  {
    printf("Parsing failed\n");
  }
  //fclose(yyin);
  return 0;
}