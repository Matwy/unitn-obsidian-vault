---
date: 2024/04/19
tags:
  - "#valoreatteso"
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---
**Esempio** In una partita di calcio vengono segnati in media 2.5 goal
Approssimazione: divido la partita da 90' in 5 parti uguali da 18'
In ogni periodo c'è $p=\frac{1}{2}$ che sia segnato un goal.
$X= \text{numero di gol}$
$X\sim bin(5,\frac{1}{2})$

Possiamo ad esempio dividere in 10 periodi
$$
\to n=10 \quad p=\frac{1}{4} \quad X\sim bin\left(10,\frac{1}{4}\right) \quad \mathbb{E}[X]=2.5
$$

$$
\to n=180 \quad p=\frac{1}{72} \quad X\sim bin\left(180,\frac{1}{72}\right) \quad \mathbb{E}[X]=2.5
$$
----
**Esempio** Mail mandate in USA in 1 giorno
media $\sim 10.000.000.000$

**Lemma** $X_{n} \sim bin (n,p)$
$np_{n}\to \lambda$ quando $n\to \infty$

$$
\Rightarrow \lim_{n\to \infty} \mathbb{P}(X_{n}=k) =  \frac{\lambda e^{-\lambda}}{n!} \quad \forall k \in \mathbb{N}
$$
## Distribuzione di Poisson
**Def** $X$ v.a. discreta è di **Poisson** di parametro $\lambda > 0$ se ha densità discreta:
$$
\phi_{x}(k)= \begin{cases}
\frac{\lambda^{k}}{k!}e^{-\lambda} & k \in \mathbb{N} \\
0 & altrimenti
\end{cases} 
$$
**Notazione** $X \sim Pois(\lambda)$    
In R $\phi_{x}(k) = dpois(k, \lambda)$
$F{x}(k) = ppois(k, \lambda)$

##### Proprietà
1) $\sum_{n=0}^{\infty} \frac{\lambda^{n}}{n!}e^{-\lambda} =1$
2) $\mathbb{E}[X]=\lambda$
3) $X_{1}\sim Pois(\lambda_{1}), X_{2}\sim Pois(\lambda_{2})$
	$X_{1}, X_{2}$ indipendenti allora $X_{1}+X_{2}\sim Pois(\lambda_{1}+\lambda_{2})$


$E[X^{2}]= \lambda^{2}+\lambda$
$Var[X] = E[X^{2}]-\lambda^{2}=\lambda$
[[dispensapdf.pdf#page=166&selection=209,0,210,0|Somma condizionata riconducibile a binomiale]]
