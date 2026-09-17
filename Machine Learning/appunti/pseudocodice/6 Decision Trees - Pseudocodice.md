---
date: 2026/06/11
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec6 - Decision_Trees.pdf]]"
---
## 6 Decision Trees - Pseudocodice

### Costruzione ricorsiva dell'albero (DecisionTreeTrain / ID3)

> Euristica greedy: a ogni nodo si sceglie lo split (attributo + valore) col gain migliore, poi si ricorre sulle sotto-partizioni finché un criterio di stop non è soddisfatto.

```
funzione DecisionTreeTrain(R):                  # R = insieme di esempi del nodo
    se CondizioneDiStop(R) allora
        # foglia: classificazione = majority vote
        restituisci Foglia( y* = argmax_{t in {1,...,C}} Σ_i 1{t = t_i} )
        # (regressione: y* = (1/k) Σ_i t_i  → media dei target)

    # cerca il miglior split tra tutti gli attributi e tutte le soglie
    miglior_gain ← -∞
    per ogni attributo a:
        per ogni valore/soglia v candidata di a:
            (R1, R2) ← Partiziona(R, a, v)        # es. a > v  vs  a ≤ v
            gain ← Gain(R, R1, R2)                 # IG, accuracy gain, o -Gini
            se gain > miglior_gain allora
                miglior_gain ← gain
                (a*, v*, R1*, R2*) ← (a, v, R1, R2)

    nodo ← NodoInterno(test: a* > v*)
    nodo.sinistro  ← DecisionTreeTrain(R1*)        # ricorsione
    nodo.destro    ← DecisionTreeTrain(R2*)        # ricorsione
    restituisci nodo


funzione CondizioneDiStop(R):
    # fermati se tutti gli esempi in R hanno la STESSA classe (foglia pura)
    se tutti gli esempi di R hanno la stessa label allora restituisci vero
    restituisci falso
```

### Predizione (discesa dell'albero)

```
funzione DecisionTreePredict(albero, x):
    nodo ← radice(albero)
    mentre nodo non è una foglia:
        se test_del_nodo(x) è vero allora      # es. x[a] > v
            nodo ← nodo.sinistro
        altrimenti
            nodo ← nodo.destro
    restituisci nodo.y*                         # classe (majority) o media (regressione)
```

### Criteri di split (gain)

> Si calcola il criterio sul padre R e la media pesata sui figli R1, R2; si sceglie lo split con Information Gain / accuracy gain più alto, oppure con Gini più basso.

```
funzione Entropia(R):
    # H(R) = - Σ_x p(x) log2 p(x)
    H ← 0
    per ogni classe j in R:
        p_j ← frazione di esempi di classe j in R
        se p_j > 0 allora  H ← H - p_j * log2(p_j)
    restituisci H

funzione Gini(R):
    # GINI(R) = 1 - Σ_j p(j|R)^2
    g ← 1
    per ogni classe j in R:
        p_j ← frazione di esempi di classe j in R
        g ← g - p_j^2
    restituisci g

funzione InformationGain(R, R1, R2):
    # IG = H(R) - { (|R1|/|R|) H(R1) + (|R2|/|R|) H(R2) }
    restituisci Entropia(R) - ( (|R1|/|R|)*Entropia(R1) + (|R2|/|R|)*Entropia(R2) )

funzione AccuracyGain(R, R1, R2):
    # L(R) = errore di misclassificazione (frazione di esempi non nella classe di maggioranza)
    # gain = L(R) - ( |R1| L(R1) + |R2| L(R2) ) / |R|
    restituisci L(R) - ( |R1|*L(R1) + |R2|*L(R2) ) / |R|

funzione GiniSplit(R, R1, R2):
    # impurità media pesata dei figli: si SCEGLIE lo split che la MINIMIZZA
    restituisci (|R1|/|R|)*Gini(R1) + (|R2|/|R|)*Gini(R2)
```

### Pruning (potatura a posteriori)

```
funzione Pruning(albero, validation_set):
    ripeti finché conviene:
        per ogni sottoalbero candidato S:
            sostituisci S con una Foglia (majority vote degli esempi di S)
            se l'errore su validation_set NON peggiora allora
                mantieni la sostituzione        # albero più semplice
            altrimenti
                ripristina il sottoalbero S
    restituisci albero
```
