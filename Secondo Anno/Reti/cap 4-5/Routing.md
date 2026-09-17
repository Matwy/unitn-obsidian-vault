---
date: 2025/01/03
tags: 
Materia: "[[Reti]]"
---
## Routing con distance vector
- Algoritmo distribuito
- non richiede la conoscenza della topologia della rete
- ogni nodo deve conoscere
	- I propri vicini
	- Il costo dei link verso questi vicini
- La presenza di altri nodi oltre i propri vicini viene notificata con dei messaggi 
- algoritmo di base per questo routing Bellman-Ford

#### Algoritmo di Bellman-Ford
- [[reti4-5.pdf#page=152&selection=0,0,0,1|slide]]
#### Problema del count to infinity
- Si risolve limitando il massimo numero di hop a 15
- **Split** **Horizon**
- **Poisoned** **reverse**

## Routing Information Protocol
- Protocollo per routing **Intra**-**AS**
	- Implementa distance vector
	- Svantaggi
		- Convergenza lenta
		- Dimensione della rete limitata

- Il **costo** dei link è il numero di hop
	- Massimo 15
	- un hop può avere comunque costo $> 1$
- Ogni 30 secondi o se cambiano le tabelle di routing **RIP** invia DV
	- **RIP** **advertisement**
	- Ogni messaggio contiene un elenco con
		- fino a 25 sottoreti di destinazione all'interno dell'AS
		- La distanza del mittente rispetto a ciascuna sottorete
	- Usa **UDP** porta 520 indirizzo multicast `224.0.0.9`

- [[reti4-5.pdf#page=179&selection=18,0,18,1|slide]]


## Confronto tra link state e distance vector
- [[reti4-5.pdf#page=184&selection=0,0,0,1|slide]]