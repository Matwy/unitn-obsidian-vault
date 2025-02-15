---
date: 2024-03-13
Materia: "[[Calcolatori]]"
tags:
  - "#binario"
---
# Codifica numeri interi

- $k$ bit $\to$ codificano $2^k$ valori
- per rappresentare valori negativi:
	- modulo e segno
	- complemento a 1
	- complemento a 2


### Modulo e segno
Si usa un bit in più per rappresentare il segno
- 0 positivo
- 1 negativo
e poi scriviamo quindi il modulo del numero
In questo modo però abbiamo due modi di rappresentare lo zero
$$+0 \quad -0$$
## Complemento a 1
- **positivi**: valore assoluto
- **negativi**: vengono rappresentati con il complemento a 1
Per svolgere il complemento a 1
- vengono invertiti tutti i bit $0\to 1$ e $1 \to 0$
- oppure si possono calcolare $(2^{k}- 1)_{2} - x = 1\dotsc 1 - x$

**OSS** Anche con questo metodo dobbiamo tenere in considerazione il segno con un bit aggiuntivo. Quindi ci sono ancora due modi di rappresentare lo zero.

### Somme e sottrazioni in complemento a 1
La somma e la sottrazione non sono semplificate
- Il riporto sul bit più significativo va sommato al risultato.
	- In questa ultima somma se i riporti delle due cifre più significative sono diversi allora il risultato **non è attendibile** non è quindi possibile rappresentare il risultato su $k$ bit
## Complemento a 2
### Calcolo
#### Metodo 1
1) Faccio il complemento a uno del numero
2) Sommo 1
#### Metodo 2
1) Calcolo $(2^{k})_{2}- x = 1\overbrace{0\dots0}^{k} - x$
	Dove $x$ è il numero che vogliamo rappresentare e $k$ è il numero di bit su cui lo rappresentiamo

### Codifica
- numeri positivi: valore assoluto con bit più significativo a 0
- numeri negativi: **complemento** **a** **due** del valore assoluto con bit più significativo a 1
