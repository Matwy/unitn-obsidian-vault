---
date: 2026/06/12
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec10-Regularization.pdf]]"
---
## 10 Regularization - Pseudocodice

### Gradient descent con regolarizzatore L2 (exp loss + L2)

> Oltre alla correzione dalla loss, il termine -ηλw_j restringe ogni peso verso 0 in modo proporzionale alla sua grandezza.

```
# Obiettivo: arg min_{w,b}  Σ_i exp(-y_i (w·x_i + b))  +  (λ/2)||w||²
# Input: learning rate η, coefficiente di regolarizzazione λ
inizializza w, b
ripeti finché convergenza:
    per ogni esempio (x_i, y_i):     # (o sull'intero dataset / batch)
        c = exp(-y_i (w·x_i + b))                       # "quanto sono lontano dal corretto"
        per ogni peso j:
            loss_correction = y_i * x_ij * c            # correzione dalla loss
            w_j = w_j + η * loss_correction - η * λ * w_j   # update: -ηλ w_j verso 0
restituisci w, b
```

### Gradient descent con regolarizzatore L1 (exp loss + L1)

> Il termine -ηλ·sign(w_j) sposta ogni peso verso 0 di una costante fissa, indipendentemente dalla sua grandezza → produce pesi esattamente a 0 (sparsità).

```
# Obiettivo: arg min_{w,b}  Σ_i exp(-y_i (w·x_i + b))  +  λ||w||₁
# Input: learning rate η, coefficiente di regolarizzazione λ
inizializza w, b
ripeti finché convergenza:
    per ogni esempio (x_i, y_i):
        c = exp(-y_i (w·x_i + b))
        per ogni peso j:
            loss_correction = y_i * x_ij * c
            w_j = w_j + η * loss_correction - η * λ * sign(w_j)   # -ηλ sign(w_j) verso 0
restituisci w, b
```

### Update generico per norma e per loss

```
# Regola di update a seconda della norma usata (loss_correction = parte dalla loss):
#   L1:  w_j = w_j + η (loss_correction - λ · sign(w_j))
#   L2:  w_j = w_j + η (loss_correction - λ · w_j)
#   Lp:  w_j = w_j + η (loss_correction - λ · c · w_j^(p-1))

# Senza regolarizzazione:  w_j = w_j + η · y_i · x_ij · c
# dove la costante c dipende dalla loss scelta:
#   exponential:   c = exp(-y_i (w·x_i + b))
#   hinge loss:    c = 1[ y·y' < 1 ]                # aggiorna solo se dentro il margine
#   squared error: w_j = w_j + η (y_i - (w·x_i + b)) · x_ij
```
