---
date: 2024/10/11
tags: 
Materia: "[[Reti]]"
---
## Livello di trasporto
- Fornisce una comunicazione logica tra processi applicativi di host diversi
	- Lato Invio: divide i messaggi in segmenti e li passa al livello di rete
	- Lato ricezione riassembla i pacchetti in messaggi e li passa al livello applicazione

#### trasporto vs rete
- Livello di **rete**
	- comunicazione logica tra host
- Livello di **trasporto** 
	- comunicazione logica tra processi


## Multiplexing e demultiplexing
- multiplexing al trasmettitore: 
	- gestione dati da diverse socket
	- aggiunge header con PCI del livello transport
- demultiplexing al ricevitore 
	- utilizza le PCI nell'header per consegnare i segmenti ricevuti alle socket giuste

## Porte TCP e UDP
- La destinazione di un segmento non è un host ma un **processo** che gira sull'host
- L'interfaccia tra l'applicazione e il livello di trasporto è la **porta**
	- numero a 16 bit
	- mappatura tra **porta** e **processo**

- I numeri di porta si possono anche classificare con
	- **statici** (porte well known)
	- **dinamici**
		- assegnati automaticamente dal sistema operativo quando si apre una connessione o si crea una socket
- porte di sorgente e destinazione non sono le stesse
- concetto di **flusso** e **connessione**
	- gruppo di dati che appartengono alla stessa comunicazione logica 
	- un'applicazione può aprire multiple connessioni e veicolare molteplici flussi

#### Demultiplexing senza connessione
- I pacchetti vengono inviati con **SP** **source** **port** e **DP** **destination** **port** 
![[Pasted image 20241011142527.png]]
#### Demultiplexing orientato alla connessione
- I parametri diventano 4
	- Indirizzo IP di origine
	- numero di porta di origine
	- indirizzo IP di destinazione
	- numero di porta di destinazione
	
![[Pasted image 20241011142558.png]]

#### UDP User Datagram Protocol
- header corti
- non ha controllo di congestione
- non ha stato di connessione
![[Pasted image 20241011143438.png|center|300]]

#### Checksum UDP
- rileva gli errori nel segmento trasmesso
- **Mittente**
	- tratta il contenuto come una sequenza di interi da 16 bit
	- fa la somma e calcola il complemento a 1 della somma
	- il mittente pone il valore ottenuto nel campo checksum
	
- **Ricevente**
	- Somma tutte le parole di 16 bit 
	- controlla se il risultato è una parola di 16 bit tutti uguali a 1
		- si nessun errore rilevato
		- no errore rilevato


## ARQ Automatic Repeat reQuest
- Classe di protocolli che cerca di recuperare le perdite di pacchetti

- usa pacchetti speciali per notificare il trasmettitore di una avvenuta ricezione corretta
	- **ACK**
- Esempi di protocolli basati su forme di ARQ
	- Stop and Wait
	- Go back N
	- Selective Repeat
	- TCP
	- Il protocollo MAC dei sistemi WiFi

#### Stop-and-Wait
- **Trasmettitore**
	- Invia una PDU
	- imposta un timeout
	- attende la ricezione del rispettivo ACK
		- se non riceve ACK entro timeout riprova
		- se riceve
			- controlla che ACK non contenga errori
			- controlla il numero di sequenza
			- se tutto ok quindi l'ACK si riferiva alla PDU inviata procede con l'invio della successiva PDU
![[Pasted image 20241011145236.png]]


## Protocolli con pipelining
- Il trasmettitore accetta che ci siano diversi pacchetti che sono in attesa di un ACK
	- Va tenuta traccia dei numeri di sequenza dei pacchetti "in volo"
	- Bisogna memorizzare i segmenti sia al trasmettitore sia al ricevitore 
	
![[Pasted image 20241011145740.png]]	


#### Definizioni protocolli con pipelining
![[Pasted image 20241011150320.png]]

#### Acknowledgements
- A seconda del protocollo si possono usare diversi tipo di **ACK**
	- ACK individuale
		- indica la ricezione corretta di un pacchetto specifico
		- ACK(n) "ho ricevuto pacchetto n"
	- ACK cumulativo 
		- ACK(n) "ho ricevuto tutto fino al pacchetto n"
	- ACK negativo (NACK) 
		- NACK(n) "non ho ricevuto il pacchetto n"
	- "Piggyback" 
		- Inserimento di un ACK data in un pacchetto dati

 FAI SCREEN PAG 35 36
 CI SONO ANCHE TUTTE LE FRECCETTE CHE SI CAPISCE COSA SUCCEDE AI PACCHETTI

#### Spazio dei numeri di sequenza
- fai screen al numero di sequenza ciclico

## TCP
- [[TCP]]