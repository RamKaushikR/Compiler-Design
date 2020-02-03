#include<stdio.h>
#include<string.h>
#include<stdlib.h>

void E(char[],int*);
void T(char[],int*);
void Tprime(char[],int*);
void Eprime(char[],int*);
void F(char[],int*);


void E(char a[],int* n) {
  printf("In E\n");
  T(a,n);
  Eprime(a,n);
}

void Eprime(char a[], int *n) {
  printf("In E\'\n");
  if(a[*n]=='+'){
    printf("encountered + symbol : pointer advanced\n");
    (*n)++;
      T(a,n);
      Eprime(a,n);
  }
  else 
    return;
}

void T(char a[],int *n) {
  printf("In T\n");
  F(a,n);
  Tprime(a,n);
}

void Tprime(char a[],int *n) {
  printf("In T\'\n");
  if(a[*n]=='*') {
    printf("encountered * symbol : pointer advanced\n");
    (*n)++;

      F(a,n);
      Tprime(a,n);
  }
  else
    return;
}

void F(char a[],int *n) {
  printf("In F\n");
  if(a[*n]=='(') {
    printf("encountered ( symbol : pointer advanced \n");
    (*n)++;
    printf("\n");
    E(a,n);
    if(a[*n]==')') {
      printf("encountered ) symbol : pointer advanced\n");
      (*n)++;
      if(*n==strlen(a)) {
        printf("Parsing Complete string accepted\n");
        exit(0);
      }
    }
  }
  else if(a[*n]=='i' && a[*n+1]=='d') {
    printf("encountered id symbol : pointer advanced\n");
    (*n)+=2;
    if(*n==strlen(a)) {
      printf("Parsing Complete string accepted\n");
      exit(0);
    }
  }
  else {
    printf("Parsing error: String not accepted\n");
    exit(0);
  }
}

int main() {
  char a[100];
  int n = 0;
  printf("Enter the String to be parsed: ");
  scanf("%s", a);
  E(a,&n);
}
