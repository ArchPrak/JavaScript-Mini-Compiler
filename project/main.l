%{
    #include<stdio.h>
    #include<string.h>
    #include"symtable.h"
	#include"y.tab.h"
    void createEntry(char* ,char*, char*,int);
    void showTable();
	int alreadyexists(char *);
	void putkwd();
    #define MAX_ENTRIES 100
%}
cmt_start \/\*
cmt_end \*\/
%%
"show" {showTable();}
"\n" {yylineno++;}
[\/\/].* ; //ignore comment
{cmt_start}[^*/]*{cmt_end} ; //ignore block comment
[ \t]+ ; //ignore whitespace {}
"var"	{ createEntry("var", "keyword","",yylineno); return VAR; }

"true"					{ yylval.intVal = 1; createEntry("true", "boolean","",yylineno); return(TRUE); }
"false"					{ yylval.intVal = 0; createEntry("false", "boolean","",yylineno); return(FALSE); }

"return"				{ createEntry("return", "keyword","",yylineno);return(RETURN); }
"for"					{ createEntry("for", "keyword","",yylineno);return(FOR); }
"continue"				{ createEntry("continue", "keyword","",yylineno);return(CONTINUE); }
"if"					{ createEntry("if", "keyword","",yylineno);return(IF); }
"else"					{ createEntry("else", "keyword","",yylineno);return(ELSE); }
"break"					{ createEntry("break", "keyword","",yylineno);return(BREAK); }

[a-zA-Z_][a-zA-Z0-9_]* {createEntry(yytext,"id","",yylineno); return(IDENTIFIER);}
[0-9]*					{return INT_LITERAL; }
"&&"					{ return AND_OP; }
"||"					{ return OR_OP; }
"<="					{ return LE_OP; }
">="					{ return GE_OP; }
"=="					{ return EQ_OP; }
"!="					{ return NE_OP; }
";"					{ return ';'; }
"("					{ return '('; }
")"					{ return ')'; }
"="					{ return '='; }
"+"					{ return '+'; }
"-"					{ return '-'; }
"{"					{ return '{'; }
"}"					{ return '}'; }

"++"					{ return INC_OP; }
"--"					{ return DEC_OP; }
","					{ return ','; }

\"(\\.|[^"\\])*\"			{return STRING_LITERAL;}
.				{printf("Lexeme error at line %d\n", yylineno) ;}
%%

SymbolTable s[MAX_ENTRIES];
int n = 0;

// int main(){
// 	yylex();
// }

//enters keyword into symbol table, has to be called intially
void putkwd(){
	createEntry("return", "","",-1);
	createEntry("for", "","",-1);
	createEntry("continue", "","",-1);
	createEntry("break", "","",-1);
	createEntry("if", "","",-1);
	createEntry("else", "","",-1);
	createEntry("true", "","",-1);
	createEntry("false", "","",-1);
	createEntry("var", "","",-1);
}

void createEntry(char *name, char *type,char *value, int lineno){
//void createEntry(char *name, char *type,char *value){
    char *s_name = strdup(name);
    char *s_type = strdup(type);
    char *s_value = strdup(value);
	if(!alreadyexists(s_name) && n < MAX_ENTRIES){
        int index = n++;
        s[index].name = s_name;
        s[index].type = s_type;
	s[index].value=s_value;
        s[index].lineno=lineno;
		//s[index].scope=scope;
		//printf("Entry added\n");
	}
	//return getToken(s_name);
}

int alreadyexists(char * lexeme){
	for(int i=0;i<n;i++){
		if (strcmp(s[i].name,lexeme)==0)
			return 1;
	}
	return 0;
}

void showTable(){
    int i=0;
    printf("\t\t\tName\tType\tValue\tLine number\n");
	
    for(i;i<n;i++){
    	
        printf("\n\t\t\t%s\t%s\t%s\t%d\n", s[i].name, s[i].type,s[i].value,s[i].lineno);
		//printf("%s\t%s\t%s\n", s[i].name, s[i].type,s[i].value);
	}
}
