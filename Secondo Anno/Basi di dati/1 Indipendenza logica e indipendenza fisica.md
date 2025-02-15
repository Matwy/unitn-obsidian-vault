---
date: 2024/10/19
tags: 
Materia: "[[Basi di dati]]"
---
## Indipendenza logica dei dati
- **DEF** La capacità di modificare lo schema logico del database senza dover alterare lo schema esterno o le applicazioni che utilizzano il database
- indipendenza tra schema logico e schema esterno
##### Vantaggi 
- consente di aggiungere rimuovere o modificare campi e tabelle senza influire sulle applicazioni esistenti
- migliora la flessibilità e la gestione dell'evoluzione del database

## Indipendenza fisica dei Dati
- **DEF** La capacità di modificare lo schema fisico del database senza influenzare lo schema logico o le applicazioni
- indipendenza tra schema fisico e schema logico
##### Vantaggi
- Permette di ottimizzare le prestazioni cambiando la struttura di memorizzazione o gli indici senza alterare la logica delle applicazioni
- migliora la scalabilità e la gestione delle risorse hardware


## Schemi logico fisico esterno
#### Schema logico
- modello che rappresenta i dati nei termini del modello proprio del DBMS (modello relazionale)
#### Schema fisico 
- fornisce dettagli su come le relazioni descritte dallo schema logico sono memorizzate su memoria secondaria. Ad esempio file di record ordinati / non ordinati, indici 
#### Schema esterno
- permette di creare una o più **viste** specifiche per velocizzare / facilitare / autorizzare l'accesso a insiemi di dati a specifici utenti o gruppi di utenti

## Vantaggi base di dati
- **Indipendenza** **logica** e **fisica** dei dati
- Accesso concorrente ai dati
- Crash recovery

#### Condivisione dei dati e transazioni multi-utente
- permette a gruppi di utenti di leggere e scrivere contemporaneamente sulla stessa base di dati (**concurrent** **users**)
- Il **controllo** **della** **concorrenza** nel DBMS garantisce che ogni transazione sia eseguita correttamente o annullata
#### Recovery
- Il sottosistema di **recovery** assicura che ogni transazione correttamente completata sia memorizzata in modo permanente nella base di dati
	- Questo permette di mantenere validità e coerenza dei dati **OLTP** Online Transaction Processing

#### OLTP e OLAP
- sono due modelli di elaborazione
###### OLTP
- utilizzato per operazioni brevi e che coinvolgono pochi record
- importante l'atomicità dei dati
###### OLAP
- analisi complesse query di lunga durata

## Tipi di users
#### Database administrator
- E' responsabile dell'autorizzazione di accesso alla base di dati del coordinamento e del monitoraggio del suo utilizzo
#### Database Designer
- E' responsabile della definizione del contenuto dello schema dei vincoli e delle transazioni che possono essere eseguite 
#### End-users
- utilizzano i dati tramite query. Alcuni possono aggiornare i contenuti
