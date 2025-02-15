---
date: 2024/06/06
tags: 
Materia: "[[Programmazione funzionale]]"
---
## 4 Control Structures and abstraction
#### Activation record
- contiene le info di un blocco 
- ad esempio parametri, puntatore di ritorno, static chain pointer
---
## Static scoping
#### Static chain pointer
- puntatore all'activation record del blocco genitore
#### Static Depth 
- La **static** **depth** è un intero associato ad un blocco che corrisponde alla profondità dell'annidamento di quel blocco
#### Chain offset
- E' la **differenza** tra la **Static** **depth** del blocco dove viene usata una variabile e la static depth del blocco dove viene dichiarata

#### Static link del callee
- Se il caller ha SD m e il callee SD n la distanza tra loro è
	- $k = m-n+1$
- Quando un caller `C` chiama il callee `P` ci sono due casi
	 a)  `P` è immediatamente incluso in `C` 
		 $k=0$
	 b) `P` è in un blocco a k step da `C` 
		 $k>0$ 
- Quindi 
	- se $k=0$ `C` passa il suo activation record a `P`
	- se $k>0$ `C` trova il pointer dopo k passi nella static chain

#### Display 
- Non è altro che un vettore con tutti gli indirizzi dei blocchi della **static** **chain**
- In questo facciamo meno accessi in memoria
---

## Dynamic scoping
- Nel dynamic scoping basta semplicemente scorrere gli activation record nello stack fino a quando non troviamo il nome della variabile che stiamo cercando 
#### Association List
##### A-List
- Una struttura fatta apposta per gestire le associazioni come uno stack
- quando si entra in un environment le nuove associazioni vengono inserite
- quando si esce vengono rimosse 
- Le info riguardo le associazioni sono tipo, location, e un flag active/deactive
##### Central Referencing environment Table (CTR)
- non ho capito praticamente nulla [[L4 - Control Structures and Abstraction.pdf#page=48&selection=0,0,2,11| CTR nelle slide]]
![[Pasted image 20240606114942.png|center|350]]

- più complessa
- meno memoria usata
- tempo di accesso costante (due accessi indiretti)
---
#### Evaluation strategies
- **Eager** prima valuta gli operandi e poi applica l'operazione ai valori
- **Lazy** gli operandi solo valutati solo se necessario
---
## Call type
#### Call by value
- Vengono copiati i valori quindi (**r-value**)
- non c'è modo di restituire delle informazioni tramite i parametri
#### Call by reference
- viene passato l'indirizzo del dato (**l-value**)
- Le modifiche avvengono direttamente alla variabile passata
#### Call by constant
- viene passata la variabile ma non è possibile modificarla
- in questo modo non bisogna copiarla e abbiamo la certezza non cambi
#### Call by result
- parametro output only
- verrà assegnato al parametro un nuovo valore nel suo indirizzo
- non si può passare informazioni dal main al proc
#### Call by value-result
- viene preso r-value del parametro passato
- alla fine della procedure il valore del parametro viene assegnato alla locazione corrispondente al parametro reale
#### Call by name
- il parametro passato non viene valutato ma viene sostituito e valutato successivamente
- quindi se passiamo x+1 è come se sostituissimo tutte le volte x+1 dove usiamo il parametro
#### Esercizi
- [[L4 - Control Structures and Abstraction partII_26032024.pdf#page=14&selection=0,14,0,14|Esercizi matti in culo]]
---
[[Higher Order Function]]