---
date: 2026-06-14
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec15-Generative Models.pdf]]"
---
## 15 Modelli Generativi - Pseudocodice

### Training di un VAE (Variational AutoEncoder)

> Encoder e decoder gaussiani: si massimizza il variational lower bound = termine di ricostruzione - regolarizzatore (KL verso il prior N(0, I)).

```
# Encoder q_ψ(ω|x), Decoder q_θ(x|ω), Prior p_ω = N(0, I), learning rate η
inizializza ψ (encoder), θ (decoder)
ripeti finché convergenza:
    campiona x da p_data
    # Encoder: produce media e covarianza della gaussiana sul latente
    μ_ω, Σ_ω = encoder_ψ(x)
    # Campionamento del latente (reparameterization trick)
    campiona ε ~ N(0, I)
    ω = μ_ω + Σ_ω^(1/2) * ε
    # Decoder: produce media e covarianza per ricostruire x
    μ_x, Σ_x = decoder_θ(ω)
    # Variational Lower Bound loss = -ricostruzione + regolarizzatore
    L_recon = - log q_θ(x | ω)                          # termine di ricostruzione
    L_reg   = d_KL( q_ψ(·|x) , p_ω )                    # KL verso il prior (forma chiusa con gaussiane)
    L = L_recon + L_reg
    aggiorna θ, ψ con gradient descent su L
restituisci encoder_ψ, decoder_θ
```

### Generazione (sampling) con un VAE

> A generazione serve solo prior + decoder: l'encoder si butta via.

```
funzione genera_VAE(decoder_θ):
    campiona ω ~ p_ω = N(0, I)                          # campiona dal prior
    μ_x, Σ_x = decoder_θ(ω)                             # decoder produce la gaussiana
    campiona x_hat ~ N(μ_x, Σ_x)                        # dato generato
    restituisci x_hat
```

### Training di una GAN (gioco adversarial min-max)

> Due giocatori a somma zero: il discriminatore t_φ impara a distinguere reale da finto (max), il generatore g_θ impara a ingannarlo (min).

```
# Generatore g_θ, Discriminatore t_φ, Prior p_ω, learning rate η
inizializza θ (generatore), φ (discriminatore)
ripeti finché convergenza:

    # --- Step 1: aggiorna il DISCRIMINATORE (massimizza) ---
    campiona mini-batch di dati reali  {x_1, ..., x_B} ~ p_data
    campiona mini-batch di latenti     {ω_1, ..., ω_B} ~ p_ω
    # obiettivo: t->1 sui reali, t->0 sui generati g_θ(ω)
    L_D = (1/B) * somma_su_b( log t_φ(x_b) + log(1 - t_φ(g_θ(ω_b))) )
    φ = φ + η * gradiente_φ(L_D)                        # ascesa del gradiente (max_φ)

    # --- Step 2: aggiorna il GENERATORE (minimizza) ---
    campiona mini-batch di latenti     {ω_1, ..., ω_B} ~ p_ω
    L_G = (1/B) * somma_su_b( log(1 - t_φ(g_θ(ω_b))) )
    θ = θ - η * gradiente_θ(L_G)                        # discesa del gradiente (min_θ)

restituisci g_θ
```

### Obiettivo min-max della GAN

```
# θ* ∈ arg min_θ  max_φ  { E_{x~p_data}[ log t_φ(x) ] + E_{ω~p_ω}[ log(1 - t_φ(g_θ(ω))) ] }
```

### Generazione (test time) con una GAN

```
funzione genera_GAN(g_θ):
    campiona ω ~ p_ω                                    # campiona dal prior
    x_hat = g_θ(ω)                                      # dato generato (niente discriminatore)
    restituisci x_hat
```
