---
date: 2025/01/03
tags: 
Materia: "[[Reti]]"
---
## Protocolli per il controllo dell'accesso multiplo
- algoritmo distribuito che determina come i nodi condividano il canale quando un nodo può trasmettere e quando no

#### protocolli MAC 
- **MAC** : **multiple access control**

##### A ripartizione delle risorse
- dividi il canale in sottocanali
##### Ad accesso causale
- si verificano collisioni ma si cerca di minimizzarle
##### A turni intelligenti
- I nodi accedono al canale a turno, chi ha più dati ha il turno più lungo
---

## Ripartizione delle risorse TDMA
- **Time Division Multiple Access**
- Accesso al canale in frame
- ogni nodo ottiene uno slot di durata fissa in ogni frame

![[Pasted image 20250103150132.png]]

## Ripartizione delle risorse FDMA
- **Frequency division multiple access**
- Spettro del canale suddiviso in sottobande
![[Pasted image 20250103150303.png]]


## Ripartizione delle risorse CDMA
- **code-division multiple access**
- La ripartizione delle risorse avviene assegnando un codice diverso ad ogni nodo

## Carrier sense multiple access CSMA
#### Non persistente 0-persistent
- se il canale è vuoto trasmetti
- se il canale è occupato attente un tempo causale e poi riprova
#### 1-persistent
- se il canale è vuoto trasmetti
- se il canale è occupato aspetta che si liberi e trasmetti

#### Collisione
- in ogni caso se c'è una collisione il nodo attende un tempo casuale e riprova

> **backoff** attesa di un tempo casuale

#### p-persistente
- se il canale è vuoto trasmette
- se è occupato
	- attente finche non si libera
	- dopo con probabilità p trasmette il frame
	- con probabilità 1-p attente un tempo casuale e riprova


## CSMA/CD collision detection
- usa comunque il carrier sensing
- nel caso di collisioni vengono interrotte le trasmissioni per ridurre lo spreco di risorse

## CSMA/CA collision avoidance
- si usa quando non si possono rilevare le collisioni
- usato nel wifi
- CA significa usare un CSMA p-persistente e p viene adattata alle condizioni di rete
	- inizio p alta
	- si riduce per ogni tentativo fallito

# Protocolli a turni
## Polling
- il master dice agli slave quando parlare

## Token ring
- protocollo a turni che consiste nel passarsi un token in modo sequenziale 
- solo chi ha il token può trasmettere
