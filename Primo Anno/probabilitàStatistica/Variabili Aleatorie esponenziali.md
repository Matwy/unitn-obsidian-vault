---
date: 2024/05/06
tags:
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---
## Variabili Aleatorie esponenziali
**Def** $X$ v.a. **esponenziale** di parametro $\lambda > 0$ se
$$
f_{X}(x) = \begin{cases}
0 & x < 0 \\
\lambda e^{-\lambda x} & x \geq 0
\end{cases}
$$
**Notazione** $X \sim exp(\lambda)$
**OSS** a volte si usa il parametro $\mu = \frac{1}{\lambda} \Rightarrow f_{X(x)}= \frac{e^{\frac{-x}{\mu}}}{\mu}$

$$
F_{X}(x) = \begin{cases}
0 & x<0 \\
\int_{0}^{x}\lambda e^{-\lambda t} \, dt  = 1-e^{-\lambda x} & x \geq  0
\end{cases}
$$

![[Pasted image 20240506105318.png|center]]

#### In R
- $f_{X}(x) =$ `dexp(x, rate=1)` 
- $F_{X}(q) =$ `pexp(q, rate=1)` 

#### Indicatori
- $\mathbb{E}[X] = \int_{0}^{\infty}x \lambda e^{-\lambda x} dx = \frac{1}{\lambda}$
- $\mathbb{E}[X^{2] = \int_{0}^{\infty}x^{2} \lambda e^{-\lambda x} dx = \frac{1}{\lambda}}= \frac{2}{\lambda^{2}}$
- $Var[X] = \mathbb{E}[X^{2}] - \mathbb{E}[X]^{2} = \frac{1}{\lambda^{2}}$

#### Assenza di memoria
- Data $X \sim exp(\lambda)$ allora
- $\mathbb{P}(X > s + t | X > s) = \mathbb{P}(X > t)$     $\forall s,t > 0$