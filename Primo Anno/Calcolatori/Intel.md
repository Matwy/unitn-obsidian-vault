---
date: 2024/04/28
tags:
  - assembly
  - intel
Materia: "[[Calcolatori]]"
---
Slide: [[CalcLect11-Intel.pdf]]
## Intel
I processori intel vengono utilizzati dalla maggior parte dei pc.
- I processori **intel** hanno una architettura [[Introduzione Calcolatori#ISA|CISC]]
- Vedremo solo le sintassi del GNU Assembler (gas)
## Registri General Purpose
- Sono tutti preceduti dal prefisso `%`
- Alcuni registri:
	- `%rsp` **stack** **pointer**
	- `%rbp` **base** **pointer**

I registri con la `r` davanti sono a 64 bit al loro interno esistono registri a 32 bit che a loro volta estendono registri a 16 e a 8.
- `%rax -> %eax -> %ax -> %ah -> %al`
![[Pasted image 20240609155957.png]]
#### Registri speciali
- **Instruction** **pointer** `%rip`
- **Flags** **register** `%rflags` estende `%eflag` -> `%flag`
	- Flag per operazioni logico aritmetiche
		- `CF` Carry Flag 1 se il risultato è unsigned overflow o carry out
		- `ZF` Zero Flag 1 se il risultato è zero
		- `SF` Sign Flag 1 se il risultato è negativo
		- `OF` 2's Overflow Flag 1 se il risultato è andato in overflow

- Questi flag vengono usati dalle **istruzioni** di **salto** **condizionale**
- Alcuni flag contengono info sulla CPU

## Convenzioni di chiamata
Non fanno parte dell'architettura ma sono specificate dall'ABI
Servono per “mettere d’accordo” diversi compilatori / librerie ed altre parti del Sistema Operativo.

- argomenti:
	- primi 6 `%rdi %rsi %rdx %rcx %r8 %r9`
	- Altri argomenti sullo stack
- Valori di ritorno
	- `%rax` e `%rdx`
- Registri preservati
	- `%rbp`, `%rbx`, `%r12`, `%r13`, `%r14` ed `%r15`
- Non preservati
	- `%rax`, `%r10`, `%r11`, oltre ai registri per passaggio parametri: `%rdi`, `%rsi`, `%rdx`, `%rcx`, `%r8` ed `%r9`
## Modalità di Indirizzamento
- Istruzioni prevalentemente a **2** **operandi**
	- Secondo operando **destinazione** **implicita**
- Sorgente **primo** **operando**
	- Immediato (si usa `$` come prefisso)
	- In registro (`%rax`)
	- In memoria (`0x0100A8`)
- Destinazione **secondo** **operando**
	- In registro (`%rax`)
	- In memoria (`0x0100A8`)

##### Diverso accesso in memoria
- E' possibile usare operazioni che scrivono sia sui registri sia sulla memoria
	- RISCV accesso alla memoria solo tramite load e store
###### Operandi in memoria
- **Accesso indiretto**
- sintassi : `<displ> (<base reg>, <index reg>, <scale>)`
	- `displacement` costante a 8, 16, 32 bit
	- `base` valore in registro
	- `indice` valore in registro
	- `scala` valore costante 1,2,3,4,8
- Indirizzo `displacement + base + indice * scala`
- si possono anche omettere alcune cose in quanto non necessarie

###### Combinazioni operazioni valide
- Immediato -> Registro
- Immediato -> Memoria
- Registro -> Registro
- Registro -> Memoria
- Memoria -> Registro
Non è possibile Memoria -> memoria
![[Pasted image 20240428133801.png|center|500]]

## Istruzioni
- [[Istruzioni intel]]