---
date: 2024/12/12
tags: 
Materia: "[[Basi di dati]]"
---
##  Memorizzazione dei record su disco
- I file contenenti record sono allocati in blocchi del disco (chiamati **pagine**)
- Record "esteso" (spanned block)
	- è un record più grande di un singolo blocco sul disco
	- Un puntatore alla fine del primo blocco punta al blocco contenente il resto del record
- Record non esteso (unspanned block)
	- Record che non può superare le dimensioni di un singolo blocco

#### Operazioni su file
- **Retrieval**
	- nessun cambiamento ai dati su file
- **Update**
	- I file sono modificati mediante inserimento cancellazione o modifica
	- Tipicamente i record sono selezionati mediante condizioni di selezione

> Tipicamente i record sono selezionati mediante condizioni di selezione

- Il **DBMS**  per ogni lettura/scrittura carica sempre **pagine** **intere** mai parti di pagine
	-  In MySQL la dimensione predefinita di una pagina è di `16KB`

---
## Costo delle operazioni
- Introduciamo ora un modello di costo basato sul numero di pagine che il DBMS deve leggere/scrivere per eseguire una certa operazione
- stiamo parlando di operazioni su memoria secondaria
### Organizzazione della memoria
- **Heap** o **pile** file
	- Le tuple sono semplicemente scritte una dopo l'altra nell'ordine di inserimento
- **Sorted** **file** (file di tuple ordinate)
- **Indexed** **file**
	- Viene creato un indice separato rispetto al file che contiene le tuple vere e proprie della relazione
#### Heap file
- L'inserimento di nuove tuple in un heap file è molto facile e veloce
	- le tuple vengono memorizzate in pagine in base all'ordine di inserimento
	- Quando una pagina è piena, si passa alla successiva eventualmente lasciando spazio vuoto in fondo alla pagina precedente 

###### Costo operazioni Heap SCAN
- se vogliamo fare un `select * from R;`
- Se $P_{R}$ è il numero di pagine che contengono le tuple di $R$ allora 
$$Costo_{scan} = P_{R}$$

###### Costo operazioni Heap EQUALITY SEARCH
- se vogliamo fare un `select * from R where city = 'Trento'`
- Se $P_{R}$ è il numero di pagine che contengono le tuple di $R$ allora 
$$Costo_{EqSearch} = P_{R}$$
###### Costo operazioni Heap INSERT
- Il costo per inserire una o più tuple sarà il costo di leggere l'ultima pagina  e eventualmente crearne una nuova 
$$Costo_{Insert} = 2$$
###### Costo operazioni Heap DELETE
- Il costo per cancellare una o più tuple con una relazione $R$ `delete from R where city='Trento'`
- Se $P_R$  è il numero di pagine che contengono le tuple di $R$ e $R_{A=c}$  è il numero di tuple in cui l'attributo $A$ ha valore $c$ 'Trento' allora
$$Costo_{Delete}=P_{R}+|R_{A=c}| = P_{R}+\lceil{f\cdot|R|}\rceil$$
- Sia $|R|$ il numero di tuple in $R$ e $|R.A|$ il numero di valori diversi dell'attributo $A$ in $R$
- possiamo assumere che in media
$$
|R_{A=c}| = \lceil{\frac{|R|}{|R.A|}}\rceil
$$
#### Selectivity factor
- Il rapporto tra |R| e |R.A| può essere usato per calcolare il **selectivity factor** $f$


#### Sorted file
- per abbassare il costo di alcune delle operazioni viste sopra possiamo immaginare di ordinare le tuple rispetto a qualche attributo 
- In questo caso le tuple vengono memorizzate  in pagine in base al valore dell'attributo

###### Costo operazioni Sorted fil SCAN
- se vogliamo fare un `select * from R;`
- Se $P_{R}$ è il numero di pagine che contengono le tuple di $R$ allora 
$$Costo_{scan} = P_{R}$$
###### Costo operazioni Heap EQUALITY SEARCH
- se vogliamo fare un `select * from R where city = 'Trento'`
- possiamo usare la ricerca binaria
	- andiamo a metà e escludiamo una metà ogni volta
- se $P_{R}$ è il numero di pagine di $R$
$$Costo_{EqSearch} = \lceil log_{2}(P_{R})\rceil+ \lceil\frac{|R_{city='Trento'}|}{\lfloor \frac{P}{t_{R}}\rfloor}\rceil$$
- la prima parte è il numero di pagine che devo leggere per trovare la pagina dove iniziano le tuple con 'Trento'
- seconda parte calcola il numero di pagine che devo aprire per trovare tutte le tuple che hanno 'Trento come valore'
> Una ricerca per intervallo ha lo stesso costo
###### Costo operazioni Heap INSERT
- Il costo per inserire una o più tuple sarà il costo di trovare la pagina dove scrivere e poi riscrivere la pagina modificata 
$$Costo_{Insert} = \lceil log_{2}(P_{R})\rceil +1$$
> dobbiamo considerare che nella pagina non ci sia spazio per aggiungere la nuova tupla
> in questo caso l'operazione insert potrebbe richiedere di leggere $P_R$ pagine e scriverne altrettante
###### Costo operazioni Heap DELETE
- Il costo per cancellare una o più tuple con una relazione $R$ `delete from R where city='Trento'`
- ragionamento simile alla ricerca binaria di prima ma va aggiunto il costo della scrittura delle pagine modificate per la cancellazione delle tuple
$$Costo_{EqSearch} = \lceil log_{2}(P_{R})\rceil+2\cdot  \lceil\frac{|R_{city='Trento'}|}{\lfloor \frac{P}{t_{R}}\rfloor}\rceil$$
