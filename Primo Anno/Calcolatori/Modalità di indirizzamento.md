---
date: 2024/05/02
tags:
  - ARM
  - assembly
Materia: "[[Calcolatori]]"
---
## Modalità di indirizzamento

#### Pre Indexed
- prima di eseguire l'operazione
	- `[rb, #i] [!]`
		- `rb` è l'indirizzo base 
		- `#i` è una costante
		- `[!]` significa che aggiorniamo l'indirizzo base
	- `[rb, { + | - }ro, shift][!]`
		- `rb` è l'indirizzo base 
		- `{+}` è il segno dell'indice
		- `ro` è il registro che contiene l'indice
		- `shift` si può specificare un'eventuale shift o rotazione
		- `[!]` significa che aggiorniamo l'indirizzo base
		
#### Post Indexed 
- il registro viene aggiornato dopo l'operazione
	- `[rb], #i`
	- `[rb], {+}ro, shift`

#### Alcuni esempi
- Accesso tramite registro
	- `ldr r0, [r1]`
	- corrisponde a `r0 = mem[r1]`
	
- Accesso tramite registro e offset immediato
	- `ldr r0, [r1, #4]` 
	- corrisponde a `r0 = mem[r1+4]`
	
- Accesso tramite registro e offset da registro
	- `ldr r0, [r1, r2]` 
	- corrisponde a `r0 = mem[r1+r2]`
	
- Accesso tramite registro e offset scalato
	- `ldr r0, [r1, +r2, lsl 8]` 
	- corrisponde a `r0 = mem[r1 + (+r2 << 8) ]`
	- al posto del + possiamo mettere il - se vogliamo decrementare l'indirizzo

#### Writeback
##### Pre indexed senza writeback
- `ldr r0, [r1, $4]`
##### Pre indexed con writeback
- `ldr r0, [r1, $4]!`
##### Post indexed con writeback
- `ldr r0, [r1], $4`
