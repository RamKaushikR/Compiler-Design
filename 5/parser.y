%{
#include <stdlib.h>
#include <stdio.h>
  int yylex(void);
extern FILE *yyin;
#include "y.tab.h"
  
  int pow2(int a, int b){
    int prod = 1;
    for(int i = 0;i< b;i++)
      prod*=a;
    return prod;
  }
%}
%token INTEGER
%%
program: line program
| line

line: expr '\n' { printf("%d\n",$1); }

expr:expr '+' mulex { $$ = $1 + $3; }
     | expr '-' mulex { $$ = $1 - $3; }
     | mulex { $$ = $1; }

mulex: mulex '*' powex { $$ = $1 * $3; }
     | mulex '/' powex { $$ = $1 / $3; }
     | powex { $$ = $1; }

powex:powex '^' term {$$ = pow2($1, $3);}
     | term {$$ = $1;}

term: '(' expr ')' { $$ = $2; }
     | INTEGER { $$ = $1; }
%%
void yyerror(char *s)
{
  fprintf(stderr,"%s\n",s);
  return;
}
yywrap()
{
  return(1);
}
int main(void)
{
  char inputFile[100];
  printf("Enter the input file: ");
  scanf("%s",inputFile);
  yyin = fopen(inputFile, "r");
  yyparse();
  return 0;
}
