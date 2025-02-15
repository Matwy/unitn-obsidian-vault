---
date: 2024/06/28
tags: 
Materia: "[[FMI]]"
---
#### Ostruzione 1
**Lemma** Sia $n \in \mathbb{N}$ con $n \geq 1$ 
Allora $G=(V,E)$ è un grafo con $n$ vertici vale:
$$
deg_{G}(V) \leq n-1
$$
**Corollario** Sia $n \in \mathbb{N}$ con $n \geq 1$ e sia $d=(d_{1},\dots, d_{n}) \in \mathbb{N}^{n}$ con $d_{1}\leq \dots \leq d_{n}$. Se $d_{n} >  n-1$ allora non esiste alcun grafo finito $G$ avente d come score.

**OSS** se abbiamo uno score $(0,\dots, 0, d_{1},\dots,d_{n})$ con m-volte 0. possiamo fare le considerazioni precedenti togliendo li zeri.

#### Ostruzione 2 
![[Pasted image 20240628203202.png|center|500]]
#### Ostruzione 3
Sia $n \in \mathbb{N}$ con $n \geq 3$, sia $d=(d_{1}, \dots, d_{n}) \in \mathbb{N}^{n}$
in forma canonica e sia $L \in \mathbb{N}$ definito ponendo
$$
L:=|\{i \in \{1,\dots,n-1\}\,|\,d_{i}\geq 2\}|
$$
Se $L < d_{n-1}+d_{n}-n$ allora $d$ **non è lo score di un grafo**

#### Ostruzione 4 Lemma delle strette di mano
- In un  grafo finito il numero di vertici di grado dispari è **pari**.