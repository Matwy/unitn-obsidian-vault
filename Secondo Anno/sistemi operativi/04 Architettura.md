---
date: 2025/05/10
tags: 
Materia: "[[sistemi operativi]]"
---
## 04 Architettura
#### Principi di progettazione
- separazione tra
	- **policy** cosa deve essere fatto
	- **meccanismi** come farlo
- **KISS** keep it small and simple
- **POLP** Principle of least privileges

## Struttura SO
- sistemi a monoblocco
- sistemi a struttura semplice
- sistemi a livelli 
- sistemi basati su kernel
- sistemi micro-kernel
- virtual machine
- sistemi client-server

## Sistemi monoblocco
- nessuna gerarchia
- unico strato sw tra utente e hw
- componenti allo stesso livello
- codice dipendete dall'architettura hw era distribuito su tutto il so
- test e debug difficile

## Sistemi a struttura semplice
- minima organizzazione gerarchica
- tipo msdos
#### MS-DOS
- Pensato per fornire il maggior numero di funzionalità nel minimo spazio
	- non suddiviso in moduli
	- possiede un minimo di struttura ma le interfacce e i livelli di funzionalità non sono ben definiti
#### UNIX
- struttura base limitata a causa delle limitate funzionalità hw
- programmi di sistema
- kernel

![[image 1.png|500x326]]


## Sistema a livelli
- servizi organizzati per livelli gerarchici
- ogni livello può usare solo funzioni fornite dai livelli inferiori
- per ogni livello viene quindi definito il tipo di servizio e l'interfaccia verso il livello superiore nascondendone l'implementazione
##### Vantaggi
- modularità
##### Svantaggi
- difficile definire gli strati
- minor efficienza ogni strato aggiunge  overhead alle system call
- meno portabilità 
- le funzionalità dipendenti dall'architettura sono sparsi sui vari livelli

#### THE
- sistema operativo accademico per sistemi batch
- primo sistema a livelli
- inseme di processi cooperanti con semafori
![[image-1 1.png|557x228]]

## Sistemi basati su kernel
- due soli livelli 
	- servizi kernel
	- servizi non kernel
##### Vantaggi
- vantaggi dei sistemi a livelli ma meno livelli

##### Svantaggi
- non così generale come un sistema a livelli

## Virtual Machine
![[image 2.png|540x250]]
#### Hypervisor tipo 1 e 2
![[image-1 2.png|578x253]]

#### Hypervisor design
![[image-2 1.png|580x266]]