---
date: 2024/12/09
tags: 
Materia: "[[Reti]]"
---
## Protocolli di instradamento
- obbiettivo determinare buoni percorsi da un mittente a un destinatario
	- **Percorso**: sequenza di router attraversati da un datagramma per giungere all'host destinatario

- ":**Buon** **percorso**":
	- costo più basso
	- più veloce
	- meno congestionato

#### Modello a grafo della rete
- **Grafo** $G=(N, E)$
	- $N$ nodi router 
	- $E$ insieme di link

##### Costo di un percorso
- $c(x,x')$ **costo** del link $(x, x')$
	- può essere qualunque cosa
		- numero di salti
		- inverso della banda del link
		- congestione
	- Costo del percorso $(x_{1}, \dots, x_{p})=c(x_{1}, x_{2}) + \dots +c(x_{p-1}, x_{p})$

> Il compito dell'algoritmo di routing è trovare il percorso con costo minimo

## Tipi di algoritmi di routing
- Informazioni globali o distribuite
	- **Globali**:
		- Tutti i router conoscono la topologia della rete e i costi dei link
		- algoritmi a "link state"
	- **Distribuite**:
		- I router conoscono gli altri router cui sono collegati e il costo verso di essi
		- processo iterativo di calcolo percorsi e scambio info con router vicini
		- algoritmi a "distance vector"
- Statico o dinamico
	- **Statico**
		- I percorsi cambiano poco o sono fissati
	- **Dinamico**
		- Le rotte cambiano 
		- aggiornamenti periodici

#### Algoritmo di Dijkstra (link state)
- Assunzione: topologia di rete e costi dei link noti a tutti i nodi
	- si ottiene circolando le info sullo stato dei link
	- tutti i nodi hanno le stesse info
- **Output**: il percorso a costo minimo da un nodo a tutti gli altri nodi
	- tabella di inoltro
- **Iterativo**: dopo $k$ iterazioni si conosce il percorso a costo minimo verso almeno $k$ destinazioni

###### Notazione
- $c(x,y)$ costo del link da $x$ a $y$
- $D(v)$ costo del percorso da sorgente  a $v$
- $p(v)$ predecessor del nodo lungo il cammino dalla sorgente al nodo $v$
- $N'$ insieme di nodi per cui il cammino a costo minimo è già stato determinato

- esempio sulle slide 4-138

#### In pratica: internet e gli AS
- Ogni rete su internet idealmente dovrebbe essere
	- Amministrativamente autonoma
		- amministratori di rete liberi di configurare la rete come vogliono 
	- Capace di collegarsi comunque a tutte le altre reti
- Soluzione: si organizzano i router in "**autonomous** **systems**" (ASs)
	- definizione: un **AS** è un gruppo di router sotto lo stesso controllo amministrativo
	- Ogni **AS** è identificato da un numero e i numeri di AS sono assegnati centralmente dai registri regionali ICANN
	- **Intra-AS** routing vs. **Inter-AS** routing

##### Intra-AS Open Shortest Path First
- **OSPF** protocollo di routing basato su link state
	- dissemina pacchetti con lo stato dei link
	- assunzione: topologia nota a tutti i router
	- calcola i percorsi usando l'algoritmo di Dijkstra
- Usa datagrammi IP
	- Non usa livello di trasporto
	- Invia i pacchetti di aggiornamento dei link all'indirizzo multicast 224.0.0.5
- Implementa tre procedure 
	- Protocollo di "Hello"
		- Messaggi di mantenimento: controllano i link funzionanti, e quindi  verificano quali altri nodi sono vicini
	- Protocollo di "Exchange"
		- Usato per informare i vicini che si sono appena "conosciuti" sulla topologia della rete percepita da ciascuno
	- Protocollo di "Flooding"
		- Informa tutti i router di un cambio nello stato dei link
###### OSPF gerarchico
![[Pasted image 20241209090928.png|500]]
- Usato in reti con molti router
- Gerarchia a due livelli: backbone e reti di area
	- I messaggi con i link state circolano sono nelle reti di area
	- i nodi conoscono la topologia di rete solo all'interno della propria area e uno shortest path verso le altre aree
- I router di bordo di ciascuna area riassumono la distanza verso le reti che fanno parte della propria area agli altri router
- I router della dorsale fanno girare OSPF solo per la dorsale
- I router di bordo connettono ad altri AS