BISON ALONE, README



espilon e' reso con il blank
default in caso di s/r conflict: shift
default in caso di r/r conflict: ridurre la produzione piu' che occorre prima nella lista



-------------

***1.y %% espressioni aritmetiche, grammatica ambigua

$ bison 1.y
1.y: warning: 4 shift/reduce conflicts [-Wconflicts-sr]
1.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples


-------------


***2.y %% espressioni aritmetiche, grammatica non ambigua
$ bison 2.y
$ bison -g 2.y %% produce 2.gv da aprire con un qualunque interprete del dot language per grafi



-------------

***3.y %% espressioni aritmetiche, grammatica ambigua, convenzioni esplicite su associativita' e precedenza 
$ bison 3.y


