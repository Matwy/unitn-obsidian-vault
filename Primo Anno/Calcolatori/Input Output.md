---
date: 2024/05/22
tags: 
Materia:
---
## Input Output
- Sono collegati al Processore tramite un **bus**
![[Pasted image 20240522085951.png|center|350]]
#### Bus
##### Bus Processore/memoria
- specializzati, corti e veloci
##### Bus I/O
- possono essere lunghi e collegano periferiche eterogenee
- non sono collegati direttamente alla memoria ma passano per un **bus processore/memoria**


#### Terminologia
##### Transazione di I/O
- Invio indirizzo e spedizione o ricezione dei dati
##### Input
- trasferimento da periferica a memoria dove il processore può leggerla
##### Output
- trasferimento da memoria a dispositivo

#### Bus sincrono
- Le comunicazioni usano un protocollo legato al ciclo di clock
![[Pasted image 20240522091217.png|center|400]]
###### Pro 
- Sistema semplice e veloce
###### Contro
- Poca robustezza al drift del clock
- Tutte le periferiche devono andare alla velocità del clock

#### Bus asincrono
- Non c'è più un clock 
- tutte le transazioni vengono gestite con **segnali di handshake**
- richiedere l'introduzione di apposite **linee di controllo** per segnalare inizio e fine delle transazioni
- le periferiche andranno quindi a velocità diversa

![[Pasted image 20240522092607.png|center|450]]

###### Pro 
- Consente di comunicare con velocità diverse
- E' più robusto al drift del clock
###### Contro
- Molto più complesso
- Lento nelle interazioni

#### Osservazioni
- Spesso si usano tecnologie ibride (con un ciclo di clock) ma principalmente si usa quello asincrono
---
## SO
- [[IO e Sistema Operativo]]

