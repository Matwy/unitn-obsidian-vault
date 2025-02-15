---
date: 2024/12/15
tags: 
Materia: "[[Basi di dati]]"
---
## 12 Piano esecuzione query
- quando un db deve eseguire una query il processo si suddivide in due livelli
	- **pianificazione** **logica**
	- **pianificazione** **fisica**

#### Pianificazione logica
- viene deciso cosa fare
- le operazioni algebriche che portano al risultato
#### Pianificazione fisica
- le operazioni logiche vengono tradotte in operazioni fisiche e algoritmi concreti
	- file scan index scan eccetera
---
## Costo del piano di esecuzione
- Il DB deve stimare il costo dei possibili piani di esecuzione
#### Cardinalità delle relazioni intermedie
- La **cardinalità** è il numero di righe risultanti da un'operazione intermedia
#### Costo operazioni fisiche
- Ogni operazione fisica ha un costo, numero di pagine da leggere scrivere
---
## Informazioni per stimare i costi
Per calcolare il costo di un piano di esecuzione serve
- la **cardinalità** delle relazioni di partenza
- **indici** sugli attributi rilevanti per la query
- numero di **pagine** per relazione
- informazioni sui valori degli attributi

---
## L'albero di esecuzione della query
#### Struttura dell'albero
- le **foglie** rappresentano le tabelle di partenza
- I **nodi** **intermedi** rappresentano le operazioni algebriche
- la **radice** il risultato della query
#### Costi associati ai nodi
- Ad ogni nodo intermedio viene associato un costo stimato per eseguire l'operazione

## [[Argomento12 Piani di esecuzione delle query.pdf#page=12&selection=0,7,0,7|Esempiozzo]]

