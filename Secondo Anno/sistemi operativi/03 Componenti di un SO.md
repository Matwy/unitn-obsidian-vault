---
date: 2025/05/08
tags: 
Materia: "[[sistemi operativi]]"
---
# Componenti di un SO
- Gestione dei processi
- Gestione della memoria primaria
- Gestione della memoria secondaria
- Gestione dell'I/O
- Gestione dei file
- Protezione 
- Rete
- Interprete dei comandi
#### Gestione Processi
- Un **processo** è un programma in esecuzione 
	- necessita risorse
	- eseguito in modo sequenziale un'istruzione alla volta
- Il **SO** è responsabile 
	- della creazione e distruzione di processi
	- sospensione e riesumazione di processi
	- fornisce dei meccanismi per sincronizzare i processi e permettere la comunicazione tra loro

#### Gestione Memoria Primaria
- La **memoria** **primaria** conserva dati condivisi dalla CPU e dai dispositivi I/O
- Il **SO** è responsabile della 
	- Gestione dello spazio di memoria (quali parti sono usate da chi)
#### Gestione Memoria Secondaria
- La **memoria secondaria** è fondamentale in quanto la memoria primaria è volatile e piccola.
- Il SO è responsabile della 
	- gestione allocazione spazio
	- scheduling degli accessi sul disco
#### Gestione dell'I/O
- Il sistema IO
	- Un sistema per accumulare  gli accessi ai dispositivi
	- Una generica interfaccia verso i device driver
	- Device driver specifici per alcuni dispositivi
#### Gestione dei file
- I **File** sono delle astrazioni logiche per rendere conveniente l'uso della memoria non volatile
- SO è responsabile di 
	- creazione de cancellazione di file e directory
	- supporto di primitive per la gestione di file e directory
	- corrispondenza tra file e spazio fisico su disco
	- salvataggio delle informazioni a scopo di backup
	
#### Protezione
- Meccanismo per controllare l'accesso alle risorse da parte di utenti e processi
- SO è responsabile della definizione di **accessi autorizzati e non**, controlli da imporre, politiche di accesso
#### Sistemi Distribuiti
- Un sistema distribuito è una collezione di elementi di calcolo che non condividono ne la memoria ne un clock

## Interprete dei Comandi (Shell)

- L'**interprete** **dei** **comandi**, o **shell**, è il programma che:

    **Legge i comandi forniti dall'utente.**
    **Interpreta ed esegue ciascuna istruzione.**

- Tipi di operazioni gestite tramite la shell
- Creare e gestire processi

- Gestire operazioni di input/output

- Gestire memoria, file system e dischi

- Configurare e controllare le protezioni (es. permessi di accesso)

- Gestire le funzionalità di rete

#### Come funziona l'esecuzione dei comandi

- L'interprete può eseguire comandi in due modi:

    - Comandi implementati internamente (built-in):
        - Sono integrati direttamente nella shell.
        - Modificarne la semantica richiede interventi sulla shell.
    - Comandi esterni (es. ls, rm, grep):
        - Sono programmi autonomi presenti nel sistema.
        - La shell si limita a invocarli tramite il nome del file eseguibile.
        - Non è necessario modificare la shell per cambiarne il comportamento.

    ✅ Nota: aggiungere nuovi comandi built-in richiede modificare il codice dell'interprete. Ma aggiungere nuovi programmi esterni (script o eseguibili) no.

## Interfaccia Utente

### Tipi di interfacce fornite dall'interprete dei comandi
L'interprete può offrire diversi tipi di interfacce utente:
- **Command-Line Interface (CLI)**  
  - Permette di digitare direttamente comandi testuali (es. UNIX).
  - Spesso implementata nel kernel, ma talvolta anche come programma di sistema.
  - Può esistere in diverse varianti, chiamate *shells* .
- **Graphical User Interface (GUI)**  
  - Basata sull'uso di mouse, tastiera e schermo.
  - Rappresenta file, programmi e azioni tramite *icone*.
  - Le azioni si eseguono puntando e cliccando con il mouse.
- **Interfaccia Batch**  
  - I comandi sono scritti in anticipo in uno script e vengono eseguiti in sequenza.
  - Non richiede interazione durante l'esecuzione.

---

## GUI e Metafora del Desktop

- La GUI spesso utilizza la **metafora del desktop**:
  - File, programmi e azioni sono rappresentati da **icone**.
  - Le cartelle (directories) sono visualizzate come **folder**.
  - I tasti del mouse, usati su un oggetto, possono:
    - Visualizzare informazioni
    - Mostrare opzioni
    - Eseguire azioni
    - Aprire directory o applicazioni
---
## System Call

### Chi usa le system call?
- L'**utente** interagisce con il sistema tramite la **shell**.
- I **processi**, invece, utilizzano le **system call** per accedere ai servizi del sistema operativo.

### Cos'è una system call?
- È un'interfaccia fornita dal Sistema Operativo tra i **processi** e i **servizi** che il sistema offre.
- Le system call sono accessibili tramite le **API (Application Programming Interface)** fornite dal sistema operativo.

#### Opzioni per la comunicazione tra il S.O. e un processo
- Passare i parametri (della system call) tramite registri 
- Passare i parametri tramite lo stack del processo 
- Memorizzare i parametri in una tabella in memoria • L’indirizzo della tabella è passato in un registro o nello stack
# Nelle slide spiegano bene tutto quello che succede
- [[03-Componenti.pdf#page=31&selection=10,0,18,5|03-Componenti, page 31]]
---

### Dettagli di implementazione
- Le API sono **tipicamente scritte in linguaggi di alto livello** come **C o C++**.
- Alcune system call, in casi specifici, sono scritte anche in **assembler** per esigenze di basso livello.

---

### Livello intermedio
- Per **nascondere i dettagli implementativi** complessi delle system call, il sistema operativo fornisce un **livello intermedio**:
  - I programmi in genere **non chiamano direttamente** le system call.
  - Usano invece **l'API di alto livello**, che le invoca per loro in modo trasparente.

> ✅ Questo approccio rende la programmazione più semplice e portabile tra sistemi diversi.

---
