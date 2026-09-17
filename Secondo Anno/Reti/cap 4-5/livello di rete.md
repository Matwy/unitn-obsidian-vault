---
date: 2024/10/30
tags: 
Materia: "[[Reti]]"
---
## livello di rete
#### Ha due funzioni 
- **Inoltro (forwarding)**
	- Operazione locale 
	- spostamento da ingresso a uscita del routing
- **Instradamento (routing)**
	- Operazione locale con scala globale
	- Determinare il percorso di un pacchetto
	- Algoritmi di routing

#### Data plane
- Funzione locale a ogni router
- Determina come inoltrare un datagramma da una porta di arrivo ad una di uscita
- Funzione di **forwarding**
#### Control plane
- Logica globale di rete
- determina come instradare un datagramma in un percorso end-to-end
![[Pasted image 20241030090158.png|center|600]]

## Architettura dei router
![[Pasted image 20241030090423.png]]

### Sistema di commutazione
-  trasferisce i pacchetti dall'ingresso all'uscita appropriata
- **tasso** **di** **commutazione** frequenza alla quale i pacchetti vengono trasferiti dagli ingressi alle uscite
	- Spesso misurato come multiplo della velocità di comunicazione
	- Con $N$ ingressi vorremmo una commutazione $N$ volte più veloce della comunicazione
![[Pasted image 20241030090544.png]]
- Utilizzando i valori nell'header livello 3, trova la porta di uscita corretta usando la tabella di inoltro. (match plus action)
- L'obbiettivo è **decentralizzare** il sistema di commutazione in modo da non introdurre ritardi
- **Accodamento nel buffer** in caso i datagrammi arrivino più in fretta del tasto di smistamento
#### tre tipi di strutture
![[Pasted image 20241030091426.png]]
##### Commutazione a memoria
- Computer tradizionali dove la commutazione è controllata dalla CPU
- pacchetti copiati nella memoria del computer
- velocità di commutazione limitata dalla banda dati della memoria
![[Pasted image 20241030091629.png]]
##### Commutazione a bus
- Si usa un bus dati condiviso interno al router per trasmettere i datagrammi da ingressi a uscite
- Contesa del bus: la velocità di commutazione è limitata dalla banda del bus
- 32 Gbit/s Cisco 5600 sufficiente per router di accesso e router interni ad aziende
![[Pasted image 20241030092010.png|center|200]]
##### Commutazione a matrice
- matrice di punti di interconnessione tra linee di ingresso e uscita
- supera i limiti della velocità di bus
- **Design avanzato** frammentazione dei datagrammi in celle di lunghezza  fissa
- Cisco 12000: commuta 60 Gbit/s attraverso la rete di interconnessione
![[Pasted image 20241030092329.png|center|200]]
#### Accodamento alle porte di ingresso
- Un commutatore più lento della velocità complessiva delle porte di ingresso causa **accodamenti** **agli** **ingressi** 
	- ritardi o anche perdite dovute agli overflow dei buffer
	
- **Blocco "head-of-line" (HOL)** un datagramma accodato al primo posto della coda impedisce a quelli successivi di avanzare
	- Esempi:
![[Pasted image 20241030092731.png|center|500]]

#### Porte di uscita
- datagrammi più veloci di quanto le porte di uscita possano smaltirli
	- I datagrammi potrebbero essere scartati se le memorie si riempiono
##### Accodamento nelle porte di uscita
- se i pacchetti arrivano troppo in fretta si accodano
- ritardi di accodamento o perdite per buffer overflow

#### Standard memoria nei buffer
-  [[reti4-5.pdf#page=20&selection=0,0,0,1|Standard RFC 3439]]
#### Meccanismi di scheduling
- **Scheduling**  scelta di quale pacchetto trasmettere
- **FIFO** 
- politica di scarto
	- **Tail drop**: scarto i pacchetti in arrivo
	- **Priority drop**: scarto o cancello basandomi su un livello di priorità
	- **Random drop**: scarto o cancello casualmente

## Protocollo IP
- [[Protocollo IP]]