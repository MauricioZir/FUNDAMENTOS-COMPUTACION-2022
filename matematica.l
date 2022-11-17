%option noyywrap
%{
    #include <stdlib.h>
    #include "y.tab.h"
    void yyerror(char *);
%}

%%
[-]*([0-9]+|[0-9]*\.[0-9]+) {
                yylval.dval = atof(yytext);
                return NUMERO;
            }
[-+()=/^*,\n] { return *yytext; }
"raiz"      return RAIZ;
"log"	    return LOG;
"seno"      return SENO;
"coseno"    return COSENO;
"tangente"  return TANGENTE;
"aseno"      return ASENO;
"acoseno"    return ACOSENO;
"atangente"  return ATANGENTE;
[ \t]        ;
.               yyerror("invalid character");
%%