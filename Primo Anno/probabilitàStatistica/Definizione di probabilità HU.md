---
date: 06/03/2024
tags:
  - probabilità
Materia: "[[Probabilità e Statistica]]"
---
## Assiomi che definiscono la probabilità
- $P(\varnothing) = 0$      $P(S) = 1$
- $P(\bigcup_{n=1}^{\infty}A_{n}) = \sum_{n=1}^{\infty}P(A_{n})$
## Proprietà 1
 $$P(A^{c)}= 1 - P(A)$$
**Proof** 
$$ \begin{align}
1 = P(S) = P(A\cup A^{c)}\\
=P(A)+P(A^c)
\end{align}$$ 
in quanto $A\cap A^{c}= \varnothing$

## Proprietà 2 
If $A \subseteq B$, allora $P(A) \leq P(B)$

**Proof**
$B = A \cup (B\cap A^{c})$, disjoint
$P(B) = P(A) + P(B\cap A^{c)} \geq P(A)$

## Proprietà 3
$P(A\cup  B) = P(A) + P(B) - P(A\cap B)$
 