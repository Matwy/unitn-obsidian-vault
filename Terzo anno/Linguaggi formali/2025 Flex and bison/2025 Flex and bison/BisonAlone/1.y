/* 1.y */

%token id
%%

E : E '+' E
  | E '*' E
  | '(' E ')'
  | id
;

%%


