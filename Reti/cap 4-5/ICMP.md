---
date: 2024/11/08
tags: 
Materia: "[[Reti]]"
---
## ICMP Internet Control Message Protocol
- **ICMP** viene usato per 
	- segnalare errori
	- notificare
- formato da
	- **type**
	- code
	- checksum
	
![[Pasted image 20241108125652.png|center]]

#### Tipi di messaggi
- due classi
	- **segnalazione** **errori**
	- **recuperare** **informazioni**
- **Echo** Request/Reply usati dal comando ping
	- quando un host riceve un echo request restituisce un ICMP con gli stessi dati presenti nella richiesta
- I messaggi **ICMP** funzionano come qualunque pacchetto IP
	- Eccezione se un messaggio ICMP genera un errore non si invia nessun messaggio di errore (evita congestioni)

- trasportato come un **datagramma**
![[Pasted image 20241108130335.png|center|400]]
#### Ping e traceroute
- **Ping**
	- echo request + echo reply
	- verifica l'esistenza del percorso e misura RTT
- **Traceroute**
	- Si inviano datagrammi IP con TTL sempre maggiore
	- $TTL = 1$ 
		- primo router decrementa a 0 e manda messaggio Time Exceeded con il proprio indirizzo
	- $TTL = 2$ 
		- primo router porta a 1 e il secondo manda Time Exceeded
	- Si ripete fino a quando non si raggiunge la destinazione 

