---
date: 11/03/2024
tags:
  - induzione
Materia: "[[FMI]]"
---
$$
\newcommand{\N}{\mathbb{N}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Z}{\mathbb{Z}}
$$
- deve comparire la **base dell'induzione**
- **ipotesi induttiva**

### Primo modo
Ora assumiamo che P(n) sia vera **ipotesi induttiva**
Dimostriamo che $P(n+1)$ é vera **passo induttivo**

Dunque il **il passo induttivo** é stato fatto segue che, grazie al principio di induzione shiftato di prima forma $P(n)$ é vera per ogni n > uguale di 1

### Secondo modo
Ora assumiamo che $P(n)$ sia vera **ipotesi induttiva** con 
Dobbiamo provare che $P(n+1)$ sia vera
Vale:
$$
\sum_{k=1}^{n+1}\frac{k}{2^{k}}= 2- \frac{(n+1)+2}{2^{n+1}}
$$
$$
(\sum_{k=1}^{n+1}\frac{k}{2^{k}})+\frac{n+1}{2^{n+1}}= 2- \frac{(n+1)+2}{2^{n+1}}
$$
$$
2- \frac{n+2}{2^{n}}+\frac{n+1}{2^{n+1}}= 2- \frac{(n+1)+2}{2^{n+1}}
$$
$$
-n-3=-n-3
$$
Poiché l'ultima uguaglianza è verificata anche la prima lo è, quindi il passo induttivo è stato fatto. Grazie al **principio di induzione** l'uguaglianza è vera sempre $\forall n \geq 1$

### Come scrivere la forma compatta
Dimostrare per induzione su $n \geq 1$ che 
$$
\sum_{k=1}^{n+1}\frac{k}{2^{k}}= 2- \frac{n+2}{2^{n}}
$$
Procediamo per **induzione** su $n \geq 1$

$n = 1$ (**Base induzione**) Dobbiamo provare che $\frac{1}{2} = 2-\frac{3}{2}$ 
Dunque la **base dell'induzione è verificata**

#### Forma compatta
$n \geq 1, \quad n \Rightarrow n+1$ **(passo induttivo)**. Assumiamo che:
$$
\sum_{k=1}^{n+1}\frac{k}{2^{k}}= 2- \frac{n+2}{2^{n}}
$$
Per qualche $n \geq 1$ (**Ipotesi induttiva**)

Dobbiamo provare che vale:
$$
\sum_{k=1}^{n+1}\frac{k}{2^{k}}= 2- \frac{(n+1)+2}{2^{n+1}}
$$
e qui applichi uno tra 
- [[Esercizi Induzione#Primo modo]]
- [[Esercizi Induzione#Secondo modo]]
