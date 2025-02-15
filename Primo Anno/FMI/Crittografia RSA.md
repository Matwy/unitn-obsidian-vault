---
date: 2024/06/27
tags: 
Materia: "[[FMI]]"
---
## Crittografia RSA
Fissiamo $n > 0$    $\forall c \in \mathbb{N}\setminus \{0\}$ 
definiamo la seguente funzione  $\alpha\to \alpha^{c}$
$$
P_{c}:(\mathbb{Z}/n \mathbb{Z})^{*}\to(\mathbb{Z}/n \mathbb{Z})^{*}
$$
ovvero $P_{c}(\alpha):=\alpha^{c}\quad \forall \alpha \in  (\mathbb{Z}/n \mathbb{Z})^{*})$

---
## Teorema Fondamentale della crittografia RSA
Sia $c \in \mathbb{N}\setminus \{0\} \quad tc\quad (c,\Phi(n))=1$ e sia $d \in \mathbb{N}\setminus \{0\}$ un inverso di $c$ modulo $\Phi(n)$ (ovvero $d$ $> 0$ e $d \in [c]^{-1}_{\Phi(n)}$)

Allora
$P_{c}:(\mathbb{Z}/n \mathbb{Z})^{*}\to(\mathbb{Z}/n \mathbb{Z})^{*}$ è una funzione invertibile e vale:
$$
P_{c}^{-1}=P_{d}
$$
