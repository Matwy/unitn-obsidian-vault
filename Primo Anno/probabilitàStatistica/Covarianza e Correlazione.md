---
date: 2024-05-06
tags:
  - varianza
Materia: "[[Probabilità e Statistica]]"
---

## Covarianza e Correlazione
#### Covarianza
**Def** $X,Y$ v.a.
Chiamiamo **covarianza** di $X$ e $Y$ il numero 
$$
Cov[X,Y]=\mathbb{E}[(X-E[X])(Y-\mathbb{E}[Y])]
$$
Se $Cov[X,Y]=0$ diciamo che $X$ e $Y$ sono **scorrelate**

**OSS** $Cov[X,X]=Var[X]$
- $Cov[X,Y]=\mathbb{E}[XY]-\mathbb{E}[X]\mathbb{E}[Y]$
- $Cov[X,Y] = Cov[Y,X]$
- $X,Y$ indipendenti allora $\Rightarrow Cov[X,Y] = 0$

**Proposizione**
1) $Var[X+Y]= Var[X]+Var[Y]+2Cov[X,Y]$
2) $Cov[aX+bY, Z]=aCov[X,Z]+bCov[YZ]$
3) no voglia

##### Matrice di Covarianza
**Def** $X=(X_{1}, \dots, X_{n})$ vettore aleatorio chiamiamo **matrice** **di** **covarianza** la matrice
$$
\sum_{ij}=Cov[X_{i}, X_{j}]\quad i,j=1,\dots,n
$$

#### Correlazione
**Def** Chiamiamo **correlazione** di $X,Y$ il numero 
$$
\rho(X,Y)=corr[X,Y]=\frac{Cov[X,Y]}{\sqrt{Var[X]Var[Y]}}
$$
- $\rho(X,Y) > 0 \qquad X,Y$   **positivamente correlate**
- $\rho(X,Y) < 0 \qquad X,Y$   **negativamente correlate**

###### Proposizione
- $-1 \leq \rho(X,Y) \leq 1$
- $\rho(X,Y) = 1 \quad\Rightarrow \quad X=aY+b \quad a > 0$
- $\rho(X,Y) = -1 \quad\Rightarrow \quad X=aY+b \quad a < 0$

