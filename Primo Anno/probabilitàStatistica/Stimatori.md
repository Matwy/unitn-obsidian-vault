---
date: 2024/05/14
tags:
  - statistica
Materia: "[[Probabilità e Statistica]]"
---
## Modello statistico (parametrizzato)
$$
\mathcal{F}= \{f(x;\theta): \theta \in \Theta \}
$$
**Esempio** $\theta \in  \mathbb{R}^{+}$
$f$ è monotona
$X \sim N(\theta, 1)$
$\theta= \mathbb{E}(X)$ 

$T(X_{1}, \dots, X_{n})$ è lo **stimatore**
**Esempio** $T(X_{1}, \dots, X_{n}) = \frac{1}{n}\sum_{i=1}^{n}X_{i}$

$T(x_{1}, \dots, x_{n})$ è la stima
**Esempio** $T(x_{1}, \dots, x_{n}) = \frac{1}{n}\sum_{i=1}^{n}x_{i}$

#### Errore quadratico medio (MSE) (EQM)
$$
\begin{gather*}
MSE(T, \theta) = \mathbb{E}[(T-\theta)^{2}]\\
=\mathbb{E}[(T\pm \mathbb{E}(T) - \theta)^{2}]\\
=\mathbb{E}[((T- \mathbb{E}(T)) + (\mathbb{E}(T)- \theta))^{2}]\\
= \mathbb{E}[(T-\mathbb{E}(T))^{2}]+\mathbb{E}[(\mathbb{E}(T)-\theta)^{2}] + 2\mathbb{E}[((T- \mathbb{E}(T)) + (\mathbb{E}(T)- \theta))]\\
= Var(T) + \mathbb{E}(T-\theta)^{2}
\end{gather*}
$$
$Var(T)$ è l'**errore** **accidentale**
$\mathcal{B}(T,\theta)=E(T)-\theta$ **distorsione**

---
**Esempio**
$T_{2}(X_{1}, \dots, X_{4}) = \frac{X_{1}+X_{2}}{3}$
$\mathbb{E}(T_{2}) = \mathbb{E}\left(\frac{X_{1}+X_{2}}{3}\right)= \frac{2}{3}\theta$
$\mathcal{B}(T_{2}) = -\frac{1}{3}\theta$    Stimatore Distorto
$Var(T_{2}) = \frac{2}{3}Var(X)$

---
## Stimatore Asintoticamente non Distorto
**Def** $T$ è uno **stimatore** di $\theta$ **asintoticamente** **non** **distorto** se 
$$
\lim _{n\to \infty} B(T(X_{1,\dots}, X_{n})) = 0
$$
---

## Stimatore consistente in Media Quadratica ($L_{2}$)
**Def** $T_{n}=T(X_{1}, \dots, X_{n})$     $\{T_{n}\}^{+\infty}_{n=1}$
La successione $T_{n}$ converge in media quadratica a $\theta$ se 
$$
\lim _{n\to \infty} MSE(T_{n}!\theta) = 0
$$
Allora lo stimatore è consistente in **Media** **Quadratica**

---
#### Minimi Quadrati
$X \sim N(\mu, \sigma^{2})$
$$\frac{1}{n}\sum_{i=1}^{n}(|x_{i}-\mu|)^{2}$$ $$
T(x_{1}, \dots, x_{n})=\frac{1}{n}\sum x_{i}=\overline{x}
$$
Quindi $T(X_{1}, \dots, X_{4})= \overline{X}$

$\sigma^{2}= \frac{1}{n}\sum_{i=1}^{n}(x_{i}-\overline{x})^{2}$
$\hat{\mu} = \overline{x}$
#### Metodo dei momenti
$$
\begin{cases}
\mu = \mathbb{E}(X) = \overline{x} &\\
\sigma^{2}\mu^{2}=\mathbb{E}(X^{2}) = \frac{1}{n}\sum ^{n}_{i=1}x_{i}^{2}
\end{cases}
$$
$\hat{\mu}= \overline{x}$
$\hat{\sigma}^{2}= \frac{1}{n}\sum_{i=1}^{n}(x_{i}-\mu)^{2}$

- si confronta il momento teorico con il momento empirico
#### Metodo della Massima Verosimiglianza
- La verosimiglianza è la densità dell'evento congiunto
$$
f_{X_{1},\dots, X_{n}}(x_{1},\dots, x_{n}) = \prod_{i=1}^{n}f_{X_{i}}(x_{i})
$$
##### Esempio con un serie di bernoulliane
- Chiamiamo la log-verosimiglianza
$$
l(p|x) = logL(p;z)=log(p^{\sum{x_{i}}}(1-p)^{n-{\sum{x_{i}}}})
$$
- Una volta semplificata dobbiamo trovare il punto in cui la $p$ è massima
	- essendo derivabile troviamo la derivata e i punti stazionari

