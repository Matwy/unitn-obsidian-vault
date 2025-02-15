---
date: 2024/06/28
tags: 
Materia: "[[FMI]]"
---
## Cancellare un vertice
**Def** Sia $G=(V,E)$ un grafo con almeno due vertici e sia $v \in V$.
Definiamo il grafo $G-v$ detto **grafo ottenuto da G cancellando il vertici $v$** ponendo
$$
V(G-v):=V\setminus \{v\}, \quad E(G-v):= \{e \in E \,|\, v \notin e \}
$$
## 2-connessione
Un grafo $G$ si dice **2-connesso** se ha almeno tre vertici e, $\forall v \in V(G)$, $G-v$ è connesso.

#### Lemma 
Ogni grafo **2-connesso** è anche **connesso**.
falso viceversa

## Grafo Hamiltoniano
**Def** sia $G$ un grafo. Un ciclo in $G$ che attraversa tutti i vertici di $G$ è detto **ciclo hamiltoniano** in $G$. Se $G$ ammette almeno un ciclo hamiltoniano allora $G$ è detto **grafo hamiltoniano**.

**OSS** Un grafo hamiltoniano è finito e possiede almeno tre vertici.
![[Pasted image 20240628163447.png|center|400]]

#### Lemma
Un grafo **hamiltoniano** è sempre **2-connesso**.
viceversa no
