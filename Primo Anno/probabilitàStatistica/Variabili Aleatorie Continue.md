---
date: 2024/04/30
tags:
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie Continue]]"
---
## Variabili aleatorie Continue
**Def** $X$ v.a è **continua** se $F_{X}$ è **continua**

#### Assolutamente continue
**Def** $X$ v.a è **assolutamente** **continua** se esiste una funzione
$f_{x}:\mathbb{R}\to \mathbb{R}$ detta **densità** (**Pdf**) di $X$ tale che 
$$
F_{X}(x)=\int_{-\infty}^{x}f_{x}(y)dy
$$
$\mathcal{R}_{X}=\{y \in \mathbb{R}| f_{X}(Y) \neq 0\}$

**OSS** lavoreremo con v.a assolutamente continue ma le chiamiamo continue

**Teorema**
1) $\int_{-\infty}^{-\infty}f_{x}(y)dy=1$
2) $\int_{a}^{b}f_{x}(y)dy=F_{X}(b)-F_X(a)$

**OSS** $f(y) > 1$ è possibile ma l'integrale deve essere 1

**OSS** Se $F_{X}$ è derivabile $\Rightarrow$  $F_{X}^{'}=f_{X}$

## Trasformazioni lineari continue
##### Esempio
$X$ v.a. uniforme $[0,1]$   $Y =2X +3$
$\mathcal{R}= [3,5] = \{y \in \mathbb{R} | f_{Y}(y)\neq c\}$

![[Pasted image 20240430151808.png|center|500]]

$1= \int_{-\infty}^{+\infty} f_{y}(y)dy = 2c \Leftrightarrow c = \frac{1}{2}$


![[Pasted image 20240430152123.png]]

**Proposizione** $X$ v.a. continua  $Y=aX+b$  $a \neq 0$   $b \in \mathbb{R}$
1) $a > 0 \quad F_{y}(y) = F_{X}(\frac{y-b}{a})$
2) $a < 0 \quad F_{y}(y) = 1-F_{X}(\frac{y-b}{a})$

## Costante di rinormalizzazione
- [[La costante di rinormalizzazione]]
## Speranza
- [[Speranza di v.a. continue]]
## Trasformazioni non lineari
- [[Trasformazioni non lineari]]
## Varianza
- [[Varianza v.a. continue]]
## Vettori aleatori
- [[Vettori aleatori continui]]