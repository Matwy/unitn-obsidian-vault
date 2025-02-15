---
date: 2024-03-18
tags: 
Materia: "[[FMI]]"
---
$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
## La divisione euclidea
Dispensa: [[Dispensa FMI.pdf#page=23&selection=937,0,971,1|Dispensa FMI, page 23]]
### Teorema 7.7
Siano $n,m \in \Z \quad tc\quad m \neq 0$ Allora $\exists ! q,r \in \Z$
$tc$ 
$$
\begin{cases}
n = q m + r \\
0 \leq r < |m|
\end{cases}
$$
In questo caso si dice che $q$ è il quoziente della divisione di $n$ per $m$ e $r$ è il **resto**
della divisione per $m$

**DIM** ($\exists$) Supponiamo che $n,m \in N$ $m > 0$
Procediamo per induzione di 2nd forma su $n \in \N$ 
Definiamo $P(n)$ Ponendo:
$$
P(n) = \begin{cases}
n = q m+r \\
0 \leq r < |m| = m
\end{cases}
$$
**base induzione** $n=0$ $\forall m > 0$
$$
\begin{align}
n=0 = qm+r \\
0 \leq r < m
\end{align}
$$
$n > 0$, ($\underbrace{P(k)\, \forall k \in \Z: 0\leq k < n}_\text{ipotesi induttiva} \Rightarrow P(n$) **passo induttivo**
Assumiamo che $\forall n> 0$, $\forall k\in \N \quad tc\quad 0 \leq k < n$
$\Rightarrow \exists q,r \in \N \quad tc$
$$
\begin{cases}
k=qm+r \\
0\leq r<m
\end{cases}
$$
Dobbiamo provare che $P(n):$
Se $n < m$, allora è sufficente porre
$$
q=0, \quad r=n
$$
Controlliamo
$$
\begin{cases}
n=qm+r = 0 \cdot m + n \\
0\leq 0 < n
\end{cases}
$$
Supponiamo $n \geq m$ Definiamo 
$$
\begin{align*}
k:= n - m \Rightarrow \quad 0 \leq K < n\\
n=k+m\\\\
\text{Per l'ipotesi induttiva}, \exists \, q,r \in \N \quad tc\quad \\
\begin{cases}
k=qm+r \\
0\leq r < m
\end{cases}
\end{align*}
$$
Grazie al principio di induzione di 2nd forma esiste almeno un $q,r \in \N$ della divisione di ogni $n \in \N$ per $m$.

### Unicità
(!) Sia $n \in \N$ e sia $m>0$ e siano
$q,q',r,r' \in \N \quad tc\quad$
$$
\begin{align*}

\begin{cases}
(1)\quad k=qm+r \\
(2)\quad 0\leq r < m
\end{cases}
\quad
\begin{cases}
(1')\quad k=q'm+r' \\
(2')\quad 0\leq r' < m
\end{cases}\\
\\
\text{Semplificando otteniamo che} \quad q=q'\quad e \quad r=r'
\end{align*}
$$
#### Caso in cui $n<0 \quad m> 0$
Applichiamo il caso precedente alla coppia  $n>0, \, m>0 \Rightarrow \exists! q,r \in \N \quad tc\quad$
$$
\begin{align*}

\begin{cases}
-n = qm+r \Rightarrow n = (-q)m-r \\
0 \leq r < m
\end{cases}
\\ \text{Osserviamo che se} \quad r = 0\\
allora \quad 0 \leq -r = 0 < m\\
\text{quindi quoziente} = -q \\
\text{e resto} = 0

\end{align*}
$$
#### Caso m<0
Siano $n \in \Z$ e $m<0$
Applico i 2 casi precedenti alla coppia n, -m:
$$
\begin{align*}
\Rightarrow \exists!\,\, q,r \in \N \quad tc\quad \\

\begin{cases}
n = q(-m)+r = (-q)m+r\\
0\leq r < -m = |m|
\end{cases}
\end{align*}
$$
Verificato



### Esercizio
Eseguire la divisione di n per m nei seguenti casi
$$
\begin{align*}
(1) n=16, m =5\\
(2) n=-16, m =5\\
(3) n=16, m =-5\\
(4) n=-16, m =-5\\
\end{align*}
$$