---
date: 2024/05/01
tags:
  - ARM
  - assembly
Materia: "[[Calcolatori]]"
---
## Info generali
##### Operandi
- Operandi **sinistro** e **destro**
	- **sinistro** registro
	- **destro** immediato o registro
	- no memoria
##### Memoria
- Per accedere alla memoria `load` e `store`
	- Load Register `ldr`
	- Store Register `str`
	- Load multiple `ldm`
	- Store multiple `stm`

###### Modalità di indirizzamento
- [[Modalità di indirizzamento]]


## Istruzioni ARM
- Sono prevalentemente a **tre** argomenti
#### add
- `add r0, r1, r2`    r0 = r1+r2
- `adc r0, r1, r2`    r0 = r1+r2+c    (c carry bit di CPSR)

#### sub
- `sub r0, r1, r2`    r0 = r1-r2
- `sbc r0, r1, r2`    r0 = r1-r2+c-1    (c carry bit di CPSR)


#### reverse sub
- `rsb r0, r1, r2`    r0 = r2-r1
- `rsc r0, r1, r2`    r0 = r2-r1+c-1    (c carry bit di CPSR)

#### Boolean
- `and r0, r1,  r2`
- `orr r0, r1,  r2`
- `eor r0, r1,  r2`    **xor**
- `bic r0, r1, r2` **bit** **clear** per ogni bit di r2 a 1 in r1 viene messo a 0

#### Moltiplicazione
- `mul r0, r1, r2`
- `mla r0, r1, r2, r3`  `r0 = r1*r2+r3`

#### shift al terzo operando
- `add r0, r1, r2, lsl r4`  `r0=r1+r2<<4`  

#### Movimento registri
- `mov r0, r1`
- `mvn r0, r1`    r0 = not r1

#### branch
- `bl` branch and link salva nel `lr` link register (`r14`) l'indirizzo dell'istruzione successiva e chiama la label indicata

#### compare
- `cmp` setta i flag senza cambiare i registri
- ma alla fine delle istruzioni aggiungendo `eq` possiamo renderle condizionali esempio `addeq`
#### test
- `tst r0, r1`   set cc a r0 and r1
- `teq r0, r1`   set cc a r0 xor r1
- `cmn r0, r1`   set cc a r0 + r1

#### load e store
- `ldr r0 [r1]`
- `str r0 [r1]`
	- `ldr` 32 bit
	- `ldrh` 16 bit
	- `ldrb` 8 bit

#### load e store multiple
- `ldm r0, {r1, r2, r3}`
	- `r1 = mem[r0]`
	- `r2 = mem[r0+4]`
	- `r3 = mem[r0+8]`

- `stm r0, {r1, r2, r3}`
	- `mem[r0] = r1`
	- `mem[r0+4] = r2`
	- `mem[r0+8] = r3`

##### modalità
- `ia` increment after r, r+4
- `ib` increment before r+4, r+8
- `da` decrement after r, r-4
- `db` decrement before r-4, r-8
- esistono anche altri nomi come `ea, ed, fa ,fd`
##### Writeback
-  si usa `[!]` per aggiornare il registro base