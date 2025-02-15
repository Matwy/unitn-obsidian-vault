---
date: 2025/01/08
tags: 
Materia: "[[Reti]]"
---
# P2P
## Directory centralizzata
- server con directory centralizzato
- scambio file peer to peer
## Directory distribuita
### Query flooding
- completamente distribuito 
- ogni peer **indicizza** i file e li rende **disponibili per la condivisione**
- Il messaggio di richiesta viene trasmesso sulle connessioni TCP esistenti
- Il peer inoltra il messaggio di richiesta
- Il messaggio di successo viene trasmesso sul percorso
#### Rete di copertura
- un grafo 
- i peer sono connessi con degli archi 
- connessioni TCP
- collegamento virtuale

## Copertura gerarchica
- via di mezzo tra directory centralizzata e distribuita
- il leader del gruppo ha l'indice di tutto il suo gruppo
![[Pasted image 20250108094819.png|200]]
