%{
    #include<string.h>
    #include<stdio.h>
    #include "y.tab.h"
%}

alpha [A-Za-z_]
digit [0-9]

%%
[ \t\n] ;

 	
"for" {return FOR;}
"if" {return IF;}
"else" {return ELSE;}
"var" {return VAR; }
	
"break" {return BREAK;}
"continue" {return CONTINUE;}
	
"float" {return FLOAT;}
	
{digit}+    {yylval.text = yytext; return NUM;}
{digit}+.{digit}+ {return FLOAT;}
{alpha}({alpha}|{digit})* {yylval.text = yytext;return ID;}
	
\".*\" {yylval.text = yytext;return STRING;}
"<" {return T_lt;}
">"     {return T_gt;}
"="     {return T_eq;}
"<="    {return T_lteq;}
">="    {return T_gteq;}
"=="    {return T_eqeq;}
"==="	{return T_teq;}
"!="    {return T_neq;}
"+"     {return T_pl;}
"-"     {return T_min;}
"*"     {return T_mul;}
"/"     {return T_div;}
	
"!"     {return T_neq;}
"||"    {return T_or;}
"&&"    {return T_and;}


.    return yytext[0];

%%
int yywrap (void)
{return 1;} 

