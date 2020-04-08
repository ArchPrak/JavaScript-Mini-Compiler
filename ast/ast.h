enum code {
	LIST,
	NUM,
	STR,
	SYM,
	EX_EQ,
	PLUS_OP,
	MINUS_OP,
	MUL_OP,
	LT_OP,
	LE_OP,
	GT_OP,
	GE_OP,
	EQ_OP,
	NE_OP,
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