---
date: 2024/05/08
tags: 
Materia: "[[Probabilità e Statistica]]"
---
# Teoremi limite

## Successione di variabili aleatorie  
$(X_{n})_{n \in \mathbb{N}}$ 
$X_{n}: \Omega \to \mathbb{R}$

- Una successione di variabili aleatorie la possiamo considerare come una successione di funzioni
	- Proviamo a fissare un valore $\omega$ 
	- $\omega \in \Omega$           $\lim_{n\to \infty} X_{n}(\omega)=X(\omega)$
	- E speriamo che il limite converga ad una variabile $X$ valutata in $\omega$  

**Def** $(X_{n})_{n \in \mathbb{N}}$  successione di v.a., $X$ v.a.
$X_{n}$ **converge quasi certamente** a $X$ se  
$$
\mathbb{P}(\lim_{n\to\infty} X_{n}=X) = 1
$$
In altre parole
$$
\mathbb{P}(\{\omega\,|\,\lim_{n\to \infty} X_{n}(\omega)=X(\omega)\})=1
$$
#### Notazione
$$
X_{n} \xrightarrow[n \to \infty]{\text{q.c}} X
$$
---
**Def** $X_{n}$ **converge** **in** **probabilità**  a $X$ se 
$$
\lim_{n\to0}\mathbb{P}(|X_{n}-X| > \epsilon) = 0 \qquad \forall \epsilon > 0
$$
#### Notazione
$X_{n}$ converge in probabilità per $n\to \infty$  
$$X_{n} \xrightarrow[n\to \infty]{P}X$$
$$P(\{\omega \in \Omega \, |\, |X_{n}(\omega)-X(\omega)| >  \epsilon\}) = 0$$
---
**Def** $(X_{n})_{n \in \mathbb{N}}$  successione di v.a. **converge in media quadratica** a $X$ se
$$
\lim_{n\to \infty} \mathbb{E}[|X_{n}-X|^{2}]=0 
$$
#### Notazione
$$
X_{n} \xrightarrow[n\to \infty]{L^{2}}X
$$
---
## Capiamo
- Se $X_{n}$ converge **quasi certamente** allora converge anche in probabilità
$$
X_{n} \xrightarrow[]{q.c}X \quad\Longrightarrow \quad X_{n} \xrightarrow[]{P}X
$$
- Se $X_{n}$ converge **in media quadratica** allora converge anche in probabilità
$$
X_{n} \xrightarrow[]{L^2}X \quad\Longrightarrow \quad X_{n} \xrightarrow[]{P}X
$$

- Se $X_{n}$ converge **in probabilità** allora converge anche in distribuzione
$$
X_{n} \xrightarrow[]{P}X \quad\Longrightarrow \quad X_{n} \xrightarrow[]{d}X
$$
![[Pasted image 20240509155818.png|center|600]]

---
**Def** Diciamo che $X_{n}$ **converge in legge** o **in distribuzione** o **debolmente** a $X$ se
$$
\lim_{n\to\infty} F_{X_{n}}(x)=F_{X}(x) \qquad \forall x \in \mathbb{R}
$$
ossia 
$$
\lim_{n\to\infty} \mathbb{P}(X_{n} \leq x) = \tilde{\mathbb{P}}(X \leq q) \qquad \forall x \in \mathbb{R}
$$
#### Notazione
$$
X_{n} \xrightarrow[]{d}X \qquad \text{oppure}\qquad  X_{n} \xrightarrow[]{\mathscr{L}}X
$$
---
## Teoremi Limite
$X_{1}, \dots, X_{n}$  v.a. indipendenti di media $\mu$ , varianza $\sigma^{2}$ 
e la loro somma è $S_{n} = \sum_{i=1}^{n}X_{i}$
$\mathbb{E}\left[\frac{S_{n}}{n}\right]= \mu$
$Var\left[\frac{S_{n}}{n}\right]= \frac{\sigma^{2}}{n}$
#### Teorema Legge debole dei grandi numeri
$(X_{n})_{n \in \mathbb{N}}$ successione di v.a. indipendenti di media $\mu$ , varianza $\sigma^{2}$ 

Allora $$\frac{S_{n}}{n} \xrightarrow[n\to \infty]{P} \mu$$
#### Teorema centrale del limite CLT
$(X_{n})_{n \in \mathbb{N}}$ successione di v.a. indipendenti di media $\mu$ , varianza $\sigma^{2}$ 
$S_{n}= \sum_{i=1}^{n}X_{i}$ 
Allora: $$
\frac{S_{n}-\mu n}{\sigma\sqrt{n}} \xrightarrow[n\to \infty]{d}N(0,1)
$$
In altre parole $$
\lim_{n\to\infty} \mathbb{P}\left(\frac{S_{n}-\mu n}{\sigma\sqrt{n}}\right)=\phi(x)
$$
**OSS** Nella pratica, se "n è grande" 
$$
\mathbb{P}\left(\frac{S_{n}-\mu n}{\sigma\sqrt{n}}\leq X\right)\approx\phi(X)
$$
$$
S_{n} \approx N(\mu n, \sigma^{2}n)
$$
alla fine di sto casino si usa effettivamente questa:
$$
\mathbb{P}(S_{n} \leq  y) = F_{S_{n}}(y) \approx \Phi\left(\frac{y+\frac{1}{2}-n\mathbb{E}[X_{1}]}{\sqrt{n}\sqrt{Var[X_{1}]}}\right) $$
