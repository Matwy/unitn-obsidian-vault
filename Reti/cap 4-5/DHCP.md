---
date: 2024/11/08
tags: 
Materia: "[[Reti]]"
---
## DHCP Dynamic Host Configuration Protocol
- Assegna un indirizzo IP ad un host in maniera **automatica**
- libera indirizzi non utilizzati 

#### Procedura in breve
- host invia un messaggio `DHCP discover` (opzionale)
- Il server **DHCP** risponde con un messaggio `DHCP offer` (opzionale)
- host richiede un indirizzo con `DHCP request`
- Il server **DHCP** invia un messaggio `DHCP ack`

![[Pasted image 20241108131502.png|center|500]]

#### Prestiti ("lease")
- L'indirizzo IP fornito da DHCP rimane valido per un tempo **limitato**
- Il client può chiedere di **cambiare** indirizzo o negoziare un'**estensione**
- Normalmente DHCP approva tutte le **estensioni**
	- Un host può continuare a funzionare senza **interruzioni**
	- Se il server nega l'estensione l'host deve smettere di usare quell'IP

#### Altri dettagli
- **DHCP** usa **UDP**
	- DHCP è progettato per essere robusto a perdite e duplicati
- Il client quando trova un server DHCP ne memorizza l'indirizzo

#### Formato dei messaggi DHCP
![[Pasted image 20241108132120.png|center|600]]

![[Pasted image 20241108154326.png|center|500]]
 
#### DHCP in una rete reale
- In una rete locale il broadcast è `255.255.255.255`
- I router non inoltrano un pacchetto broadcast (in questo caso il DHCP discover) di solito
	- ma possono essere configurati per inoltrarlo a un server DHCP noto 
	- in questo modo non serve un DHCP per tutte le sottoreti
##### se non c'è DHCP
- si disabilita il client DHCP di un host e si configura l'IP manualmente
- Altrimenti il client DHCP imposta un indirizzo tipo **link-local**
	- `169.254.0.0/16`
- passi
	1) si sceglie casualmente un indirizzo di tipo link-local
	2) si cerca se esiste un interfaccia di rete con quell'indirizzo, risoluzione ARP 
	3) se la si trova si torna all'1
	4) altrimenti l'host si tiene l'indirizzo scelto
- questo permette agli host di parlarsi nella rete locale