---
date: 2024/04/28
tags:
  - assembly
  - intel
Materia: "[[Calcolatori]]"
---
Slide: [[CalcLect11-Intel.pdf]]
## Istruzioni intel
Le istruzioni  sono troppe per vederle tutte
- In generale sintassi: `<opcode> <source>, <destination>`
	- il carattere finale dell'opcode indica la dimensione degli operandi
		- `b` 8 bit
		- `w` 16 bit
		- `l` 32 bit
		- `q` 64 bit
	- nomi registri `%`
	- costanti `$`
	- indirizzi diretti numero senza dollaro davanti `420`
#### istruzione `mov`
oltre ai caratteri finali che abbiamo visto prima ci può essere
- `movsx` estensione del segno
- `movzx` estensione dello zero
#### istruzioni varie
- `adc` add with carry
- `sbc` sub with carry
- `mul/imul` signed/unsigned
- `div/idiv` signed/unsigned
- `inc/dec` incrementa/decrementa di uno
- `rcl, rcr, rol, ror` operazioni di rotazione c=carry
- `sal, sar, shl, shr` operazioni di shift a=aritmetico
- `and/or/xor/not` booleane bit a bit

- Tutte queste modificano i **flag**

- `neg` complemento a due

## Operare nello stack
- `push` inserisce dati sullo stack
	- sintassi `pushq %reg`
		- decrementa `rsp` di 8
		- scrive `%req` nella memoria indicata da `%rsp`
- `pop` rimuove i dati dallo stack
	- sintassi `popq %reg`
		- legge e scrive in  `%req` il dato indicato da `%rsp`
		- incrementa `rsp` di 8
---
## Operazioni di comparazione
- `cmp ar1, arg2`
	- effettua arg1 - arg2 settando i flag ma senza memorizzare il risultato
	
- `test ar1, arg2`
	- effettua arg1 and arg2 settando i flag ma senza memorizzare il risultato
	- spesso usato per vedere se un registro contiene zero o un numero negativo facendo ad esempio `test %eax, %eax`

- Queste operazioni vengono usate prima di effettuare operazioni di salto
## Istruzioni di salto
- `jmp` salto incondizionato
- `je/jnz/jc.jnc` salti condizionati
	- In generale `j<condition>`

![[Pasted image 20240428172835.png]]

## Istruzione di chiamata 
- `call` chiamata a procedura
	- Esempio `call label`
	- Fa un push sullo stack dell'indirizzo della prossima istruzione 
	- Modifica il program counter per andare all''inizio della procedura desiderata

- `ret` ritorno da procedura
	-  Esempio `ret`
	- Fa pop dallo stack dell'indirizzo di ritorno e lo memorizza in `%rip`

## Load Effective Address
- `lea`
- sintassi `lea src, dest`
	- Nata per calcolare indirizzi
	- Esempio `lea 80(%rdx, %rcx, 2), %rax -> %rax = %rdx + 2*%rcx +80`
- Questa operazione ci permette di fare una somma tra due registri con un terzo registro di destinazione
	- `lea (%rbx, %rcx), %rax`
	