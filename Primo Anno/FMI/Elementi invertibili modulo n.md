---
date: 2024/06/27
tags: 
Materia: "[[FMI]]"
---
## Elementi invertibili modulo n
Siano $a,n \in \mathbb{Z}$ con $n > 0$ 
**Def** diciamo che $a$ è **invertibile** **modulo** $n$ in $\mathbb{Z}$ o equivalentemente $[a]_{n}$ è invertibile in $\mathbb{Z}/n \mathbb{Z}$ se esiste $x \in \mathbb{Z} \quad tc\quad$
$$
ax \equiv 1 (mod \,\,\, n)\quad \text{ in }\quad \mathbb{Z}  \Leftrightarrow [a]_{n}[x]_{n}=[1]_{n} \quad \text{ in }\quad \mathbb{Z}/n\mathbb{Z}
$$
Si dice $x$ è un **inverso di** $a$ a **modulo** $n$ e $[x]_{n}$ è una inversa di $[a]_{n}$

##### Lemma
- $[a]_{n}[x]_{n}=[x]_{n}[a]_{n} = [1]_{n}$
- Cioè $[x]_{n}$ è l'unica classe inversa di $[a]_{n}$ in $\mathbb{Z}/n$$\mathbb{Z}$ 
- Viene indicata con $[a]_{n}^{-1}$
- In particolare $[a]_{n}^{-1}$ vista come sottoinsieme di $\mathbb{Z}$ è costituita da tutti e soli gli interi inversi di $a$ modulo $n$

##### Proposizione
- $a \in \mathbb{Z}$ è invertibile $mod \,\,\, n$ se e soltanto se $(a,n)=1$ . In questo caso cioè se $(a,n)=1$, $\exists x,y \in \mathbb{Z} \quad tc\quad$
$$
xa+yn=1 \quad \text{Algoritmo di euclide su }a,n
$$
Allora vale:
$$
[a]_{n}^{-1} = [x]_{n}
$$
---
**Def** Dato $n \in \mathbb{N} \quad tc\quad n> 0$ indichiamo con $(\mathbb{Z}/n\mathbb{Z})^{*}$ il sottoinsieme di $\mathbb{Z}/n\mathbb{Z}$ formato da tutti gli interi modulo $n$ **invertibili**

**Proposizione** Sia $p$ un numero primo. Vale
![[Pasted image 20240627113542.png]]
