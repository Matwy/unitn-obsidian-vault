---
date: 2024/05/22
tags: 
Materia: "[[Calcolatori]]"
Argomento: "[[Input Output]]"
---
## Eccezioni
- Trasferimento (non programmato) del controllo del programma
1) Lo user program genera un'eccezione 
2) Viene gestita dal **System** **Exception** **Handler**
3) Si ritorna allo user program
---
## Tipi di Eccezioni
#### Interrupt
- Causate da eventi esterni **(I/O)**
- Asincrone
- Il programma viene solo fermato e fatto ripartire
#### Traps (Eccezioni)
- Causate da eventi interni al programma
	- Condizioni eccezionali (divisione per 0)
	- Errori (hardware, memory, segmentation fault)
	- Fault (page fault)
- Vengono gestite dal **Trap** **Handler** 
- sincrone
- si può riprovare o abortire
#### Environment call/break
- `ecall` è una richiesta di un servizio di sistema
- `ebreak` break per debug
---
## Gestire le eccezioni
- In tutti i casi bisogna salvare lo stato salvando i registri

#### Salto diretto all'indirizzo della routine di gestione
1) `PC <- ind_proc_gest`
	- In RISCV l'indirizzo è contenuto in `STVEC`
	- In RISCV la causa è in  `SCAUSE`

#### Vettore di interruzione
- Usiamo una tabella di indirizzi dove sono contenuti gli indirizzi delle routine di gestione
1) `PC <- ind_proc_gest + causa*4`
	- In RISCV l'indirizzo è contenuto in `STVEC`
	- In RISCV la causa è in  `SCAUSE`
----
#### Salvataggio dello stato della macchina al verificarsi di una eccezione
- Possibilità 
	- salvataggio sullo stack
	- salvataggio in registri ausiliari
	- salvataggio in registri speciali

- Nel RISCV si salva sia nello stack che in dei registri speciali 
