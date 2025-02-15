---
date: 2024/03/21
tags:
  - binario
Materia: "[[FMI]]"
---
$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
## Scrittura dei numeri naturali in base maggiore di 2
**DEF 8.1**
Sia $b \in \N$. Diciamo che un numero naturale $n \in \N$ è **rappresentabile in base** $b$ se 
$$
\begin{align*}

\exists\,k \in \N \quad e \quad \exists\, n_{0,}\dots n_{k}\in I_{b}\quad \\
(\text{dove} \quad I_{0}=\varnothing, \, i_{b}= \{0,1,\dots, b-1\}\text{ se } b\geq 1) \quad tc\quad 
\end{align*}
$$
$$
n = n_{0}\cdot b^{0}+n_{1}\cdot b^{1}+ n_{k}\cdot b^{k}
$$
**OSS** Quali $n \in \N$ si possono rappresentare in base $b =0$, 
- Nessuno perchè $I_{0}=\varnothing$

Quali $n \in \N$ si possono rappresentare in base $b =1$,  
- Solo $n=0$ perchè $I_{1}=\{0\}$
Per $b \geq 2$ ?

**OSS 8.3** Sia $b\geq 2$
Osserviamo che $n \in \N$ è rappresentabile in base b se soltanto se $\exists\{\epsilon_{i}\}_{i \in \N} \subset I_b$
1) $\exists\{\epsilon_{i}\}_{i \in \N} \subset I_b$ è definitivamente nulla 
2) $\epsilon_{i}\in I_{b}\forall i \in \N$
3) $n=\sum_{i \in \N} \epsilon_{i}b^{i}= \epsilon_0+\epsilon_{1}b+\dots + \epsilon_{k}b^k$

### Teorema 8.4 Scrittura dei naturali in base arbitraria >=2
Sia $b \in \N \quad tc\quad b \geq 2$ 
Allora ogni numero naturale $n \in \N$ si può rappresentare in $b$ in modo unico, cioè 
$\exists\{\epsilon_{i}\}_{i \in \N} \subset I_b$ con le proprietà (1)(2)(3)
Inoltre se $\exists\{\epsilon_{i}\}_{i \in \N} \subset I_b$ con le stesse  proprietà allora $\epsilon_{i}= \epsilon_{i}' \quad \forall i \in \N$

**DIM** Procediamo per induzione su $n \in \N$ di seconda forma
$n = 0$ **base induzione** E' sufficiente porre $\epsilon_{i}= 0 \,\, \forall i \in \N \Rightarrow \{\epsilon_i\}_{i \in \N}$ è nulla

$\forall n > 0$, $(\forall k, 0\leq k < n )$ =>$n$
Sia $n> 0$. Assumiamo di saper scrivere in base $b$ ogni numero naturale $k$ compreso tra $0$ e $n-1$ (IP IND)
Dobbiamo provare che anche $n$ è rappresentabile in base $b$
Eseguiamo la divisione di $n$ per $b$ ottenendo $1,4 \in \N \quad tc\quad$
$$
\begin{cases}
n=qb+r \\
0\leq r < b \Leftrightarrow r \in I_{b}
\end{cases}
$$
Proviamo che $q<m$
Se $q=0$ abbiamo finito
Se $q \geq 1$, allora vale 

$\underbrace{q < qb}_{\text{perchè } b\geq 2}$ 
quindi $qb \leq qb+r = n \Rightarrow 1<n$

Posso dunque applicare l'ipotesi induttiva $k=q$ Segue che 
$$
\exists\{\}
$$
cotto
