---
date: 2025/02/19
tags: 
Materia: "[[computer-network-security]]"
---
# TLS
## TLS handshake
#### Client Hello 
- viene mandato dal **client** al **server**
- ha la **versione del protocollo** che il client vuole usare
- la lista delle **cipher suite** supportate
	- una cipher suite è l'insieme di algoritmi che verranno usati dal TLS per garantire una connessione sicura.
#### Server Hello
- dal **server** al **client** 
- contenuto
	- **protocollo scelto** dal server
	- **cipher suite** scelta dal server
	- **session ID**
		- un identificatore della nuova sessione che sta venendo creata 
#### Certificate Server Key Exchange
- Se il **client** ha chiesto il **certificato** al server il server deve mandare il suo **certificato X.509** 
- Viene scambiata la **premaster** secret che verrà poi usata per generare la **master** secret.  
- il **client** invia la sua **premaster** 
- dopo questo scambio di chiavi client e server riescono a calcolare la **stessa** **master** **key**
- questa verrà usata da un algoritmo di cifratura per scambiare messaggi
- si passa al record protocol
## Confidenza Integrità Autenticazione
#### Confidenza
- Il TLS garantisce confidenza grazie a uno scambio di chiavi sicuro. Non avendo il problema di distribuzione delle chiavi la comunicazione può procedere con algoritmi di criptografia sicuri come AES con 256bit.
	- spesso si usa Diffie Hellman per lo scambio di chiavi
	- AES e ChaCha20 per criptare i messaggi
#### Autenticazione
- Il TLS ci garantisce che i messaggi sono autenticati grazie al controllo dei certificati X.509.
#### Integrità
- Ogni messaggio contiene un MAC Message authentication code, questo codice è generato con funzioni hash sicure come SHA 256. Il destinatario può quindi ricalcolare l'hash per vedere se corrisponde