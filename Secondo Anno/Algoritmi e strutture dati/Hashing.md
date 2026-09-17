---
date: 2024/11/12
tags: 
Materia: "[[Algoritmi e strutture dati]]"
---
## Hashing
- L'insieme della possibili chiavi è rappresentato dall'insieme universo $U$ di dimensione $u$
- Le chiavi si memorizzano in un vettore $T[0\dots m-1]$ di dimensione $m$ detto **tabella hash**


- La coppia chiave-valore $k,v$ viene memorizzata in un vettore nella posizione $h(k)$
##### Collisioni
- quando due o più chiavi nel dizionario hanno lo stesso valore hash diciamo che è avvenuta una **collisione**
	- Idealmente vogliamo funzioni hash senza collisioni

#### Funzione Hash
- una **funzione hash** è definita come $h:U \rightarrow \{0,1,\dots, m-1\}$
- si dice **perfetta** se è **iniettiva** ovvero non genera **collisioni**


##### Uniformità semplice
- sia $P(k)$ la probabilità che una chiave $k$ sia inserita in tabella 
- Sia $Q(i)$ la probabilità che una chiave finisca nella cella $i$
- Una funzione hash $h$ gode di **uniformità** **semplice** se 
$$
\forall i \in [0, \dots, m-1]: Q(i) = 1/m
$$
- Per poter ottenere una funzione hash con uniformità semplice, la distribuzione delle probabilità $P$ deve essere nota

##### Come si realizza una funzione hash
- Le chiavi possono essere tradotte in valori numerici anche interpretando la loro rappresentazione in memoria com un numero 
###### Metodo della divisione
###### [[07-hashing.pdf#page=26&selection=4,0,4,46|Metodo della moltiplicazione (Knuth)]]
![[Pasted image 20241112112152.png|center|450]]

#### Gestione delle collisioni
##### Liste di trabocco o memorizzazione esterna
- Le chiavi con lo stesso valore hash $h$ vengono memorizzate in una lista **monodirezionale**/vettore **dinamico**
- si memorizza un puntatore alla testa della lista/ al vettore nello slot $H(k)-esimo$ della tabella hash
![[Pasted image 20241112112842.png|center|300]]
- **operazioni**
	- `insert()` inserimento in testa
	- `lookup(), remove()` scansione della lista per cercare la chiave
###### Termini
- $n$ numero di chiavi memorizzati in tabella hash
- $m$ capacita tabella hash
- $\frac{n}{m}$ fattore di carico
- $I(\alpha)$ numero medio di accessi alla tabella per la ricerca di una chiave non presente nella tabella (**ricerca con insuccesso**)
- $S(\alpha)$ numero medio di accessi alla tabella per la ricerca di una chiave presente nella tabella (**ricerca con successo**)
###### Analisi complessità
- analisi caso pessimo: tutte le chiavi sono collocate in unica lista
	- `insert()`: $\Theta(1)$
	- `lookup(), remove()`$\Theta(n)$
##### Indirizzamento aperto o memorizzazione interna
- memorizzare tutte le chiavi nella tabella stessa
- ogni slot contiene una chiave oppure nil
- **Inserimento**
	- se lo slot prescelto è utilizzato, si cerca uno slot "alternativo"
- **Ricerca**
	- si cerca nello slot prescelto e poi negli slot "alternativi", fino a quando non si trova la chiave oppure nil
- **Ispezione**
	- un'**ispezione** è l'esame di uno slot durante la ricerca
- fattore di carico
	- compreso tra 0 e 1
	- la tabella può andare in overflow

##### Tecniche di ispezione
- hashing uniforme
- la situazione ideale prende il nome di **hashing** **uniforme** in cui ogni chiave ha la stessa probabilità di avere come sequenza di ispezione una qualsiasi delle $m!$ permutazioni di $[0,\dots, m-1]$
- nella realtà è difficile da implementare
- tecniche diffuse
	- Ispezione **lineare**
	- Ispezione quadratica
	- Doppio hashing

###### Ispezione lineare
- [[07-hashing.pdf#page=50&selection=4,0,4,17|07-hashing, page 50]]
###### Ispezione quadratica
- [[07-hashing.pdf#page=56&selection=4,0,4,20|07-hashing, page 56]]
###### Doppio hashing
- [[07-hashing.pdf#page=57&selection=4,0,4,14|07-hashing, page 57]]

