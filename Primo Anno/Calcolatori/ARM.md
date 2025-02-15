---
date: 2024/05/01
tags:
  - assembly
  - ARM
Materia: "[[Calcolatori]]"
---
## ARM
- Architettura **RISC** **pragmatica**
## Registri
- registri general purpose decisi dall'ABI
- Ha **16** **registri** a **32** **bit**
- da `r0` a `r15`
- **stack** **pointer** `r13==sp`
- **link** **register** `r14==lr`
- **flags register** 
	- Application Program Status Register `apsr`
	- Current Program Status Register `cpsr`
- `r15` contiene il **program** **counter** `pc` e i flags dal 31 e e 28 bit
	- `apsr` per esecuzione condizionale
#### Flags
[[CalcLect12-ARM.pdf#page=6&selection=0,0,0,13|Flag e operazioni]]
- `V` overflow 0
- `Z` numeri uguali 1
- `C` carry
- `N` negativo 1

## Convenzioni di chiamata
- Sono definite dall' **ABI**
In generale:
- primi quattro argomenti
	- `r0` e `r1` valori di ritorno
	- `r0 -> r3` 
	- altri argomenti sullo stack
- registri preservati `r4 -> r11` a volte `r9` non è salvato
- I registri utilizzabili sono quindi `r0->r3 e r12` e a volte `r9`

## Istruzioni
- [[Istruzioni ARM]]
