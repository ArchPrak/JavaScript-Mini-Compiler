%{
    #include<string.h>
    #include<stdio.h>
    int line = 0;
    //#define YYSTYPE char *
%}

alpha [A-Za-z_]
digit [0-9]
%option yylineno
%%
[ \t\n] {yylval.text= strdup(yytext);}
"while" {yylval.text = strdup(yytext);return WHILE;}
"for" {yylval.text = strdup(yytext);return FOR;}
"if" {yylval.text = strdup(yytext);return IF;}
"else" {yylval.text = strdup(yytext);return ELSE;}
"var" {yylval.text = strdup(yytext);return VAR;}

"break" {yylval.text = strdup(yytext);return BREAK;}
"continue" {yylval.text = strdup(yytext);return CONTINUE;}
{digit}+    {yylval.text = strdup(yytext);return NUM;}

{alpha}({alpha}|{digit})* {yylval.text = strdup(yytext);return ID;}
\".*\" {yylval.text = strdup(yytext);return STRING;}
"<" {yylval.text = strdup(yytext);return T_lt;}
">"     {yylval.text = strdup(yytext);return T_gt;}
"="     {yylval.text = strdup(yytext);return T_eq;}
"<="    {yylval.text = strdup(yytext);return T_lteq;}
">="    {yylval.text = strdup(yytext);return T_gteq;}
"=="    {yylval.text = strdup(yytext);return T_eqeq;}
"!="    {yylval.text = strdup(yytext);return T_neq;}
"+"     {yylval.text = strdup(yytext);return T_pl;}
"-"     {yylval.text= strdup(yytext);return T_min;}
"*"     {yylval.text = strdup(yytext);return T_mul;}
"/"     {yylval.text = strdup(yytext);return T_div;}
"++"    {yylval.text = strdup(yytext);return T_incr;}
"--"    {yylval.text = strdup(yytext);return T_decr;}
"!"     {yylval.text = strdup(yytext);return T_neq;}
"||"    {yylval.text = strdup(yytext);return T_or;}
"&&"    {yylval.text = strdup(yytext);return T_and;}

.    return yytext[0];

%%
