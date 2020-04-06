%{
	#include<stdio.h>
	#include<string.h>
	
	#include"symtable.h"
	#include"y.tab.h"
	void createEntry(char* ,char*, char*);
	void showTable();
	int alreadyexists(char *);
	void putkwd();
	char* getVal(char* name);
	int getPos(char* name);
	void addVal(char * name,char* value);
	#define MAX_ENTRIES 100
	SymbolTable s[MAX_ENTRIES];
	int n = 0;

%}
cmt_start \/\*
cmt_end \*\/
%%
"show" {showTable();}
"\n" {yylineno++;}
[\/\/].* ; //ignore comment
{cmt_start}[^*/]*{cmt_end} ; //ignore block comment
[ \t]+ ; //ignore whitespace {}
"var"	{ return VAR; }

"true"					{ yylval.intVal = 1; return(TRUE); }
"false"					{ yylval.intVal = 0; return(FALSE); }

"return"				{ return(RETURN); }
"for"					{ return(FOR); }
"continue"				{ return(CONTINUE); }
"if"					{ return(IF); }
"else"					{ return(ELSE); }
"break"					{ return(BREAK); }

[a-zA-Z_][a-zA-Z0-9_]* {yylval.text = strdup(yytext); return(IDENTIFIER);}

[0-9]*					{/*yylval.intVal=atoi(yytext);*/ yylval.text = strdup(yytext);
return INT_LITERAL; }

"&&"					{ return AND_OP; }
"||"					{ return OR_OP; }
"<="					{ return LE_OP; }
">="					{ return GE_OP; }
"<"					{return L_OP;}
">"					{return G_OP;}	
"=="					{ return EQ_OP; }
"==="					{ return TEQ_OP; }
"!="					{ return NE_OP; }
";"					{ return SC; }
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

\"(\\.|[^"\\])*\"			{yylval.text = strdup(yytext);return STRING_LITERAL;}
.				{printf("Lexeme error at line %d\n", yylineno) ;}
%%

//enters keyword into symbol table, has to be called intially
void putkwd(){
	createEntry("return", "keyword","");
	createEntry("for", "keyword","");
	createEntry("continue", "keyword","");
	createEntry("break", "keyword","");
	createEntry("if", "keyword","");
	createEntry("else", "keyword","");
	createEntry("true", "keyword","");
	createEntry("false", "keyword","");
	createEntry("var", "keyword","");
}

void createEntry(char *name, char *type, char *value){
	char *s_name = strdup(name);
	char *s_type = strdup(type);
	char *s_value = strdup(value);
	if(n < MAX_ENTRIES){
		int pos = getPos(s_name);
		if(pos==-1){
			int index = n++;
			s[index].name = s_name;
			s[index].type = s_type;
			s[index].value=s_value;
			s[index].lineno=yylineno;
			//s[index].scope=scope;
		}else{
			s[pos].value = s_value;
			s[pos].lineno=yylineno;
		}
	}
	//return getToken(s_name);
}

void showTable(){
    int i=0;
	printf("\n\t------------------------------------------------------");
    printf("\n\tName\tType\tValue\tLine number\n");
	printf("\n\t------------------------------------------------------");
    for(i;i<n;i++){
    	printf("\n\t%s\t%s\t%s\t%d",s[i].name, s[i].type, s[i].value, s[i].lineno);
		
	}
}

int getPos(char * name){
	for(int i=0;i<n;i++){
		if(strcmp(name,s[i].name)==0){
			return i; 
		}
	}
	return -1;
}