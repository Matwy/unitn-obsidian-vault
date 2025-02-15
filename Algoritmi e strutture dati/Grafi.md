---
date: 2024/11/11
tags: 
Materia: "[[Algoritmi e strutture dati]]"
---
## Grafi
- $n$ numero di nodi
- $m$ numero di archi
- si possono rappresentare con 
	- matrici di adiacenza
	- linked list

### Definizioni
#### Grafo connesso
- Un grafo non orientato è **connesso** $\Leftrightarrow$ ogni suo nodo è raggiungibile da ogni altro suo nodo
#### Raggiungibile
- Un nodo $v$ è **raggiungibile** da un nodo $u$ se esiste un cammino da $u$ a $v$
#### Grafi orientati
- **componenti connesse**
#### Grafi non orientati
- **componenti  fortemente connesse**
#### grafo massimale
#### ciclo
#### grafo ciclico
#### grafo aciclico
- un grafo non orientato che non contiene cicli è detto **aciclico**
#### DAG directed acyclic graph


#### BFS
- complessità $O(m+n)$
##### ALBERO BFS

#### DFS
#####  [[09-grafi.pdf#page=66&selection=6,0,6,23|Albero di copertura DFS]]
- Ogni volta che si esamina un arco da un nodo marcato ad un nodo non marcato tale arco viene chiamato **arco dell'albero**

- tutti gli altri archi sono classificati così
- $(u,v)$ non inclusi nell'albero 
	- arco in avanti
		- $u$ antenato di $v$
	- arco all'indietro
		- $u$ discendente di $v$
	- altrimenti arco di attraversamento