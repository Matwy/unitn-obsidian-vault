---
date: 2024/05/13
tags: 
Materia: "[[Calcolatori]]"
Argomento: "[[Processore]]"
---
## Pipeline
- Usata per non usare come ciclo di clock la durata del ciclo più lungo
![[Pasted image 20240513101022.png|center|600]]

#### Calcolo del throughput
$$
\text{tempo tra due istruzioni con pipeline} = \frac{\text{tempo tra due istruzioni senza pipeline}}{\text{Numero stadi della pipeline}}
$$

---
## Vantaggi RISCV per la pipeline
- Tutte  le istruzioni hanno la stessa lunghezza. Facilità il prelievo (sempre una word)
- I codici degli operandi sono in una posizione fissa. Questo permette di leggere il codice in parallelo con la decodifica
- Gli operandi residenti in memoria sono possibili solo per load e store. Questo permette di calcolare l'indirizzo con la ALU. (con due indirizzi da calcolare servono due cicli di clock)
- L'uso di accessi allineati permette di eseguire operazioni in memoria in un solo ciclo di clock (occupando quindi un solo stadio della pipeline)

---
## Hazard
- Solitamente la pipeline permette di eseguire un'istruzione per ciclo di clock. Ma a volte non è possibile per il verificarsi di **hazard**
#### Hazard strutturale
- Un **Hazard** **strutturale** e la condizione in cui l'**architettura** non permette l'esecuzione di alcune sequenze di istruzioni in pipeline
	- **Esempio** con un'unica memoria non si potrebbe nello stesso ciclo caricare istruzione e memorizzare o prelevare operandi in memoria
---
#### Hazard sui dati
- Un **hazard** **sui** **dati** si verifica quando la pipeline deve essere messa in stallo per aspettare delle informazioni degli stati precedenti
	- **Esempio** `add x1, x2, x3` `sub x4, x1, x5`
	- Il problema è che `x1` è l'operando di destinazione ma viene usato nell'istruzione successiva bisogna quindi aspettare
- Per risolvere questo problema si agisce a livello del compilatore il quale riordina le istruzioni per evitare queste situazioni. Anche se non sempre è possibile.
##### Operand forwarding
- Può risolvere un **hazard** **sui** **dati** ma funziona solo se lo stadio a cui il dato viene propagato è successivo nel tempo alla stadio dal quale viene prelevato.
---
#### Hazard sul controllo
- Questo **hazard** si verifica nei salti condizionati. Non possiamo sapere quale sarà la prossima istruzione fin tanto che la ALU non verifica se bisogna saltare o meno.

- In questi casi si cerca di prevedere se il salto viene effettuato o meno
	- spesso si assume che il salto non viene fatto e in caso si corregge (**branch untaken**)
	- esistono anche circuiterie che permettono di memorizzare l'esit del branch precedente e assumere che il comportamento rimanga coerente
---
![[Pasted image 20240513114811.png|center|700]]