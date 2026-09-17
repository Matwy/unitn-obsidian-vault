---
date: 2024/11/08
tags: 
Materia: "[[Reti]]"
---
## ARP Address Resolution Protocol
- Se un host deve inviare un pacchetto ad un altro host nella stessa rete
	- capisce che l'host è nella stessa rete perchè ha il suo stesso netId
	- **ARP**
		- manda un messaggio broadcast chiedendo l'indirizzo MAC dell'host destinatario
		- il destinatario risponde con il suo indirizzo MAC
		- ora si può inviare il pacchetto
- questo si fa solo per comunicazioni punto punto sulla stessa rete

#### Formato messaggio ARP
![[Pasted image 20241108101859.png|center|400]]
- Il messaggio ARP viene incapsulato in un **frame** (livello 3)
- nell'header c'è il Type che se viene impostato a `2054` (`0x806`) significa che i dati sono un messaggio **ARP**

#### ARP caching
- per evitare di inviare un messaggio ARP per ogni datagramma si mantengono in memoria le risposte ARP ricevute

#### Il proxy ARP
- Un **proxy** **ARP** è una macchina che restituisce un indirizzo MAC facendo le veci di un host che si trova su una rete diversa
![[Pasted image 20241108102710.png]]

