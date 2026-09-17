---
date: 2024/11/05
tags: 
Materia: "[[Reti]]"
---
## Protocollo IP
#### Formato del datagramma IP
![[Pasted image 20241105100208.png|center|300]]
#### Campi del datagramma
- `VER` numero versione
- `Lunghezza header` indica numero di parole di 32 bit nell'header
- `tipo di servizio` ToS Type of service: classe di servizio del datagramma
	- potenzialmente usato per ECN (explicit congestion notification)
	- raramente usato
- `Lunghezza totale` numero totale di byte nel datagramma includendo sia l'header sia i dati 
- `ID del datagramma` numero sequenziale assegnato al datagramma
- `FLAG` che dice se il datagramma è un frammento di un datagramma più lungo
- `OFFSET del FRAMMENTO` posizione del frammento nel datagramma originale
- **TIME TO LIVE TTL** intero inizializzato dal mittente e viene ridotto di 1 da ogni router se arriva a 0 viene scartato
- `protocollo superiore` indica il protocollo di livello superiore aspettarsi 
- `checksum dell'header`
- `indirizzo IP sorgente`
- `indirizzo IP destinazione`
- `opzioni IP` usato poco
- `padding` vengono aggiunti dei bit a 0 per arrivare a un multiplo di 32 bit
#### MTU e frammentazione datagrammi
- Tutti i tipi di hardware specificano un MTU **Maximum** **Transmission** **Unit** 
- se un host invia un pacchetto ad un altro host il primo ha MTU più alta del secondo il router potrebbe dover frammentare il pacchetto 
- i frammenti li riassembla il destinatario