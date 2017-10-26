%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

  typedef struct node
  {
    struct node *left;
    struct node *right;
    char *token;
  } node;

  node *createNode(node *left, node *right, char *token);
  void printtree(node *tree);

#define YYSTYPE struct node *

%}

%start lines

%token  EQUAL
%token  VARIABLE
%token  PLUS    MINUS   TIMES 
%token  LEFT_PARENTHESIS    RIGHT_PARENTHESIS
%token  END
%right  EQUAL
%left   PLUS    MINUS
%left   TIMES	DIVIDE

%%

lines:  /* empty */
        | lines line /* do nothing */

line:   exp END     { printtree($1); printf("\n");}
    ;

exp    : term             {$$ = $1;}
	   | term EQUAL exp    {$$ = createNode($1, $3, "=");}
	   | exp PLUS term     {$$ = createNode($1, $3, "+");}
        | exp MINUS term    {$$ = createNode($1, $3, "-");}
        ;

term   : factor           {$$ = $1;}
        | term TIMES factor  {$$ = createNode($1, $3, "*");}
        | term DIVIDE factor  {$$ = createNode($1, $3, "/");}
        ;

factor : VARIABLE           {$$ = createNode(0,0,(char *)yylval);}
        | LEFT_PARENTHESIS exp RIGHT_PARENTHESIS {$$ = $2;}
        ;
%%

int main (void) {return yyparse ( );}

node *createNode(node *left, node *right, char *token)
{
  /* malloc the node */
  node *newnode = (node *)malloc(sizeof(node));
  char *newstr = (char *)malloc(strlen(token)+1);
  strcpy(newstr, token);
  newnode->left = left;
  newnode->right = right;
  newnode->token = newstr;
  return(newnode);
}

void printtree(node *tree)
{
  int i;


  if (tree->left || tree->right)
    printf("(");

  printf(" %s ", tree->token);

  if (tree->left)
    printtree(tree->left);
  if (tree->right)
    printtree(tree->right);

  if (tree->left || tree->right)
    printf(")");
}

int yyerror (char *s) {fprintf (stderr, "%s\n", s);}


