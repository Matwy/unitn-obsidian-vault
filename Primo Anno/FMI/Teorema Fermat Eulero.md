---
date: 2024/06/27
tags: 
Materia: "[[FMI]]"
---
## Teorema Fermat Eulero
**Def** Definiamo la funzione $\Phi:\mathbb{N}\setminus \{0\}\to \mathbb{N}$  detta funzione "phi" di **Eulero** ponendo
$$
\Phi(n):=|\{a \in \mathbb{Z} \,|\, 1 \leq a \leq n, \, (a,n)=1\}|\quad \forall n \in \mathbb{N}\setminus \{0\}
$$

- Che corrisponde al numero di interi compresi tra 1 e n inclusi che sono coprimi con n
**OSS**
(1) $\Phi(1)=|\{a \in \mathbb{Z} \,|\, 1 \leq a \leq 1, \, (a,1)=1\}|=|\{1\}|=1$
(2) $\Phi$ è **moltiplicativa** per **le coppie coprime** cioè 
(3) Sia $p$ un numero primo e sia $m \in \mathbb{N}\setminus \{0\}$ 
Considero $n=p^{m}$
- Calcoliamo $\phi(n)=\Phi(p^{m})$$= p^{m}-p^{m-1}$ e vale $\forall p \,\,\text{ primo e}\quad \forall m \in \mathbb{N}\setminus \{0\}$
- $\Phi(p) = p^{1}-p^{0}= p -1\quad \forall p\,\, \text{primo}$

## Formula generale
Sia $n \geq 2$ e sia $n=p^{m1}_{1}p^{m2}_{2}\dots p^{mk}_{k}$ per qualche numero primo $p_{1},\dots,p_{k}$ 
che cagada
![[Pasted image 20240627154003.png]] 

## Teorema di Fermat-Eulero
Sia $n > 0$ Per ogni $\alpha \in (\mathbb{Z}/n\mathbb{Z})^{*}$ vale
$$a^{\Phi(n)}=[1]_{n}\quad in\quad \mathbb{Z}/n \mathbb{Z}
$$
Equivalentemente per ogni $a \in \mathbb{Z} \quad tc\quad (a,n)=1$
$$a^{\Phi(n)}\equiv 1\,(mod\,\,\, n)$$
