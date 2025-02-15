---
date: 2024/05/20
tags: 
Materia: "[[Calcolatori]]"
Argomento: "[[Memoria]]"
---
## Gerarchia di memoria
#### Principio di località temporale
- Se usiamo una locazione di memoria è molto probabile che la riuseremo poco dopo
#### Principio di Località spaziale
- Quando usiamo una locazione nei prossimi step useremo locazioni vicine a questa

## Terminologia

##### Blocco
- Unità minima dell'informazione che può essere presente  assente in ciascun livello
##### Hit rate
- Frequenza di successi, frazione degli accessi in cui trovo il dato nel livello superiore
##### Miss rate
- 1-Hit Rate (quando non lo trovo al livello superiore)
##### Tempo di hit
- Tempo necessario per accedere al dato nel livello superiore
##### Penalità di miss
- Tempo necessario per leggere un dato se non è nel livello superiore
