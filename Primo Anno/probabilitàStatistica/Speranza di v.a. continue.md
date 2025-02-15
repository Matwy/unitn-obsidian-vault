---
date: 2024/05/06
tags:
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie Continue]]"
---
## Speranza di v.a. continue
Chiamiamo **valore** **atteso** o **speranza** o **media** di $X$ v.a. continua il numero
$$
\mathbb{E}[X] = \int_{-\infty}^{+\infty} xf_{X}(x) \, dx
$$
**OSS** se l'integrale non esiste o vale $\pm \infty$ la speranza non è definita

**Teorema** 
$X$ v.a. continua 
$Y=g(X)$ Allora
$$
\mathbb{E}[Y] =\int_{-\infty}^{+\infty}g(x) \cdot f_{X}(x) \, dx
$$
**Prop** $X,Y$ v.a. continue
- $\mathbb{E}[aX+Y+b]= a \mathbb{E}[X]\mathbb{E}[Y]+b\qquad \forall a,b \in \mathbb{R}$
- $X \geq 0 \Rightarrow \mathbb{E}[X] \geq 0, E[X] = 0 \Leftrightarrow X = 0$

