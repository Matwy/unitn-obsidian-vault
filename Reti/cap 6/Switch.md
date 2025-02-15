---
date: 2025/01/05
tags: 
Materia: "[[Reti]]"
---
# Switch
#### Info di base
- un hub è un ripetitore di livello 1
- switch dispositivo di livello 2 **data link**
- memorizza e inoltra frame ethernet
- esamina il MAC address dei frame che arrivano
- **trasparente**
	- gli host non sanno se sono collegati a uno switch
- non necessitano configurazione

#### Tabella di inoltro degli switch
![[Pasted image 20250105180149.png|400]]
##### Autoapprendimento degli switch
- ricevendo frame aggiorna la tabella
- questo metodo per riempire la tabella si chiama **backward** **learning**

- inoltre se con il **backward** **learning** non abbiamo riempito sufficientemente la tabella quindi non sa dove spedire il frame fa broadcast su tutte le porte tranne quella di arrivo (**flooding** **del** **frame**)
---
## Switch ad anello (loop)
- I loop portano a molto traffico dovuto al **broadcast** **storming**
- però avere dei loop ci permette di avere una rete più affidabile grazie ai collegamenti ridondanti
### Spanning tree protocol (STP)
- per evitare i loop viene creata dal punto di vista logico una tipologia ad **albero**
- tutti gli switch hanno un identificatore a 64 bit così formato
	- `16 bits` impostati dall'admin
	- `48 bits` **MAC** **address** dello switch

- **radice** **dell**'**albero**: lo switch con ID più basso
	- per come è fatto l'ID l'admin può decidere quale è la radice

##### BPDU
- **Bridge Protocol Data Unit** contiene l'**ID** del mittente e il **costo** del link
- tramite lo scambio di queste info tra gli switch cambiano lo stato delle porte
#### Stati delle porte
##### Root
- riceve **BPDU**
- non invia **BPDU**
- gestisce i frame
##### Blocked
- Una porta viene messa in stato di **blocked** quando il collegamento con essa è ridondante si cerca di bloccare la porta con il costo più alto
- riceve **BPDU**
- non invia **BPDU**
- **non** gestisce i frame
##### Designated
- sono le porte che rimangono attive
- riceve **BPDU**
- invia **BPDU**
- gestisce i frame
---
## Domini di broadcast e di collisione
#### Domini di collisione
- parte della rete dove se due nodi trasmettono **contemporaneamente** si verifica una **collisione**
#### Domini di broadcast
- parte della rete che può essere raggiunta attraverso un messaggio di broadcast di livello 2
- I nodi collegati alla stessa infrastruttura di livello 2 sono parte dello stesso dominio di broadcast

![[Pasted image 20250106090535.png|500]] 


 - per separare i domini di broadcast si usano le **VLAN**
 ---
## VLAN
- **Virtual LAN**
- Le VLAN sono un insieme di porte di uno o più switch di rete
- gli switch eseguono un processo di **backward** **learning** indipendente per ogni VLAN
- I frame in **broadcast** vengono inviati solo alle porte della stessa VLAN
#### Trunk
- Una porta viene configurata come **trunk** per far passare il traffico di più VLAN sullo stesso collegamento

#### VLAN con switch multipli 
- Viene creato il protocollo 802.1Q perchè non c'è più spazio per i campi
- Questo protocollo serve per trasmettere anche il **VLAN** **ID**
![[Pasted image 20250106091959.png]]


