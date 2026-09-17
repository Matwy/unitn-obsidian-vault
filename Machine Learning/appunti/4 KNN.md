---
date: 2026/05/25
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec4-KNN.pdf]]"
---
## 4 KNN

> [!abstract] Idea di fondo
> Il **k-Nearest Neighbor** classifica un nuovo esempio guardando i **k esempi più vicini** nel training set e prendendo la label di **maggioranza**. È il primo algoritmo di classificazione concreto del corso.

# 1. Dagli esempi allo spazio delle feature
- Ogni esempio è un **vettore di feature** $x = [x_1, \dots, x_d]$.
- Quindi ogni esempio è un **punto in uno spazio $d$-dimensionale** (d = numero di feature).
- Classificare = capire in quale "regione" dello spazio cade un nuovo punto.

# 2. L'algoritmo k-NN
Per classificare un esempio $d$:
1. Trova i **k vicini più prossimi** di $d$ nel training set.
2. Assegna la **label di maggioranza** tra questi k vicini.

- Con **k = 1** si prende semplicemente la label dell'esempio più vicino (sensibile al rumore).
- Usare **k > 1** rende il metodo **robusto al rumore**.

# 3. Come si misura "vicino"? Distanze e similarità

## Distanza Euclidea
In $d$ dimensioni, tra $a=(a_1,\dots,a_d)$ e $b=(b_1,\dots,b_d)$:
$$D(a,b) = \sqrt{\sum_{i=1}^{d} (a_i - b_i)^2}$$

> [!warning] Le feature devono essere comparabili
> La distanza euclidea ha senso solo se le feature sono sulla **stessa scala**. Se mescoli (es.) lunghezza e peso, le feature con valori grandi dominano. Soluzione: **standardizzare** prima di calcolare le distanze.

### Standardizzazione & Scaling
- **Standardization (Z-score)**: rende media = 0 e deviazione standard = 1. $\quad z = \frac{x - \mu}{\sigma}$
- **Min-Max scaling**: porta i dati in un range fisso, tipicamente $[0,1]$.
→ rendono tutte le feature **ugualmente importanti**.

## Distanza di Minkowski (generalizza l'euclidea)
$$D(a,b) = \left( \sum_{i=1}^{d} |a_i - b_i|^r \right)^{1/r}$$
- $r = 1$ → **Manhattan / City block** (norma $L_1$).
- $r = 2$ → **Euclidea** (norma $L_2$).
- $r \to \infty$ → **supremum** (norma $L_\infty$): la massima differenza tra le componenti.

## Cosine Similarity
$$C(a,b) = \frac{a \cdot b}{\|a\| \, \|b\|}$$
- Misura il **coseno dell'angolo** tra due vettori → guarda la **direzione**, ignora la magnitudine.
- Valori: **1** = perfettamente allineati, **0** = ortogonali (no similarità), **−1** = direzioni opposte.
- Distanza derivata: $D(a,b) = 1 - C(a,b)$.
- Molto usata per la **similarità tra documenti**.

> [!note] Distanza vs Similarità
> **Similarità**: alta quando gli oggetti sono simili (spesso in $[0,1]$). **Distanza**: bassa quando sono simili (minimo spesso 0). La scelta della metrica è **domain-specific**.

# 4. Decision boundaries e Diagramma di Voronoi
- Le **decision boundaries** sono i luoghi nello spazio delle feature dove cambia la classificazione.
- k-NN dà confini **definiti localmente**.
- k-NN **non calcola esplicitamente** i confini: essi sono un **sottoinsieme del diagramma di Voronoi** del training set (Voronoi = aree più vicine a ciascun punto, i segmenti sono equidistanti tra due punti).
- Più esempi memorizzi → confini **più complessi**.

# 5. La scelta di k (collegata a over/underfitting)

> [!important] Il ruolo di k
> - **k piccolo (k=1)** → confine frastagliato, training error basso, **molto sensibile al rumore** → **OVERFITTING**.
> - **k grande** → confine **liscio**, training error più alto → **UNDERFITTING**.
> - Se **k = N** (tutti i punti) → predice sempre la **classe di maggioranza** del dataset.
> - **Trade-off**: scegliere il k che minimizza l'errore di **validation/test**.

## Come scegliere k in pratica
- Euristiche comuni: spesso **3, 5, 7**; scegliere un numero **dispari** per evitare pareggi.
- Usare **validation set** o **cross-validation**.
- Rule of thumb: $k < \sqrt{N}$ (N = numero di esempi di training).

# 6. Cross-Validation (digressione)
Metodo di resampling per **stimare la performance di generalizzazione** e selezionare gli iperparametri.
**Procedura (k-fold):**
1. Dividi il dataset in **m fold** uguali.
2. Per ogni fold: allena su **m−1 fold**, valida sul fold rimanente.
3. Ripeti m volte (ogni fold usato una volta come validation).
4. Calcola l'**errore medio** di validation sui fold.

→ stima più **affidabile** del test error; aiuta a scegliere la complessità del modello (k in kNN, parametro di regolarizzazione, ecc.).

# 7. Varianti: Weighted k-NN
Invece di dare uguale peso a tutti i k vicini, **pesa il voto** in base alla vicinanza: i vicini più prossimi contano di più. Tipicamente peso $\propto 1/d_i$ (con un piccolo termine per evitare instabilità numerica quando la distanza → 0).

# 8. Proprietà e limiti

## Lazy vs Eager learner
- **Lazy learning** (k-NN): memorizza solo i dati e lavora **al momento della predizione**. Training quasi nullo, **predizione lenta**.
- **Eager learning** (Decision Trees, SVM): costruisce il modello **prima** di vedere i test data.

## Parametrico vs non-parametrico
- **Parametrici**: numero **finito** di parametri (regressione lineare/logistica, SVM lineari).
- **Non-parametrici**: il numero di parametri **cresce col training set** → k-NN, decision trees, SVM non lineari.

## Curse of Dimensionality (maledizione della dimensionalità)
- In **alta dimensione** quasi tutti i punti sono **lontani** tra loro.
- Lo spazio cresce **esponenzialmente** col numero di dimensioni → servono **esponenzialmente** più dati per mantenere la stessa densità.
- k-NN richiede che un punto sia vicino **in ogni singola dimensione** → soffre particolarmente: senza un dataset denso **perde potere predittivo**.

## Costo computazionale
- Memoria: $O(dN)$.
- Inferenza per punto: calcola la distanza su tutti gli N punti → $O(dN)$ → **lento** su grandi dataset e in alta dimensione.
- Si accelera con **KD-trees**, **Ball trees** o metodi **approssimati (ANN)**.

# 9. Riepilogo k-NN
**Quando usarlo:** poche feature (es. < 20) e **tanti** dati di training.

| Vantaggi | Svantaggi |
|----------|-----------|
| Facile da programmare | **Lento in inferenza** |
| Nessun training/ottimizzazione | Ingannato da **attributi irrilevanti** |
| Può apprendere funzioni complesse | Soffre la **curse of dimensionality** |
| Accuratezza talvolta ottima (batte modelli più complessi) | Memory-based: scansiona i dati a ogni classificazione |

> [!example] Esempio reale: im2gps
> "Dove è stata scattata questa foto?" → 6M immagini da Flickr con GPS, feature significative, k-NN con **k = 120**.

# Da padroneggiare
1. L'algoritmo k-NN (k vicini → voto di maggioranza).
2. Distanza euclidea + perché serve standardizzare; Minkowski (L1/L2/L∞) e cosine similarity.
3. Relazione **k ↔ over/underfitting** e come scegliere k (validation/CV, dispari, $k<\sqrt{N}$).
4. Decision boundary come sottoinsieme del **Voronoi**.
5. Lazy vs eager, parametrico vs non-parametrico.
6. **Curse of dimensionality** e costo computazionale $O(dN)$.
