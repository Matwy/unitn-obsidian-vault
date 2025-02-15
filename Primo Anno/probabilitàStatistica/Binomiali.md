---
date: 2024/04/09
tags:
  - probabilità
  - binomiali
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---

# Binomiali
**Def** $X$ v.a. discreta è una **binomiale** di parametri $n \in \mathbb{N}\setminus \{0\}$ e $p \in [0,1]$ se è la somma di $n$ v.a. di Bernoulli indipendenti di parametro $p$
Scriviamo: $$
x \sim bin(n,p)
$$
**OSS** $X \sim bin(1,p)$ è una **Bernoulliana** di parametro $p$

**Proposizione** Sia $X \sim bin(n,p)$, allora 
$$
\phi_{x}(n) = \begin{cases}
\binom{n}{k}p^{k}(1-p)^{n-k}& k \in \{0,\dots,n\} \\
0 & altrimenti
\end{cases}
$$
$$
F_{x}(x) = \sum^{floor(x)}_{k=0}\binom{n}{k}p^{k}(1-p)^{n-k}
$$
---
## Binomiali in $\mathcal{R}$
$X \sim bin (n,p)$

$\phi_{x}(y)$ $\leftarrow$ $\underbrace{d}_{\text{tipo di operazione}}\overbrace{binom}^{distribuzione}(y,n,p)$

$F_{x}(y) \Leftarrow pbinmo(y,n,p)$
