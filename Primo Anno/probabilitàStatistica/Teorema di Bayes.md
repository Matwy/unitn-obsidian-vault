---
Materia: "[[Probabilità e Statistica]]"
date: 2024-03-14
tags:
  - probabilità
---
	$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}\newcommand{\P}{\mathbb{P}}$
## [Teorema di Bayes 3.1](dispensapdf.pdf#page=61&selection=388,0,390,16|dispensapdf, page 61)
$$
\P(E|F) \neq \P(F|E)
$$
**In** **generale**:
Esempio    $10\%F$ $90\% M$
Il $90\%$ di $F$ prende appunti con il tablet
Il $10\%$ di $M$ prende appunti con il tablet
Se uno prende appunti con il tablet quale è la probabilità di $F$
$\P(T|F) = 90\%$   $\P(T|M) = 10\%$
$$\P(F|T) = \frac{\P(F\cap T)}{\P(T)} = \frac{\P(T|F)\P(F)}{\P(T)}$$
quindi $\P(T) = \P(T|F)\P(F) + \P(T|M)\P(M)$

**Teorema (Bayes)**: Sia $(\Omega, \Fcal, \P)$ uno spazio di probabilità
$E,f\in \Fcal$ di probabilità non nulla
Allora 
$$
\P(E|F) = \frac{\P(F|E)\P(E)}{\P(F)}
$$
**Corollario** $(E_i)_{i\in I}$ partizione di $\Omega$ 
$\forall E_{i},F\in \Fcal$
$$
\P(E|F) = \frac{\P(F|E)\P(E)}{\sum_{i\in I}\P(F|E_{i})\P(E_{i})}
$$