---
date: 2024/04/19
tags:
  - variabilialetorie
  - varianza
  - valoreatteso
Materia: "[[Probabilità e Statistica]]"
---
## Momenti di una v.a.
**Def** $n \in \mathbb{N}\setminus \{0\}$ , chiamiamo **momento** n-esimo di una v.a. $X$ il numero $E[X^{n}]$

- Chiamiamo **momento centrato** n-esimo di una v.a. il numero:
$$
\mathbb{E}[(x-\mathbb{E}[X])^{n}]
$$

- **momenti** **empirici**
	- **non** **centrati**
$$
\frac{1}{n}\sum_{i=1}^{n}x_{i}^{n}
$$
	- **centrati**
$$
\frac{1}{n}\sum_{i=1}^{n}(x_{i}-\overline{x})^{n}
$$

- Se $n=2$ chiamiamo **varianza** il numero:
$$
Var[X] = \mathbb{E}[(X-\mathbb{E}[X])^{2}]
$$

**OSS** 
- $n=1$  $\mu = \mathbb{E}[X]$
	$\mathbb{E}[X-\mu] = \mathbb{E}[X]-\mu = 0$
	
- la **varianza** misura la dispersione di $X$ 
- $X = C$ allora $Var[X] = 0$

**Proprietà**
1) $Var[X] = \mathbb{E}[X^{2}] - \mathbb{E}[X]^{2}$
---
**Esempio** (Bernoulliane)
$X\sim bin(1,p)$       $\mathbb{E}[X] =p$
$$
\begin{gather*}
\mathbb{E}[X^{2}] = \sum_{k \in \mathcal{R}_{x}} k^{2}\phi_{x}(k) = 0^{2}(1-p) + 1^{2}p = p\\
\Rightarrow Var[X] = \mathbb{E}[X^{2}] - \mathbb{E}[X]^{2} = p-p^{2}= p(1-p)
\end{gather*}
$$
---
##### Proprietà
- $X$ v.a.
1) $Var[X]\geq0$ e $Var[X] = 0 \Leftrightarrow X\text{ è costante}$
2) $a,b \in \mathbb{R} \,\, Var[aX+b] = a^{2}Var[X]$
3) $X,Y$ v.a. indipendenti allora $\Rightarrow Var[X+Y] = Var[X]+Var[Y]$
---
## Varianza di V.A note
#### Binomiali
$$
\begin{gather*}
X\sim bin (n,p) \qquad Y_{i}\sim bin (1,p)\\
X = Y_{1}+\dots+Y_{n}\\
\Rightarrow Var[X] = Var[Y_{1}+\dots+Y_{n}]=np(1-p)
\end{gather*}
$$
#### Poissoniane
$X \sim Pois(\lambda)$    $\mathbb{E}[X] = \lambda$
$E[X^{2}]= \lambda^{2}+\lambda$
$Var[X] = E[X^{2}]-\lambda^{2}=\lambda$

#### Geometriche
$X\sim geom(p)\Rightarrow Var[X]= \frac{1-p}{p^{2}}$

#### Binomiali Negative
$X\sim BN(n, p)\Rightarrow Var[X]= n\frac{1-p}{p^{2}}$