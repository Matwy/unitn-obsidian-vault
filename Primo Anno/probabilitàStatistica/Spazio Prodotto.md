---
date: 2024/03/19
tags:
  - probabilità
Materia: "[[Probabilità e Statistica]]"
---
$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
## Spazio prodotto 
 **Esempio** Lanciamo una moneta e un dado a 6 facce
 $\Omega_{1}= \{T, C\}$  $\Omega_{2}= \{1, 2, \dots 6\}$  $\Omega= \Omega_{1}\times \Omega_{2}$
$\Fcal = P(\Omega)$   $\Fcal_1 = P(\Omega_1)$    $\Fcal_2 = P(\Omega_2)$      $\Fcal \neq \Fcal_{1}\times \Fcal_2$ 
![[Pasted image 20240319085301.png|center|400]] Su $\Omega$ mettiamo $\Fcal = \sigma(\Fcal_1\times\Fcal_{2)}= \Fcal_{1} \otimes\Fcal_2$ 

 In questo caso $\Fcal = \mathscr{P}(\Omega)$ Costruiamo una probabilità $\P$ su $(\Omega, \Fcal)$ ponendo $$ \P(E_{1}\times E_{2)}= \P(E_{1})\P(E_{2}) \quad \forall E_{1}\in\Fcal_{1}\quad  E_{2}\in\Fcal_{2} $$
 