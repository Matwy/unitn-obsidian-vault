---
date: 2024-03-18
tags:
  - induzione
Materia: "[[FMI]]"
---

$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
## Il principio di induzione (prima forma)
**Teorema 2.10** 
Sia $\langle P(n) \rangle_{n\in\N}$ una famiglia di proposizioni (ossia affermazioni) indicizzate su $\N$
Supponiamo che 
1) **base induttiva** P(0) è vera. 
2) **passo induttivo** $\forall n \in \N :(\underbrace{P(n)}_{ipotesi\, induttiva} \Rightarrow P(succ(n)))$
## **Teorema 7.6** Principio di induzione di seconda forma
Dispensa: [[Dispensa FMI.pdf#page=23&selection=485,0,576,2|Dispensa FMIpdf, page 23]]

Sia $\{P(n)\}_{n\in \N}$ una famiglia di proposizioni
indicata su $\N$, Supponiamo che valgano le seguenti proprietà:
- **base induttiva** $P(0)$ è vera
- **passo induttivo** $\forall n >0$, ( $P(k) \quad vera\quad \forall k \in \N, 0 \leq k <n$)

Ovvero per ogni $n>0$, $\underbrace{se\quad P(k)\quad è \quad vera\quad \forall k \in \N \quad tc \quad 0\leq k < n}_\text{ipotesi \quad induttiva}$,

allora $P(n)$ è vera $\forall n \in \N$
