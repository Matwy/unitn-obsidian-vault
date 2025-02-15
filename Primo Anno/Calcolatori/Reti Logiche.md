---
date: 2024/03/19
tags: 
Materia: "[[Calcolatori]]"
---
$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
## Reti logiche
Le reti logiche sono dei circuiti che trasformano alcuni valori logici in **ingresso** in altri valori in **uscita**
Possiamo distinguere reti logiche di due tipi:
- **Combinatorie**
	-  Relazione funzionale tra ingresso e uscita
	- Non hanno memoria
	- L'uscita dipende solo dal valore dell'ingresso
- **Sequenziali**
	- L'uscita dipende anche dagli ingressi passati oltre che quelli attuali
	- Hanno una memoria (detta anche **stato** della rete)

Un modo compatto per descrivere funzioni logiche è tramite l'[**Algebra** **di** **Boole**](obsidian://open?vault=unitn&file=Algebra%20di%20boole)

### Costo di una rete logica
Le funzioni logiche possono essere implementate in modi più o meno efficienti.
Per **COSTO** di una rete logica si intende la somma di ingressi e del numero di porte della rete.

## Reti sequenziali
Le reti sequenziale fanno uso di una **memoria** per ricordare gli ingressi passati.
La **memoria** in una rete logica si ottiene con una **reazione** ovvero si ridireziona l'uscita di alcune porte in ingresso verso altre porte del **medesimo** **stadio**. 

### R-S Latch
Un circuito **R-S Latch** è un esempio di rete sequenziale:
![[Pasted image 20240319143045.png|center|600]]
In questo circuito riusciamo possiamo settare due diversi stati 
- tramite l'operazione di **reset** quindi 
	- $R=1$ e $S=0$ otterremmo che $Q+ = 0$ e $Q- = 1$
- tramite l'operazione di **set** otterremo lo stato opposto, quindi:
	- $R=0$ e $S=1$ otterremmo che $Q+ = 1$ e $Q- = 0$
- mentre se in ingresso sia $R$ che $S$ vengono settati a $0$ allora il circuito manterrà lo stato precedente $Q+ = Q+$ e $Q- = Q-$ 

| R   | S   | Q-  | Q+  |
| --- | --- | --- | --- |
| 0   | 0   | Q   | Q   |
| 0   | 1   | 0   | 1   |
| 1   | 0   | 1   | 0   |
| 1   | 1   | -   | -   |
#### Stati indecidibili
In questo caso con 1 e 1 in ingresso l'uscita non è mappata e non è prevedibile. Uno stato di questo tipo si chiama stato **indecidibile**.
#### Clock
Per evitare questa situazione gli elementi in memoria vengono governati da un segnale chiamato **clock**. Si dice quindi che l'elemento di memoria è **temporizzato**.
Un elemento di memoria **temporizzato** viene indicato come **gated latch**.

### Gated Latch
La differenza da un Latch non temporizzato è quella di avere un segnale di abilitazione chiamato **clock** questo segnale viene aggiunto tra delle porte **AND** (vedi [[Algebra di Boole#AND]]).
![[Pasted image 20240319150036.png|center|400]]

- Nel caso il **clock** sia a zero la rete non può cambiare stato.
- Nel caso il **clock** sia ad uno $R$ ed $S$ sono gli ingressi del circuito

Abbiamo ancora il problema di avere degli stati **indecidibili**: per risolvere questo problema:
- **Latch-D**
- **flip-flop**

### Latch-D
Un **Latch-D** ha un unico ingresso chiamato $D$ e questo verrà portato alla $S$ normalmente e alla $R$ negandolo.
In questo modo il circuito non avrà mai $R=S=1$ 
![[Pasted image 20240319150950.png|center]]

### Flip-flop Master-Slave
E' composto da due **Latch-D** in cascata.
In questo circuito il **clock** comanda il **master** e il **clock negato** comanda lo **slave**.
![[Pasted image 20240319151500.png|center]]
In questo circuito le transizioni avvengono precisamente alla fine degli **instanti di clock**.

### Registri
Un **registro** è composto da una collezione di **Latch-D** o **flip-flop**.
Sono sensibili agli input sono sul fronte di **salita** del clock.
![[Pasted image 20240319152022.png|center|200]]
#### Operazioni sui registri
![[Pasted image 20240319152122.png|center|400]]
Questa immagine spiega che l'input $y$ viene memorizzato solo con il **segnale di clock** in **salita**.

### Edge triggered
Questi si chiamano sistemi di **edge** **triggered**. E permettono di creare sistemi senza stati di **indicibilità**.
- L'**output** dipende dallo stato presente nel sistema e dall'**input**
