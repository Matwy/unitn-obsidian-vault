---
date: 14/03/2024
tags:
  - "#probabilità"
Materia: "[[Probabilità e Statistica]]"
---
$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\P}{\mathbb{P}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
## Cardinalità
$\#\N = \#Q$
$\#\N^{2}= \#\N$

**Teorema** $\#\mathscr{P}(A) > \# A$
La cardinalità dell'insieme delle parti di $A$ è maggiore della cardinalità di $A$

## Lo spazio dei numeri reali e $\sigma$-algebra di Borel
$\Omega = [0,1]$ 
Abbiamo visto che $\mathscr{P}([0,1])$ è un insieme troppo grande.
Costruisco $\Fcal$ che contiene
- i singoletti
- tutti gli intervalli $[a,b], [a,b), (a,b], (a,b)$
- intersezioni, complementari, unioni
La $\sigma$-algebra che contiene tutti questi sottoinsiemi si dice $\sigma$-algebra di **Borel**, e i suoi elementi li chiamiamo **Boreliani**.
Si indica con $\mathscr{B}([0,1]), \mathscr{B}(\R), \mathscr{B}((a,b))$

**Esempio** $\Omega = [0,1] \quad \Fcal = \mathscr{B}([0,1])$

$\forall 0< a \leq b \leq 1 \quad \P([a,b]) = b-a \geq 0$
$P([0,1]) = 1$
$\P(\{a\}) = \P([a,a]) = 0$

Data una **funzione** che si comporta come una probabilità sugli intervalli chiusi, la possiamo estendere univocamente ad una probabilità sui **Boreliani** di $[0,1]$.
	Per $\R$ usiamo le semirette $(\infty, b)$.
Abbiamo definito la probabilità **uniforme**
