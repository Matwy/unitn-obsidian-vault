---
date: 2024-06-07
Materia: "[[Programmazione funzionale]]"
Argomento: "[[4 Control Structures and abstraction]]"
---
# Higher Order Function
#### Funzioni come parametro
- si usa un puntatore all'activation record nello stack
---
#### Binding policy
##### deep binding
- può essere usato sia con scoping statico sia dinamico
- l'enviroment usato nel momento in cui usiamo la funzione passata come parametro è quello al momento della creazione del link
- bisogna salvare lo scope in modo da riattivarlo quando necessario
- bisogna salvare l' environment al momento della creazione dell'associazione
- al momento della chiamata sia il codice della funzione e il puntatore al suo activation record sono associati al parametro formale
##### shallow binding
- può essere usato solo con lo scoping dinamico
- l'enviroment usato nel momento in cui usiamo la funzione passata come parametro è quello al momento della chiamata
- Per accedere alle variabili locali usa lo stack
- usa strutture standard A-list CTR 
---
### cosa definisce l' environment
- Regole di visibilità
- eccezioni sulla visibilità
- scoping regole (**static/dynamic**)
- regole per il passaggio di parametri (**value/reference/name/…**)
- binding policy (**deep/shallow**)
----
### Funzioni come valore di ritorno
- Bisogna mantenere un activation record ma non nello stack
- Quando diamo come result una funzione dobbiamo salvare l' environment in cui verrà valutata
- il risultato del return sarà una **closure**
- Lo static chain pointer dell'activation record è determinato usando la closure
