---
date: 2025/01/06
tags: 
Materia: "[[Reti]]"
---
## Reti wireless
### Modalità
#### Modalità Infrastrutturata
- stazione base connette i terminali wireless alla rete cablata
- **handover** un terminale può cambiare la stazione
#### Modalità ad hoc
- non ci sono stazioni base
- i nodi possono trasmettere solo agli altri nodi entro il loro raggio
- i nodi si organizzano tra loro in una rete
	- percorsi multi salto possibili
#### tabelloski
![[Pasted image 20250106104948.png|500]]


## Wireless LAN IEEE 802.11
#### Architettura di riferimento per una WLAN
- Stazione Wireless STA
	- terminale/host
- **Basic Service Set** **BSS**
	- gruppo di STA che usano lo stesso canale radio
- **Access Point AP**
	- Stazione integrata nella LAN e connessa al sistema di distribuzione
- Sistema di distribuzione
	- fornitore di connettività
- Extended Service Set ESS
	- unisce più BSS in un'unica rete logica
![[Pasted image 20250106110946.png|400]]

#### Canali e associazione
- lo spettro di frequenze da 2.4 a 2.485 è suddiviso in 11 canali
- l'amministratore dell'AP può scegliere la frequenza o auto
- host quando si deve associare con un AP
	- ascolta su tutti i canali per cercare i frame **beacon** che contengono **SSID** e **MAC** dell'AP
	- sceglie un AP e poi comincia la connessione con una possibile autenticazione DHCP eccetera

#### Scansione
- **scansione** **passiva**
	- AP invia i beacon
	- l'host invia un richiesta di associazione e AP conferma
- **scansione** **attiva**
	- l'host invia a tutti i vicini un frame di **probe** **request**
	- Gli AP rispondono con una **probe** **response**
	- l'host invia un richiesta di associazione e AP conferma


#### Collision Avoidance
- si usa Collision avoidance perchè la detection è impossibile
##### CSMA/CA
- se il canale rimane libero per un tempo chiamato DIFS (Distributed Inter-Frame Space)
	- Si **trasmette** l'intero frame
	
- Se il canale è **occupato**
	- si sceglie un tempo di **backoff** **casuale**
	- se il countdown arriva a 0 mentre il canale è libero
		- **trasmetti**

###### ACK
- quando il ricevitore riceve il messaggio manda un **ACK** dopo un tempo chiamato SIFS
- se non si riceve l'**ACK**
	- aumentiamo il valore massimo di  backoff
	- scegliamo un nuovo backoff
![[Pasted image 20250106141609.png|200|center]]


![[Pasted image 20250106142303.png|600]]

### Problema del terminale nascosto
![[Pasted image 20250106142513.png|600]]
#### Coordinamento a livello MAC messaggi RTS e CTS
- l'handshake serve a prenotare esplicitamente il canale
	- Trasmettitore invia Request To Send (**RTS**)
	- Ricevitore risponde con un Clear To Send (**CTS**)

#### Problema del terminale esposto
- **RTS** e **CTS** potrebbero rendere sequenziali delle trasmissioni che possono avvenire contemporaneamente
![[Pasted image 20250106143548.png|500]]

