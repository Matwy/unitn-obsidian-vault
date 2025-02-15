---
date: 2024/03/24
tags:
  - "#assembly"
  - RISCV
Materia: "[[Calcolatori]]"
---
## Istruzioni aritmetiche
**RISC V** supporta le operazioni aritmetiche
Un modo per immaginare le istruzioni aritmetiche è in questo modo 
$$
a = b + c
$$
Infatti **RISC**-**V** supporta solamente **istruzioni** **aritmetiche** a **tre** operandi.
```
add a, b, c
```

##### Istruzioni più complesse
Le istruzioni più complesse si ottengono dalla combinazione di quelle semplici ad esempio
$$
a = b + c  + d + e
$$
diventa 
```
add a, b, c
add a, a, d
add a, a, e
```

### Alcune considerazioni
- I commenti possono essere inseriti dopo il cancelletto 
```
add a, b, c # commento in assembly
```

- L'operando destinatario è sempre il primo

Questo standard non è seguito da tutti gli assemblatori 
Ad esempio **gcc** usa `/` e `/**/` per commentare
e il destinatario dell'operazione è infondo

### Operandi
Gli operandi non sono normali variabili ma sono dei **registri**. Una memoria molto limitata ma velocissima accessibile in un solo ciclo di clock

## Registri del RISC-V
Nel RISC-V ci sono **32 registri a 64 bit.**
Avere solo 32 registri permette esecuzioni più veloci.

Un esempio di accesso a registri
```
add x5, x20, x21 # x5 x20 e x21 sono i registri a cui stiamo accedendo
```
### Accesso alla memoria
Ovviamente nella maggior parte dei casi 32 registri non ci bastano infatti dobbiamo poter accedere alla memoria tramite delle **istruzioni di trasferimento**:
- **load** carica dati dalla memoria
- **store** salva dati nella memoria
## La memoria 
La **memoria** è una sequenza di bit organizzati in gruppi da 8, chiamati **byte**
- Ogni **byte** è associato ad un indirizzo lineare progressivo con il quale possiamo accedere alle sue informazioni
### Word e double word
La maggior parte delle architetture permettono l'accesso anche a 4 o 8 byte in una istruzione.
- 4 byte vengono chiamati **word**
- 8 byte vengono chiamati **double word**
Per caricare una word o una double word bisogna specificarne l'**indirizzo** (registro e offset):
#### Esempio
Esempio di una parola doppia contenuta in un certo indirizzo di memoria
```
ld x9, 8(x22)
```
- `ld` stiamo caricando una doppia parola
- `x9` registro in cui la vogliamo caricare
- `8` offset
- `x22` è la base (indirizzo da cui preleviamo)

#### Esempio
Vogliamo effettuare l'istruzione `A[12] = h + A[8]`
In assembly RISC-V:
```
ld x9, 64(x22) 
# A ha il puntatore in x22
# L'ottava double word è in x22 + 8*8

add x9, x21, x9 # h è in x21
sd x9, 96(x22) # memorizzo x9 in A[12]

# A[12] è dato da x22 + 12*8
```

### Register Spilling
I programmi contengono variabili e  il compilatore si occupa quindi di effettuare il **load** delle informazioni necessarie e l'**unload** di quelle non necessarie.

### Operandi immediati o costanti
Per salvare un valore costante vediamo un esempio:
`f = f + 4` vogliamo che il `4` sia una costante
```
ld x9, IndCost4(x3) 
# la costante 4 è nell'indirizzo x3 + IndCost4
add x22, x22, x9
```

Questa soluzione è poco efficiente infatti esistono operazioni che permettono l'uso di costanti:
```
addi x22, x22, 4
```

La **costante** **zero** `0` viene  spesso usata e **RISC**-**V** dedica un registro per quest'ultima, il registro `x0`.

### Little Endian e Big Endian
Sono due notazioni diverse per salvare i bit più **significativi**.
Nelle immagini il numero esadecimale è `EA01BD1C`
- **Little** **Endian** il bit più significativo va salvato nel indirizzo più alto. 
![[Pasted image 20240324105303.png|center| 150]] 
- **Big** **Endian** il bit più significativo va salvato nel indirizzo più basso
![[Pasted image 20240324105358.png|center|150]]
## Rappresentazione delle istruzioni
Le istruzioni assembly prima di essere eseguite devono essere convertite in codice macchina. In RISC-V ogni istruzione viene codificata in 32 bit.
Vediamo un esempio:
Data l'istruzione `add x9, x20, x21`
In codice macchina `00000000|10101|10100|000|01001|0110011`
- istruzione
- secondo operando
- primo operando
- Risultato
I registri in RISC-V sono numerati da 0 a 31 e possono essere scritti in 5 bit
### Campi delle istruzioni RISC-V
Diamo dei nomi ai vari campi:
- `funz7|rs2|rs1|funz3|rd|codop`
	- `codop` codice operativo dell'istruzione
	- `funz7` e `funz3` codici operativi aggiuntivi
	- `rs1` primo operando sorgente
	- `rs2` secondo operando sorgente
	- `rd` operando destinazione
### Trade off
Salvando tutto in **32 bit** abbiamo
- un limite al numero di istruzioni
- un limite al numero di registri
- un limite alle modalità di indirizzamento
Ma guadagniamo in efficienza

Che corrisponde a sommare `1` a `x5`

## Operazioni logiche
[[Operazioni logiche]]
## Istruzioni condizionate
[[Istruzioni Condizionate]]
## Procedure e convenzioni chiamata
- [[Procedure]]
## Esempi
- Esempi Folli: [[esempiRiscV.pdf]]