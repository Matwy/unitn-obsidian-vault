---
date: 2024/05/22
tags: 
Materia: "[[Calcolatori]]"
Argomento: "[[Input Output]]"
---
## Interrupt
- Una **interruzione** **I/O** è un segnale che notifica il processore che la periferica è pronta ad eseguire il trasferimento richiesto
	- Gli interrupt possono avere diversi **gradi** **di** **urgenze**
	- Serve un modo per capire quale periferica a fatto l'interrupt

#### Asincroni
- Gli interrupt sono sempre **asincroni** rispetto all'esecuzione delle istruzioni
	- Avvengono durante una qualsiasi istruzione
	- A volte ci possono essere delle istruzioni non interrompibili nel kernel
	- Il programmatore può quindi rimandare l'interruzione in un momento più conveniente

#### Svantaggio
- Occorre un hardware speciale per
	- permettere ai dispositivi I/O di generare interrupt
	- Rilevare l'interrupt salvare lo stato del processore per eseguire la **Interrupt Service Routine (ISR)** e poi riprendere 