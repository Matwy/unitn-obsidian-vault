---
date: 14/03/2024
tags:
  - probabilità
Materia: "[[Probabilità e Statistica]]"
---

$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
**Esempio** Giacomo fa un secondo test che è positivo
$\P(I) = 0.5\%$ probabilità di essere infetti
$\P(+|I)=99.9\%$ probabilità di essere positivi se infetti
$\P(-|S) = 99.7\%$

$$
\P(I|+_{1}\cap +_{2})= \frac{\P(+_{1}\cap +_2|I)\P(I)}{\P(+_{1}\cap +_2|I)\P(I)+\P(+_{1}\cap +_{2}|S)\P(S)}
$$
Assumiamo che i due test siano indipendenti condizionatamente cioè $\P(+_1\cap+_2|I)= \P(+|I)\P(+_2|I)$

$$
= \frac{\P(+|I)\P(+|I)\P(I)}{\P(+|I)\P(+|I)\P(I)+\P(+|S)\P(S)} = 99.9\%
$$