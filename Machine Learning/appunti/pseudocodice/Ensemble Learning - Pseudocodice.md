---
date: 2026/06/15
tags:
Materia: "[[Machine Learning]]"
---
## Ensemble Learning - Pseudocodice

### Bagging (Bootstrap Aggregating)

> Si allenano M modelli in parallelo, ognuno su un bootstrap sample diverso (resampling con reinserimento); si aggregano gli output per ridurre la varianza.

```
funzione BaggingTrain(dataset D, M):
    per m = 1 ... M:
        D_m ← BootstrapSample(D)        # campiona |D| esempi da D CON reinserimento
        h_m ← AddestraModello(D_m)      # es. un Decision Tree
    restituisci {h_1, ..., h_M}

funzione BaggingPredict({h_1,...,h_M}, x):
    # Classificazione (hard voting): voto di maggioranza
    restituisci argmax_c  Σ_{m=1}^{M} 1{ h_m(x) = c }
    # Regressione: media  →  ŷ = (1/M) Σ_{m=1}^{M} h_m(x)
    # Soft voting: p̂_c = (1/M) Σ_m p_c^(m) ; poi argmax_c p̂_c
```

### Random Forest

> È un bagging di Decision Tree con feature randomness: a ogni split si considera solo un sottoinsieme casuale di feature, così gli alberi si decorrelano.

```
funzione RandomForestTrain(dataset D, M, k):   # k = # feature considerate per split
    per m = 1 ... M:
        D_m ← BootstrapSample(D)               # con reinserimento
        h_m ← DecisionTreeTrain(D_m) con la modifica:
                  ad ogni nodo, scegli il miglior split
                  SOLO tra k feature estratte a caso (su tutte le feature)
    restituisci {h_1, ..., h_M}

funzione RandomForestPredict({h_1,...,h_M}, x):
    restituisci argmax_c  Σ_{m=1}^{M} 1{ h_m(x) = c }   # majority vote (o media in regressione)
```

### AdaBoost (Adaptive Boosting)

> Boosting: i modelli sono addestrati in sequenza; ogni round aumenta il peso degli esempi sbagliati dal modello precedente. Riduce il bias.

```
funzione AdaBoostTrain(dataset {(x_i, t_i)} con i = 1..N,  M):
    inizializza i pesi  w_i ← 1/N   per ogni i
    per m = 1 ... M:
        # 1. weak learner che minimizza l'errore pesato
        h_m ← AddestraWeakLearner(dataset, pesi w)

        # 2. errore pesato:  ε_m = ( Σ_i w_i · 1[h_m(x_i) ≠ t_i] ) / ( Σ_i w_i )
        ε_m ← ( Σ_i w_i * 1[h_m(x_i) ≠ t_i] ) / ( Σ_i w_i )

        # 3. peso del modello:  α_m = (1/2) ln( (1 - ε_m) / ε_m )
        α_m ← 0.5 * ln( (1 - ε_m) / ε_m )

        # 4. aggiorna i pesi (↑ sugli errori) e rinormalizza
        per ogni i:
            w_i ← w_i * exp( α_m * 1[h_m(x_i) ≠ t_i] )
        normalizza i pesi così che Σ_i w_i = 1

    # predizione finale: somma pesata dei voti
    restituisci H(x) = sign( Σ_{m=1}^{M} α_m · h_m(x) )
```

### Gradient Boosting

> Generalizza il boosting come discesa del gradiente nello spazio delle funzioni: ogni nuovo modello fitta i residui (gradiente negativo della loss) del modello corrente.

```
funzione GradientBoostingTrain(dataset {(x_i, t_i)},  M,  ν):   # ν = learning rate
    inizializza F_0(x) ← modello costante (es. media dei target)
    per m = 1 ... M:
        # residui = gradiente negativo della loss valutato in F_{m-1}
        per ogni i:  r_i ← -[ ∂L(t_i, F(x_i)) / ∂F(x_i) ]  valutato in F = F_{m-1}
        h_m ← AddestraModello su {(x_i, r_i)}          # fitta i residui
        F_m(x) ← F_{m-1}(x) + ν · h_m(x)               # aggiornamento
    restituisci F_M
```

### Stacking (Stacked Generalization)

```
funzione StackingTrain(dataset D, modelli_base {g_1,...,g_L}):
    per l = 1 ... L:
        g_l ← AddestraModello(g_l, D)             # modelli base eterogenei (SVM, k-NN, albero, ...)
    # costruisci nuove feature dalle predizioni dei modelli base
    D' ← { ( [g_1(x), ..., g_L(x)], t ) per ogni (x, t) in D }
    meta_modello ← AddestraModello(D')            # impara a combinare le predizioni
    restituisci ({g_1,...,g_L}, meta_modello)

funzione StackingPredict(({g_1,...,g_L}, meta_modello), x):
    z ← [ g_1(x), ..., g_L(x) ]
    restituisci meta_modello(z)
```
