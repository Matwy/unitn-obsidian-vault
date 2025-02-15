---
date: 2024-03-28
tags: []
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---
## Esempi variabili aleatorie
**Esempio** Lanciamo una moneta.
Vogliamo calcolare la probabilità di ottenere la prima testa in un lancio dispari.

$\Omega = \{T, C\}^{\N\setminus\{0\}} \quad (w_{1}, w_{2}, \dots) \quad w_{i} \in \{T,C\}$
$\text{cilindri} = \text{"eventi in cui fissiamo i primi n indici"}$
Usiamo questi $cilindri$ per formare una sigma algebra
$\Fcal = \sigma(\text{"cilindri"})$
$\mathbb{P} = \text{probabilità prodotto}$
##### Costruiamo la variabile aleatoria
$x: \Omega \to \R \quad x(w) = inf\{i \in \N \setminus \{0\}:w_{i}= T\}$
**Esempio**
$w = (C,T,T,C,C,C,C, \dots)\to 2$

$x^{-1}(\{4\}) = \{w \in \Omega | w_{1}=w_{2}=w_{3}=C, w_{4}=T\}$
$\{x \leq n\} = \bigcup_{i=1}^{n}\{x=i\}=\bigcup^{n}_{i=1}x^{-1}(\{i\})$
Quindi $\sigma(x)\subseteq \Fcal$

##### Dobbiamo calcolare la probabilità che $x$ sia dispari
Chiamiamo $H_{k} = \{w \in \Omega | \, w_{i}=C, i < k, w_{k}=T\}$
Quindi $H_{k}$ ha tutte croci fino a $k-1$ e in $k$ ha una testa
$$
\P(\text{x dispari})= \sum_{i=0}^{\infty}\P(H_{2i+1}) = \sum_{i=0}^{\infty}\frac{1}{2^{2i+1}}=\frac{1}{2}\sum_{i=0}^{\infty}(\frac{1}{4})^{i}=\frac{2}{3}
$$
**Esempio**
$c \in \R \quad x(w)=c$ funzione costante
è una variabile aleatoria **degenere**

$\forall y \in \R$
$$
\P(x=y) = \begin{cases}
0 \quad y \neq c\\
1 \quad y = c
\end{cases}
$$
In generale $A \in \mathscr{B}(\R)$
$\P(x \in A) = \P(\{w \in \Omega : x(w) \in A\}) = \P(x^{-1}(A))$
$$x^{-1}(A) =\begin{cases}
\Omega &c \in A\\
\varnothing & c \notin A
\end{cases}$$ 
Quindi
$$
\P(x \in A) = \begin{cases}
0 \quad c \notin A\\
1 \quad c \in A
\end{cases}
$$
La $\sigma$ algebra originata da $x$ è:
$\sigma(x) = \{\varnothing, \Omega \}$