---
date: 2026/05/25
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec2-MLBasics.pdf]]"
---
## 2 MLBasics

> [!abstract] Idea di fondo
> L'obiettivo del ML (Murphy) è **scoprire pattern nei dati** e usarli per **predire dati futuri**.

# 1. Il processo di apprendimento (pipeline ML)
Pipeline a 5 stadi, **iterativa** (si torna indietro a raffinare in base ai risultati della valutazione):

1. **Data acquisition** → raccolta dati (sensori, telecamere, database). Conta qualità e rilevanza.
2. **Preprocessing** → pulizia dei dati: valori mancanti, outlier, trasformazioni. Tecniche comuni: **normalizzazione, feature scaling, gestione variabili categoriche**.
3. **Dimensionality reduction** → ridurre il numero di feature (troppe feature → rumore + costo computazionale) preservando l'informazione importante.
4. **Model learning** → cuore della pipeline: si allena un modello sui dati preprocessati. La scelta dipende dal problema (classificazione/regressione) e dai dati. Es: regressione lineare, alberi di decisione, SVM, reti neurali.
5. **Model testing** → valutazione su un **test set separato** (mai visto in training) con metriche: accuracy, precision, recall, F1-score, MSE.

> [!important] Train e test sono **disgiunti**: è ciò che permette di misurare la generalizzazione.

# 2. Dati e Features
- **Example** = una singola osservazione/campione.
- Ogni esempio è rappresentato da un **vettore di features**: $x = [x_1, x_2, \dots, x_d]$, con $d$ = numero di feature (dimensionalità).
- Le **feature** sono *"le domande che possiamo porre sugli esempi"*: il modo in cui l'algoritmo **"vede" i dati**.

> [!warning] Take-home message
> Mappare i dati grezzi in feature comporta quasi sempre una **perdita di informazione**: le feature sono rappresentazioni derivate/selezionate (semplificazione e astrazione). Il dato grezzo contiene più informazione delle feature estratte.

# 3. Tipi di apprendimento

## A) Supervised Learning (dati **etichettati**)
Dato un training set $T = \{(x_1, y_1), \dots, (x_N, y_N)\}$, si impara una funzione che predice $y$ dato $x$ ($x$ generalmente multidimensionale).

| Tipo | Etichetta $y$ | Esempi |
|------|---------------|--------|
| **Classification** | insieme finito di classi | spam detection, face/character recognition, diagnosi medica, biometria |
| **Regression** | valore reale (continuo) | prezzo azioni, angolo volante, meteo nel tempo |
| **Ranking** | un ordine | ranking Netflix, image retrieval, ricerca voli |

## B) Unsupervised Learning (dati **senza etichette**)
Dato $T = \{x_1, \dots, x_N\}$, si cerca la struttura nascosta:
- **Clustering** → raggruppa esempi simili (social network, genomica, segmentazione di immagini). Include **anomaly detection** (flaggare eventi atipici, es. videosorveglianza).
- **Dimensionality reduction** → mappa i dati in uno spazio a dimensione $m \ll d$ preservando l'informazione importante.
- **Density estimation** → trova la distribuzione di probabilità che fitta i dati.

## C) Reinforcement Learning (per **tentativi e ricompense**)
Un **agente** interagisce con un **ambiente**, compie **azioni**, riceve **reward**, impara la strategia che massimizza la ricompensa a lungo termine.
- Esempio: robot su griglia → *state* = posizione, *actions* = su/giù/sx/dx, *reward* = +10 al goal, −1 altrimenti → impara il percorso più breve.
- Esempi: giochi, navigazione robot.

## Varianti minori
- **Semi-supervised**: pochi dati etichettati + molti non etichettati.
- **Active learning**: il modello sceglie quali esempi far etichettare a un *oracolo*.
- **Online vs Offline (batch) learning**:
	- *Batch/Offline*: impara dall'intero dataset in una volta, poi il modello è fisso. Serve che i dati stiano in memoria.
	- *Online*: impara incrementalmente da ogni nuovo dato/piccoli batch; si adatta a distribuzioni che cambiano nel tempo; adatto a dati sequenziali/risorse limitate.

# 4. Generalizzazione (concetto centrale)
- **Generalizzazione** = capacità del modello allenato di funzionare bene su **dati nuovi e mai visti**. → *"Learning is about generalizing from the training data."*
- Perché sia possibile, training set e test set devono essere **"simili"**. Se sono troppo diversi → **l'apprendimento non è possibile**.

## Formalizzazione probabilistica
- Esiste una **data generating distribution**: distribuzione di probabilità sulle coppie (esempio, etichetta).
- Sia il **training set** che il **test set** sono generati da **questa stessa distribuzione**.
- È **sconosciuta**: ne abbiamo solo una rappresentazione indiretta tramite il training set. Cattura pattern, struttura e rumore dei dati.

## Recap di probabilità
- Una distribuzione assegna probabilità a tutti gli eventi possibili; ogni probabilità in $[0,1]$ e **somma totale = 1**.
- **Discreta** → descritta dalla **PMF** (Probability Mass Function), assegna probabilità a valori specifici. Es: Bernoulli (0/1).
- **Continua** → descritta dalla **PDF** (Probability Density Function) $f(x)$, probabilità su un intervallo. Es: Normale (gaussiana).

# Da padroneggiare
1. I 5 stadi della pipeline e perché train/test sono separati.
2. Feature = vettore $[x_1, \dots, x_d]$, e che la feature-extraction **perde informazione**.
3. Classificare un problema: supervised (classification/regression/ranking) vs unsupervised (clustering/dim.red./density est.) vs reinforcement, con esempi.
4. **Generalizzazione** + assunzione della **data generating distribution** (train e test dalla stessa distribuzione sconosciuta).
5. PMF vs PDF.
