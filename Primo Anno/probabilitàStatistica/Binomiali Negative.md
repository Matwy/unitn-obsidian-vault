---
date: 2024/04/16
tags:
  - binomiali
  - probabilità
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---

## Binomiali Negative
**DEF** $X$ è una v.a. **binomiale negativa** di parametri $n \in \mathbb{N}$ e $p \in [0,1]$ se conta il numero di insuccessi precedenti all'n-esimo successo in uno schema di Bernoulli.
vedi: [[Schema di Bernoulli e geometriche]].

- **Notazione** $X\sim NB(n,p)$
- **OSS** $X\sim NB(1,p) \sim geom(p)$

#### Densità
**Proposizione** Dato $X\sim NB(n,p)$ allora
$$
\phi_{x}(k)=\begin{cases}
\binom{k+n-1}{n-1}p^{n}(1-p)^{k} & k \in \mathbb{N} \\
0 & altrimenti
\end{cases}
$$
