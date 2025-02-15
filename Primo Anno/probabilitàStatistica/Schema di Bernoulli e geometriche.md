---
date: 2024/04/09
tags:
  - probabilità
  - "#binomiali"
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---
## Schema di Bernoulli
Ripetizioni potenzialmente infinite di Bernoulli indipendenti.
$\Omega = \{0,1\}^{\mathbb{N}\setminus \{0\}}$
$\mathcal{F}= \{\text{"cilindri"}\}$

- Un **cilindro** $C = \{\omega=(\omega,\dots)|\, \forall i = I_{\dots,n} \,\, \omega_{i} = v_{i} \, \in \{0,1\}\}$
$\mathbb{P}(C) = P^{\sum v_{i}}(1-p)^{1-\sum v_{i}}$

##### Esempi
- Probabilità di 1 successo seguito da 2 fallimenti
	- $\mathbb{P}(100*) = p(1-p)^{k-1}$
- Probabilità che il primo successo sia al $k-$ esimo tentativo
	- $\mathbb{P}(0\dots 01*) = p(1-p)^{k-1}$
- Probabilità che il terzo sia un successo
	- $$
\begin{gather*}
\mathbb{P}(**1*) = \mathbb{P}(001*)+\mathbb{P}(101*) + \mathbb{P}(011*)+\mathbb{P}(111*)\\
=(1-p)^{2}p+p^{2}(1-p)+p^{2}(1-p)+p^{3}
\end{gather*}$$
## Geometrica
**Def** $X$ è una v.a. **geometrica** di parametro $p$ se conta il numero di fallimenti prima di ottenere un successo in uno schema di **Bernoulli**
$$
x\sim geom(p)
$$
- **Densità**
$$
\phi_{x}(k) = \begin{cases}
\mathbb{P}(0\underbrace{\dots}_{k\, volte}01) = (1-p)^{k}p & k \in \mathbb{N}\\
0 & altrimenti
\end{cases}
$$
- **CDF**
$$
F_{X}(x) = \begin{cases}
1-(1-p)^{\lfloor{x}\rfloor+1} & x \geq 0 \\
0 & altrimenti
\end{cases}
$$
**Proposizione** Se $X$ è geometrica allora
$$
\mathbb{P}( X \geq n+ k \,| \, X \geq n ) = \mathbb{P}(X \geq k) \, \forall n,k \in \mathbb{N}
$$
**Assenza di memoria** 