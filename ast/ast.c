#include"ast.h"

node* buildTree(char *op,node *left,node *right)
{
	node* new_node = (node*)malloc(sizeof(node));
	new_node->left=left;
	new_node->right=right;
	new_node->name= strdup(op);
	return new_node;
}

void printTree(node *tree)
{
	// if(tree == NULL)
	// 	return;
	if(tree->left || tree->right)
		printf("(");
	printf(" %s ",tree->name);
	if(tree->left)
		printTree(tree->left);
	if(tree->right)
		printTree(tree->right);
	if(tree->left || tree->right)
		printf(")");
	
}
/*
void printTree(node *tree,int space)
{
	if(tree == NULL)
		return;
	
	space += COUNT;
	
	printTree(tree->right, space);
	
	printf("\n");
	
	for(int i = COUNT ;i < space; i++)
		printf(" ");
	printf("%s\n",tree->name);
	
	printTree(tree->left, space);
}*/
