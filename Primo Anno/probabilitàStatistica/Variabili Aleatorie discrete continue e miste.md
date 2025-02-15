---
date: 2024/03/28
tags:
  - probabilità
  - "#variabilialetorie"
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---

## Variabili Aleatorie discrete
**DEF** Una variabile aleatoria che può assumere al più un numero finito o numerabile di valori si dice **variabile** **aleatoria** **discreta**

**Esempio** 
- [[Variabili Aleatorie#Variabili Aleatorie **Indicatrici**|Indicatrici]]

**OSS** Data una $X$ discreta la sua **CDF** dovrà essere:
- **discontinua**
- **costante** a **tratti**

Altro: [[V.A. discrete]]
## Variabili aleatorie Continue
**DEF** Una variabile aleatoria si dice **continua** se $F_x$ è continua
- [[Variabili Aleatorie Continue]]

## Variabili aleatorie miste
**DEF** Una variabile aleatoria si dice **mista** nei casi rimanenti

**Esempio** Lancio una moneta. Se T estraggo uniformamente in $[0,1]$, se C lancio un dado
$x$ è il numero che ottengo alla fine
![[Pasted image 20240328151840.png|center|500]]
- - -
## Variabili Aleatorie discrete
**DEF** Sia $X$ una variabile aleatoria discreta. Chiamiamo **densità discreta** o **funzione di massa di probabilità** (**PMF**)
$$
\begin{align*}
\phi_{x}:\mathbb{R} \to [0,1]\\
\phi_{x}(y) = \mathbb{P}(x=y)
\end{align*}
$$
- Chiamiamo **supporto** di $x$ e di $\phi_x$ l'insieme $\mathcal{R}x$ dei valori assunti da $x$

**Esempio**
$x =c$ degenere
$$
\phi_{x}(y) = \begin{cases}
1 &y=c \\
0 & \text{altrimenti}
\end{cases}
$$
![[Pasted image 20240328160907.png|center|550]]
**Esempio 2** 
$E \in \mathcal{F}$
$$
I_{E}(\omega) = \begin{cases}
1 & \omega \in  E \\
0 & \omega \in E^{c}
\end{cases}
$$
$$
\phi_{I_{E}}(y) = \mathbb{P}(I_{E}=y)=\begin{cases}
\mathbb{P}(E^{c})&y=0 \\
\mathbb{P}(E)&y=1 \\
0 &\text{altrimenti}
\end{cases}
$$
**Esempio 3** $X$ è il primo lancio in cui esce testa
$$
\begin{align*}

\phi_{x}(n) = \mathbb{P}(x=n) = \frac{1}{2^{n}}\quad n \in \mathbb{N}\setminus\{0\}\\
\phi_{x}(-1)=0 \, altrimenti
\end{align*}
$$
![[Pasted image 20240329121745.png|center|450]]

## Proprietà  della densità discreta $\phi_x$
**Teorema**
1) $\forall y \in \mathbb{R}$    $0 \leq \phi_{x}(y)\leq 1$
2) $y \notin \mathcal{R}_{x} \Longleftrightarrow \phi_{x}(y) =0$  $\mathcal{R}_{x}$ è numerabile
3) $\sum_{y \in \mathcal{R}_{x}} \phi_{x}(y) = 1$
4) Se $E \in \mathscr{B}$
$$
		\mathbb{P}_{x}(E) = \mathbb{P}(x \in E) = \sum_{y \in E \cap \mathcal{R}_{x}} \phi_{x}(y)
		$$
5) $$\phi_{x}(y_{0}) = F_{x}(y_{0})-\lim_{y\to y_0} F_{x}(y)$$


