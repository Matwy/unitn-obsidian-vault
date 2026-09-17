/* 1.l */



%{
int yylineno;
%}
%%
^(.*)\n printf("%4d\t%s", yylineno++, yytext);   /* "^" indica l'inizio di una riga */
%%
int main(void) {
     yylex();
}
