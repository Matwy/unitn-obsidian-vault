/* 3.y */

%token id

%left '+'
%left '*'


%%

E : E '+' E
  | E '*' E
  | '(' E ')'
  | id
;

%%


