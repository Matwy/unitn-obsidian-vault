---
date: 2024/06/06
tags: 
Materia: "[[Programmazione funzionale]]"
---
## 3 Memory management

#### Static allocation
- fatta dal compilatore ancora prima dell'esecuzione
- Un oggetto ha un indirizzo assoluto nella zona della memoria statica

#### Dynamic allocation Stack
Sai come funzia dai

#### Heap
- Regione di memoria che può essere allocata e deallocata quando si vuole
##### Modi per gestirlo
- **Blocchi a dimensione fissa**
	- Ogni volta che salviamo oggetti sullo stack allochiamo sempre blocchi della stessa dimensione
	- **Internal** **Fragmentation**
- **Blocchi a dimensione variabile**
	- A seconda della dimensione di quello che dobbiamo salvare nello stack creiamo un blocco della dimensione adatta
	- **External Fragmentation**

###### Fragmentation
- **Internal**
![[Pasted image 20240606095350.png|center|350]]
- **External**
![[Pasted image 20240606095420.png|center|400]]

