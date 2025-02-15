---
date: 2024/12/13
tags: 
Materia: "[[Basi di dati]]"
---
## Indicizzazione
- Per rendere più efficienti le operazioni sul file si creano degli indici esterni
- Il **data** file è il file che contiene i dati veri e propri
- L'**index** file è il file che contiene l'indice dei dati

- vediamo due tipi di indice, i più usati
	- **B+ tree**
	- **Hash**

##### Indici primari secondari unici
- Un indice si dice
	- **Primario** se contiene la chiave primaria della relazione. no duplicati
	- **Secondario** se la chiave di ricerca è diversa dalla chiave primaria. duplicati
	- **Unico** se la chiave di ricerca è una chiave candidata. no duplicati

## B+ Trees
- è un tipo di indice dinamico ad albero 
- i puntatori ai dati sono solo nei nodi foglia
	- i nodi interni contengono index entries e guidano la ricerca
	- i nodi foglia sono collegati tra loro
![[Pasted image 20241213101826.png]]

#### Proprietà di un B+ Tree
- operazioni di inserimento e cancellazione nell'albero lo mantengono bilanciato
- garantita un'occupazione almeno al 50% di ogni nodo dell'albero
- la ricerca di un record richiede soltanto di discendere l'albero fino all'appropriato nodo foglia
- Siccome l'albero è bilanciato possiamo definire come altezza dell'albero la lunghezza di qualunque percorso dalla radice alle foglie
- Grazie alle sue proprietà raramente l'altezza di un B+ supera il valore 3 o 4

#### Costo del lookup
- per costo di lookup si intende il numero di pagine che dobbiamo aprire per trovare il nodo 

## Hash Indexes
- Si sceglie una funzione di Hash
- Si allocano i diversi valori di un certo attributo in un bucket in base al valore della funzione di hash prescelta
- se la pagina del bucket contiene troppi puntatori, il DBMS dovrà creare una pagina di overflow che sarà connessa alla pagina principale del bucket e potrà contenere i nuovi puntatori al file
> Esempio: Per trovare una tupla con un certo valore di age x basterà applicare la funzione di hash h a x.
>  Questo ci darà il bucket che contiene il puntatore alla pagina del data file con quella tupla (al costo di leggere la o le pagine che contengono il bucket nell’index file)


![[Pasted image 20241213105049.png]]



###### Costo operazioni Hash index SCAN
- se vogliamo fare un `select * from R;`
- Se $P_{R}$ è il numero di pagine che contengono le tuple di $R$ allora 
$$Costo_{scan} = P_{R}$$
###### Costo operazioni Hash Index EQUALITY SEARCH
- se vogliamo fare un `select * from R where city = 'Trento'`
$$Costo_{EqSearch} = L_{h} + |R_{A=c}|$$
- $L_{h}$ è il costo del lookup nel file di indice
	- calcolo della funzione h sul valore cercato
	- lettura della pagina che contiene il bucket

- $|R_{A=c}|$ è il numero di tuple che hanno valore $c$

> molto efficiente per equality search
> invece se facciamo una ricerca per intervalli saremo costretti a rifare un equality search per ogni valore dell'intervallo
###### Costo operazioni Heap INSERT
- Il costo per inserire una tupla
	- aprire l'ultima pagina del file di dati e appendere la tupla $1+1$
	- lookup per trovare il bucket in cui inserire il puntatore al nuovo valore $L_{h}$
$$Costo_{Insert} = L_{h} + 1 +1$$
###### Costo operazioni Heap DELETE
- Il costo per cancellare una tupla in base al valore $c$ di un attributo $A$
	- eseguire il **lookup** per trovare il bucket con i puntatori alle tuple con valore $c$ costo $L_{n}$
	- aprire una alla volta le pagine del file di dati che contengono tuple con valore $c$ per l'attributo $A$ rimuovere le tuple e riscrivere la pagina modificata. costo $2*|R_{A=c}|$
- **Costo** **totale**
$$
L_{h}+2*|R_{A=c}|
$$

#### Extendible Hash Index
- prima o poi avremo sempre più pagine di overflow 
- bisogna periodicamente riorganizzare l'index file usando una funzione di hash con più bucket

#### Index matching
##### Hash Index
- Un indice hash su $A,B, ...$ soddisfa la condizione di selezione se solo se **tutti** gli attributi nella chiave di ricerca dell'indice compaiono in un predicato di identità $=$

![[Pasted image 20241214114743.png]]
##### B+ tree
- Un indice **B+ tree** su $A,B, ...$ soddisfa la condizione di selezione se nel predicato ha almeno un attributo che fa da suffisso all'indice

![[Pasted image 20241214114733.png]]


![[Pasted image 20241214115217.png]]
