---
date: 2024/06/28
tags: 
Materia: "[[FMI]]"
---
## Albero di copertura
Sia $G$ un grafo. Un sottografo $T$ di $G$ si dice **albero di copertura** di $G$ se $T$ è un albero e $V(T)=V(G)$.

**OSS** Se un grafo $G$ ammette almeno un **albero** **di** **copertura** $T$, allora $G$ è connesso. Infatti, $\forall v,v' \in V(G)=V(T)$ esiste un unico cammino $C$ in $T$ che congiunge $v$ con $v'$. Poiché $T$ è un sottografo di $G$, $C$ è anche un cammino in $G$. Segue che $G$ è connesso.

#### Teorema 
Ogni grafo finito e connesso possiede almeno un **albero di copertura.**

#### Lemma Forzatura alla sconnessione
Sia $n \in \mathbb{N}\smallsetminus \{0\}$ e sia $d=(d_{1},\dots,d_{n})\in \mathbb{N}^{n}$. Se vale 
$$
\frac{1}{2}(\sum^{n}_{i=1}d_{i})< n-1
$$
allora tutti i grafi con quello score sono **sconnessi**.

#### Lemma forzatura alla connessione
Sia $n \in \mathbb{N}\smallsetminus \{0\}$ e sia $d=(d_{1},\dots, d_{n}) \in \mathbb{N}^{n}$ tale che $d_{1} \leq \dots \leq d_{n}$
Se vale
$$
d_{1}\geq n-d_{n}-1
$$
Tutti i grafi con questo score sono **connessi**.
