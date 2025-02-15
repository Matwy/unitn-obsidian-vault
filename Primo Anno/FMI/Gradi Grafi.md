---
date: 2024/06/28
tags: 
Materia: "[[FMI]]"
---

#### Grafo finito
**Def** Un grafo $G$ è detto **grafo finito** se a un numero finito di vertici.
**OSS** ha anche un numero finito di lati.

#### Grado di un grafo
Sia $G=(V, E)$ un grafo finito e sia $v \in V$. Definiamo il **grado** $deg_{G}(V)$ **di** $V$ **in** $G$ ponendo
$$
deg_{G}(V):=|\{e \in E\,|\, v \in e\}|
$$
#### Relazione fondamentale tra gradi dei vertici e numero dei lati di un grafo finito
Sia $G=(V,E)$ un grafo finito. Allora vale 
$$
\sum_{v \in V}deg_{G}(v)=2|E|
$$
##### Lemma delle strette di mano
- In un  grafo finito il numero di vertici di grado dispari è **pari**.

#### Score
Sia $G=(V, E)$ un grafo finito con $n$ vertici. Definiamo lo **score** di $G$, indicandolo con in simbolo $score(G)$, come la $n$-upla di interi uguali ai gradi dei vertici di $G$, visto a meno di riordinamento.

Diremo che lo score di $G$ è in forma canonica, che è unica, se la $n$-upla dei gradi è ordinata in modo non decrescente.

---
**Proposizione**
Siano $G$ e $G'$ due grafi isomorfici. Vale
$$
score(G)=score(G')
$$
Non vale viceversa

---
