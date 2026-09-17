---
date: 2026/05/25
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec3-MLBasics.pdf]]"
---
## 3 MLBasics

> [!abstract] Idea di fondo
> Formalizziamo **cos'è** un problema di ML attraverso i suoi "ingredienti" e introduciamo i concetti chiave di **errore di generalizzazione**, **overfitting/underfitting** e **capacità del modello**.

# 1. Perché serve il learning
Per alcuni problemi (es. classificare immagini) scrivere regole esplicite è **quasi impossibile**. La soluzione del ML in 4 passi:
1. Raccogliere dati (annotati).
2. Definire una **famiglia di modelli** per il task.
3. Definire una **funzione di errore** che misura quanto bene un modello fitta i dati.
4. Trovare il modello che **minimizza l'errore** → questo è **TRAIN / LEARN**.

# 2. Gli ingredienti del ML
Un problema di ML è definito da:

| Ingrediente | Significato |
|-------------|-------------|
| **Task** | il tipo di predizione da fare |
| **Data** | l'informazione sul problema (sotto forma di distribuzione) |
| **Model / Hypothesis space** | la famiglia di funzioni candidate |
| **Objective** | la funzione di errore da minimizzare |
| **Learning algorithm** | la procedura che cerca la soluzione |

## Task
Un task si identifica con **l'insieme di funzioni che potrebbero risolverlo**. In generale assegna a ogni input $x$ un output. Spazio di input/output dipendono dal task:
- **Classification** → funzione che assegna a $x$ una **label discreta**.
- **Regression** → funzione che assegna a $x$ una **label continua**.
- **Clustering** → funzione che assegna a $x$ un **indice di cluster** (i punti con lo stesso indice formano un cluster).
- **Dimensionality reduction** → funzione che mappa $x$ (alta dim.) in un **embedding a dimensione minore** $m \ll d$.
- **Density estimation** → trova una **distribuzione di probabilità** $p(x)$ che fitta i dati.

## Data
- Informazione sul problema, sotto forma di **distribuzione**.
- La data distribution è tipicamente **sconosciuta**, ma possiamo **campionare** da essa → otteniamo **training set**, **validation set**, **test set**.

> [!warning] Training set design
> Il fallimento di un algoritmo è spesso causato da una **cattiva selezione dei campioni di training**: si introducono **correlazioni spurie** da cui l'algoritmo trae conclusioni sbagliate.
> *(Aneddoto dei carri armati: il modello aveva imparato a riconoscere la luminosità — soleggiato vs nuvoloso — invece dei carri stessi.)*

## Model & Hypothesis space
- Un **modello** è come un "programma" per risolvere il problema: l'implementazione di una funzione $f$ calcolabile in modo trattabile.
- Un insieme di modelli forma uno **spazio delle ipotesi** $\mathcal{H}$ (es. reti neurali, alberi di decisione).
- Il learning algorithm cerca una soluzione **dentro** $\mathcal{H}$.

# 3. Objective: i quattro "target" dell'errore
Si passa dall'obiettivo ideale (irraggiungibile) a quello concreto:

1. **Ideal target** → minimizzare l'**errore di generalizzazione** su *tutte* le funzioni possibili. Non calcolabile (spazio troppo grande + distribuzione sconosciuta).
2. **Feasible target** → ci si restringe allo spazio delle ipotesi $\mathcal{H}$. Ancora non calcolabile esattamente perché la distribuzione dati è sconosciuta.
3. **Actual target** → si lavora su un **training set**: si minimizza il **training error**.
4. **Learning output** → ciò che l'algoritmo trova effettivamente (può fermarsi in una soluzione subottima).

## Funzione di errore
Sia generalization error che training error si scrivono in termini di una **loss puntuale** $\ell$ che misura l'errore su ogni esempio:
- **Generalization error** = valore atteso della loss sulla distribuzione dati.
- **Training error** = media della loss sugli esempi del training set.

> [!example] Polynomial curve fitting (esempio guida)
> Dati generati da una funzione + rumore. Loss puntuale = errore quadratico. Minimizzare l'objective equivale a **risolvere un sistema lineare di equazioni**.

## Learning algorithm
Risolve il problema di ottimizzazione, ma può finire in un risultato diverso dall'ottimo. Nelle reti neurali: problemi di **saddle points** e **minimi locali**.

# 4. Overfitting & Underfitting

> [!important] Obiettivo: minimizzare l'**errore di generalizzazione** (proxy: test error), non solo il training error.

| Regime | Training error | Generalization error | Descrizione |
|--------|----------------|----------------------|-------------|
| **Underfitting** | alto | alto | modello troppo **semplice**, non cattura i pattern |
| **Ideal** | basso | basso | piccolo **gap** tra train e test error |
| **Overfitting** | molto basso | alto | modello troppo **complesso**, **memorizza** i dati (incluso il rumore) |

# 5. Decomposizione dell'errore di generalizzazione
- **Approximation error**: errore indotto dallo **spazio delle ipotesi** (gap tra ideal target e actual target) — quanto $\mathcal{H}$ è "abbastanza ricco".
- **Irreducible error**: porzione di errore che **non si può eliminare**, qualunque modello o quantità di dati. Dovuto a:
	- errori di misura,
	- variabili nascoste/non osservate,
	- casualità intrinseca (es. comportamento umano).
	→ rappresenta l'**incertezza fondamentale** del problema.

# 6. Model Capacity
**Capacità** = abilità di un modello di fittare un'ampia varietà di funzioni.
- **Alta capacità** → rappresenta pattern molto complessi → rischio **overfitting**.
- **Bassa capacità** → solo pattern semplici → **underfitting**.

Controllata da: **numero di parametri**, **architettura** (es. profondità della rete), **dimensionalità delle feature**.

# 7. Come migliorare la generalizzazione
- Evitare di raggiungere il minimo assoluto sul training error.
- **Ridurre la capacità** del modello.
- Aggiungere un termine di **regolarizzazione** all'objective (penalizza soluzioni complesse, es. coefficienti polinomiali grandi).
- **Iniettare rumore** nell'algoritmo di learning.
- **Aggiungere più dati di training** (es. **data augmentation** con trasformazioni).
- **Ensembling**: combinare predizioni di **più modelli decorrelati**.

> [!note] Validation set
> L'errore di generalizzazione si **stima** tenendo separati training / validation / test set: il validation serve a scegliere il modello/iperparametri, il test a misurare la performance finale.

# Da padroneggiare
1. I 5 ingredienti del ML (Task, Data, Model/Hypothesis space, Objective, Learning algorithm).
2. La catena dei 4 target dell'errore: ideal → feasible → actual → learning output.
3. Differenza tra training error e generalization error, e i 3 regimi (under/ideal/over).
4. Decomposizione: approximation error + irreducible error.
5. Concetto di **capacità** e come si controlla.
6. Le tecniche per migliorare la generalizzazione (in particolare regolarizzazione, data augmentation, ensembling).
