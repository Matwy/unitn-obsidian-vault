---
date: 2024/06/28
tags: 
Materia: "[[FMI]]"
---
## Alberi
**Def** Un grafo si dice **albero** se è connesso e non ha cicli. Una **foresta** è un  grafo senza cicli.

#### Teorema
Sia $T=(V,E)$ un grafo (non necessariamente finito). Le seguenti affermazioni sono equivalenti
- $T$ è un albero
- $\forall v,v' \in V$, esiste un unico cammino in $T$ che congiunge $v$ a $v'$
- $T$ è connesso e, $\forall e \in E$, il grafo $T-e$ è sconnesso
- $T$ non ha cicli e, per ogni $e \in \binom{V}{2}\setminus E$, il grafo $T+e$ ha almeno un ciclo

---
#### Lemma
Sia $T$ un albero finito avente almeno due vertici. Allora $T$ possiede almeno due foglie.

---
#### Teorema
Sia $T=(V,E)$ un grafo finito. Le seguenti affermazioni sono equivalenti.
- $T$ è un albero
- $T$ è connesso e soddisfa la seguente formula di **Eulero**
$$
|V|-1=|E|
$$
**Corollario** Sia $n \in \mathbb{N} \smallsetminus \{0\}$ e sia $d=(d_{1},\dots,d_{n}) \in \mathbb{N}^{n}$
si può applicare solo se non ci sono zeri
Allora esiste un albero con score $d$ se e soltanto se
$$
n-1=\frac{1}{2}(\sum_{i=1}^{n}d_{i})
$$
**OSS**
- $n \geq 2$
- $d_{1}=1$
- $d_{2}=1$
- se lo score ha solo uni allora $n=2$
