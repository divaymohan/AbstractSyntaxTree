%{
#include "y.tab.h"
%}


%%

[a-zA-Z0-9]+                {yylval = yytext; return VARIABLE;} 
                       /* cast pointer to int for compiler warning */
[ \t\n]               ;
"="	    return(EQUAL);
"+"      return(PLUS);
"-"      return(MINUS);
"*"      return(TIMES);
"/"      return(DIVIDE);
"("      return(LEFT_PARENTHESIS);
")"      return(RIGHT_PARENTHESIS);
";"      return(END);


%%

int yywrap (void) {return 1;}
