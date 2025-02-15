---
date: 2024/06/07
tags: 
Materia: "[[Programmazione funzionale]]"
---
## 5 Data Structure
#### Type safety
- Quando nessun programma può avere errori che derivano da errori di type
### Type equivalence
- Due tipi T e S sono equivalenti se ogni oggetto T è anche  di tipo S e viceversa
#### Equivalence by name 
- Nomi uguali quindi tipi uguali
- nomi diversi tipi diversi
	- anche se hanno le stesse proprietà

#### Structural equivalence
- Due tipi sono strutturalmente equivalenti se hanno la stessa struttura
- In generale le proprietà devono anche essere ordinate allo stesso modo
	- In ML no
---
## Compatibilità e conversioni
### Compatibility
- T è compatibile con S se l'oggetto T può essere usato in contesti dove ci si aspetta un oggetto di tipo S
- esempio se abbiamo `int n` e `float f` possiamo fare `f+n` in alcuni linguaggi
- la compatibilità non è simmetrica
	- `int` e `float` ok ma non viceversa
---
### Type Conversion
- Se T è compatibile con S c'è un qualche tipo di meccanismo di conversione
#### Implicit conversion
- Chiamata anche **coercion**
- Il linguaggio fa la conversione ma non la menziona a livello di linguaggio
- Tre possibili modi
	1) Stesso valore e stesso modo per salvare
		- codice non necessario
	2) Diversi valori ma valori comuni hanno la stessa rappresentazione
		- codice dinamico quando c'è un'intersezione
	3) Diverse rappresentazioni per i valori
		- codice per la conversione
#### Explicit conversion
- chiamata **cast**
- quando la conversione viene esplicitamente menzionata nel programma
- Le possibili modalità della conversione sono simili alla coercion
- La conversione è possibile solo quando il linguaggio sa come farla
- modalità preferita dai linguaggi moderni

---
## Polymorphism 
#### Ad-hoc polymorphism: overloading
- quando una funzione ha altre definizioni accettando tipi diversi
#### Parametric polymorphism
- un valore ha il polimorfismo parametrizzato universale quando può essere di un numero infinito di tipi
- si denota `<T>` un qualsiasi tipo
##### Explicit
- Generics di java e c#
##### Implicit
- il type checker prova a determinare la forma più generica per ogni oggetto (come in ML)
#### Subtype polymorphism
- Il solito polimorfismo dove usi la classe sopra