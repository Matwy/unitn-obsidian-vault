---
date: 2024/05/11
tags: 
Materia: "[[Calcolatori]]"
---
## Panoramica generale
1) Prelevo l'istruzione dalla memoria
2) Leggo i valori dei registri operandi
3) Dipendono dall'istruzione ma in generale si dividono in tre classi
#### ALU Unità Logico Aritmetica
- Tutte le operazioni la usano per calcolare indirizzi 
- per i salti condizionati
- per eseguire le istruzioni logico aritmetiche

DataPath:[[CalcLect16-CPU.pdf#page=5&selection=6,13,6,20| DataPath]] 
![[Pasted image 20240511093329.png|center|500]]
- Nei punti dove bisogna decidere tra due sorgenti si utilizzano i **multiplexer**
- Esistono quindi delle ulteriori linee di controllo per far eseguire le operazioni adatte ai vari componenti
#### Controllo
- Una figura più completa
![[Pasted image 20240511093848.png|center|600]]
---
## Realizzazione datapath
- [[Realizzazione datapath]]