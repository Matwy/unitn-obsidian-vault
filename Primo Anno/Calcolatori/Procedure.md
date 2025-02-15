---
date: 2024/03/25
tags:
  - "#assembly"
  - RISCV
Materia: "[[Calcolatori]]"
---
$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
## Procedure
Una **procedura** è una serie di operazioni che portano a termine una determinata task.
E' importante definire il **protocollo** di una procedura.

## Protocollo
1) I **parametri** di input vanno inseriti in posti noti
2) Trasferire il controllo alla procedura
	1) Acquisire le risorse necessarie 
	2) Eseguire il compito
	3) Inserire i valori di ritorno in posti noti
	4) Restituire il controllo al chiamante
3) Prendere il valore di ritorno della procedura e pulire i registri
Il modo in cui questo protocollo viene messo in pratica dipende dall'architettura.

### Protocollo di chiamata in **RISC**-**V**
Convenzioni:
- `x10 - x17` Sono usati per i parametri di ingresso e per i valori di ritorno
- `x1` Indirizzo per tornare al chiamante chiamato anche **ra** (return address)

#### Indirizzo x1 ra
Spesso vengono usate `jal` e `jalr`. Che sono operazioni che effettuano il salto e memorizzano in `x1` il punto di ritorno.
Esempio:
`jal x1, 100` Scrive in `x1` l'indirizzo della prossima istruzione e poi "salta" a 100, cioè dove dovrebbe essere la procedura
	Alla fine della procedura si dovrà saltare all'indirizzo dell'istruzione che è stato salvato in `x1`
### Stack
Nel caso i **registri** non bastino perchè una procedura ha bisogno di molti **parametri**. Bisogna appoggiarsi ad uno **stack** (struttura dati di tipo **LIFO**).

## Esempio di scrittura di una procedura
Vogliamo scrivere:
```
long long int esempio_foglia(
long long int g,
long long int h,
long long int i,
long long int j) {
	long long int f; 
	f = (g+h) – (i+j); return f;
}
```

### Prologo
- Prima di scrivere una **procedura** il compilatore sceglie un'ettichetta associata all'indirizzo di entrata della procedura. (`esempio_foglia`)

- Poi vengono salvati in memoria tutti i **registri** che la procedura andrà ad usare. In questo modo potranno essere **ripristinati**.

Abbiamo quindi un registro `sp` che punta alla testa dello **stack**. 
Per salvare dei registri dobbiamo quindi spostare la testa dello stack e poi inserire i dati che vogliamo salvare.
##### Esempio di salvataggio di tre registri x5 x6 x20
```
addi sp, sp, -24 # sposto la testa
sd x5, 16(sp) # store di una double word
sd x6, 8(sp)
sd x20, 0(sp)
```
### Esecuzione della procedura
Eseguo la procedura.
```
add x5, x10, x11 
add x6, x12, x13 
sub x20, x5, x6
```
### Epilogo
Salvo il valore di **ritorno** e ripristino i registri precedenti.
```
addi x10, x20, 0  # salvataggio del valore di ritorno
ld x20, 0(sp)  # ripristino i registri
ld x6, 8(sp)
ld x5, 16(sp)
addi sp, sp, 24 # riporto la testa dello stack a 24 
jalr x0, 0(x1) # salto a x1 (dove è salvato l'indirizzo della istruzione da eseguire dopo la chiamata alla procedura)
```

### Stack durante la procedura
![[Pasted image 20240325142118.png|center|600]]

## Convenzioni RISC-V
- `x5 - x7 e x28 - x31` sono registri temporanei che in caso di procedura non vengono salvati
- `x8-x9 e x18 - 27` registri che invece vengono salvati in caso di chiamata ad una procedura.

## Procedure ricorsive
Proviamo a creare una procedura **ricorsiva**
Esempio:
```
long long int fact(long long int n) {
	if (n < 1)
		return 1;
	else
		return n*fact(n-1);
}
```

- Se proviamo a implementare la procedura come stavamo facendo prima andremmo a **sovrascrivere** il **return** **address** `x1` e il paramento `n`.
	- Per evitare questo problema salviamo nello stack questi valori

#### Salviamo nello stack `x1` e `x10`
Come prima:
```
fact: 
addi sp, sp, -16    # Allochiamo spazio per due elementi 
sd x1, 8(sp)              # Salviamo x1 
sd x10, 0(sp)             # Salviamo x10
```
#### Continuo procedura se  `n >= 1`

```
addi x5, x10, -1    # Calcoliamo x5 = n-1 
bge x5, x0, L1      # Se n-1 >= 0, saltiamo a L1
```
Se `n >= 1` decrementiamo `n` e richiamiamo la procedura
```
L1: 
	addi x10, x10, -1 # Decrementiamo n (arg. diventa: n-1) 
	jal x1, fact # Chiamiamo fact(n-1)
```
#### Chiudo la procedura se `n < 1`
```
addi x10, x0, 1     # Metodo del RISC-V per caricare 1 in x10
addi sp, sp, 16     # Ripuliamo lo stack
jalr x0, 0(x1)      # Ritorniamo al programma chiamante
```

#### Ripristino `x10` e `x1`
```
addi x6, x10, 0 # Carichiamo risultato di fact(n-1) in x6
ld x10, 0(sp) # Ripristino dell’argomento n, x10 
ld x1, 8(sp) # Ripristino del reg. di ritorno, x1 
addi sp, sp, 16 # Ripuliamo lo stack
```

#### Calcolo e ritorno
```
mul x10, x10, x6 # Restituiamo n*fact(n-1)
jalr x0, 0(x1) # Ritorniamo al programma chiamante
```

## Memoria stack e altro
In C ci sono due tipi di storage class
- **Automatic** le variabili una volta usciti dalla funzione dove sono state create vengono rimosse dallo stack
- **Static** sono variabili globali che non vengono rimosse alla fine della procedura
#### Global pointer
In RISC-V le variabili static vengono salvate all'interno del **global** **pointer** `gp`

### Record di attivazione
Il segmento di stack relativo alle informazioni salvate da una procedura viene chiamato **record** **di** **attivazione**.

#### Frame pointer `fp`
Oltre allo **stack** **pointer** `sp` esiste il **frame** **pointer** il quale punta alla prima double word entrata nello stack
	- questo ci permette di accedere a delle area di memoria durante la procedura in modo più semplice rispetto allo stack pointer.
![[Pasted image 20240326172256.png|center|500]]
### Dati dinamici
Oltre alle variabili locali e globali, esistono **variabili** **dinamiche** (salvate nell'heap).
L'**heap** viene inizializzato e gestito a **runtime**.
- RISC-V adotta il seguente schema di memoria
![[Pasted image 20240326182406.png|center|600]]

### Tabella convenzioni registri RISC-V
![[Pasted image 20240326183017.png|center]]
