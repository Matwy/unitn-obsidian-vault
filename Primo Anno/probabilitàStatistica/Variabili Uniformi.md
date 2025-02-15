---
date: 2024/05/06
tags:
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---
## Variabili Uniformi
**Def** $a < b \in \mathbb{R}$ chiamiamo **uniforme $s- [a,b]$** una v.a. $X$ continua con pdf
$$
f_{X}(x)= \begin{cases}
\frac{1}{b-a} & x \in [a,b] \\
0 & altrimenti \\
\end{cases} 
$$
Notazione $X \sim unif[a,b]$

Funzione di **ripartizione**
$$
F_{X} (x) = \begin{cases}
0 & x<a  \\
\frac{x-a}{b-a} & a \leq x < b \\
1 & x \geq b
\end{cases}
$$
$Y \sim unif[a,b] \Rightarrow Y = bX+a \quad X \sim unif[0,1]$

#### In R
- $f_{X}(x) =$ `dunif(x, min=0, max=1)`
- $F_{X}(q) =$ `punif(q, min=0, max=1)`

#### Indicatori
- $\mathbb{E}[X] = \int_{a}^{b} \frac{x}{b-a} dx = \frac{b+a}{2}$
- $Var[X] = \mathbb{E}[X^{2}]-E[X]^{2} = \frac{(b-a)^{2}}{12}$

![[Pasted image 20240506111833.png|center]]

