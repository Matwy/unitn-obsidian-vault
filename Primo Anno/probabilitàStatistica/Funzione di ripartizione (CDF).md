---
date: 2024-03-28
tags:
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---

### Funzione di ripartizione (CDF)
**DEF** $x$ aleatoria su $(\Omega , \mathcal{F}, \mathbb{P})$
La **funzione di ripartizione** o **funzione cumulativa** (**CDF**) di $x$ è la funzione
$$
\begin{align*}
F_{x}:\mathbb{R}\to \mathbb{R}\\
F_{x}(y) = P(x\leq y)
\end{align*}
$$
**Esempio** CDF di un dado con quattro facce:
![[Pasted image 20240326143506.png|center|550]]

#### Proprietà CDF
1) $F_{x}$ è non decrescente
2) $\lim_{y\to-\infty} F_{x}(y) = 0$ $\lim_{y\to\infty} F_{x}(y) = 1$
3) $F_{x}(y) \in [0,1]$
4) $F_x$ è **continua** a destra e **limitata** a sinistra 
##### Corollario
$F_{x}$ è continua in $x_0$ se e solo se $\mathbb{P}(x > x_{0}) = 0$