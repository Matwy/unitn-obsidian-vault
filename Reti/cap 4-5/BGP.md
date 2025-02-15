---
date: 2025/01/03
tags: 
Materia: "[[Reti]]"
---
## BGP inter-AS networking
- **Border Gateway Protocol**
- **BGP** è un **Path Vector Protocol**

- ogni AS ha un certo numero di router detti **BGP** **speaker**
- BGP possono parlare attraverso una connessione **TCP** tra loro
- Una volta connessi due BGP speaker possono scambiarsi **informazioni** di **raggiungibilità**

#### Path vector protocol
- Le info condivise includono sia la raggiungibilità di un prefisso sia il **percorso** per raggiungerlo
![[Pasted image 20250103102937.png|500]]

#### Interconnessioni tra AS
- **Client - Provider** Il client paga il provider per ottenere raggiungibilità
- **Peer** due nodi hanno una relazione di peering quando condividono tutte le info di raggiungibilità

#### Policies
- Le interconnessioni tra AS sono controllate da contratti
- **Ingress Policies** Politiche applicate alle rotte che voglio importare
- **Egress Policies** Politiche applicate alle rotte che voglio esportare

#### Best Path BGP
- Nel **BGP** il best path dipende dalla policy degli AS
- Ogni **speaker** BGP condivide solo il proprio **best** **path** per raggiungere una dest
- I best path vengono poi installati nella routing table del router che fa da speaker

> In generale il best path **non** è per forza il percorso più veloce

---
## Messaggi
#### Open
- Usato per aprire una **nuova** **connessione** con un altro nodo 
- Se viene accettato viene inviato un **KEEPALIVE** di conferma
- l'**hold** **time** è una proposta che si scambiano i due speaker riguardo al tempo di validità della rotta, viene usato il minore
- BGP **identifier** indirizzo IP identificativo dello speaker, uguale per tutte le interfacce BGP dello speaker

#### Notification
- Usato per condividere errori
- 6 Error codes in base al tipo di errore
- 20 Error subcodes in base a dove avviene l'errore
#### KeepAlive
- Usato per mantenere attiva la connessione
- Devono essere inviati per non lasciar scadere l'hold timer
#### Update
- Usato per inoltrare conoscenza
- Contengono info di raggiungibilità
- I messaggi di update sono i responsabili per la disseminazione delle info
- info **additive**: Portano info di raggiungibilità per nuovi percorsi
- info **sottrattive**: rimuovono percorsi per raggiungere una destinazione
### WITHDRAW
- Un **WITHDRAW** è la rimozione  di una rotta
	- nei pacchetti update si possono inserire le rotte cancellate
- si fa un WITHDRAW quando **non è più possibile raggiungere un AS**
- Se un BGP conosce un **percorso alternativo**
	- rimuove la rotta precedente 
	- usa il nuovo **percorso** e lo **condivide**

#### implicit WITHDRAW
- invece di mandare WITHDRAW+UPDATE si manda solo un pacchetto di "aggiornamento" del percorso migliore

---


#### Aggregazione rotte
#### Filtri
- **Ingress** **filters**
- **Egress** **filters**
- Una rotta che non supera i filtri viene scartato

## Routing information Base (RIB)
- BGP usa 3 tabelle per le rotte
- **ADJ_RIB_IN**
	- rotte che hanno passato gli **ingress filter**
	- usato per valutare percorsi alternativi
- **Routing** **Table**
	- **best path** attuali
- **ADJ_RIB_OUT**
	- contiene le rotte che hanno superato gli **egress filter** e che devono essere condivise
#### Ricezione di un Update costruttivo
- valutato dagli **ingress** **filters**
- se vengono superati viene aggiunto alla **ADJ_RIB_IN** 
- Viene rivalutato il **best** **path** per la destinazione usando la ADJ_RIB_IN

- se cambia il best path si aggiorna la **routing** **table** si aggiorna la **ADJ_RIB_OUT** si inoltrano i cambiamenti

#### Ricezione di un Update con WITHDRAW
- valutato dagli **ingress** **filters**
- se superati i filtri vengono **rimosse** le rotte specificate dalla **ADJ_RIB_IN**
- rivalutazione del **best** **path** con la ADJ_RIB_IN

- se cambia il best path si aggiorna la **routing** **table** si aggiorna la **ADJ_RIB_OUT** si inoltrano i cambiamenti