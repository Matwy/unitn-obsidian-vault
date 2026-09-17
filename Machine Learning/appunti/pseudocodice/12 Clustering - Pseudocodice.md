---
date: 2026/06/13
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec12-Clustering.pdf]]"
---
## 12 Clustering - Pseudocodice

### K-Means (Lloyd)

```
Input: punti X = {x_1, ..., x_n}, numero di cluster k

inizializza k centroidi μ_1, ..., μ_k
ripeti finché le assegnazioni cambiano:
    # Step 1 — Assegnazione: ogni punto al centroide più vicino
    per ogni punto x_i:
        assegna x_i al cluster C_j tale che  j = argmin_ℓ ||x_i - μ_ℓ||
    # Step 2 — Aggiornamento: ricalcola ogni centroide come media del cluster
    per ogni cluster C_j:
        μ_j ← (1 / |C_j|) * Σ_{i ∈ C_j} x_i
restituisci i cluster C_1, ..., C_k e i centroidi μ_1, ..., μ_k
```

### EM Clustering (Expectation-Maximization, mixture di gaussiane)

> Soft clustering: i dati sono modellati come mixture di K gaussiane. Si alternano E-step (responsabilità) e M-step (aggiornamento parametri) fino a convergenza della likelihood.

```
Input: punti {x_1, ..., x_N}, numero di componenti K

# Inizializzazione dei parametri delle K gaussiane
inizializza {π_k, μ_k, Σ_k}  per k = 1 ... K
   con  Σ_k π_k = 1,  π_k ≥ 0

ripeti fino a convergenza:
    # --- E-Step (Expectation / soft assignment): responsabilità ---
    per ogni punto n e ogni componente k:
        γ_nk ← [ π_k * N(x_n | μ_k, Σ_k) ] / [ Σ_j π_j * N(x_n | μ_j, Σ_j) ]

    # --- M-Step (Maximization / update): aggiorna i parametri ---
    per ogni componente k:
        N_k ← Σ_n γ_nk                                    # numero effettivo di punti (soft)
        π_k ← N_k / N                                     # mixing coefficient
        μ_k ← (1 / N_k) * Σ_n γ_nk * x_n                  # media pesata
        Σ_k ← (1 / N_k) * Σ_n γ_nk (x_n - μ_k)(x_n - μ_k)^T   # covarianza pesata

restituisci {π_k, μ_k, Σ_k} e le responsabilità γ_nk
```

### Spectral Clustering (Ng, Jordan & Weiss)

> Rimappa i punti tramite gli autovettori del Laplaciano normalizzato del grafo di similarità, poi applica K-Means nel nuovo spazio: gestisce cluster di forma arbitraria.

```
Input: punti S = {s_1, ..., s_n}, numero di cluster k, parametro σ

# 1 — Matrice di affinità
per ogni coppia (i, j):
    se i ≠ j:  A_ij ← exp( -||s_i - s_j||^2 / σ^2 )
    altrimenti: A_ii ← 0

# 2 — Laplaciano normalizzato
costruisci D = matrice diagonale con D_ii = Σ_j A_ij    # grado del nodo i
L ← D^(-1/2) * A * D^(-1/2)

# 3 — Autovettori principali
trova x_1, ..., x_k = i k autovettori più grandi di L
impilali in colonna formando X ∈ R^(n×k)

# 4 — Rinormalizzazione delle righe
forma Y rinormalizzando ogni riga di X a lunghezza unitaria

# 5 — K-Means nello spazio spettrale
tratta ogni riga di Y come un punto in R^k
raggruppa le righe in k cluster con K-Means

# 6 — Assegnazione finale
assegna il punto originale s_i al cluster j  se e solo se  la riga i di Y è nel cluster j
restituisci l'assegnazione dei punti ai k cluster
```

### Hierarchical Clustering agglomerativo (bottom-up)

> Parte da ogni punto come cluster singolo e fonde iterativamente i due cluster più vicini, producendo un dendrogramma. La distanza tra cluster dipende dal criterio di linkage.

```
Input: punti {x_1, ..., x_n}, criterio di linkage

# All'inizio ogni istanza è un proprio cluster
inizializza i cluster: C_i = {x_i}  per ogni i

ripeti:
    scegli i due cluster (C_a, C_b) con distanza minima secondo il linkage:
        single   (nearest):  dist = min distanza tra coppie di punti dei due cluster
        complete (farthest): dist = max distanza tra coppie di punti dei due cluster
        average:             dist = media delle distanze tra tutte le coppie
    fondi C_a e C_b in un nuovo cluster
    registra la fusione (livello del dendrogramma)
fermati quando resta un solo cluster

restituisci il dendrogramma (famiglia di partizioni annidate)
```
