---
date: 2026/06/13
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec13-Intro2NN.pdf]]"
---
## 13 Introduzione alle Reti Neurali - Pseudocodice

### Forward pass (rete con un hidden layer)

```
# Rete: input x (d feature) -> hidden con tanh -> output lineare
# Pesi: w1[i][j] (input->hidden), w2[j] (hidden->output)

funzione forward(x, w1, w2):
    # Strato nascosto
    per ogni neurone nascosto j:
        a[j] = somma_su_i( w1[i][j] * x[i] )      # pre-attivazione  a_j = Σ_i w1_ij x_i
        z[j] = tanh(a[j])                          # attivazione      z_j = tanh(a_j)
    # Strato di output (lineare)
    y_hat = somma_su_j( w2[j] * z[j] )             # ŷ = Σ_j w2_j z_j
    restituisci y_hat, z, a
```

### Calcolo dell'errore (square loss)

```
# Errore su un singolo esempio (il fattore 1/2 semplifica la derivata)
funzione loss(y, y_hat):
    restituisci 0.5 * (y - y_hat)^2               # L = ½ (y - ŷ)²
```

### Backpropagation (regola della catena)

> Propaga il segnale di errore dall'output verso l'input: il δ di un'unità nascosta è la somma pesata dei δ a valle, moltiplicata per la derivata dell'attivazione.

```
funzione backprop(x, y, w1, w2):
    y_hat, z, a = forward(x, w1, w2)

    # δ dell'unità di output (attivazione lineare)
    delta = y_hat - y                              # δ = ŷ - y

    # δ delle unità nascoste (tanh: h'(a_j) = 1 - z_j²)
    per ogni neurone nascosto j:
        delta_h[j] = (1 - z[j]^2) * w2[j] * delta  # δ_j = (1 - z_j²) · w2_j · δ

    # Gradiente rispetto ai pesi:  ∂L/∂w = (errore a valle) · (input a monte)
    per ogni j:
        grad_w2[j] = delta * z[j]                  # ∂L/∂w2_j = δ · z_j
    per ogni i, j:
        grad_w1[i][j] = delta_h[j] * x[i]          # ∂L/∂w1_ij = δ_j · x_i

    restituisci grad_w1, grad_w2
```

### Caso generale: δ di un'unità nascosta t

```
# Per un'unità nascosta t che alimenta le unità a valle S:
delta_t = h'(a_t) * somma_su_s_in_S( w[t][s] * delta_s )    # δ_t = h'(a_t) Σ_s w_ts δ_s

# Per ogni unità di output (square loss):
delta_k = y_hat[k] - y[k]                                    # δ_k = ŷ_k - y_k
```

### Training con SGD + backpropagation

```
# Dati: training set T = {(x_1,y_1), ..., (x_N,y_N)}, learning rate η
inizializza casualmente w1, w2

ripeti finché criterio di stop non soddisfatto:
    campiona un esempio (x_i, y_i) da T
    grad_w1, grad_w2 = backprop(x_i, y_i, w1, w2)

    # Gradient descent: w <- w - η · ∂L/∂w
    per ogni j:
        w2[j] = w2[j] - η * grad_w2[j]            # w2_j <- w2_j - η δ z_j
    per ogni i, j:
        w1[i][j] = w1[i][j] - η * grad_w1[i][j]   # w1_ij <- w1_ij - η δ_j x_i

restituisci w1, w2
```
