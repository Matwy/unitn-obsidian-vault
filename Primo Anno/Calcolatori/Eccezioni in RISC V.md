---
date: 2024/05/22
tags: 
Materia: "[[Calcolatori]]"
Argomento: "[[Eccezioni]]"
---
## Eccezioni in RISC V
#### Registi
- Vari registri a 64 bit 
	- `SEPC` indirizzo dell'istruzione che ha generato l'eccezione
	- `SSTATUS` bit di abilitazione globale degli interrupt
	- `SCAUSE` I bit 63 e (3-0) codificano le possibili eccezioni
		- Illegal instruction {0, 2}
		- Breakpoint {0, 3}
		- Time interrupt {1, 5}
		- External interrupt {1, 9}
	- `STVAL` **Supervisor Trap Value** indirizzo dove c'è stato un riferimento alla memoria sbagliato
	- `SIE` **Supervisor Interrupt Enable** specifica abilitazioni degli interrupt in attesa
	- `SIP` **Supervisor Interrupt Pending** monitoraggio degli interrupt in attesa
	- `STEC` **Supervisor Trap Vector** Indirizzo base delle Routine di gestione
	- `SSCRATCH` Registro per salvataggi temporanei
- Tutti questi si trovano in un banco interno al processore chiamato **Control** **Status** **Register** (**CSR**)
- Al verificarsi di una eccezione la parte di controllo della CPU modifica questi registri
---
## Status Register

![[Pasted image 20240522152446.png|center|400]]
- **SIE** Interrupt Enable abilita globalmente gli interrupt a quel dato livello, per non entrare in loop viene subito disabilitato (dopo aver gestito l'eccezione)
- **SPIE** Previous Interrupt Enable indica lo stato precedente del **SIE** al momento in cui si verifica un'eccezione
- **SPP** Previous Privilege mode indica il livello di privilegio precedente al momento in cui si verifica l'eccezione
---
## Controllo fine degli interrupt

![[Pasted image 20240528084757.png|center|400]]
- **SxIE** sono bit di abilitazione più fine degli interrupt
- **SxIP** sono bit di indicazione di interrupt pendenti (in attesa) 
- x si riferisce alla possibile sorgente dell'eccezione
	- x = E -> interrupt esterno
	- x = T -> interrupt dal timer
	- x = S -> interrupt software (eccezione)

- Possiamo quindi dire che in **SIE** ci sono gli interrupt che si sono verificati e in **SIP** ci sono quelli ancora in attesa
---
## Ingresso ed Uscita in modalità supervisor

- Quando si verifica una eccezione
![[Pasted image 20240528085403.png|center|500]]
- Quando finiamo di gestire gli interrupt chiamiamo `SRET`
![[Pasted image 20240528085542.png|center|500]]

---
## SCAUSE Register
![[Pasted image 20240528085803.png|center|400]]
- **Int** 1 bit 
	- se vale `1` la sorgente è un interrupt
	- se vale `0`  è un'eccezione

- **Code** (4 bits) codifica la ragione dell’eccezione 
	- 0 - Instruction address misaligned 
	- 2 - Illegal instruction 
	- 3 - Breakpoint  
	- 4 - Load address misaligned  
	- 5 - Load address fault 
	- 6 - Store address misaligned 
	- 7 - Store address fault 
	- 8 - Environment call from U-mode 
	- 9 - Environment call from S-mode 
	- C - Instruction page fault 
	- D - Load page fault
---
## Lettura/Scrittura di SEPC SCAUSE STVEC STVAL...
- Per modificare i contenuti dei registri speciali CSR
	- CSR Atomic Read and Write (/immediate) `CSRRW rd, csr, rs` `CSRRWI rd, csr, imm` `imm` è codificato a 5 bit
	- CSR Atomic Read and Set Bit(/immediate) `CSRRS rd, csr, rs` `CSRRSI rd, csr, imm` `imm` 
	- CSR Atomic Read and Clear Bit(/immediate) `CSRRC rd, csr, rs` `CSRRCI rd, csr, imm` `imm` 

##### Esempi
![[Pasted image 20240528091023.png|center|600]]

---
## Supporto del RISC-V per la gestione delle eccezioni
- I soli tipi di eccezioni  che possono essere generate nell'implementazione della CPU analizzata sono:
	- Esecuzione di una istruzione non valida
	- malfunzionamenti hardware
- In caso di eccezione il processore deve
	- Salvare l'indirizzo dell'istruzione che la ha generata nel registro causa delle eccezioni SEPC
	- Salvare la causa dell'eccezione nel registro causa di supervision dell'eccezione SCAUSE
	- Trasferire il controllo ad un indirizzo specifico del sistema operativo per gestire l'eccezione
	- Terminata la gestione ripristinare lo stato del processore e ritornare all'esecuzione precedente (se possibile)
- Le eccezioni sono trattate nel RISCV come se fossero degli hazard sul controllo
---
- Gestione di una eccezione in fetch, trasformiamo l'istruzione in nop (no operation)
- Introduciamo un nuovo segnale di controllo `ID.Flush`, messo in OR con il segnale di stallo che proviene dall'unità di rilevamento hazard, in modo da eliminare l'istruzione dallo stadio ID e quindi avere lo stallo
- Nuovo segnale `Ex.Flush` che pilota un nuovo multiplexer per mettere a 0 i segnali di controllo di quello stadio
 - Ora bisogna aggiungere una linea che porta il valore dell'indirizzo di gestione delle eccezioni al program counter
 - Infine salviamo l'indirizzo dell'istruzione che ha causato l'eccezione nel registro `SEPC`
---
#### Problema
- Al verificarsi di un'eccezione bisogna evitare che l'operazione vada a "sporcare i registri" scrivendo qualcosa di errato
- Molte eccezioni richiedo di completare normalmente l'esecuzione dell'istruzione che ha causato l'eccezione
	-  Il modo più semplice per ottenere ciò consiste nell'eliminare l'istruzione e farla eventualmente ripartire
---
![[Pasted image 20240528095001.png|center]]