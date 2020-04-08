enum code {
	LIST,
	NUM,
	STR,
	SYM,
	EX_EQ,
	PLUS_OP,
	MINUS_OP,
	MUL_OP,
	DIV_OP,
	LT_OP,
	LE_OP,
	GT_OP,
	GE_OP,
	EQ_OP,
	NE_OP,
	AND_OP,
	OR_OP,
	IF_STATEMENT,
	BLOCK_STATEMENT,
	FOR_STATEMENT
};

typedef struct symbol
{
    char *name;
    char *type;
    char *value;
    int lineno;
} Symbol;
typedef struct abstract_syntax_tree {
	enum code op;
	int val;
	struct symbol *sym;
	struct abstract_syntax_tree *left, *right;
	char *str;
} AST;

extern void printAST(AST *p);
AST *makeAST(enum code op, AST *left, AST *right);
AST *makeStr(char*);
AST *addLast(AST *l, AST *p);
// #define makeList1(x1) makeAST(LIST, x1, NULL)
#define makeList2(x1, x2) makeAST(LIST, x1, makeAST(LIST, x2, NULL))
#define makeList3(x1, x2, x3) makeAST(LIST, x1, makeAST(LIST, x2, makeAST(LIST, x3, NULL)))
// #define addList(x1) ((x1->op!=LIST) ? makeList1(x1) : x1)