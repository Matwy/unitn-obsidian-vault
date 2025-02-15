---
date: 2024-05-12
Materia: "[[Calcolatori]]"
tags: 
Argomento: "[[Processore]]"
---
## Realizzazione datapath
- **Memoria** **Istruzioni** dove sono memorizzate le istruzioni
- **PC** **Program** **Counter** contiene l'indirizzo dell'istruzione da caricare
- **Addizionatore** incrementa il PC per passare all'istruzione successiva

![[Pasted image 20240511105234.png|center|500]]

#### Istruzioni di tipo R
- Operazioni logico aritmetiche che operano tra registri e salvano nei registri
	- `add x5, x6, x7`
![[Pasted image 20240511105435.png|center|350]]

Per svolgere operazioni di questo tipo bisogna aggiungere al **datapath** i **Registri** e la **ALU**
![[Pasted image 20240511110019.png|center|600]]

---
#### Load e store
- `ld x5, offset(x6)`
![[Pasted image 20240511110216.png|center|350]]

-  l'offset che è salvato a 12 bit andrà esteso a 64 bit per calcolare l'indirizzo corretto con la ALU
- aggiungiamo quindi la **memoria** **dati** e l'unità di **estensione** **del** **segno**
![[Pasted image 20240511111235.png|center|500]]
#### Salto condizionato
- ![[Pasted image 20240511111549.png|center|400]]
-  **ALU** svolge l'operazione di confronto tra `x5` e `x6` e setta il bit `Zero`
-  La somma del program counter con l'offset viene eseguita dal sommatore apposito non dalla **ALU**
- L'offset viene **esteso** a 32 bit permette di fare salti da $-2^{12}$ a $2^{12}$
	- Viene inoltre shiftato di 1 bit a sinistra per permettere di codificare lo spiazzamento di mezze parole
- ![[Pasted image 20240511112846.png|center|550]]

### Esempio
[[CalcLect17-CPU.pdf#page=2&selection=0,7,0,7|Esempio istruzioni e flag]]