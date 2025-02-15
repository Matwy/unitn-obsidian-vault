---
date: 11/03/2024
tags: 
Materia: "[[FMI]]"
---
$$
\newcommand{\N}{\mathbb{N}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Z}{\mathbb{Z}}
$$
## Costruzione dei numeri naturali
### Assiomi di Peano per l'insieme $\mathbb{N}$ dei numeri naturali
**Assioma 2.5** $0\in \mathbb{N}$ ($\exists$ l'elemento $0$)
**Assioma 2.6** $\exists\, succ: \mathbb{N} \to \mathbb{N}$ funzione iniettiva (funzione successivo)
**Assioma 2.7** $succ(\mathbb{N}) \subset \mathbb{N} \\ \{0\}$, ovvero $\forall n \in \mathbb{N}, succ(n) \neq 0$
**Assioma 2.8 (di induzione)** Sia $A$ un sottoinsieme di $\mathbb{N}$. Supponiamo che $A$ soddisfa le seguenti due condizioni: 
1) **base dell'induzione** $0\in A$
2) **Passo induttivo** $\forall n \in \mathbb{N}, (n\in A =>succ(n)\in A) ovvero se n\in A$ per qualche $n\in \mathbb{N}$ allora anche $succ(n) \in A$
Allora $A = \mathbb{N}$

**Proposizione 2.9** Sia $n\in \N \setminus {0}$
Allora $\exists ! \,m\in N \quad tc\quad succ(m) = n$ ($m$ si dice predecessore di $n$)
**DIM** Se un tale $m\in \N$ esiste, allora è unico grazie al secondo assioma.

## Teorema di ricorsione
##### Ipotesi
Sia $X$  un insieme non vuoto,
sia $h:\N \times X \to X$ una funzione qualsiasi,
sia $c\in X$
##### Tesi
Esiste ed è unica una funzione 
$f: \N \to X \quad tc$ 
- $f(0) = c$
- $f(succ(n)) = h(n, f(n))$
- $\forall n \in \N$

## Addizione e moltiplicazione
### Addizione
Sia $m \in \N$
- Definiamo la funzione "somma a sinistra con $m$" $=$ "$N \ni n \to m+n \in \N$"
Poniamo $X = \N$ e 
$h: \N \times \N \to \N = (a,b) \to succ(b)$ e $c = m$

Applichiamo il **teorema di ricorsione** con i dati $X, h, c$ precedenti
Otteniamo quindi una sola funzione $f:\N \to \N \, tc$
- $f(0) = m$
- $f(succ(n)) = h(n, f(n)) = succ(f(n))$

Se indichiamo questa funzione $f: \N \to \N$ con il simbolo usuale
$$m \,+ \, .\, : \N \to \N \quad ovvero \quad f(n) = m+n$$
allora 
$$
\begin{cases}
m + 0 = m  \\
m + succ(n) = succ(m+n) \quad \forall n \in \N 
\end{cases}
$$
### Moltiplicazione
Sia $m \in \N$ (fissato)
Dobbiamo definire una funzione tale che
$$
m\cdot . : \N \to \N
$$

- Poniamo $c = 0$
- $X = \N$
- $h: \N \times \N \to \N$  $= (a,b) \to m +b$

Quindi esiste ed è unica una funzione unica
$$\exists ! f: \N \to \N$$
$$
\begin{cases}
m\cdot 0 = 0 \\
m\cdot (succ(n)) = n + m\cdot n
\end{cases}
$$

**OSS 3.2** Sia $n \in \N$ Vale:
$$
n+1 =n+succ(0) = succ(n+0) = succ(n)
$$
## Ordinamento Totale dei Naturali
**DEF 3.6** Sia $X$ un insieme non vuoto e sia $\mathcal{R}$ una relazione binaria su $X$ (ovvero $\mathcal{R}\subset X \times X)$ Tale relazione $\mathcal{R}$ si dice **ordinamento parziale di $X$** se soddisfa le seguenti proprietà.
1) $x\mathcal{R}x \quad \forall x \in X$ (proprietà **riflessiva**) ($x\mathcal{R}x$ significa che $(x,x)\in \mathcal{R}$)
2) $\forall x,y \in X$ $x\mathcal{R}y$ e $y\mathcal{R}x \Rightarrow x=y$ (proprietà **antisimmetrica**)
3) $\forall x,y,z \in X,\quad x\mathcal{R}y$ e $y\mathcal{R}z \Rightarrow x\mathcal{R}z$ (proprietà **transitiva**)

Se in aggiunta a queste proprietà vale anche la seguente 
4) $\forall x,y \in X, \quad x\mathcal{R} y$ è vera oppure $y\mathcal{R}x$ è vera (**tricotomia**)
allora si dice che $\mathcal{R}$  è un **ordinamento totale** di $X$

- Se $\mathcal{R}$ è un ordinamento parziale di $X$ allora $(X, \mathcal{R})$ si dice **insieme parzialmente ordinato**
- Se $\mathcal{R}$ è un ordinamento totale, allora $(X, \mathcal{R})$ si dice **insieme totalmente ordinato**

Usualmente la relazione di ordinamento parziale si indicano con $\leq$

**DEF 3.3** Siano $n,m \in \N$
Diciamo che $n \leq m$ se
$$\exists k \in \N \quad tc \quad n+k=m$$
**OSS** $n \leq m \Leftrightarrow m\geq n$

**TEOREMA (proposizione 3.5)** $(\N, \leq)$ è un insieme totalmente ordinato

**TEOREMA (principio di induzione 'shiftato' di prima forma)** 
Sia $\langle P(n) \rangle _{n\geq k}$ una famiglia di proposizioni indicizzata sui numeri naturali $n\geq k$

Supponiamo che valgano le seguenti due proprietà:
1) **base induttiva** $P(k)$ è vera
2) **passo induttivo** $\forall n \ge$ k : $(P(n) \Rightarrow P(n+1))$ cioè
	se $P(n)$ è vera allora anche $P(n+1)$ è vera
	Allora $P(n)$ è vera $\forall n \geq k$

## Dimostriamo che $\N$ è infinito
Dato un insieme $X,Y$ è detto **FINITO** se $X\sim I_{n}$ per qualche $n\in \N$

**Proposizione 4.4** Sia $X$ un insieme finito e sia $Y$ un suo sottoinsieme.
Allora $Y$ è finito e 
$$
|Y| \leq|X|
$$
Più precisamente se $Y$ è un sottoinsieme proprio di $X$ ovvero $Y\subsetneq X$, allora $|Y| < |X|$
**DIM** [[Dispensa FMI.pdf#page=14&selection=956,0,980,3|Dispensa FMIpdf, page 14]]

**Corollario 4.5** [[Dispensa FMI.pdf#page=14&selection=1508,1,1508,14|Dispensa FMIpdf, page 14]]
Un insieme finito non è equipotente con nessun suo sottoinsieme proprio
**Corollario 4.6** $\N$ è infinito

