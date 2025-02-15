---
date: 2024/03/25
tags: 
Materia: "[[FMI]]"
---
$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
## Divisibilità
**DEF 9.1** Siano $n, m \in \Z$ Diciamo che $n$ è un divisore di $m$ o equivalentemente che $m$ è un multiplo di $n$ se $\exists k \in \Z \quad tc\quad nk =m$
Si indica con $n|m$
**Esempio** 
1) $\forall n \in \Z$, $n|0$ per ogni $n$ allora $0\nmid n$ si ha inoltre che $\pm 1 |n$ e $\pm n | n$ per ogni $n$

**Proposizione 9.3** Siano $m,n,q \in \Z$
Allora valgono
(1) $n|m$ e $m|q$ $\Rightarrow n|q$
(2) $n|m$ e $m|n$ $\Rightarrow n=m$ oppure $n=-m$

## Massimo Comune Divisore
**DEF 9.5 (9.7)** Siano $n,m \in \Z$ non **entrambi** **nulli**
Si dice che $d \in \N \quad tc\quad d>0$ 
è un **MCD**, tra $n$ e $m$ se ha le seguenti proprietà:
- (1) $d|n$ e $d|m$
- (2) Se $c \in \Z \quad tc\quad c|n \quad e \quad c|m$ allora $c|d$
**Proposizione 9.6** Siano $n,m \in \Z$ non entrambi nulli.
Se esiste un $MCD$ tra $n$ e $m$ allora è $!$
Ovvero se $\exists d, d' \quad tc\quad d>0, d'>0$ 
valgono la (1) e la (2)
Allora $d=d'$

## Lemma Utile
Siano $c, n, m \in \Z \quad tc\quad c|n \,\,e\,\, c|m$
Scegliamo arbitrariamente $x,y \in \Z$ Allora $c|(xn+ym)$
**DIM** 
$c|n \LeftrightArrow \exists k \in \Z \quad tc\quad n = kc$ 
$c|m \LeftrightArrow \exists k \in \Z \quad tc\quad m = kc$ 

## Teorema 9.8
Dispensa [[Dispensa FMI.pdf#page=28&selection=767,0,779,8|Dispensa FMI, page 28]]
Siano $n,m \in \Z$ non entrambi nulli. Allora $\exists ! MDC \, tra\,\, m\,\, e m$
**Corollario 9.8** Siano $n,m \in \Z$ non non etrambi nulli
Allora 
$$
(n,m) = xn+ym\quad \text{per qualche } x,y \in \Z
$$
**OSS 9.8** Siano $n,m \in \Z$
(1) La divisibilità tra $n$ e $m$ non dipende dal loro segno:

**OSS** 
$$
(n,m)=(m,n)
$$
(2) 
$$
(n,m) = (|n|,|m|) = max\{c \in \Z|\, c|n \,\,e\,\, c|m\}
$$

(3) Per ogni $n \in \Z \setminus \{0\}$, vale
$$
(m,0) = (|n|, 0) = |n|
$$
## Numeri Comprimi
**DEF 9.10** $n, m \in \Z$ non entrambi nulli si dicono **coprimi** se (n, m) = 1
**OSS 9.11** Siano $n,m \in \Z$ non entrambi nulli
Le seguenti affermazioni sono equivalenti
(1) $(n,m) = 1$
(2) $\exists x, y \in \Z \quad tc\quad xn+ym = 1$

**Proposizione 9.12** Siano $n,m \in \Z$ non entrambi nulli e sia $d$ il loro $MCD$
Allora $\left(\frac{n}{d}, \frac{m}{d}\right)= 1$

## Minimo comune multiplo
**DEF 10.3** Dati $n,m \in \mathbb{Z}$ e $M \in \mathbb{Z} \quad tc\quad M \geq 0$ e che $M$ è un **minimo** **comune multiplo** tra $n$ e m se 
- **(1)** $n|M$ e $m|M$
- **(2)** se $c \geq$ è $\quad tc\quad$ $n|c$ e $m|c$ allora $M|c$

**OSS** Se **mcm** esiste allora è unico !

---
Supponiamo che $\exists M \geq 0$, $M' \geq 0$ che soddisfa (1) e (2)
- $M'$ soddisfa (1) => (2) con $M$ e $c:=M'$ => $M|M'$
- $M$ soddisfa (1) => (2) con $M'$ e $c:=M'$ => $M'|M$
Quindi $M'=\pm M$   $M\geq 0$   e $M'\geq 0$
$M = M'$
**DEF 10.4** Dati $n,m \in \mathbb{Z}$ se l'mcm tra $n$ ed $m$ esiste allora
$$
[n,m] = [m,n]=[|n|, |m|]
$$
---
**OSS** $n=m=0$, $\exists M \in \mathbb{Z}\quad tc\quad 0|M\,e\,0|M$ <=> $M=0$
Quindi il $mcm$ tra $0$ e $0$ è $0$

---
### Teorema 10.4
Dati $n,m \in \mathbb{Z}$ l'$mcm$ tra $n$ e $m$ esiste sempre ed è unico
Inoltre valgono:
- $n=m=0$ => $[0,0]$ = 0
- Se $n$ e $m$ non sono entrambi nulli, allora $[n,m]=\frac{nm}{(n,m)}$
