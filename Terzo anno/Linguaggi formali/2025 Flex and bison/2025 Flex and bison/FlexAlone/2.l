/* 2.l */



%{
int yylineno;
%}
%%
^(.*)\n printf("%4d\t%s", yylineno++, yytext);   /* "^" indica l'inizio di una riga */
%%
int main(int argc, char *argv[]) {
     yyin = fopen(argv[1], "r");
     yylex();
     fclose(yyin);
}
