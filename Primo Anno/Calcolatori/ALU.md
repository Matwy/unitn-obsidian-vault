---
date: 2024/05/13
tags: 
Materia: "[[Calcolatori]]"
Argomento: "[[Processore]]"
---
## ALU
- Viene usata per:
	- Operazioni di tipo R compreso `slt`
	- Calcolare indirizzi di memoria (`sd` e `ld`)
	- Sottrazione per `beq`
#### Codifica operazioni
- Le operazioni vengono codificate in 4 bit
![[Pasted image 20240513063122.png|center|300]]
- Per questa codifica viene utilizzato una piccola unità di controllo
	- `funz7` e `funz3`
	- `ALUop`
		- `ALUop = 00` somma (per istruzioni di `sd` e `ld`)
		- `ALUop = 01` sottrazione (per `beq`)
		- `ALUop = 10` operazione di tipo R (specificata da `funz7` e `funz3`)
- Tabella istruzioni: [[CalcLect17-CPU.pdf#page=7&selection=2,0,2,19|tabella]]

##### Campi
![[Pasted image 20240513065712.png|center|600]]
#### Segnali di controllo
![[Pasted image 20240513065830.png|center|600]]
