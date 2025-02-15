---
date: 2024/04/09
tags:
  - assembly
  - RISCV
Materia: "[[Calcolatori]]"
---

# Operazioni logiche per [[RISC V]]

### Shift Logico a sinistra
- Shift logico a **sinistra** inserisce gli **zeri** a destra (nei bit meno significativi)
```
slli x11, x19, 4
```
- se `x11` ha il valore 9 è come fare $9*2^{4} = 144$
- funziona fino a quando non si sforano i numeri rappresentabili
### Shift logico a destra
- Inserisce **zeri** a **sinistra**
```
srli x11, x19, 4
```
- Corrisponde a dividere per $2^{4}$
- in caso di numero negativo però si rompe il completamento a due
### Shift aritmetico a destra
- Uguale allo shift logico ma al posto degli zeri si inseriscono i bit **uguali** al **bit** **di** **segno**
```
srai x11, x19, 4
```

### AND bit a bit
```
and x9, x10, x11
```

### OR bit a bit
```
or x9, x10, x11
```

### Rotazione a sinistra
 - Vogliamo ruotare a sinistra i 4 bit più significativi di `x9`
1) `srli x10, x9, 60` i 4 bit più significativi li mettiamo nei meno significativi sul registro `x10`
2) `slli x9, x9, 4` spostando a sinistra andiamo a rimuovere i 4 bit più significativi di `x9`
3) `srli x9, x9, 4` rispostiamo a destra in modo da riavere i bit nella posizione iniziale
4) `or x9, x9, x10` effettuiamo l'or in modo da unire i due registi

### OR esclusivo (XOR)
- **1** se i due bit sono diversi
- **0** altrimenti

### NOT
- il **not** avendo un solo operando non esiste in **RISCV** il quale ha tutte operazioni con 3 operandi 
- Quindi l'unico modo è $NOT(A) = XOR(A, 1)$
##### Esempio
- **NOT** di `x9`, in `x10` ci sono tutti i bit a $1$
```
xor x9, x9, x10
```
