---
date: 2024/10/15
tags: 
Materia: "[[Reti]]"
Argomento: "[[Livello di trasporto]]"
---
## TCP
- Protocollo punto-punto 
- Flusso di byte affidabile consegnato in ordine
- Con pipelining
- Full duplex
- Orientato alla connessione
- Flusso controllato
	- il trasmettitore non sovraccarica il ricevitore
- Il controllo di congestione evita di saturare la rete

#### Struttura segmenti TCP
SCREENSHOTT pag 42

#### Finestra di ricezione RWND receiver window
- Campo di 16 bit
	- indica il numero di byte che il ricevitore può immagazzinare
	- quantità massima di dati in transito nel RTT

#### Three way handshake
- Host A segmento con flag SYN a 1
	- porta sorgente A porta destinazione B
	- numero sequenza iniziale x
- Host B segmento con flag SYN e ACK a 1
	- porta sorgente B porta destinazione A
	- numero sequenza iniziale y
	- numero ACK(x+1)
- Host A segmento con flag  ACK a 1
	- porta sorgente A porta destinazione B
	- numero ACK(y + 1)

#### MSS Maximum Segment Size
- Lunghezza massima di un segmento TCP **solo payload**
- TCP cerca di inviare segmenti lunghi quanto un MSS
-  Maximum Transfer Unit (MTU)

#### Chiusura connessione tear down
- procedura "**gentile**"
	- flag **FIN** a 1
	- ricevitore invia un ACK
	- connessione è semichiusa
	- si possono ancora mandare dati nella direziona opposta
		- gli ACK inviati su una connessione semi-chiusa non costituiscono traffico dati
	- la chiusura è completa solo se si invia un FIN e si riceve un ACK

- chiusura "**brusca**"
	- reset RST
	- RST si usa per resettare connessioni 
	- un host invia un segmento con flag **RST**  a 1

#### TCP tempo di andata e ritorno
- come si stima il timeout
- **SampleRTT** tempo misurato dalla trasmissione del segmento fino alla ricezione di ACK
	- Media mobile esponenziale ponderata
	- l'influenza dei vecchi campioni diminuisce
	- $EstimatedRTT = (1 - \alpha)*EstimatedRTT + α*SampleRTT$

##### Impostazione dell'RTO
- EstimatedRTT più un "margine di sicurezza"
	- Grande variazione di EstimatedRTT
- Stimare innanzitutto di quanto **SampleRTT** si discosta da **EstimatedRTT**
- $DevRTT = (1-β)*DevRTT + β*|SampleRTT - EstimatedRTT$
Poi impostare l'intervallo di timeout
$$
RTO = EstimatedRTT + 4*DevRTT
$$
#### controllo di flusso
- permette al ricevitore di controllare la velocità di trasmissione del mittente 
- troppi dati troppo in fretta
FAI SCREEN 59
- il ricevitore comunica quanto **spazio libero** ha nel proprio buffer di ricezione includendo il valore della **RWND** nell'header TCP di ogni segmento
FAI SCREEN

#### controllo di congestione
- problema della rete
	- pacchetti persi 
	- ritardi lunghi
##### Cause/Costi della congestione
- Due trasmettitori due ricevitori
- ci sono tre scenari pag 65

