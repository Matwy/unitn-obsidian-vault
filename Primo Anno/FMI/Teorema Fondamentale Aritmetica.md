---
date: 2024/04/04
tags: 
Materia: "[[FMI]]"
---

## Teorema Fondamentale Aritmetica
Dispensa: 
**Teorema** **10.5**
Ogni numero naturale $n\geq 2$ può essere fattorizzato in numeri primi,
ovvero: $n=p_{1}p_{2}\dots p_{a}$ eventualmente ripetuti, e tale insieme di numeri primi è unico (si dice che tali primi sono unici a meno di riordinamento, ovvero se $\exists$ altri numeri primi $q_{1} 1_{b} \quad tc\quad n=q_{1}\dots q_{b}$, allora $a=b$ e $\exists\, Q:\{1,\dots, b \} \to \{1, \dots, a$\} bigezione $\quad tc\quad q_{i} = q_{\phi_{i}}$ $\forall i \in \{1,\dots, b\}$ )

**DIM** **ESISTENZA** Procediamo per induzione di 2nd forma
$n=2$ (base induzione) $n=2$ ,  $2$ è un numero $a=1, p_{1}:=2$
- $n>2$, $\forall k$, $2\leq k < n \Rightarrow n$ **passo induttivo**

Sia $n>2$ Assumiamo di saper fattorizzare ogni $k \in \mathbb{Z}$
$\quad tc\quad 2 \leq k < n$ (**ipotesi induttiva**) OSS che, se $n$ è z primo allora $a=1$, $p_{1}:=n \Rightarrow n=p_{1}$
Supponiamo che $n$ **non** sia **primo**
Allora $n=d_{1}d_{2} \quad tc\quad 2 \leq d_{1} < n$, $2\leq d_{2}<n$ 
Dunque, $a d_{1} a d_{2}$ si può applicare **l'ipotesi induttiva**
$$
d_{1}=p_{1}\dots, p_{a} \quad d_{2}=p_{a+1},\dots, p_{b}
$$
$$
n=d_{1}d_{2} = p_{1},\dots, p_{b}
$$
Il passo induttivo è stato fatto. Grazie al principio di induzione di seconda forma shiftato in 2 ogni $n\geq 2$ ammette una fattorizzazione.

**DIM UNICITA'** Siano $n\geq 2, \, \, p_{1,}p_{a}, p_{b}$ primi
eventualmente ripetuti t.c.
$$n=p_{1}, p_{2},\dots, p_{b} \Rightarrow p_{1}p_{a}=q_{1}q_{b}$$
A meno di scambiare a  con b possiamo sempre supporre $a \leq b$

---
Procediamo per induzione di prima forma su $a\geq1$
- **base induzione** $a=1$   Siano $b\geq 1$, $p_{1},q_{1},q_{2},\dots q_{b}$ primi $\quad tc\quad p_{1}=q_{1}\dots q_{b}$
	$\Rightarrow b=1$ 
		supponiamo per **assurdo** che $b\geq 2$ :
		$p_{1} = (a_{1})(q_{2},\dots, q_{b})$  Questo è impossibile perchè $p_{1}$ è primo per ipotesi
		quindi $b=1$
- $a \geq 1$ $a \Rightarrow a+1$ (**passo induttivo**) Sia $a\geq 1$ Assumiamo che valga:
	$\forall b\geq a, \forall p_{1},\dots p_{b}, q_{1}, q_{b}\, primi$ $\quad tc\quad p_{1}\dots p_{a} = q_{1}\dots q_{b}\Rightarrow$
	$\Rightarrow a = b$ e almeno di
# TODO
---
**Corollario 10.6** L'insieme dei **numeri** **primi**  è **infinito**.
**DIM**  Supponiamo che esiste $a \in \mathbb{N} \quad tc\quad \{p_{1}, \dots p_{a}\}$ sia l'insieme di tutti i numeri primi.
Definiamo $n \in \mathbb{N}$ ponendo
$$
n = p_{1}p_{2}\dots, p_{a}+1 
$$
Per ogni $i \in \{1,,a\}$ vale:
$$
\begin{cases}
n=(p_{1}, p_{2}, p_{i-1}, p_{i+1}, p_{a})p_{i}+1 \\
0\leq 1 < p_{i}, \quad perchè \,\, p_{i}\geq 2
\end{cases}
$$
Per unictià del quoziente e del resto della divisione e il resto della divisione di $n$ per ogni fissato numero peporcodio
