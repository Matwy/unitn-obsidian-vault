---
date: 2024/06/08
tags: 
Materia: "[[Programmazione funzionale]]"
---
# Part 1
## Prolog Horn clauses
- Nei logic languages scriviamo assiomi sotto forma di **Horn Clause**
#### Horn clause
- E' composta da **head** e **body**
	- Esempio `H: B1, B2, .., Bn`
	- se tutti i `B1 ... Bn` sono veri allora H è vera
- Per derivare nuovi statement un sistema di programmazione logica **combina** le clause esistenti per formarne di nuove in uno processo chiamato **resolution**
#### Prolog
- Un interprete prolog ha un database di clauses che sono assunte vere
- Ogni **clause** è composta da **terms**
##### Term
- Un **term** può essere:
	- Una **constant**
		- **Atom** un identifier che inizia con lettere minuscole o una sequenza di "punctuation" characters o una stringa tra virgolette
		- Un **numero**
	- Una **variable**
		- Come un identifier ma inizia con lettera maiuscola
		- Le variabili possono assumere valori a runtime come risultato di unification
	- Una **structure**
		- un predicato logico
		- una data structure
##### Structures
- Le strutture consistono in **atom** chiamati **functor** e liste di argomenti
	- `teaches(scott, cs354)`
- Usiamo il termine **predicato** per riferirci alla combinazione di **functor** e un "arity" (numero di argomenti)

##### Clauses facts and rules
- Le **clauses** in un database prolog sono classificate in 
	- **facts**
	- **rules**
- Entrambe terminano con un **period**
###### Fact
- Un **Fact** è una horn clause senza la parte a destra
- Esempio
	- `p(t1, ..., tn).`
	- `p` è il nome del **fact** e `t1, ..., tn` sono i **terms** 
###### Rule
- Una **rule** ha il lato destro
- Esempio
	- `snowy(X):-rainy(X), cold(X).`
	- Il `:-` è l'implication symbol
	- e la virgola indica "and"
	- `X` è snowy se `X` è rainy e `X` è  cold
##### Query (or goal)
- **Goal** il predicato che speriamo sia vero
- Clause senza il lato sinistro
	- Queries non appaiono nei programmi prolog
	- Uno si deve costruire il database di facts and rules e poi inizializza l'esecuzione facendo la query a cui il programma deve rispondere
	- nella maggior parte delle implementazioni di prolog le query sono inserite con `?-` una versione speciale del simbolo di implicazione
- Esempio
```
rainy(seattle).
rainy(rochester).
?-rainy(C).
```
- prolog risponde con `C = seattle` perchè seattle è la prima risposta che ha trovato
- se noi rispondiamo con `;` cercherà un'altra risposta

## Resolution and unification
#### Resolution
- Il principio di risoluzione (Robinson) dice che se `C1` e `C2` sono horn clauses e la head di `C1` matcha con uno dei termini del body di `C2`, allora possiamo rimpiazzare i termini in `C2` con il body di `C1`

- Esempio
```
takes(alice, his201).
takes(alice, cs254).
takes(bob, art302).
takes(bob, cs254).
classmates(X, Y) :- takes(X, Z), takes(Y, Z).
```
- usando la regola viene fuori `classmates(alice, Y) :- takes(Y, cs254).`
#### Unification
- Il processo usato per associare X a alice e Z con cs254 è conosciuto come **unification**
- Le variabili a cui sono stati dati valori come risultato dell'unificazione sono dette instantiated
#### Unification in Prolog
- **Unification** è una key feature in prolog
- due termini vengono uniti se
	- **Identical**
		- `?- takes(alice, cs254). -> unifies directly with the fact`
	- possono essere resi identici **sostituendo** variabili
		- `?- takes(alice, X). -> variable X is instantiated with cs254`
- L'idea di unire il **goal** con la **head** di una **rule**
	- Se funziona allora le clauses nel body diventano subgoals
	- continua fino a quando le subgoals non sono soddisfatte
		- Se la ricerca fallisce torna indietro e riprova con le subgoals non ancora provate

##### Unification rules in Prolog
- Una **constant** si unisce solo con se stessa
- Due **strutture** si uniscono se e solo se hanno lo stesso functor e lo stesso numero di argomenti e gli argomenti si corrispondono ricorsivamente
- Una **variable** si unisce con tutto
	-  Se l'altra cosa ha un valore allora la variabile è instantiated
	- se l'altra cosa è una variabile non instantiated allora le due variabili vengono associate in modo che successivamente una delle due riceve un valore lo ricevono entrambe

##### Equality in prolog
- **Equality** in prolog è definita in termini di "**unifiability**"
- Il goal `?-A=B.` Ha successo se e solo se `A` e `B` possono essere unite

##### Arithmetic
- I solito operatori aritmetici sono disponibili in prolog ma svolgono la funzione di **predicati** non di funzioni
	- `+(2, 3)` che può anche essere scritto `2+3` è una struttura a due argomenti non una funzione 
	- Questo vuol dire che non si uniscono a 5
	- `?- (2+3) = 5.` `false`
- per gestire l'aritmetica Prolog usa `is`
- `?- is(X, 1+2).` `X=3`
- `?- X is 1+2,` `X=3`
- `?- 1+2 is 4-1,` `false`
- `?-X is Y` `<error> Arguments are not sufficiently instantiated`
- `?- Y is 1+2, X is Y` `Y=X, Y =3`

##### Lists
- Una list è un sequenza finita di elementi
- Example
	- `[a,c,2,'hi',[W,3]]`
- **empty list** `[]`
###### Head and Tail
- Una lista non vuota può essere pensata come divisa in due parti
	- La **Head**
	- La **tail**
- Come in ML la testa è il primo elemento
- La tail è tutto il resto
- vedi esempi anche con la **vertical** **bar** per capire bene 
	- [[L6.1 - Logic Programming_09042024.pdf#page=67&selection=0,8,0,8|Head Tail Vertical Bar in Prolog List]]
###### List Matching
- `?-[X,1,Z]=[a,_,17]` `X=a, Z=17`
- `_` è la variabile anonima usata quando non ci interessa il suo valore
---
# Part 2
## Prolog terminology
#### ground and nonground
- Un **goal** o un **term** senza variabili viene chiamato **ground** altrimenti viene chiamato **nonground**
- Esempio 
	- `foo(a, b)` **ground**
	- `bar(X)` **nonground**

#### Substitution
- Una sostituzione $\theta$ è una mappa da variabili a termini dove:
$$
domain(\theta) \cap range(\theta) = \varnothing
$$
- **OSS** non possiamo sostituire una variabile con se stessa
- Unire due termini s e t significa trovare una sostituzione $\theta$ alle loro variabili
## Search/execution order
- Due strategie
	- **Forward chaining**
		- Parti con le clauses  e cerchi di derivare il goal
	- **Backward chaining**
		- Parti con il goal e cerchi di scomporlo in clauses già esistenti

- In generale meglio **backward** **chaining** (usata da Prolog)
#### Search order
- In prolog uniamo i termini sulla destra con le **head** delle altre clauses ottenendo un **albero di subgoals**
- Metodo di esplorazione dell'albero
	- **Depth-first and left to right**
![[Pasted image 20240608112652.png|center|550]]
##### Evaluation
- L'interprete Prolog parte all'inizio del DB cercando una regola la cui testa possa venir unificata al top level goal
- poi prende il body della regola e considera i termini dei subgoals e cerca di soddisfarli ricorsivamente da sinistra a destra
- se ad un certo punto un subgoals fallisce l'interprete torna al subgoal precedente e cerca di soddisfarlo in un altro modo (**backtracking**)
#### Backtracking
- Lo spazio usato per la backtracking search in Prolog usa un solo **stack** solitamente (sia per l'esecuzione sia per la scelta)
- L'interprete mette un frame nello stack ogni volta che insegue un nuovo subgoal `G`
- if `G` fallisce il frame viene popped dallo stack e l'interprete inizia a fare backtrack
- if `G` ha successo il controllo ritorna al caller il genitore nel search tree
- `G` non fallisce a meno che tutti i suoi subgoals e tutti i sibling alla destra del search tree falliscono anche loro, implicando che non c'è nulla sopra al frame di `G` nello stack
- Quando all'interprete diamo `;` lui lo prende come un fallimento del subgoal appena soddisfatto
---
### Cut
- Impedisce al backtracking di provare altre vie oltre a quella in cui si è in quel momento
- `if-then-else`
```
statement:- condition, !, then.
statement:- else.
```
### The negation
- `not(G)`
- valuta il contenuto di G e se termina con un fallimento allora il goal not(G) ha successo
- `not` è implementata con una combinazione di cut e altri due predicati `call` e `fail`
	- `not(P) :- call(P), !, fail.`

### Call and fail
- `call` prende un term come argomento e cerca di soddisfare il goal
- `fail` fallisce sempre
----
## IO built-in predicates
- `write` and `nl` print to the current output file
- `read` legge terms dal current input file
- `get` and `put` singolo carattere lettura scrittura
- `consult` and `reconsult` leggono le clauses da un file

#### repeat
- Il predicato `repeat`  può avere successo  un numero arbitrario di volte
#### assert
- Permette al programma di aggiungere delle clause al database
#### retract
- rimuove la clause dal database
----
## In generale
### Vantaggi
- possiamo usare un programma in più di un modo
- possiamo ottenere molteplici soluzioni
- possiamo guardare un programma come una formula logica
### Contro
- Il backtracking può essere inefficente
- non ci sono tipi e moduli
- non è molto sviluppato come ambiente di sviluppo
