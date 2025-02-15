---
date: 2024/04/11
tags: 
Materia: "[[Calcolatori]]"
---

# ripasso
# Procedure
In una procedura bisogna seguire uno standard di chiamata

## Epilogo
In questa fase bisogna salvare i registri non temporanei che andremo ad utilizzare nello stack
questo lo si fa spostando la testa dello stack `sp` del valore di byte che necessitiamo
esempio
```
addi sp, sp, -24 # facciamo spazio a 3 registri 8*3=24
sd x16, 16(sp)
sd x17, 8(sp)
sd x15, 0(sp)
```
In questo modo abbiamo salvato i registri 16 17 15 nello stack e durante la procedura potremmo utilizzare quei registri senza sovrascriverli
Nel caso ci sia un gran numero di parametri andremo ad utilizzare lo stack per il passaggio di parametri
## Esecuzione della procedura
In questa fase non facciamo altro che eseguire la task 
## Prologo
Infine dobbiamo salvare il valore di ritorno in un registro noto e ricaricare nei registri le informazioni che avevamo spostato nello stack
esempio
```
addi sp, sp, 24
ld x16, 16(sp)
ld x17, 8(sp)
ld x15, 0(sp)
```
Infine dobbiamo ritornare all'istruzione successiva a quella da cui è partita la chiamata, per fare questo viene utilizzato il registro `x1` chiamato anche return address
Infatti per chiamare una procedura si effettua un operazione di **jump and link** `jal`
ad esempio `jal x1, 100` effettua un salto di 100 istruzioni e salva in `x1` l'indirizzo della istruzione successiva
In questo modo al termine della nostra procedura possiamo fare una operazione di **jump and link register** `jalr` per  tornare indietro
esempio `jalr x0, 0(x1)` dove `x1` è ancora il return address

# Istruzioni condizionate
## If
L'if in RISCV viene implementato tramite dei salti condizionati
Ad esempio `if(a < b) {L1}else{L2}`
```
blt x5, x6, L1
L2: ....
L1:....
```
## While
`while(a < b){a++}`
```
ciclo:
bget x5, x6, ESCI
addi x5, x5, 1
jal x0, ciclo

ESCI:...
```

## Case switch 
Il case switch in assembly può venire implementato sia come una serie di if else in cascata oppure 
Viene utilizzata una tabella di indirizzi e a seconda del parametro fornito è associato un indirizzo a cui saltare
