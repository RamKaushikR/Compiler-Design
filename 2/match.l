%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
typedef struct table {
    char identifier[32];
    char type[5];
    int start;
    int size;
    double value;
} Table;
Table t[100];
int t_index = 0, base = 1000, flag, fg[20], cn = 0; 
char symbols[20][20], values[20][20], dtype[20][20];
%}
keyword ("auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while")
function [a-zA-Z_][a-zA-Z0-9_]*[(].*[)]
identifier [a-zA-Z_][a-zA-Z0-9_]*
int_constant [0-9]+
float_constant [0-9]+.[0-9]+
%%
^#.* { printf("%s - preprocessor directive\n", yytext); }
{keyword} {
    int i = 0;
    char s[10]; strcpy(s, yytext);
    while(s[i++] != '\0') if(s[i] == ' ' || s[i] == '\t' || s[i] == '\n') s[i] = ' ';
    printf("%s - keyword\n", s);

    if(strcmp(s, "int") == 0) 
        flag = 2;
    else if(strcmp(s, "float") == 0)
        flag = 4;
        
}
{function} { printf("%s - function call\n", yytext); }
{identifier} {
    printf("%s - identifier\n", yytext);
    strcpy(symbols[cn], yytext);
}
{int_constant} {
    printf("%s - integer constant\n", yytext);
    strcpy(values[cn],yytext);
    fg[cn] = flag;
    strcpy(dtype[cn], "int");
    cn++; 
}
{float_constant} {
    printf("%s - float/double constant\n", yytext);
    strcpy(values[cn],yytext);
    fg[cn] = flag;
    strcpy(dtype[cn], "float");
    cn++; 
}
("<"|"<="|">"|">="|"=="|"!=") { printf("%s - relational operator\n", yytext); }
= { printf("%s - assignment operator\n", yytext); }

[{}(),;] { printf("%s - special character\n", yytext); }
. { }
\n { }
%%
int main(int argc, char* argv[])
{
    yyin = fopen(argv[1], "r");
    yylex();

    for(int i = 0; i < cn; i++) {
	printf("%s\t%s\t%d\t%d\t%s\n", symbols[i], dtype[i], fg[i], base, values[i]);
        base += fg[i];
    }
    return 0;
}
