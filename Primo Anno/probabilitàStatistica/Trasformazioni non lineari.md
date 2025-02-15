---
date: 2024/05/06
tags:
  - variabilialetorie
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie Continue]]"
---
## Trasformazioni non lineari
#### Esempio 1
$X \sim exp(1)$
$f_{X}(x) = e^{-x}$ se $x \geq 0$

$g:\mathbb{R}\to \mathbb{R}$
$g(x)=e^{-X}$

$Y = e^{-X}$ v.a.
$F_{Y}(y) = \mathbb{P}(Y \leq y) = \mathbb{P}(e^{-X} \leq y)$
$$
= \begin{cases}
\mathbb{P}(-X \leq log\,y) = \mathbb{P}(X \geq -log\,y)= 1-F_{X}(-log\,y) & y > 0\\
0 & y \leq 0
\end{cases}
$$

$$
F_{X}(x)=\begin{cases}
1-e^{-x} & x \geq 0 \\
0 & x<0 
\end{cases}
$$

$$
F_{Y}(y)=\begin{cases}
0 & y \leq 0 \\
1-(1-e^{log\,y}) = y & 0 < y < 1 \\
1- 0 & y \geq 1 \\
\end{cases}
$$
Quindi $Y \sim Unif [0,1]$
$$f_{y}(y)=I_{[0,1]}=\begin{cases}
0 & y< 0 \\
1 & 0 < y < 1  \\
0 & y > 1
\end{cases}$$
---
#### Esempio 2
$X \sim exp(1)$    $\mathbb{Z}= (1-X)^{2}$     $g(x) = (1-X)$
$F_{Z}(z) = \mathbb{P}(Z \leq z) = \mathbb{P}((1-X)^{2}\leq z) =$
$$
=\begin{cases}
0 & z \leq 0 \\
\mathbb{P}( |1-X| \leq \sqrt{z}), & z \geq 0 
\end{cases}
$$
$$
\begin{gather*}
\mathbb{P}(1-\sqrt{z} \leq X \leq 1+\sqrt{z}) = F_{X}(1+\sqrt{z}) - F_{X}(1-\sqrt{z})=
\end{gather*}
$$
$$
F_{Z}(z) = \begin{cases}
0 & z < 0 \\
-e^{-(1+\sqrt{z})} + e^{-(1-\sqrt{z})} & 0 \leq z < 1 \\
1- e^{-(1+\sqrt{z})} & z \geq 1
\end{cases} 
$$
Per la densità bisogna solamente derivare i termini
![[Pasted image 20240506160046.png]]
