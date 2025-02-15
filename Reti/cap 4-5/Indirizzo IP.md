---
date: 2024/11/05
tags: 
Materia: "[[Reti]]"
---
## Indirizzo IP
- è una stringa di 32 bit associata ad una interfaccia di rete
- una **interfaccia** è una connessione tra host o router e il collegamento fisico
- Ogni interfaccia ha un indirizzo IP diverso
- Ogni interfaccia ha almeno un indirizzo IP
- I router per prendere le decisioni si basano solamente sul destination address
#### Notazione degli indirizzi IP
![[Pasted image 20241105165553.png]]

##### Prefisso
- Indica la rete alla quale l'host è allacciato
##### Suffisso
- Identifica un'interfaccia di rete, ogni interfaccia un un indirizzo IP univoco su quella rete

#### Distinzione NetID e HostID
- si usavano assegnazioni statiche
	- classi di indirizzi con diverse lunghezze
		- **Classe A** 7 NetID, 24 HostID
		- **Classe B** 14 NetID, 16 HostID
		- **Classe C** 21 NetID, 8 HostID
		
![[Pasted image 20241105170409.png]]


#### Autorità che assegnano indirizzi
- **ICANN** Internet Corporation for Assigned Names and Numbers
- non assegna i prefissi direttamente 
	- autorizza delle entità dette registrar
- I registrar consentono agli ISP di prendere dei blocchi di indirizzi

#### Indirizzamento classless
- suddivisione arbitraria tra prefisso e suffisso

##### Subnet Mask
- Maschera di rete
- Si memorizzano 32 bit dove gli unici bit a 1 sono quelli del prefisso
	- I router possono quindi fare solamente una AND per ottenere il prefisso

##### Notazione CIDR
- Classless Inter-Domain Routing **CIDR
	- Maschera con 26 bit a 1 e 6 zeri
	- Notazione binaria `11111111.11111111.11111111.11000000`
	- Notazione decimale `255.255.255.192`
- Notazione **CIDR** `ddd.ddd.ddd.ddd/m`
	- cioè si usa la notazione decimale e si aggiunge `/m` dove m è il numero di bit a 1 nella maschera
- Esempio `193.185.15.199/26`

## Indirizzi pubblici e privati
- Indirizzi privati
	- da `10.0.0.0` a `10.255.255.255` `10.0.0.0/8`
	- da `172.16.0.0` a `172.31.255.255` `172.16.0.0/12`
	- da `192.168.0.0` a `192.168.255.255` `192.168.0.0/16`
- **non escono** dalla rete
- sempre univoci all'interno di una rete privata

## Indirizzi speciali
- indirizzi che si riferiscono a tutta la rete
- indirizzo broadcast di una rete Directed Broadcast Address
- indirizzo broadcast di una rete locale Limited Broadcast Address
- Questo computer
- Indirizzi loopback
- indirizzi multicast
- indirizzi link-local
#### Indirizzi di tutta la rete
- Sono usati per riferirsi al prefisso usato per una rete
- hostID tutti a 0
- non si usano per indirizzi di destinazione
#### Indirizzo broadcast di una rete
- "Directed Broadcast Address"
- hostID tutti a 1
- Questi pacchetti vengono inoltrati anche dai router
	- Una sola copia del datagramma viaggia in internet
	- quando raggiunge la destinazione viene consegnato a tutti gli host della rete
#### Indirizzo broadcast di rete locale
- "Limited broadcast address"
- 255.255.255.255 indirizzo con tutti i bit a 1
- i router non inoltrano questi messaggi
- Gli host lo usano per capire in che rete si trova
#### Questo computer
- l'indirizzo con soli zeri
- quando un host viene avviato ed è senza indirizzo viene assegnato questo indirizzo
#### Indirizzi loopback
- Si usano per testare le app di rete
- Il datagramma scende la pila protocollare fino al livello 3 IP
- IP riserva il prefisso `127.0.0.0/8` per il loopback
	- HostID irrilevante
	- spesso si usa `127.0.0.1`

#### Indirizzi multicast
- Servono per inviare pacchetti a gruppi di host
- I router si occupano di creare le copie necessarie
- In IPv4 gli indirizzi multicast iniziano con 1110
	- Da `224.0.0.0` a `239.255.255.255`

- supporto limitato su internet viene spesso bloccato

#### Indirizzi IP link-local
- Quando un host non trova un indirizzo IP usa la sottorete:
- `169.254.0.0/16`
- si vede con DHCP
## Indirizzi IP per i router
- Ad ogni router si assegnano due o più indirizzi IP
	- almeno un indirizzo per interfaccia
