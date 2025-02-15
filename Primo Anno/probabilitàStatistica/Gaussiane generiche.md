---
date: 2024/05/08
tags:
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---
## Gaussiane generiche
**Def** Sia $Z \sim N(0,1)$ Chiamiamo **normale** o **Gaussiana** di parametri $\mu \in \mathbb{R},\,\sigma^{2} \in \mathbb{R}_{+}\setminus \{0\}$ una v.a. $X$ tale che
$$
X = \sigma Z + \mu
$$
**Notazione** $X \sim N(\mu, \sigma^2)$ 

#### Densità
$$
f_{X}(x)=\frac{1}{\sigma\sqrt{2\pi}}\cdot e^{- \frac{(x-\mu)^2}{2\sigma^{2}}} 
$$
#### CDF
 $$
F_{X}(x)=\phi(\frac{x-\mu}{\sigma})
$$
#### Indicatori
- $\mathbb{E}[X] = \sigma \mathbb{E}[Z] + \mu = \mu$
- $Var[X]=\sigma^{2}Var[Z] = \sigma^{2}$

#### Proprietà Riproducibilità
$X \sim N(\mu,\sigma^{2})$
$X_{2} \sim N(\mu_{2},\sigma^{2}_{2})$ indipendenti
allora
$\Rightarrow X_{1}+X_{2} \sim \mathbb{N}(\mu_{1}+ \mu_{2}, \sigma_{1}+\sigma_{2})$

#### In R
$f_{X}(x) =$ `dnorm(x, mean=0, sd=1)` dove `sd` è la deviazione standard
$F_{X}(q)=$ `pnorm(q, mean=0, sd=1)` 
$\phi(x) =$ `pnorm(x)`
 