---
date: 2026/06/12
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec7-GradientDescent.pdf]]"
---
## 7 Gradient Descent - Pseudocodice

### Algoritmo del Perceptron

```
ripeti fino a convergenza (o per un certo # di iterazioni):
    per ogni esempio di training (f_1, ..., f_n, label):
        prediction ← b + Σ_{i=1}^{n} w_i f_i
        se prediction · label ≤ 0:           # errore: segni diversi (o prodotto 0)
            per ogni w_i:
                w_i ← w_i + f_i · label
            b ← b + label
```

### Gradient Descent (batch)

> Si parte da un punto e si ripete: si calcola il gradiente (vettore delle derivate parziali) e ci si muove di un passo nella direzione opposta (verso la loss decrescente). η è il learning rate.

```
funzione GradientDescent(F, K, η):           # F = loss da minimizzare, K = # iterazioni
    inizializza z^(0) ← ⟨0, 0, ..., 0⟩        # variabile da ottimizzare (es. w, b)
    per k = 1 ... K:
        g^(k) ← ∇_z F valutato in z^(k-1)     # gradiente nel punto corrente
        z^(k) ← z^(k-1) - η^(k) · g^(k)        # passo "giù" lungo il gradiente
    restituisci z^(K)
```

Regola di aggiornamento per singolo peso (con learning rate):
$$w_j = w_j - \eta\, \frac{d}{dw_j}\, loss$$

### Gradient Descent con exponential loss (batch)

> Surrogate loss exp: $\sum_i \exp(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b))$. La derivata rispetto a $w_j$ è $\sum_i -y_i x_{ij}\exp(-y_i(\mathbf{w}\cdot\mathbf{x}_i+b))$; il doppio segno meno diventa un più.

```
funzione GradientDescentExpLoss(dataset {(x_i, y_i)} i=1..n, η, K):
    inizializza w ← 0,  b ← 0
    per k = 1 ... K:
        per ogni peso j:
            # update batch (somma su tutti gli esempi)
            w_j ← w_j + η · Σ_{i=1}^{n} y_i · x_{ij} · exp( -y_i (w·x_i + b) )
        b ← b + η · Σ_{i=1}^{n} y_i · exp( -y_i (w·x_i + b) )
    restituisci (w, b)
```

### Stochastic Gradient Descent (SGD)

> A differenza del batch, aggiorna i pesi un esempio alla volta. Con exp loss l'update assomiglia al perceptron, ma SGD aggiorna SEMPRE (anche su esempi già classificati bene), il perceptron solo sugli errori.

```
funzione StochasticGradientDescent(dataset {(x_i, y_i)}, η, K):
    inizializza w ← 0,  b ← 0
    ripeti per K epoche (o fino a convergenza):
        per ogni esempio (x_i, y_i) preso (in ordine casuale):
            c ← η · exp( -y_i (w·x_i + b) )       # costante: grande se sbaglio, piccola se già giusto
            per ogni peso j:
                w_j ← w_j + x_{ij} · y_i · c       # = w_j + η · y_i · x_{ij} · exp(-y_i(w·x_i+b))
            b ← b + y_i · c
    restituisci (w, b)
```
