---
date: 2024/05/06
tags: []
Materia: "[[Probabilità e Statistica]]"
Argomento: "[[Variabili Aleatorie]]"
---
## Gaussiane o normali
**Def** $X$  è v.a. **normale** o **Gaussiana** **standard** se la sua densità è
$$
f_{X}(x) = \frac{1}{\sqrt{2\pi}}e^{\frac{-x^{2}}{2}}
$$
**Notazione** $X \sim N(0,1)$

![[Pasted image 20240506162835.png|center]]

- $f_{X}(X) = f_{X}(-x)$
- ha massimo in 0

$$
F_{X}(x) = \int_{-\infty}^{x}\frac{1}{\sqrt{2\pi}}e^{\frac{-y^{2}}{2}}\, dy = \phi(x)
$$

![[Pasted image 20240506163244.png|center]]

---
#### Indicatori
$\mathbb{E}[X] = \int _{-\infty}^{\infty} x \frac{1}{\sqrt{2\pi}}e^{-\frac{x^{2}}{2}}\,dx = 0$
$Var[X]= 1$
