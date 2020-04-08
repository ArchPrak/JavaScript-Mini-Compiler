%{
    #include<string.h>
    #include<stdio.h>
    #include "y.tab.h"
    extern void showTable(void);
    extern AST *makeNum(int val);
    extern AST *makeStr(char *s);
    extern AST *makeSymbol(char *name, int lineno);
%}
alpha [A-Za-z_]
digit [0-9]
cmt_start \/\*
cmt_end \*\/

%option yylineno

%%
"show" {showTable();}
[\/\/].* ; //ignore comment
{cmt_start}[^*/]*{cmt_end} ; //ignore block comment
[ \t\n]+ ; //ignore whitespace {}

"true"					{ yylval.node = makeNum(1); return(TRUE); }
"false"					{ yylval.node = makeNum(0); return(FALSE); }

"var"	                { return VAR; }
"return"				{ return(RETURN); }
"for"					{ return(FOR); }
"continue"				{ return(CONTINUE); }
"if"					{ return(IF); }
"else"					{ return(ELSE); }
"break"					{ return(BREAK); }
	
[a-zA-Z_][a-zA-Z0-9_]*  {yylval.node = makeSymbol(strdup(yytext), yylineno); return(IDENTIFIER);}

[0-9]*					{yylval.node = makeNum(atoi(strdup(yytext))); return INT_LITERAL;}
	
\"(\\.|[^"\\])*\"       {yylval.node = makeStr(strdup(yytext));return(STRING_LITERAL);}
"&&"					{ return AND_OP; }
"||"					{ return OR_OP; }
"<="					{ return LE1_OP; }
">="					{ return GE1_OP; }
"<"					    { return L_OP;}
">"					    { return G_OP;}	
"=="					{ return EQ1_OP; }
"!="					{ return NE1_OP; }
";"					    { return SC; }
"++"					{ return INC_OP; }
"--"					{ return DEC_OP; }

"!"     {return NOT_OP;}

.    return yytext[0];

%% 

// int main(){
//     yylex();
// }