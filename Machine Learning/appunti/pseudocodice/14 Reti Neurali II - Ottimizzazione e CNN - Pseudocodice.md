---
date: 2026-06-14
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec14-OptimizationCNN.pdf]]"
---
## 14 Reti Neurali II — Ottimizzazione e CNN - Pseudocodice

### Vanilla Gradient Descent

```
mentre True:
    weights_grad = valuta_gradiente(loss_fun, data, weights)
    weights = weights - step_size * weights_grad   # parameter update
```

### Batch Gradient Descent (BGD)

> Calcola il gradiente medio su TUTTI gli N esempi prima di ogni singolo update: stime stabili ma lente.

```
# Input: learning rate η_k, parametri iniziali w
mentre criterio di stop non soddisfatto:
    # gradiente medio su tutto il training set
    g = (1/N) * gradiente_w( somma_su_i( L(f(x_i; w), y_i) ) )   # g = (1/N) ∇_w Σ_i L
    w = w - η_k * g
restituisci w
```

### Stochastic Gradient Descent (SGD)

> Identico al BGD ma il gradiente è stimato su UN solo esempio campionato: veloce ma rumoroso.

```
# Input: learning rate η_k, parametri iniziali w
mentre criterio di stop non soddisfatto:
    campiona un solo datapoint (x_i, y_i) dal training set
    g = gradiente_w( L(f(x_i; w), y_i) )           # gradiente su 1 esempio
    w = w - η_k * g
restituisci w
```

### Mini-batch Gradient Descent

```
# Compromesso tra BGD e SGD; batch di dimensione potenza di 2 (GPU-friendly)
# Input: learning rate η_k, dimensione batch B, parametri iniziali w
mentre criterio di stop non soddisfatto:
    campiona un mini-batch {(x_1,y_1), ..., (x_B,y_B)} dal training set
    g = (1/B) * gradiente_w( somma_su_b( L(f(x_b; w), y_b) ) )
    w = w - η_k * g
restituisci w
```

### SGD con Momentum

> Introduce la velocità v, media mobile a decadimento esponenziale del gradiente negativo: accelera nelle direzioni costanti e smorza le oscillazioni.

```
# Input: learning rate η_k, momentum α (≈ 0.9), parametri iniziali w
inizializza v = 0
mentre criterio di stop non soddisfatto:
    campiona un esempio (o mini-batch) e calcola la stima del gradiente g
    v = α * v - η_k * g                             # v <- α v - η_k g
    w = w + v                                       # w <- w + v
restituisci w
```

### Forward di un layer convoluzionale (Conv → ReLU → Pooling)

```
# Input: immagine/feature map I, insieme di filtri appresi K[1..F]
funzione forward_conv(I, K):
    per ogni filtro f in K[1..F]:
        # Convoluzione: S(i,j) = Σ_m Σ_n I(m,n) · K_f(i-m, j-n)
        per ogni posizione (i, j):
            S_f[i][j] = somma_su_m_n( I[m][n] * K_f[i-m][j-n] )
        # Non-linearità elementwise (ReLU)
        per ogni (i, j):
            S_f[i][j] = max(0, S_f[i][j])           # h(x) = max(0, x)
    # Pooling spaziale (es. max pooling 2x2, stride 2)
    per ogni feature map S_f:
        per ogni blocco 2x2:
            P_f[blocco] = massimo dei valori del blocco
    restituisci P                                   # feature map ridotte
```

### Autoencoder (training non supervisionato)

> Encoder comprime x in z, decoder ricostruisce x̂; si minimizza la distanza L2 senza usare le etichette.

```
# Input: dati non etichettati {x}, learning rate η
inizializza parametri di encoder e decoder
ripeti finché convergenza:
    campiona x dal dataset
    z = encoder(x)                                  # compressione  x -> z
    x_hat = decoder(z)                              # ricostruzione z -> x̂
    L = || x - x_hat ||^2                           # loss L2 (niente etichette)
    aggiorna encoder, decoder con gradient descent su L
restituisci encoder   # il decoder si butta via
```
