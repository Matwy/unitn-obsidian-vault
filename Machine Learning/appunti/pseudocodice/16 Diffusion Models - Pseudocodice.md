---
date: 2026-06-14
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec16 - Diffusion Models.pdf]]"
---
## 16 Diffusion Models - Pseudocodice

### Forward process (aggiunta di rumore)

> Catena di Markov fissa (non imparata). Grazie al campionamento diretto si può saltare al passo t in un colpo solo, conoscendo esattamente il rumore ε aggiunto.

```
# Schedule β_1..β_T, con α_t = 1 - β_t e ᾱ_t = Π_{s=1}^t α_s

# Singolo passo:  q(x_t | x_{t-1}) = N( sqrt(1-β_t)·x_{t-1}, β_t·I )
funzione passo_forward(x_prev, β_t):
    campiona ε ~ N(0, I)
    x_t = sqrt(1 - β_t) * x_prev + sqrt(β_t) * ε
    restituisci x_t

# Campionamento diretto da x_0 al passo t (reparameterization):
funzione forward_diretto(x_0, t):
    campiona ε ~ N(0, I)
    x_t = sqrt(ᾱ_t) * x_0 + sqrt(1 - ᾱ_t) * ε          # x_t = √ᾱ_t x_0 + √(1-ᾱ_t) ε
    restituisci x_t, ε
```

### Algoritmo 1 — Training

> Allenare = insegnare alla rete a predire il rumore presente in un'immagine rumorosa: una semplice loss MSE sul rumore.

```
ripeti:
    x_0 ~ q(x_0)                                        # immagine reale dal dataset
    t   ~ Uniform({1, ..., T})                          # timestep a caso
    ε   ~ N(0, I)                                       # rumore campionato
    x_t = sqrt(ᾱ_t) * x_0 + sqrt(1 - ᾱ_t) * ε          # immagine rumorosa al passo t
    # Gradient descent sulla loss MSE sul rumore:
    grad = gradiente_θ( || ε - ε_θ(x_t, t) ||^2 )
    θ = θ - η * grad
fino a convergenza
```

### Algoritmo 2 — Sampling (generazione / reverse process)

> Si parte da rumore puro e si applicano T passi di denoising imparati; a ogni passo si sottrae il rumore stimato e si ri-aggiunge un po' di rumore (stocasticità).

```
x_T ~ N(0, I)                                           # parti da rumore puro
per t = T, T-1, ..., 1:
    se t > 1:
        z ~ N(0, I)
    altrimenti:
        z = 0
    # un passo di denoising:
    x_{t-1} = (1 / sqrt(α_t)) * ( x_t - ((1 - α_t) / sqrt(1 - ᾱ_t)) * ε_θ(x_t, t) ) + σ_t * z
restituisci x_0
```

### Classifier-Free Guidance (sampling condizionato su testo)

> Si estrapola tra predizione condizionata e non condizionata per rendere l'immagine più aderente al prompt; s è la guidance scale.

```
# c = embedding del testo (es. da CLIP), s ≥ 1 = guidance scale
funzione predizione_guidata(x_t, t, c, s):
    ε_uncond = ε_θ(x_t, t)                              # predizione non condizionata
    ε_cond   = ε_θ(x_t, t, c)                           # predizione condizionata
    ε_hat    = ε_uncond + s * (ε_cond - ε_uncond)       # estrapolazione verso il prompt
    restituisci ε_hat
# usata al posto di ε_θ(x_t, t) nel passo di sampling
```
