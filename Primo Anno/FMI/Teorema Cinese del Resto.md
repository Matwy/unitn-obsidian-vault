---
date: 2024/06/26
tags: 
Materia: "[[FMI]]"
---
## Teorema Cinese del Resto
Siano $n,m > 0$ e siano $a,b \in \mathbb{Z}$. Consideriamo il seguente sistema di congruenze
$$
\begin{cases}
x \in \mathbb{Z} \\
x \equiv a (mod \,\,\, n)\\
x \equiv b (mod \,\,\, m)
\end{cases}
$$
equivalentemente

$$
\begin{cases}
x \in \mathbb{Z} \\
[x]_{n}=[a]_{n}\\
[x]_{m}=[b]_{m}\\
\end{cases}
$$
Sia $S$ l'insieme delle soluzione del precedente sistema ovvero
$$
S=\langle x \in \mathbb{Z} | x \equiv a (mod \,\,\,n) \,\,e\,\, x \equiv b(mod \,\,\, m)\rangle
$$
Allora il precedente sistema è **compatibile** cioè ammette almeno una soluzione cioè $S \neq \varnothing$ se e soltanto se $(n, m)|a-b$

Se $S \neq \varnothing$ e $c \in S$ allora
$$
S = [x]_{[n,m]} \subset \mathbb{Z}=\langle c+k[n,m] \in \mathbb{Z} | k \in \mathbb{Z}\rangle
$$
## Dimostrazione
#### Compatibilità
- Dobbiamo trovare che
$$
S \neq \varnothing \Leftrightarrow (n,m)| a-b
$$
- Supponiamo che $S \neq \varnothing$ Scegliamo $c \in S$ ovvero $c \equiv a(mod\,\, n) \,\,e\,\, c \equiv b(mod\,\, m)$ ovvero $\exists k,h \in \mathbb{Z} \quad tc\quad c = a+kn$ e $c=b+hm$
- $a+kn=c=b+hm \Leftrightarrow a-b=-kn+hm$
- Ricordiamo che $(n,m)|n$ e $(n,m)|m$ $\Rightarrow (n,m)|a-b$ (per il lemma utile)

- Supponiamo che $(n,m)|a-b$ , ovvero $\exists k \in \mathbb{Z}\quad tc\quad a-b=k(n,m)$
- Grazie all'algoritmo di Euclide con sostituzione "a ritroso" $\exists r,s \in \mathbb{Z}$
$$
(n,m) = rn+sm
$$
Da (1) e (2) segue che $a-b=k(n,m)=k(rn+sm)=(kr)n+(ks)m$
- riassumendo
$$
a-b = (kr)n+(ks)m
$$
che è equivalente
$$
c=a-krn=b+ksm
$$
## Soluzioni
Dobbiamo provare che $S=[c]_{[n,m]} \subset \mathbb{Z}$ dove $c \in S$
$S \subset [c]_{[n,m]}$ Sia $c' \in S$ Poichè $c \in S$ valgono
- $c \equiv a(mod\,\,\,n) \Leftrightarrow c = a+kn$ per qualche $k \in \mathbb{Z}$
- $c \equiv b(mod\,\,\,m) \Leftrightarrow c = a+hm$ per qualche $k \in \mathbb{Z}$
- $c' \equiv a(mod\,\,\,n) \Leftrightarrow c' = a+kn$ per qualche $k \in \mathbb{Z}$
- $c' \equiv a(mod\,\,\,m) \Leftrightarrow c' = a+hm$ per qualche $k \in \mathbb{Z}$

Possiamo fare $c'-c=(k'-k)n$ e quindi $n|c'-c$
Ugualmente $c'-c=(h'-h)m$ e quindi $m|c'-c$

- $n|c'-c$ e $m|c'-c$ $\Rightarrow$ $[n,m]|c'-c$
- quindi $c'\equiv c(mod\,\,\,[n,m]) \Leftrightarrow c' \in [c]_{[n,m]}$
- $\Rightarrow S \subset [c]_{[n,m]}$

Sia $c' \in [c]_{[n,m]}$ ovvero $c'=c+k[n,m]$ per qualche $k \in \mathbb{Z}$
$$
\begin{gather*}
\Rightarrow [c']_{n}=[c+k(n,m)]_{n}=\\
[c]_{n}+[k]_{n}[[n,m]]_{n}=\\
[a]_{n}+[k]_{n}[0]_{n}=\\
=[a+k*0]_{n}=[a]_{n}
\end{gather*}
$$
poi fa la stessa cosa con m ma non ho capito
$c \in S \Rightarrow [c]_{[n,m]} cs.$

