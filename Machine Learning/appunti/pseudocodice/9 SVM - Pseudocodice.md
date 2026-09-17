---
date: 2026/06/12
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec9-SVM.pdf]]"
---
## 9 SVM - Pseudocodice

### Addestramento SVM soft-margin via (sub)gradient descent della hinge loss

> Minimizza in modo non vincolato l'obiettivo SVM (hinge loss + regolarizzatore L2) con discesa del (sotto)gradiente, equivalente alla formulazione soft-margin.

```
Input: dati di training {(x_i, y_i)}, con y_i ∈ {-1, +1}
       parametro C (trade-off margine/violazioni), learning rate η, numero epoche T

Obiettivo: minimizza  J(w, b) = ||w||^2 + C * Σ_i max(0, 1 - y_i (w · x_i + b))

inizializza w ← 0, b ← 0
per epoca = 1 ... T:
    per ogni esempio (x_i, y_i):
        margine ← y_i (w · x_i + b)
        se margine ≥ 1 allora            # esempio fuori dal margine, classificato bene
            # solo il regolarizzatore contribuisce al gradiente
            grad_w ← 2 * w
            grad_b ← 0
        altrimenti                       # esempio dentro il margine o mal classificato
            grad_w ← 2 * w - C * y_i * x_i
            grad_b ← - C * y_i
        # aggiornamento dei parametri lungo il (sotto)gradiente discendente
        w ← w - η * grad_w
        b ← b - η * grad_b
restituisci w, b
```

### Classificazione (predizione) con SVM lineare

```
Input: esempio di test x, parametri appresi (w, b)
y' ← w · x + b
se y' ≥ 0 allora restituisci +1
altrimenti restituisci -1
```

### Addestramento e classificazione SVM con kernel (forma duale)

> Si risolve il problema duale (quadratic programming) per ottenere i moltiplicatori α_i; i punti con α_i ≠ 0 sono i support vector. Con il kernel trick si sostituisce il prodotto interno x_i·x_j con K(x_i, x_j).

```
Input: dati di training {(x_i, y_i)}, funzione kernel K, parametro C

# --- Fase di ottimizzazione (duale soft-margin) ---
risolvi il problema di quadratic programming:
    massimizza_α   Σ_i α_i - (1/2) Σ_i Σ_j α_i α_j y_i y_j K(x_i, x_j)
    soggetto a     Σ_i α_i y_i = 0
                   0 ≤ α_i ≤ C   per ogni i

# i support vector sono gli esempi con α_i ≠ 0
support_vectors ← { i : α_i > 0 }

# --- Calcolo del bias b usando un support vector k con 0 < α_k < C ---
scegli un indice k tale che 0 < α_k < C
b ← y_k - Σ_i α_i y_i K(x_i, x_k)

restituisci {α_i}, b

# --- Classificazione di un nuovo punto x ---
f(x) ← Σ_i α_i y_i K(x_i, x) + b
se f(x) ≥ 0 allora restituisci +1
altrimenti restituisci -1
```
