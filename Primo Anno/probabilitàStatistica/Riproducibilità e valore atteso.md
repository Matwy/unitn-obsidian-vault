---
date: 2024/04/16
tags:
  - "#valoreatteso"
Materia: "[[Probabilità e Statistica]]"
---
## Riproducibilità
**DEF** Una famiglia di leggi di probabilità è **riproducibile** se sommando due v.a. indipendenti con le leggi di quella famiglia se ne ottiene un'altra nella stessa famiglia.

**Esempio** Data $X,Y \sim Bernoulli(p)$
- $X+Y \sim binom(2,p) \text{ non riproducibile}$
- $X\sim binom(n,p), Y\sim binom(m,p)\quad X+Y\sim binom(n+m, p) \,riproducibile$
## Valore atteso o Speranza di v.a. discrete
**Def** chiamiamo **valore** **atteso** oppure **speranza** oppure anche **media** di una variabile aleatoria discreta $X$ il baricentro della sua distribuzione.

$$
\mathbb{E}[x]:=\sum_{k \in \mathcal{R}_{x}} k \phi_{x}(k)= \sum_{k \in \mathcal{R}_{x}}k \mathbb{P}(X=k)
$$
#### Proprietà
Date $X,Y$ v.a
1) **Linearità** $\mathbb{E}[aX+Y+b] = a \mathbb{E}[x] + \mathbb{E}[y] + b\quad \forall a,b \in \mathbb{R}$
2) $X,Y$ sono indipendenti allora $\mathbb{E}[XY]= \mathbb{E}[X] \mathbb{E}[Y]$
3) $X \geq 0 \Rightarrow \mathbb{E}[X] \geq 0$
	$X \geq 0 \, e \, \, \mathbb{E}[X] =0 \Rightarrow X=0$

---
##### Valore atteso di a [[Binomiali]]
Data una **binomiale** $X \sim bin(n,p)$
il suo **valore** **atteso** sarà 
$$
\mathbb{E}[X] = n\cdot p
$$
---
##### Valore atteso di [[Schema di Bernoulli e geometriche#Geometrica|Geometriche]]
Data una **geometrica** $X\sim geom(p)$
il valore atteso sarà:
$$
E[X] = \frac{1-p}{p}
$$
---
##### Valore atteso di [[Binomiali Negative]]
Data $X \sim NB(n,p)$

Che possiamo descrivere come
$Y_{i} \sim geom(p)$     $X= \sum_{i=1}^{n}Y_{i}$

Il valore atteso allora è
$$
\mathbb{E}[X]=\sum _{i=1}^{n}\mathbb{E}[Y_{i}]=n \frac{1-p}{p}
$$
---
## Speranza condizionata
- [[Speranza Condizionata.pdf]]

