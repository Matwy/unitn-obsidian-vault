---
date: 2024/04/09
tags:
  - assembly
  - RISCV
Materia: "[[Calcolatori]]"
---
## Confronti
#### Equal
```
beq rs1, rs2, L1
```
- Se `rs1 == rs2` salta a `L1`
#### Not Equal

```
bne rs1, rs2, L1
```
- Se `rs1 != rs2` salta a `L1`
#### Less than
```
blt rs1, rs2, L1
```
- Se `rs1 < rs2` salta a `L1`
#### Greater equal than
```
bge rs1, rs2, L1
```
- Se `rs1 >= rs2` salta a `L1`
#### Less than unsigned
```
bltu rs1, rs2, L1
```
- Se `rs1 < rs2` senza segno salta a `L1`
#### Greater than unsigned
```
bgeu rs1, rs2, L1
```
- Se `rs1 >= rs2` senza segno salta a `L1`

## If in assembly
- Traduciamo `if (i == j) f = g + h; else f = g – h;`
```
bne x22, x23, ELSE #  i != j vai ad ELSE
add x19, x20, x21 # f = g + h
beq x0, x0, ESCI # 0 == 0 vai ad esci

ELSE: sub x19, x20, x21 # f = g-h
ESCI: ...
```

## Cicli
- traduciamo `while (salva[i] == k ) { i += 1 }`
```
x25 indirizzo di salva
x22 indirizzxo di i
x24 indirizzo di k

Ciclo: 
	slli x10, x22, 3 # x10 = 2^3*i
	add x10, x10, x25
	ld x9, 0(x10) # load di salva[i]

	bne x9, x24, Esci
	beq x0, x0, Ciclo

Esci: ...
```

## Case switch
- [[CalcLect8-RISC-V Logiche.pdf#page=32&selection=0,0,1,6|CalcLect8-RISC-V Logiche, page 32]]
