#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include"ast.h"



char *code_name(enum code op)
{
	switch (op) {
	case LIST:
		return "LIST";
	case NUM:
		return "NUM";
	case STR:
		return "STR";
	case SYM:
		return "SYM";
	case EX_EQ:
		return "EX_EQ";
	case PLUS_OP:
		return "PLUS_OP";
	case MINUS_OP:
		return "MINUS_OP";
	case MUL_OP:
		return "MUL_OP";
	case LT_OP:
		return "LT_OP";
	case GT_OP:
		return "GT_OP";
	case IF_STATEMENT:
		return "IF_STATEMENT";
	case BLOCK_STATEMENT:
		return "BLOCK_STATEMENT";
	case FOR_STATEMENT:
		return "FOR_STATEMENT";
	default:
		return "???";
	}
}

void _printAST(AST *p)
{
	if (p == NULL) {
		printf("()");
		return;
	}
	switch (p->op) {
	case NUM:
		printf("%d", p->val);
		break;
	case STR:
		printf("'%s'", p->str);
		break;
	case SYM:
		printf("'%s'", p->sym->name);
		break;
	case LIST:
		printf("(LIST ");
		while (p != NULL) {
			_printAST(p->left);
			p = p->right;
			if (p != NULL) {
				printf(" ");
			}
		}
		printf(")");
		break;
	default:
		printf("(%s ", code_name(p->op));
		_printAST(p->left);
		printf(" ");
		_printAST(p->right);
		printf(")");
	}
	fflush(stdout);
}
void printAST(AST *p)
{
	printf("\033[1m\033[35m");
	_printAST(p);
	printf("\033[0m\n");
}

Symbol s[100];
int n = 0;
#define MAX_ENTRIES 100

int getPos(char * name){
	for(int i=0;i<n;i++){
		if(strcmp(name,s[i].name)==0){
			return i; 
		}
	}
	return -1;
}

Symbol* createEntry(char *name, char *type, char *value, int lineno){
	Symbol *sp = NULL;
	char *s_name = strdup(name);;
	char *s_type = strdup(type);
	char *s_value = strdup(value);
	if(n < MAX_ENTRIES){
		int pos = getPos(s_name);
		if(pos==-1){
			sp = &s[n++];
			sp->name = s_name;
			sp->type = s_type;
			sp->value = s_value;
			sp->lineno = lineno;
			//s[index].scope=scope;
		}else{
			sp = &s[pos];
			s[pos].value = s_value;
			s[pos].lineno = lineno;
		}
	}
	return sp;
}

AST *makeNum(int val)
{
	AST *p = (AST *)malloc(sizeof(AST));
	p->op = NUM;
	// printf("%p\n",p);
	// printf("%ld\n",sizeof(p));
	p->val = val;
	return p;
}

AST *makeStr(char *s)
{
	AST *p = (AST *)malloc(sizeof(AST));
	p->op = STR;
	p->str = s;
	return p;
}

AST *makeSymbol(char *name, int lineno)
{
	//printf("SYM:[%s]\n", name);
	AST *p = (AST *)malloc(sizeof(AST));
	p->op = SYM;
	p->sym = createEntry(name,"id", "", lineno);
	return p;
}

AST *makeAST(enum code op, AST *left, AST *right)
{
//	printf("[%d,%x,%x]\n",op,left,right);
	AST *p = (AST *)malloc(sizeof(AST));
	p->op = op;
	p->left = left;
	p->right = right;
	return p;
}

//enters keyword into symbol table, has to be called intially
void putkwd(){
	createEntry("return", "keyword","",-1);
	createEntry("for", "keyword","",-1);
	createEntry("continue", "keyword","",-1);
	createEntry("break", "keyword","",-1);
	createEntry("if", "keyword","",-1);
	createEntry("else", "keyword","",-1);
	createEntry("true", "keyword","",-1);
	createEntry("false", "keyword","",-1);
	createEntry("var", "keyword","",-1);	
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

char* copyVal(char *set, char * name){
	char *ret;
	for(int i=0;i<n;i++){
		if(strcmp(name,s[i].name)==0){
			ret = malloc(strlen(s[i].value));
			strcpy(ret, s[i].value);
			return ret; 
		}
	}
	ret = malloc(1);
	strcpy(ret,"");
	return ret;
}