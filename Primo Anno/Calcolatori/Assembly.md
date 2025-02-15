---
date: 2024/03/20
tags:
  - assembly
Materia: "[[Calcolatori]]"
---
$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
# Assembly
Un file contenente istruzioni **assembly** per essere eseguito dalla CPU deve essere compilato per venire eseguito.
Viene compilato dall' **assembler** che traduce quindi le istruzioni in $0$ e $1$.

### Istruzioni e etichette
Ad ogni istruzione **assembly** corrisponde un'istruzione in linguaggio macchina.
Escluse alcune eccezioni come le (macro, label...)

Un insieme di istruzioni viene chiamato **ISA**(Instruction Set Architecture)
### ISA
Nell'**ISA** vengono specificate
- **sintassi** 
- **semantica**  
- Accesso ai dati:
	- **Registri** (tipo e numero)
	- Modalità di accesso alla memoria(indirizzamento)
Queste istruzioni cambiano a seconda del processore.

## Funzionamento CPU
Principalmente vengono eseguiti 3 passaggi:
1) **Fetch** 
	- Prelevo il dato dalla memoria
	- L'indirizzo in memoria del dato da prelevare è salvato nel **Program Counter** (o **Instruction** **Pointer**)
2) **Decode**: 
	- Decodifica l'istruzione
3) **Execute**: esegue l'istruzione aritmetico logica

## Istruzioni
### Tipi di Istruzioni principali
Principalmente le istruzioni sono dei seguenti tipi:
- Aritmetico Logiche
- Movimento di dati
- Operazioni di controllo del flusso (Vanno a modificare il valore di **PC**/**IC**)
### Operandi principali
- Operazioni aritmetico logiche
- Dati da muovere 
- Nuovi valori per **PC/IP**

### Memorie Principali utilizzate dalla CPU
- Immediati (constanti)
- Nei **registri**
- In memoria (varie modi di **indirizzamento**)
- **Registri** [[Primo Anno/Calcolatori/Reti Logiche#Registri]]
	- Gli insiemi di registri chiamati **banchi di registri**, il loro numero cambia da CPU in CPU ed è definito nell'**ISA**
	- Per riferirsi ai registri in alcuni casi si usano nomi in altri numeri

### Esecuzione condizionale
Per esprimere delle condizioni ci sono più possibilità:
- Confronto fra valori di registri generici (general-purpose)
- Ci si basa sui valori assegnati ai **flag** in un particolare registro
