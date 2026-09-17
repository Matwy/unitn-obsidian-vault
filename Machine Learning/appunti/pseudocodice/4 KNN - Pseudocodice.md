---
date: 2026/05/25
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec4-KNN.pdf]]"
---
## 4 KNN - Pseudocodice

### Algoritmo k-NN
```
funzione kNN_classifica(d, TrainingSet, k):
    per ogni esempio x in TrainingSet:
        calcola distanza(d, x)        # es. distanza euclidea
    seleziona i k esempi con distanza minore   # i k nearest neighbors
    restituisci la label di maggioranza tra i k vicini
```

### Distanza euclidea
```
funzione distanza_euclidea(a, b):       # a, b vettori d-dimensionali
    somma = 0
    per ogni i da 1 a d:
        somma = somma + (a_i - b_i)^2
    restituisci sqrt(somma)             # D(a,b) = sqrt( Σ_i (a_i - b_i)^2 )
```

### Distanza di Minkowski
```
funzione distanza_minkowski(a, b, r):
    somma = 0
    per ogni i da 1 a d:
        somma = somma + |a_i - b_i|^r
    restituisci somma^(1/r)             # D(a,b) = ( Σ_i |a_i - b_i|^r )^(1/r)
    # r = 1 -> Manhattan (L1), r = 2 -> Euclidea (L2), r -> ∞ -> supremum (L∞)
```

### Cosine similarity
```
funzione cosine_similarity(a, b):
    restituisci (a · b) / (||a|| * ||b||)   # C(a,b) = (a·b) / (||a||·||b||)
    # distanza derivata: D(a,b) = 1 - C(a,b)
```

### Weighted k-NN
> Variante di k-NN: ogni vicino vota con peso proporzionale alla sua vicinanza.
```
funzione weightedKNN_classifica(d, TrainingSet, k):
    trova i k nearest neighbors di d
    per ogni classe c:
        voto[c] = 0
    per ogni vicino i nei k vicini:
        peso_i = 1 / (distanza(d, x_i) + ε)   # ε piccolo per stabilità numerica
        voto[label(x_i)] = voto[label(x_i)] + peso_i
    restituisci la classe c con voto[c] massimo
```

### Standardizzazione (Z-score) e Min-Max scaling
```
# Z-score: media = 0, deviazione standard = 1
funzione zscore(x, μ, σ):
    restituisci (x - μ) / σ

# Min-Max scaling: porta i dati nel range [0, 1]
funzione minmax(x, x_min, x_max):
    restituisci (x - x_min) / (x_max - x_min)
```

### Cross-Validation (k-fold)
```
funzione kFoldCrossValidation(Dataset, m):
    dividi Dataset in m fold di dimensione uguale
    per ogni fold j da 1 a m:
        TrainSet = tutti i fold tranne il fold j
        ValSet   = fold j
        allena il modello su TrainSet
        errore_j = errore del modello su ValSet
    restituisci media(errore_1, ..., errore_m)   # errore medio di validation
```
