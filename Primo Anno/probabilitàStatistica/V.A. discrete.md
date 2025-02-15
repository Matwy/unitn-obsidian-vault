---
date: 2024/04/05
tags:
  - probabilità
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---
## Trasformazioni
### Trasformazioni lineari
**Proposizione** $X$ variabile aleatoria discreta $Y=aX+b\quad a\neq 0,\quad b \in \mathbb{R}$
Allora $\forall y \in \mathbb{R}$    $\phi_{y}(y) = \phi_{X}(\frac{y-b}{a})$

-  $a>0$  $F_{y}(y) = F_{x}\left(\frac{y-b}{a}\right)$
-  $a<0$  $F_{y}(y) = 1-F_{x}\left(\frac{y-b}{a}\right)+ \phi_{x}(\frac{y-b}{a})$

### Trasformazioni non lineari
 $g:\mathbb{R}\to \mathbb{R}$   $X$ variabile aleatoria   $Y = g(x)$
 $g$ non necessariamente iniettiva o suriettiva quindi 
$$\begin{align*}
$\phi_{Y}(y) = \mathbb{P}(y=y) = \mathbb{P}(g(x)=y)$\\
= \sum_{x \in \mathcal{R}x \cap g^{-1}\{y\}}\phi_{x}(x)
\end{align*}$$**Esempio**  
$X=D_{4}$ dado da 4
$Y=|X-2|$
$\mathcal{R}y=\{1,2,0\}$

$\phi_{y}(0) = \phi_{x}(2) = \frac{1}{4}$
$\phi_{y}(2)=\phi_{x}(4)=\frac{1}{4}$
$\phi_{y}(1) = \phi_{x}(1)+\phi_{x}(3) = \frac{1}{4}+\frac{1}{4}= \frac{1}{2}$




## Bernoulliane
**Def** $X$ variabile aleatoria discreta si dice **Bernoulliana** di parametro $p$ con $p \in [0,1]$ se:
 $$ 
PMF\quad \varphi_{x}(x)=\begin{cases}
p&x=1 \\
1-p&x=0 \\
0 & altrimenti
\end{cases}
$$
equivalentemente
$$
CDF\quad F_{x}(x)=\begin{cases}
0&x < 0 \\
1-\mathbb{P}&0\leq x < 1 \\
1 & 1\leq x
\end{cases}
$$
**OSS** $X$ **Bernoulli** $\Longleftrightarrow I_{E}$    $E = \text{"successi"}$
$\sigma(X)=\{\varnothing, \Omega , E, E^{c}\}$
$X$ può essere definita sulla spazio $\Omega \{0,1\}, \mathcal{P}(\Omega )$
$\mathbb{P}(\{0\})=1-p$   $P(\{1\})=p$

## Vettori aleatori (Discreti)
Vogliamo trattare assieme $2$ variabili aleatorie $X$ e $Y$ su $(\Omega, \mathcal{F}, \mathbb{P})$
**Esempi** $\mathbb{P}(x < y)$   $\mathbb{P}(|x+y| > 1)$

**Def** Si chiama **coppia di variabili aleatorie** oppure **variabili aleatorie doppie** oppure **vettore aleatorio di dimensione 2** la funzione
$$
V:\Omega \to R^{2} \quad V(w)=(X(w), Y(w))
$$
- Se $X, Y$ **discrete**
	- $\mathcal{R}v = \mathcal{R}_{X}\times \mathcal{R}_{Y}= \{(x,y|x \in \mathcal{R}_{X}, y \in R_{Y}\}$
	- Sia $(X,Y)$ una v.a doppia, la sua **funzione di ripartizione** è
			$F_{X,Y}((x,y)) = F_{X,Y}(x,y)=\mathbb{P}(X \leq x, Y \leq y)$
			$\forall x,y \in \mathbb{R}^{2}$
**OSS** Si può generalizzare a qualsiasi dim $\geq 1$
- Sapere $F_{X,Y}$ ci dice sia $F_{X}$ che $F_{Y}$

$$
\begin{gather*}
F_{X}(x) = \mathbb{P}(X \leq x)=\mathbb{P}(X \leq x, \forall Y)\\
=\mathbb{P}(X \leq x, Y < +\infty)\\
= \lim_{y\to +\infty}\mathbb{P}(X \leq x, Y \leq y)\\
=\lim_{y\to+\infty}F_{X,Y}(x,y)
\end{gather*}
$$
**Esempio** Urna con 2 palline Rosse $R$ e $2B$
Estraiamo una pallina $X=I_B$
estraendo un'altra pallina $Y=I_{B}$
 Caso 1 Reinserimento
$F_{XY}(0,0)=\mathbb{P}(x \leq 0, y \leq 0) = \mathbb{P}(x=0, y=0)$ $=\mathbb{P}(R_{1}, R_{2}) = \frac{1}{2}\cdot \frac{1}{2}=\frac{1}{4}$ 

$F_{X,Y}(0,1) = \mathbb{P}(x \leq 0, y \leq 1) = \mathbb{P}(x \leq 0) = \frac{1}{2}$
$F_{X,Y}(1,1) = 1$

Guardando il piano generato da $X,Y$ dall'alto

![[Pasted image 20240405130241.png|center|400]]

### Densità
**Def** $X,Y$ sono v.a. discrete su $(\Omega , \mathcal{F}, \mathbb{P})$
- Si dice **densità** **congiunta** di $X$e $Y$ la funzione
$$
\begin{align*}
\phi_{X,Y}=\mathbb{R}^{2} \to [0,1] \quad tc\quad \\
\phi_{X,Y}(x,y) = P(X=x,Y=y) \quad \forall (x,y) \in \mathbb{R}^{2}
\end{align*}
$$
- Si dice **densità** **condizionale** di $X$ data $Y$ 
$$
\phi_{X|Y}(x|y) =\begin{cases}
\mathbb{P}(X=x|Y=y) & y \in \mathcal{R}y \\
0 & y \notin Ry
\end{cases}
$$

#### Proprietà 
1) $0 \leq \phi_{x,y}(x,y) \leq 1 \quad \forall x,y \in \mathbb{R}^{2}$
2) $\phi_{x,y}(x,y) = 0$ se  $(x,y) \notin \mathcal{R}_{x,y} = \mathcal{R}_{x} \times \mathcal{R}_y$
3) $\sum_{(x,y) \in \mathcal{R}_{x,y}}\phi_{x,y}(x,y) = 1$
4) $F_{x,y}(x,y)= \sum_{(x,y) \in \mathcal{R}_{x,y}} I_{\{x \leq x_{0}\}}I_{\{y \leq y_{0}\}}\phi_{x,y}(x,y)$
5) $\phi_{xy}(x,y) = \phi_{x|y}(x|y)\phi_{y}(y)=\phi_{y|x}(y|x)\phi_{x}(x)$
6) $\phi_{x}(x) = \sum_{y \in \mathcal{R}_{y}} \phi_{x,y}(x,y)$
---
### Marginali
**Def** Chiamiamo $\phi_{x}$ e $\phi_{y}$ le **densità** **marginali** o **distribuzioni** **marginali** di $(x,y)$ oppure di $\phi_{x,y}$

**OSS** Sapere $\phi_{x,y}$ ci dice chi sono $\phi_{x}$ e $\phi_{y}$ ma viceversa non è vero
### Indipendenza
Spazio di probabilità generico fissato $(\Omega, \mathcal{F}, \mathbb{P})$
**Def** Siano $\mathcal{F}_{1},\mathcal{F}_{2}$ $\sigma$ algebre $\leq \mathcal{F}$
Allora $\mathcal{F}_{1}$ e $\mathcal{F}_{2}$ sono **indipendenti** se tutti gli eventi di $\mathcal{F}_{1}$ sono indipendenti da $F_{2}$
Tradotto in matematichese:
$$
\begin{gather*}

\forall E_{1}\in \mathcal{F}, \forall E_{2} \in \mathcal{F}_{2}\\
\mathbb{P}(E_{1} \cap E_{2}) = \mathbb{P}(E_{1})\mathbb{P}(E_{2}) 
\end{gather*}
$$
**Def** $X,Y$ v.a. sono **indipendenti** se le loro $\sigma$ algebre sono **indipendenti**
Quindi $\sigma(x)$ e $\sigma(y)$ sono indipendenti

**Proposizione** $X,Y$ v.a. sono **indipendenti**
$\Leftrightarrow F_{x,y}(x,y) =F_{x}(x)\cdot F_{y}(y)$

==$\Leftrightarrow \phi_{x,y}(x,y) = \phi_{x}(x)\phi_{y}(y) \quad \forall (x,y) \in \mathbb{R}^{2}$==
$\Leftrightarrow \phi_{x}(x) = \phi_{x|y}(x|y)$

**OSS** Se $x,y$ indipendenti allora $\phi_{x}$ e $\phi_{y}$ determinano univocamente $\phi_{x,y}$

##### Proposizione somma v.a. discrete
$X,Y$ v.a. discrete
Allora $$
\begin{gather*}

\phi_{X+Y}(Z) = \sum_{x \in \mathcal{R}_{x}} \phi_{X,Y}(X,Z-X)\\
= \sum_{y \in \mathcal{R}_{y}} \phi_{X,Y}(Z-Y, Y)
\end{gather*}
$$


