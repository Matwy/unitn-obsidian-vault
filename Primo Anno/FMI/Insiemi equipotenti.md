---
date: 11/03/2024
tags:
  - insiemi
Materia: "[[FMI]]"
---
$$
\newcommand{\N}{\mathbb{N}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Z}{\mathbb{Z}}
$$
## Insiemi equipotenti (cenni)
**DEF 2.1** Siano $X$ e $Y$ due insiemi.
Diciamo che $X$ e $Y$ sono **equipotenti** e scriveremo $X\sim Y$ (leggendo $X$ è equipotente a $Y$ oppure $X$  ha la stessa cardinalità di $Y$)
se $\exists \,f\, X \to Y$ una bigezione, ossia una funzione bigettiva (se $X=\varnothing$ allora intendiamo che anche $Y$ lo sia)

**Proposizione 2.2** Dati $X,Y,Z$ tre insiemi valgono
1) $X\sim X$ (infatti $id_{x}: X\to X$ è una bigezione)
2) Se $X\sim Y$ allora $Y \sim X$
3) Se $X \sim Y$ e $Y \sim Z$ allora $X \sim Z$
**OSS 2.3** Concetto di **cardinalità**
Se dato $X$ insieme, il cardinale $|X|$ è in bigezione con un sottoinsieme di $\mathbb{N} = \{0,1,2, \dots\}$ allora $X$ si dice insieme **finito**. Si dice che la cardinalità di $X$  è n+1
**Teorema 2.4** Siano $X$ e $Y$ due insiemi
Allora vale che $X \sim Y <=> |X| =|Y|$