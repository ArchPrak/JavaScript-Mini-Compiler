%{
#include <stdio.h>
#include <stdlib.h>
%}

%token    CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK 
%token    IDENTIFIER

%%
STATEMENT
      : VARIABLE_DECLARATION 
      |  EXPRESSION ";"  
      |  STATEMENT_block 
      |  if_STATEMENT 
      |  FOR_STATEMENT  
      |  BREAK  ";"
      |  CONTINUE ";"  
      |  ";"
;  
 
      ;

VARIABLE_DECLARATION
	: "var” S “;”
	;
S
	: VARIABLE_DECLARATOR 
	| S ”,” S
	;
VARIABLE_DECLARATOR
	: IDENTIFIER | IDENTIFIER "=" VARIABLE_INITIALIZER
	; 

VARIABLE_INITIALIZER
	: EXPRESSION 
	|  "{" [ VARIABLE_INITIALIZER { "," VARIABLE_INITIALIZER } [ "," ] ] "}" 
	| ( "[" [ VARIABLE_INITIALIZER { "," VARIABLE_INITIALIZER } [ "," ] ] "]" )
	;
      
EXPRESSION
	: numeric_EXPRESSION 
	| testing_EXPRESSION 
	| logical_EXPRESSION 
	| STRING_EXPRESSION 
	| BIT_EXPRESSION 
	| literal_EXPRESSION 
	| IDENTIFIER 
	| "(" EXPRESSION ")" 
	;

numeric_EXPRESSION
	: A EXPRESSION
	| EXPRESSION B1
	| EXPRESSION B2 EXPRESSION
	;
    
A
	:  "++" 
	| "--" 
	;     

B1
	: "++"  “;”
	| "--"  “;”
	; 
B2
	:    "+" 
	| "+=" 
	| "-"
	| "-="
	| "*"
	| "*=" 
	| "/"
	| "/=" 
	| "%" 
	| "%=" 
	;

testing_EXPRESSION 
	: EXPRESSION C EXPRESSION
	;
C
	:    ">" 
	| "<" 
	| ">=" 
	| "<=" 
	| "==" 
	| “===” 
	| "!="
	;  

logical_EXPRESSION
	: "!" EXPRESSION 
	| EXPRESSION D EXPRESSION
	| TRUE
	| FALSE
	| EXPRESSION ”?” EXPRESSION ”: ”EXPRESSION
	;
D
      : "&" 
      | "&=" 
      | "|" 
      | "|=" 
      | "^" 
      | "^=" 
      | "&&” 
      | "||=" 
      | "%" 
      | "%=" 
      ;

STATEMENT_block
	: "{" { STATEMENT } "}"
	;

if_STATEMENT
	: IF "(" EXPRESSION ")" STATEMENT Q
Q
	:
	| ELSE STATEMENT
	;
FOR_STATEMENT
	: FOR “(” VARIABLE_DECLARATION ”;” EXPRESSION “;” EXPRESSION “)” STATEMENT
	;      

%%      
