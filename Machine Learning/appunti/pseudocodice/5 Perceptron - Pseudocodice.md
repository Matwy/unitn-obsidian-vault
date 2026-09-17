---
date: 2026/05/25
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec5-Perceptron.pdf]]"
---
## 5 Perceptron - Pseudocodice

### Algoritmo del Perceptron (training)
> Algoritmo online e mistake-driven: scorre gli esempi e aggiorna i pesi solo quando sbaglia. Label ∈ {−1, +1}.
```
inizializza w_1, ..., w_n = 0   e   b = 0
ripeti fino a convergenza (oppure per un numero fisso di iterazioni):
    per ogni esempio di training (f_1, ..., f_n, label):
        prediction = sign( b + Σ_{i=1}^{n} w_i * f_i )
        se prediction è diversa da label:        # se sbaglia
            per ogni w_i:
                w_i = w_i + f_i * label           # regola di update dei pesi
            b = b + label                         # update del bias
restituisci w_1, ..., w_n, b
```

### Predizione (classificazione)
```
funzione perceptron_predici(x, w, b):
    score = b + Σ_{i=1}^{n} w_i * x_i
    restituisci sign(score)        # >0 -> classe +1, <0 -> classe -1
```

### Variante: campionamento casuale degli esempi
> L'ordine degli esempi influenza la soluzione: invece di scorrerli in ordine fisso, se ne estrae uno a caso a ogni passo.
```
inizializza w = 0, b = 0
ripeti per un numero fisso di iterazioni:
    (f_1, ..., f_n, label) = esempio estratto casualmente dal training set
    prediction = sign( b + Σ_{i=1}^{n} w_i * f_i )
    se prediction è diversa da label:
        per ogni w_i:
            w_i = w_i + f_i * label
        b = b + label
restituisci w, b
```
