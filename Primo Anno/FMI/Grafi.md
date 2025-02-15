---
date: 2024/06/28
tags: 
Materia: "[[FMI]]"
---
## Grafi
Dato un insieme $V$ indichiamo con $\binom{V}{2}$, che si legge "V su 2", l'insieme i cui elementi sono tutti i sottoinsiemi di $V$ con $2$ elementi (anche detti $2$-sottoinsiemi di $V$) ovvero
$$
\binom{V}{2}:=\{A \in 2^{V}\,|\,|A|=2\}
$$
**Esempi**
- Se $V=\varnothing$ oppure se $V$ è un singoletto allora $\binom{V}{2}=\varnothing$
- Se $V=\{a,b\}$ allora $\binom{V}{2}=\{V\}=\{\{a,b\}\}\Rightarrow|\binom{V}{2}|=1$
- Se $V=\{a,b,c\}$ allora $\binom{V}{2}= \{\{a,v\},\{a,c\}, \{b,c\}\} \Rightarrow |\binom{V}{2}|=3$

Vale la formula seguente
$$
\begin{cases}
|\binom{V}{2}| = \binom{|V|}{2}=\frac{|V|!}{2!(|V|-2)!}=\frac{|V|!(|V|-1)}{2} \\
\text{se} \,\,\, |V|\geq 2
\end{cases}
$$
---
**Def** Un **grafo** $G$ è una coppia $(V, E)$ dove $V$ è un insieme non vuoto detto **insieme dei vertici di $G$** e $E$ è un sottoinsieme di $\binom{V}{2}$, detto **insieme dei lati di $G$**.

Se $G=(V,E)$ è un grafo ed $e=\{V_{1}, V_{2}\}\in E$ cioè è un lato di $G$ allora diciamo che $V_{1},V_{2}$ sono gli **estremi** di $e$ ed anche che $e$ congiunge $V_{1}$ e $V_{2}$

Se $G$ è un **grafo** allora $V(G)$ indica l'insieme dei **vertici** di $G$ e $E(G)$ dei **lati** di $G$

![[Pasted image 20240628121608.png|center|500]]

---
## Cammino
- Per ogni $n \in \mathbb{N}$ definiamo il **cammino $P_{n}$ di lunghezza $n$** come il seguente grafo
$$
\begin{gather*}
V(P_{n}) = \{0,1,...,n\}; \,E(P_{n})=\varnothing \quad se\,\, n=0\\
E(P_{n}):=\{\{i, i+1\} \in \binom{V(P_{n})}{2}\,|\, i \in \{0,\dots,n\}\}
\end{gather*}
$$
![[Pasted image 20240628122413.png|center|400]]
##### Cammino infinito
**OSS** $|E(P_{n})|=n$
- $P_{\infty}$ il **cammino** **infinito**

##### Ciclo $C_{n}$
- Per ogni $n \in \mathbb{N}$ con $n \geq 3$ il ciclo $C_{n}$ di **lunghezza** $n$ è definito ponendo
$$
\begin{gather*}
V(C_{n})=\{1,2\dots,n\},\\
E(C_{n}):=\{\{i,i+1\}\in \binom{V(C_{n})}{2}\,|\, i \in \{1,\dots,n-1\}\cup \{1,n\}
\end{gather*}
$$
- numero di lati $E(C_{n})=n$
![[Pasted image 20240628123632.png|center|400]]

##### Grafo completo su $n$ vertici
- $\forall n \in \mathbb{N}$, $n \geq 1$, il **grafo completo su $n$** **vertici**, denotato con $K_{n}$, è definito ponendo
$$
V(K_{n}):=\{1,2,\dots,n\},\,E(k_{n}):=\binom{V(K_{n})}{2}
$$
![[Pasted image 20240628123654.png|center|400]]

---
## Sottografi e sottografi indotti
**Def** Siano $G=(V, E)$ e $G'=(V', E')$ due grafi. Diciamo che $G'$ è un **sottografo** di $G$ se $V' \subset V$ e $E' \subset E$.

Se $G'$ è un sottografo di $G$ e vale 
$$
E'=\{e \in E \,|\,e=\{V_{1}, V_{2}\}, V_{1}\in V', V_{2}\in V'\},
$$
allora $G'$ si dice **sottografo** di $G$ **indotto** da $V'$ e si indica con il simbolo $G[V']$

---
## Passeggiate, Cammini e cicli
**Def** Sia $G=(V,E)$ Una successione finita ordinata $(v_{0}, \dots, v_{n})$ di vertici di $G$ si dice
- **passeggiata** in $G$ se $n=0$ oppure $n \geq 1$ e $\{v_{i}, v_{i+1}\} \in E \quad\forall i \in \{0,1,\dots,n-1\}$.
- **cammino** in $G$ se è una passeggiata in $G$ e $v_{i}\neq v_{j}\,\, \forall i,j \in \{0,\dots,n\} \,\,\, con \,\,\, i\neq j$
- **ciclo** in $G$ se è una passeggiata in $G, v_{0}=v_{n}$ e $n \geq 3$ $v_{i}\neq v_{j} \forall i,j \in \{0,\dots,n-1\} \, con \,\, i\neq j$

Se $(V_{0}, \dots, V_{n})$  è una passeggiata in $G$, allora $n$ è detto  **lunghezza** della passeggiata $P$ (cioè il numero di lati percorsi) cioè $n=l(p)$

---
## Congiungibilità
**Def** Sia $G=(V,E)$ e siano $v,w \in V$. Diciamo che $v$ e $w$ sono **congiungibili con un cammino** (o con una **passeggiata**) se esiste un cammino 
$(v_{0},\dots ,v_{n})$ $\quad tc\quad v_{0}=v\quad$ e $\quad v_{n}=w$

**Prop** Se riusciamo a congiungere due vertici con un cammino allora lo sono anche con una passeggiata

**Prop** Sia $G=(V,E)$ e sia $\sim$ la relazione binaria su $V$ indotta dalla nozione di congiungibilità in $G \sim \in \mathscr{P}(V\times V)$ è definita ponendo $v\sim w$ se $v$ è congiungibile a $w$ in $G$.
Allora $\sim$  è una relazione di equivalenza in $V$.

----
## Componenti connesse
**Def** sia $G=(V,E)$ e sia $\sim$  la relazione di equivalenza di congiungibilità su $V$. Indichiamo con $\{V_{i} \}_{i \in I}$ l'insieme di tutte le $\sim$-classi di equivalenza (considerate come sottoinsiemi di $V$). I sottografi $\{G[V_{i}\}_{i \in I}$ indotti da $G$ su $V_{i}$ si dicono **componenti** **connesse** **di** $G$.
#### Grafo connesso
- Un **grafo** si dice **connesso** se possiede una sola **componente** **connessa**. Altrimenti si dice essere **sconnesso**.
---
 **Proposizione** Siano $G$ e $G'$ due grafi e sia $f:G\to G'$ un morfismo. Valgono:
 - Se $v,w \in V(G) \quad tc\quad v \quad \text{è congiungibile a w in} \quad G$ allora $f(u)$  e $f(w)$ sono congiungibili $G'$      
 - un morfismo trasforma quindi coppie di vertici congiungibili in coppie di vertici congiungibili

 - In più se $f$ è un isomorfismo, allora $v \sim w$ in $G \Leftrightarrow f(u) \sim f(w)$ in $G$
 
 **Corollario** Siano $G$ e $G'$ due grafi isomorfi, siano $\{G_{i}\}_{i \in I}$ le componenti connesse di $G$ e siano $\{G_{j}'\}_{j \in J}$ le componenti connesse di $G'$. Allora $G$ e $G'$ hanno lo stesso numero di componenti connesse e tali componenti connesse sono a 2 a 2 isomorfe.
 Più precisamente $\exists_{\phi}:I\to J$ una bigezione $\quad tc\quad G_{i} \equiv G'_{\phi(i)}\forall i \in I$

---
![[Pasted image 20240628170141.png|center|500]]
