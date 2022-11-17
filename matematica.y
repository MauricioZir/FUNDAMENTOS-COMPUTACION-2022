%{
#include <stdio.h>
#include <string.h>
#include <math.h>
void yyerror(){
	printf("error");
}
int yywrap(){
	return 1;
}
main(){
	yyparse();
}
%}
%union
{	
	double dval;
}
%token NUMERO RAIZ LOG SENO COSENO TANGENTE ASENO ACOSENO ATANGENTE
%type <dval> NUMERO
%type <dval> resultado expr
%left '+' '-'
%left '*' '/'
%left '^'
%%
programa:
       programa resultado '\n'
       |
       ;
resultado:
        expr                      { printf("%g\n", $1); }
	;
expr:
        NUMERO
        | expr '+' expr                         { $$ = $1 + $3;}
        | expr '-' expr                         { $$ = $1 - $3;}
        | expr '*' expr                         { $$ = $1 * $3;}
        | expr '/' expr                         { $$ = $1 / $3;}
        | '(' expr ')'                          { $$ = $2;}
        | expr '^' expr                         { $$ = pow($1, $3);}
        | RAIZ '(' expr ',' expr ')'            
	  { 
                if($3>0){$$ = pow($3, 1/$5);}
                if(fmod($5,2) !=0 && $3<0){$$ = -pow(-$3, 1/$5);}
		else{printf("ERROR! No esta definido raiz de indice par y argumento negativo\n");}
          }
        | LOG '(' expr ',' expr ')'             
	  { 
		if($3>0 && $5>0 && $5!=1){$$ = log($3) / log($5);}
                else{printf("ERROR! El dominio del argumento de la funcion logaritmo es (0,infinito) y de la base es (0,infinito)-{1}\n");}		
	  }
        | SENO '(' expr ')'                     { $$ = sin($3);}
        | COSENO '(' expr ')'                   { $$ = cos($3);}
        | TANGENTE '(' expr ')'                 { $$ = tan($3);}
        | ASENO '(' expr ')'                    
	  { 
		if($3 >= -1 && $3 <= 1){$$ = asin($3);}
		else{printf("ERROR! El dominio de la funcion seno^-1 es [-1,1]\n");}
	  }
        | ACOSENO '(' expr ')'                 
	  { 
		if($3 >= -1 && $3 <= 1){$$ = acos($3);}
		else{printf("ERROR! El dominio de la funcion coseno^-1 es [-1,1]\n");}
	  }
        | ATANGENTE '(' expr ')'                { $$ = atan($3);}
	;