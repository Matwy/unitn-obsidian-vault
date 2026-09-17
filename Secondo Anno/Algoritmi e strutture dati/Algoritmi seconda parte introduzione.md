---
date: 2025/02/24
tags: 
Materia: "[[Algoritmi e strutture dati]]"
---
## Algoritmi seconda parte introduzione
#### Tecniche soluzioni problemi
- divide et impera 
- programmazione dinamica / mamoization
- Tecnica greedy
- ricerca locale
- backtrack
- algoritmi probabilistici
- tecniche di soluzione per problemi intrattabili
## Programmazione dinamica
- Spezziamo un problema in un sottoproblema 
- ogni sottoproblema viene risolto solo una volta
- la soluzione viene memorizzata in una tabella
- se troviamo un sottoproblema già risolto abbiamo già la soluzione
- tabella con lookup O(1)


### Tabella DP
- memorizziamo i casi base direttamente nelle posizioni relative
- lo facciamo bottom up