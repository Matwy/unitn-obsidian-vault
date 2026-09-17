FLEX ALONE, README



flex: default action is ECHO

-------------

***1.l

$ flex 1.l  %% aggiunge numero di linea
$ gcc lex.yy.c -lfl
$ ./a < input-file.txt > output-file.txt

-------------

***2.l  %% aggiunge numero di linea, previsto il file argomento
$ flex 2.l
$ gcc lex.yy.c -lfl
$ ./a input-file.txt

-------------

***3.l %% conta identificatori
$ flex 3.l
$ gcc lex.yy.c -lfl
$ ./a < input-file.txt


-------------

***4.l %% conta caratteri, parole, linee
$ flex 4.l
$ gcc lex.yy.c -lfl
$ ./a < input-file.txt > output-file.txt
$ ./a < input-file.txt



