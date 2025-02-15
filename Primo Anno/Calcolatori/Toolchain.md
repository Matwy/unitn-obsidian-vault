---
date: 2024/05/08
tags: 
Materia: "[[Calcolatori]]"
---
## Esempio Compilazione in C
1) **Prepocessore:** al posto delle **direttive** aggiunge **codice** (esempio `#include`)
2) **Compilazione**: da C ad **assembly** (`.s`)
3) **Assembler:** da assembly a **linguaggio** **macchina** (`.o`)
4) **Linker:** Mette insieme il codice in linguaggio macchina e librerie per generare un **eseguibile** (uno dei file deve avare il `main()`)
---
# GCC 
- **g**nu **c**ompiler **c**ollection
- I vari passaggi di compilazione sono `cpp, cc, as, ld`
- `gcc` li invoca tutti
	- Default vengono eseguiti tutti
	- `gcc -S` si ferma dopo `cc` (genera file `.s` assembly)
	- `gcc -c` si ferma dopo `as` (genera file `.o` oggetto)
---
## Compiler
- `cc` è il **Compilatore** si occupa anche di ottimizzare il codice per l'architettura target
	- Diversi livelli di ottimizzazione `-ON` dove N è il livello di ottimizzazione 
---
## Assembler
- `as` è l'**Assembler** si occupa di tradurre il linguaggio assembly in **linguaggio** **macchina** e genera un file **oggetto** `.o`
	- **Pseudo** **Istruzioni** o macro vengono tradotte
	- Converte da decimale/esadecimale a binario
	- Gestisce le **label**
	- Gestisce i **salti** se si salta in un indirizzo troppo grande con `j DEST` lo converte in un caricamento a registro e quindi `jr`
	- Genera **metadati** 

###### Esempio Macro
- `mv x10, x11` diventa
	- `addi x10, x11, 0`
- `li x9, 123` load immediate diventa
	- `addi x9, x0, 123`
- `j LABEL`
	- `jal x0, LABEL`
- eccetera
---
## File Oggetto
- **Header**
	- Dimensione e posizioni degli altri segmenti del file

- Segmenti
	- **Text** **segment** codice in linguaggio macchina
	- **Data** **segment** dati statici dinamici allocati per la durata del programma

- **Symbol** **Table**
	- Associa simboli ad indirizzi
	- Enumera simboli non definiti

- **Relocation** **table**
	- Enumera istruzione che usano degli **indirizzi** **assoluti** che verranno tradotti quando il programma viene caricato in memoria
---
## Linker
- `ld` mette assieme uno o più file oggetto eseguendo le necessarie rilocazioni
	- Associa indirizzi assoluti a tutti i simboli 
	- Decide come il codice e dati sono disposti in memoria (in modo congruente con l'architettura)
	- "Patcha" le istruzioni inserite nella Relocation table in base agli indirizzi assegnati
##### Simboli
- Per **simboli** si intende nomi di variabili e funzioni
- Tipi di **simboli** che il linker gestisce
	- **Simboli definiti** (defined) associati ad un indirizzo relativo nella tabella dei simboli
	- **Simboli indefiniti** (undefined) definiti in un file ma usati in un altro file non presenti quindi nella tabella dei simboli
	- **Simboli locali** (o non esportati) definiti ed usati in un file ma non usabili in altri file
	
- In tutti i casi si associa un indirizzo **assoluto** ad ogni simbolo
- Per i simboli non definiti si cerca in altri file
	-  Se non lo trova errore di linking

#### Passaggi Linker
1) Dispone in memoria i segmenti (`.text`, `.data`, etc)
2) In base al passo precedente associa gli indirizzi assoluti
3) In base alle tabelle di rilocazione correggere le varie istruzioni con gli indirizzi calcolati
- Viene tutto incapsulato nell'**eseguibile**
	- segmenti
	- info per il caricamento in memoria
	- debugging
---
## Librerie
- Esistono funzioni fornite dal compilatore/sistema
- Altre sono definite dal programmatore e sono definite quindi nei file oggetto

- Una **libreria** è una collezione di `.o` 
	- **librerie** **statiche** `.a`
		- `ld` fa tutto
		- la libreria deve essere tutta linkata e aumenta la dimensione dell'eseguibile
	- **librerie** **dinamiche** `.so` (in windows `.ddl`)
		- il linking avviene a tempo di esecuzione (caricamento dinamico)

#### Librerie dinamiche
- `ld` inserisce i riferimenti alle funzioni e librerie usate ma non le include nell'eseguibile
- ogni eseguibile contiene un riferimento ad un **linker dinamico** (`/lib/ld-linux.so`)
	- All'esecuzione viene eseguito il linker dinamico passando il programma come argomento
	- carica l'eseguibille e le librerie dinamiche da cui dipende e fa il linking
##### Vantaggi svantaggi
- `+` eseguibile più piccolo
- `+` possibile aggiornare le librerie senza ricompilare
- `-` il programma non è più auto contenuto
- `-` esecuzione complessa

#### Lazy linking
- Solo nel momento in cui c'è il bisogno di una libreria viene caricata la libreria
- questo viene fatto chiamando uno **stub** il quale si occupa del caricamento e rilocazione quando serve
---
## Esempi
- [[CalcLect15-ToolChain.pdf#page=18&selection=0,0,0,40|Esempi]]
