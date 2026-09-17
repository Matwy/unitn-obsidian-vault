---
date: 2026/06/12
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec11-Unsupervised Learning.pdf]]"
---
## 11 Unsupervised Learning - Pseudocodice

### PCA via Eigenvalue Decomposition

```
Input: punti X = [x_1, ..., x_n]

# 1 — Centering: a ogni punto si sottrae la media
X̄ ← X - (1/n) * X * 1_n * 1_n^T

# 2 — Matrice di covarianza dei dati centrati
C ← (1/n) * X̄ * X̄^T

# 3 — Eigenvalue decomposition
U, λ ← eig(C)            # U = autovettori, λ = autovalori (varianze)

# convenzione: ordina per autovalore decrescente λ_1 ≥ λ_2 ≥ ... ≥ λ_m
restituisci  componenti principali W = U = [u_1, ..., u_m]
             varianze λ = (λ_1, ..., λ_m)
```

### PCA via SVD (Singular Value Decomposition)

> Evita di calcolare esplicitamente la matrice di covarianza calcolando direttamente la SVD dei dati centrati.

```
Input: punti X = [x_1, ..., x_n]

# 1 — Centering
X̄ ← X - (1/n) * X * 1_n * 1_n^T

# 2 — Singular value decomposition
U, s, V ← SVD(X̄)        # s = valori singolari s_1 ≥ ... ≥ s_k > 0

# 3 — Componenti principali e varianze
componenti principali ← U = [u_1, ..., u_k]
varianze ← ( s_1^2 / n, ..., s_k^2 / n )
restituisci U, varianze
```

### Riduzione di dimensionalità con PCA (proiezione sui k componenti)

```
Input: dati centrati X̄, componenti principali Ŵ = [w_1, ..., w_k] (primi k)

# proietta i dati centrati sui primi k componenti
T ← Ŵ^T * X̄            # T ∈ R^(k×n): principal component scores
restituisci T
```

### K-Means Clustering

> Minimizza la variazione interna ai cluster Σ_j Σ_{i∈C_j} ||x_i - μ_j||^2 alternando assegnazione e ricalcolo dei centroidi.

```
Input: punti X = [x_1, ..., x_n], numero di cluster k

inizializza k centroidi μ_1, ..., μ_k
while i cluster cambiano:
    # Step 1 — Assegnazione: ogni punto al centroide più vicino
    per ogni punto x_i:
        C_j = { i : j = argmin_ℓ ||x_i - μ_ℓ|| }
    # Step 2 — Aggiornamento: ricalcola i centroidi come media del cluster
    per ogni cluster C_j:
        μ_j ← (1 / |C_j|) * Σ_{i ∈ C_j} x_i
restituisci i cluster e i centroidi
```

### Algoritmo Eigenfaces (face detection & recognition con PCA)

> Applica PCA al database di volti per ottenere le eigenfaces; un volto è rappresentato dai suoi coefficienti nel face space. Detection via errore di ricostruzione, recognition via k-NN.

```
Input: database di immagini di volti, numero di componenti K, soglia di detection

# 1 — Pre-elaborazione del database
applica PCA alle immagini → eigenfaces u_1, ..., u_K e media μ
per ogni immagine del database:
    calcola i K coefficienti  t_j = u_j^T (x - μ)

# 2 — Nuova immagine x: calcola i coefficienti
per j = 1 ... K:
    t_j ← u_j^T (x - μ)

# 3 — È un volto? (detection via ricostruzione)
x̂ ← μ + Σ_{j=1..K} u_j * t_j
se ||x - x̂|| < soglia allora x è un volto
altrimenti x non è un volto

# 4 — Di chi è? (recognition)
trova il volto etichettato più vicino nel database
   (k-NN nello spazio K-dimensionale dei coefficienti)
restituisci l'identità del volto più vicino
```
