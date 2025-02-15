---
date: 2024-02-27
tags:
  - "#combinatoria"
Materia: "[[Probabilità e Statistica]]"
---
# Probabilità combinatoria (tutti i casi sono equiprobabili) 
### $\frac{CASI FAVOREVOLI} {CASI TOTALI}$

# Tre principi fondamentali della combinatoria
## 1° principio
$A$ insieme
$\{E\}^n_{n=1}$ è la partizione di A
Allora: 
$$\#A = \#E_{1} +\dots + \#E_{n}$$ 
## 2° principio
Per descrivere il secondo principio della combinatoria definiamo prima il prodotto cartesiano
**DEF** $A, B$ insiemi, 
Il **prodotto cartesiano** $A \times B$ è l'insieme delle coppie ordinate
$$(a, b) \quad a\in A, b\in B$$
Il secondo principio stabilisce che se un evento può verificarsi in $m$ modi diversi e un secondo evento può verificarsi in $n$ modi diversi indipendentemente dal primo, allora ci sono $m\times n$ modi in cui entrambi gli eventi possono verificarsi. 

Da notare che $m\times n$ e $n\times m$ non sono la stessa cosa in quanto originano coppie ordinate in modi diversi.
E vale che:
$$\#(A \times B) = \#(B \times A) = \#A \cdot \#B$$
## 3° principio
$A, B$ insiemi
$$\#(A\cup B) = \#A + \#B - \# (A\cup B)$$

**3 principio generalizzato**
$A_{1} \dots A_{n}$ insiemi
![[Pasted image 20240305103703.png]]


### Permutazioni e anagrammi
$A$ con n elementi, quanto sono le possibili **PERMUTAZIONI** ?
**permutazioni: modi di disporre gli elementi di $A$**

![[Pasted image 20240227100659.png]]

#### Regola generale permutazioni
Le permutazioni di $n$ elementi sono $n!$

#### Regola generale anagrammi
$A$ insieme di $n$ elementi con $m$ tipi diversi $(m \leq n)$
Quindi gli anagrammi di $A$ sono :
$$\frac{n!}{n_{1}! \cdot \dotsc \cdot n_{m}!}$$

#### Permutazioni incomplete
$$\frac{n!}{(n-k)!}$$