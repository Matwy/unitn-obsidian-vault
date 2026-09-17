---
date: 2025/03/31
tags: 
Materia: "[[Fisica]]"
---
## Pendolo semplice

Il pendolo semplice è un modello ideale costituito da:
- un punto materiale di massa $m$
- sospeso tramite un filo inestensibile e senza massa
- vincolato a muoversi su un piano verticale

---
![[image 1.png]]
#### Forze agenti

- Tensione $\vec{T}$ del filo
- Peso $\vec{P} = m\vec{g}$

Nel riferimento polare (lunghezza $l$, angolo $\theta$):

$$
\vec{a}_n = \frac{v^2}{R} = \frac{v^2}{l}
$$

---

#### Equilibrio delle forze
![[image-1 1.png|446x445]]
Nel riferimento radiale e tangenziale:

Radiale:
$$
-T + mg \cos\theta = -m a_r
$$

Tangenziale:
$$
m g \sin\theta = m a_t
$$

---

#### Accelerazione angolare

L'accelerazione tangenziale è collegata all'accelerazione angolare da:
$$
a_t = l \frac{d^2\theta}{dt^2}
$$

Quindi:
$$
g \sin\theta = l \frac{d^2\theta}{dt^2}
$$

---

#### Equazione differenziale del moto

$$
\frac{d^2\theta}{dt^2} + \frac{g}{l} \sin\theta = 0
$$

---

#### Approssimazione per piccoli angoli

Per $\theta \ll 1$ rad:
$$
\sin\theta \approx \theta
$$

L’equazione diventa:
$$
\frac{d^2\theta}{dt^2} + \frac{g}{l} \theta = 0
$$

Ponendo $\omega^2 = \frac{g}{l}$, otteniamo:
$$
\frac{d^2\theta}{dt^2} + \omega^2 \theta = 0
$$

---

#### Soluzione dell’equazione (moto armonico)

$$
\theta(t) = \theta_0 \sin(\omega t + \varphi)
$$

Dove:
- $\theta_0$: ampiezza iniziale
- $\omega = \sqrt{\frac{g}{l}}$: pulsazione
- $\varphi$: fase iniziale

---

Se vuoi posso esportartelo direttamente in `.md` oppure aggiungere un diagramma (stilizzato) del pendolo! Fammi sapere.