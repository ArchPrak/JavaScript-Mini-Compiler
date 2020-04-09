%{
    #include<string.h>
    #include<stdio.h>
    int line = 0;
    #define YYSTYPE char *
%}


cmt_start \/\*
cmt_end \*\/
alpha [A-Za-z_]
digit [0-9]
%option yylineno
%%
[\/\/].* ; //ignore comment
{cmt_start}[^*/]*{cmt_end} ; //ignore block comment

[ \t\n] {yylval= strdup(yytext);}
"while" {yylval = strdup(yytext);return WHILE;}
"for" {yylval = strdup(yytext);return FOR;}
"if" {yylval = strdup(yytext);return IF;}
"else" {yylval = strdup(yytext);return ELSE;}
"var" {yylval = strdup(yytext);return VAR;}

"break" {yylval= strdup(yytext);return BREAK;}
"continue" {yylval= strdup(yytext);return CONTINUE;}
{digit}+    {yylval= strdup(yytext);return NUM;}

{alpha}({alpha}|{digit})* {yylval= strdup(yytext);return ID;}
\".*\" {yylval = strdup(yytext);return STRING;}
"<" {yylval= strdup(yytext);return T_lt;}
">"     {yylval= strdup(yytext);return T_gt;}
"="     {yylval= strdup(yytext);return T_eq;}
"<="    {yylval= strdup(yytext);return T_lteq;}
">="    {yylval= strdup(yytext);return T_gteq;}
"=="    {yylval= strdup(yytext);return T_eqeq;}
"!="    {yylval= strdup(yytext);return T_neq;}
"+"     {yylval = strdup(yytext);return T_pl;}
"-"     {yylval= strdup(yytext);return T_min;}
"*"     {yylval = strdup(yytext);return T_mul;}
"/"     {yylval = strdup(yytext);return T_div;}
"++"    {yylval= strdup(yytext);return T_incr;}
"--"    {yylval = strdup(yytext);return T_decr;}
"!"     {yylval = strdup(yytext);return T_neq;}
"||"    {yylval = strdup(yytext);return T_or;}
"&&"    {yylval = strdup(yytext);return T_and;}

.    return yytext[0];

%%
