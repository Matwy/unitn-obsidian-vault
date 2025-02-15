---
date: 2024/05/06
tags:
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie Continue]]"
---
## Vettori aleatori continui
**Def** $X,Y$ continue
Chiamiamo **densità** **congiunta** o **bivariata**  di $X$ e $Y$
la funzione $f_{X,Y}:\mathbb{R}^{2} \to \mathbb{R}$ tale che
$\forall E \in \mathscr{B}(\mathbb{R}) \times \mathscr{B}(\mathbb{R})$
$$
\mathbb{P}((X,Y) \in E) = \iint_{E}f_{X,Y}(s,t) \,ds\,dt
$$
$$
\begin{gather*}
F_{X,Y}(x,y) = \mathbb{P}(X \leq x, Y \leq y) = \mathbb{P}((X,Y) \in (-\infty, x] \times (- \infty, y])\\
=  \int_{-\infty}^{x}\int_{-\infty}^{y}f_{X,Y}(t,s)\,ds\,dt
\end{gather*}
$$
---

#### Proprietà
- Le **densità marginali** di $X$ e $Y$ sono 
$$
f_{X}(x) = \int_{-\infty}^{+\infty}f_{X,Y}(x,y)\,dy
$$$$
f_{Y}(y) = \int_{-\infty}^{+\infty}f_{X,Y}(x,y)\,dx

$$
- $X,Y$ indipendenti $\Leftrightarrow$ $f_{X,Y}(x,y) = f_{X}(x)\,f_{Y}(y)$$
- $\int_{-\infty}^{+\infty}\int_{-\infty}^{+ \infty}f_{X,Y}(t,s)\,ds\,dt = 1$
---
#### Teorema valore atteso
Data $W=g(X,Y)$ con $(X,Y)$ vettore aleatorio continuo
$$
\mathbb{E}[W] = \int_{-\infty}^{+\infty}\int_{-\infty}^{+\infty}g(x,y)\,f_{X,Y}(x,y)\,dx\,dy
$$
