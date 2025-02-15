---
date: 2024/06/26
tags: 
Materia: "[[FMI]]"
---
## Congruenza modulo n
Sia $n \in \mathbb{Z}$
Dati $a,b \in \mathbb{Z}$, diciamo che $a\equiv b(mod\, n)$ se $n|a-b$

**Esempio**
- $5 \equiv 3 (mod \, 4) \Leftrightarrow 4| 5-3 = 2$ **falso**
- $16 \equiv 2 (mod \, 7) \Leftrightarrow 7|16-2$**vero**

**prop** La relazione di esser congrui modulo n è una relazione di equivalenza su $\mathbb{Z}$

## Classi di equivalenza
**Def 11.6** Sia $X$ insieme e sia $\sim$ una relazione di equivalenza su $X$
Fissiamo $x \in X$. Definiamo la classe di equivalenza di $x$ in $X$ rispetto a $\sim$ come il seguente sottoinsieme $[x]_{\sim}$ di $X$ :
$$
[x]_{\sim} := \{y \in X \,|\, y \sim x\}
$$
Definiamo l'insieme quoziente di $X$ modulo $\sim$ come l'insieme i cui elementi sono tutte e sole le classi di $\sim$-equivalenza di tutti i punti $x$ di $X$ che denoteremo $X/\sim$
ovvero
$$
X/\sim  =\{[x]_{\sim} \in 2^{X} | x \in X\}
$$
- $[x]_{\sim}$ è un elemento ora

**Proposizione** Sia $X$ un insieme e sia $\sim$ una relazione di equivalenza su $X$. Valgono le seguente affermazioni
- $\forall x \in X,\quad x \in [x]_\sim$
- $\forall x,y \in X, \quad [x]_{\sim} = [y]_{\sim}$ se e soltanto se $x\sim y$
- $\forall x,y \in X, [x]_{\sim} \cap [y]_{\sim} \neq \varnothing \Rightarrow [x]_{\sim}= [y]_\sim$

## Classi di congruenza
Sia $n \in \mathbb{Z}$ Indichiamo con $\sim_{n}$ la relazione di congruenza modulo $n$ su $\mathbb{Z}$ ovvero 
$a \sim_{n}b$ con $a,b \in \mathbb{Z}$ se $a \equiv b (mod\,\, n)$
Per ogni $a \in \mathbb{Z}$ la classe di $\sim_{n}$-equivalenza di $a$ in $\mathbb{Z}$ si dice **CLASSE DI CONGRUNZA DI $a$ modulo $n$** e si indica con il simbolo $[a]_{n}$ (invece di $[a[_{\sim n}$)

![[Pasted image 20240626145536.png]]