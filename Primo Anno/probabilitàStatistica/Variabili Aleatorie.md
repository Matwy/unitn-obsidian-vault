---
date: 2024-03-28
tags:
  - probabilità
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---
## Variabili Aleatorie
- [[dispensapdf.pdf#page=91&selection=291,0,291,13|dispensa]]
**DEF** Dato uno spazio probabilizzabile $(\Omega, \Fcal)$ si dice
**Variabile Aleatoria** ogni funzione 
$$
\begin{align*}
X:\Omega \to \R \quad tc\quad \forall x \in \R\\
\text{l'insieme } \{u \in \Omega \, |\, X(u) \leq x \} \in \Fcal
\end{align*}
$$
---
**OSS** La definizione non dipende dalla funzione di probabilità

- Vorremmo essere in grado di assegnare una probabilità alle semirette perchè generano $\mathscr{B}(\R)$ (Con $\mathscr{B}$ si intende una $\sigma$-algebra di **Borel** vedi [[Cardinalità#Lo spazio dei numeri reali e $ sigma$-algebra di Borel]])
- Portiamo gli insiemi indietro

**Def** $f: \Omega \to \tilde{\Omega}$
**preimmagine** di $\tilde{E} \in \tilde{\Omega }$         $f^{-1}(\tilde{E}):=\{w \in \Omega \,|\, f(w) \in \tilde{E}\}$
- - - 
$X = \Omega \to \tilde{\Omega }$    funzione
**Teorema** $(\tilde{\Omega }, \tilde{\Fcal})$   spazio probabilità Allora
$$
\Fcal = \{x^{-1}(\tilde{E})\,|\, \tilde{E} \in  \tilde{\Fcal}\} \Rightarrow \sigma\text{-algebra generata da X}
$$
- Gli eventi in $\Fcal$ sono tutti quelli per cui su definiamo una probabilità
- Gli eventi in $\sigma(x)$ sono quelli che hanno a che fare con $X$
- - - 
**Teorema** $x:(\R, \mathscr{B}(\R)) \to (\R, \mathcal{B}(R))$
una funzione continua o monotona => $X$
- - - 
**Teorema**  $X : \Omega \to \tilde{\Omega }$         $(\Omega , \Fcal) \quad \text{spazio di probabilità}$
$$\tilde{\Fcal} = \{\tilde{E}\subseteq \tilde{\Omega} \,|\, X^{-1}(\tilde{E})\in \Fcal \} \, \sigma-algebra$$
![[Pasted image 20240319101347.png|center|]]

- - -
[[Esempi variabili aleatorie]]
- - -
### Variabili Aleatorie **Indicatrici**  
$E \in \Fcal$ La variabile aleatoria **indicatrice** di $E$ è

$$I_{E}(\omega) =\begin{cases}
1& se\, w \in E \\
0&se \, w \notin E
\end{cases}$$
$I^{-1}_{E}(\{1\}) = E$     $I^{-1}_{E}(\{0\}) = E^{c}$

$A \in \mathscr{B}= \mathscr{B}(\mathbb{R})$    $1 \in A$   $0\notin A$ $\Rightarrow I_{E}^{-1}(A) = E$
- - - 
### Variabili Aleatorie **Semplici**  
Le variabili aleatorie **semplici** sono combinazioni lineari di indicatrici
$$
x = \sum_{i=1}^{n}\lambda_{i}I_{E_{i}} \quad \quad E_{i}\in \mathcal{F}\quad \lambda_{i}\in \mathbb{R}
$$
**Esempio** Lancio un dado e vinco il valore del risultato se dispari
$$
x:\Omega \to \mathbb{R}\quad \quad x= I_{\{1\}}+3_{\{3\}}+5I_{\{5\}}
$$
