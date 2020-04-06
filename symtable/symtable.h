typedef struct symtable
{
    char *name;
    char *type;
    char *value;
    int lineno;
} SymbolTable;
extern SymbolTable s[100];
