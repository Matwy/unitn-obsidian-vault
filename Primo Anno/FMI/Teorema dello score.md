---
date: 2024/06/28
tags: 
Materia: "[[FMI]]"
---
#### Lemma criterio di arresto
Sia $n \in \mathbb{N} \setminus \{0\}$ e sia $d=(d_{1},\dots, d_{n}) \in \mathbb{N}^{n}$ un vettore  tale che $d_{1} \leq \dots \leq d_{n} \leq 2$. Le seguenti affermazioni sono verificate. 
1) Se $d=(0,\dots,0,2)$ oppure se $n \geq 1$ e $d=(0,\dots,0,2,2)$ allora $d$ non è lo score di un grafo.
2) Se $d=(0,\dots,0)$ allora $d$ è lo score del grafo avente $n$ vertici isolati. Inoltre, se esiste $m \in \mathbb{N}$ tale che 
$$
\begin{gather*}
n \geq m \geq 3\\
d=(\underbrace{0,\dots,0}_{(n-m)-volte}, \underbrace{2,\dots,2}_{m-volte})
\end{gather*}
$$
	allora $d$ è lo score del seguente grafo
![[Pasted image 20240628223247.png|center|300]]

3) Se $d$ possiede un numero dispari di componenti uguali a 1 allora $d$ non è lo score di un grafo (lemma delle strette di mano). Se compare 1 un numero di volte pari (lemma delle strette di mano verificato) allora $d$ è lo score del seguente grafo
![[Pasted image 20240628223758.png|center|600]]


## Teorema dello score
Sia $n \in \mathbb{N}$ con $n \geq 2$ e sia $d=(d_{1},\dots,d_{n})\in \mathbb{N}^{n}$ tale che $d_{1}\leq \,dots \leq d_{n}\leq n-1$. Definiamo il vettore $d'=(d_{1}', \dots, d_{n-1}')$ e ponendo
$$
d_{i}'=\begin{cases}
d_{i} & se \,\, i < n-d_{n} \\
d_{i}-1 & se \,\, i \geq  n-d_{n} \\

\end{cases}
$$
$\forall i \in \{1,\dots,n-1\}$. Allora $d$ è lo score di un grafo se e soltanto se $d'$ è lo score di un grafo.