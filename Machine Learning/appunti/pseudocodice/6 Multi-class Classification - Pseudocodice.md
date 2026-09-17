---
date: 2026/06/12
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec6-Multi-class Classification.pdf]]"
---
## 6 Multi-class Classification - Pseudocodice

### Algoritmo del Perceptron (binario, ripasso)
```
inizializza w = 0, b = 0
ripeti fino a convergenza (o per un certo # di iterazioni):
    per ogni esempio di training (f_1, ..., f_n, label):     # label ∈ {−1, +1}
        prediction = sign( b + Σ_{i=1}^{n} w_i * f_i )
        se prediction è diversa da label:
            per ogni w_i:
                w_i = w_i + f_i * label        # update pesi
            b = b + label                       # update bias
restituisci w, b
```

### Confidence del perceptron
```
funzione confidence(x, w, b):
    restituisci b + Σ_{i=1}^{n} w_i * f_i   # valore con segno = distanza dall'iperpiano
    # il segno dà la classe, il modulo quanto è confidente
```

### One vs All (OVA) - Training
> Si imparano K classificatori binari: per ciascuna classe k, gli esempi di k sono positivi e tutti gli altri negativi.
```
funzione OneVersusAllTrain(D_multiclass, BinaryTrain):
    per i da 1 a K:
        D_bin = rietichetta D_multiclass: classe i -> +1, ogni altra classe -> −1
        f_i   = BinaryTrain(D_bin)
    restituisci f_1, ..., f_K
```

### One vs All (OVA) - Test
> Si valuta l'esempio su tutti i K classificatori e si sceglie la classe con punteggio massimo (positivo più confidente; se nessun positivo, negativo meno confidente).
```
funzione OneVersusAllTest(f_1, ..., f_K, x̂):
    score = ⟨0, 0, ..., 0⟩              # K punteggi inizializzati a zero
    per i da 1 a K:
        y = f_i(x̂)                      # con confidence: y = confidence di f_i
        score_i = score_i + y
    restituisci argmax_k score_k        # ŷ = argmax_k score_k
```

### All vs All (AVA) - Training
> Si allena un classificatore F_ij per ogni coppia di classi (i, j): classe i positiva, classe j negativa, le altre ignorate. Totale K(K−1)/2 classificatori.
```
funzione AllVersusAllTrain(D_multiclass, BinaryTrain):
    f_ij = ∅   per ogni 1 ≤ i < j ≤ K
    per i da 1 a K−1:
        D_pos = tutti gli x in D_multiclass con label i
        per j da i+1 a K:
            D_neg = tutti gli x in D_multiclass con label j
            D_bin = {(x, +1) : x ∈ D_pos} ∪ {(x, −1) : x ∈ D_neg}
            f_ij  = BinaryTrain(D_bin)
    restituisci tutti gli f_ij
```

### All vs All (AVA) - Test
> Si classifica l'esempio con ogni F_ij; ogni voto alza lo score della classe i e abbassa quello della j (voto pesato con la confidence y). Vince la classe con più voti.
```
funzione AllVersusAllTest(tutti gli f_ij, x̂):
    score = ⟨0, 0, ..., 0⟩              # K punteggi inizializzati a zero
    per i da 1 a K−1:
        per j da i+1 a K:
            y = f_ij(x̂)
            score_i = score_i + y       # weighted vote: score_i += y
            score_j = score_j − y       #                score_j −= y
    restituisci argmax_k score_k
```

### Accuracy, Micro e Macro averaging
```
# Accuracy: frazione di esempi classificati correttamente
funzione accuracy(predizioni, etichette_vere):
    corretti = numero di esempi con prediction == label
    restituisci corretti / numero_totale_esempi

# Microaveraging: media sugli esempi (ogni esempio conta uguale)
funzione microaverage(c, n, K):        # c_k corretti, n_k totali per classe k
    restituisci ( Σ_{k=1}^{K} c_k ) / ( Σ_{k=1}^{K} n_k )

# Macroaveraging: media sulle classi (ogni classe conta uguale)
funzione macroaverage(c, n, K):
    somma = 0
    per ogni classe k da 1 a K:
        somma = somma + (c_k / n_k)    # acc_k = c_k / n_k
    restituisci somma / K
```

### Confusion matrix
```
funzione confusion_matrix(predizioni, etichette_vere, K):
    M = matrice K x K inizializzata a zero
    per ogni esempio:
        i = label vera dell'esempio
        j = label predetta dell'esempio
        M[i][j] = M[i][j] + 1          # (i,j) = # esempi di classe vera i predetti come j
    restituisci M                       # diagonale = predizioni corrette
```
