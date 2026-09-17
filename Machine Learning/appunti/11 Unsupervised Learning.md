---
date: 2026/06/12
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec11-Unsupervised Learning.pdf]]"
---
## 11 Unsupervised Learning

> [!abstract] Idea di fondo
> Finora abbiamo fatto **supervised learning**: avevamo gli esempi **e le etichette**. Nell'**unsupervised learning** abbiamo **solo i dati**, senza etichette: il "segnale di apprendimento" è dato implicitamente dal **design della funzione obiettivo**. Tre famiglie di problemi: **(1) Dimensionality Reduction** — comprimere i dati riducendo il numero di feature (es. **PCA**); **(2) Clustering** — raggruppare i punti simili (es. **K-Means**); **(3) Density Estimation** — stimare la distribuzione di probabilità che ha generato i dati. Questa lezione approfondisce **PCA** e **K-Means**, con il ripasso di algebra lineare (covarianza, autovalori/autovettori) necessario per capirli.

# 1. Cos'è l'unsupervised learning
- Osserviamo dati da una distribuzione **sconosciuta** $p_{data} \in \Delta(\mathcal{X})$.
- **Mancano** le osservazioni di una variabile target (es. le **etichette** di classe).
- La supervisione è data **implicitamente** dal **design della funzione obiettivo**.

Tre task principali:
- **Dimensionality Reduction**
- **Clustering**
- **Density Estimation**

## Dimensionality Reduction
> [!important] Definizione
> Trovare una funzione $f \in \mathcal{Y}^{\mathcal{X}}$ che mappa ogni input (ad **alta dimensione**) $x \in \mathcal{X}$ in un **embedding a dimensione più bassa** $f(x) \in \mathcal{Y}$, con
> $$\dim(\mathcal{Y}) \ll \dim(\mathcal{X})$$

> [!note] Perché farlo?
> - **comprimere** i dati riducendo la dimensionalità delle feature, **preservando più informazione possibile** (il modo in cui si misura la perdita di informazione dà algoritmi diversi);
> - **riduce il tempo** di elaborazione e lo **storage**;
> - permette una **migliore visualizzazione** dei dati;
> - riduce la **curse of dimensionality** (maledizione della dimensionalità).

## Clustering (partizionale)
> [!important] Definizione
> Trovare una funzione $f \in \mathbb{N}^{\mathcal{X}}$ che assegna a ogni input $x \in \mathcal{X}$ un **indice di cluster** $f(x) \in \mathbb{N}$. Tutti i punti mappati allo **stesso indice** formano un **cluster**.

> [!note] Perché farlo?
> - **analizzare i dati raggruppando** insieme punti che mostrano un pattern/similarità secondo un criterio;
> - **comprimere i dati** riducendo il **numero di punti** (anziché ridurre la dimensione delle feature);
> - **applicazioni:** raggruppare utenti per preferenze (es. rating dei film), famiglie di geni, community nei social network.

## Density Estimation
> [!important] Definizione
> Trovare una **distribuzione di probabilità** $f \in \Delta(\mathcal{X})$ che **fitta** i dati $x \in \mathcal{X}$.

> [!note] Perché farlo?
> - ottenere una **stima esplicita** della distribuzione sconosciuta che ha generato i dati;
> - **generare nuovi dati** campionando dalla distribuzione stimata;
> - **rilevare anomalie/novelties** = punti con **bassa probabilità** secondo la distribuzione stimata.

# 2. Principal Component Analysis (PCA)
> [!important] Idea principale
> - trovare le **direzioni ortogonali di massima varianza**;
> - **cambiare sistema di coordinate** (allinearlo a queste direzioni);
> - **eliminare le dimensioni a varianza minima** (quelle "poco informative").
>
> Le direzioni di massima varianza si chiamano **componenti principali**. Esempio: dati 2D allungati in diagonale → la 1ª componente segue la diagonale, la 2ª è perpendicolare; tenendo solo la 1ª si passa da 2D a 1D perdendo poco.

## Varianza lungo una direzione unitaria $w$
Consideriamo una direzione $\mathbf{w}$ **unitaria** ($\mathbf{w}^T\mathbf{w} = 1$) e proiettiamo i dati su di essa. La proiezione (centrata) del punto $\mathbf{x}_i$ è:
$$t_i = (\mathbf{x}_i - \mathbf{c})^T \mathbf{w}$$

> [!note] Cosa significa questa formula, pezzo per pezzo
> - $\mathbf{c}$ è il **centro** dei dati (la **media** $\bar{\mathbf{x}}$): lo usiamo come **nuova origine**, così la proiezione è "centrata".
> - $\mathbf{x}_i - \mathbf{c}$ è il **vettore che va dal centro al punto** $\mathbf{x}_i$: descrive *dove si trova* $\mathbf{x}_i$ rispetto al centro (direzione e distanza dalla media).
> - $(\mathbf{x}_i - \mathbf{c})^T \mathbf{w}$ è il **prodotto scalare** tra quel vettore e la direzione $\mathbf{w}$. Un **vettore trasposto** (riga) **per un vettore** (colonna) dà uno **scalare** (un numero):
>   $$(\mathbf{x}_i - \mathbf{c})^T \mathbf{w} = \|\mathbf{x}_i - \mathbf{c}\|\,\|\mathbf{w}\|\cos\theta = \|\mathbf{x}_i - \mathbf{c}\|\cos\theta$$
>   (l'ultimo passaggio vale perché $\|\mathbf{w}\|=1$). Geometricamente, $t_i$ è **quanto "avanza" il punto lungo la direzione $\mathbf{w}$**: la lunghezza dell'**ombra** (proiezione ortogonale) di $\mathbf{x}_i - \mathbf{c}$ sull'asse individuato da $\mathbf{w}$.
> - Il **segno** di $t_i$ dice da che parte sta il punto rispetto al centro lungo $\mathbf{w}$: positivo se è "nel verso" di $\mathbf{w}$, negativo se nel verso opposto, zero se è perpendicolare a $\mathbf{w}$.

> [!note] Media e varianza delle proiezioni
> **Media:**
> $$\mathbb{E}[t] = \frac{1}{n}\sum_{i=1}^{n} t_i = \frac{1}{n}\sum_{i=1}^{n}(\mathbf{x}_i - \mathbf{c})^T\mathbf{w} = \bar{\mathbf{x}}^T\mathbf{w} - \mathbf{c}^T\mathbf{w}$$
> **Varianza:**
> $$\text{Var}[t] = \frac{1}{n}\sum_{i=1}^{n}(t_i - \mathbb{E}[t])^2 = \frac{1}{n}\sum_{i=1}^{n}\big[(\mathbf{x}_i - \bar{\mathbf{x}})^T\mathbf{w}\big]^2 = \mathbf{w}^T \underbrace{\bigg[\frac{1}{n}\bar{X}\bar{X}^T\bigg]}_{C} \mathbf{w} = \mathbf{w}^T C \mathbf{w}$$
> dove $C$ è la **matrice di covarianza** dei dati centrati. **Risultato chiave:** la varianza lungo $\mathbf{w}$ è $\mathbf{w}^T C \mathbf{w}$.

## Ripasso: Covarianza
> [!note] Definizioni
> - **Varianza e covarianza** misurano lo "**spread**" (dispersione) dei punti attorno al loro centro di massa (media).
> - **Varianza:** deviazione dalla media per i punti in **una** dimensione.
> - **Covarianza:** quanto **due** dimensioni variano dalla media **l'una rispetto all'altra** (se c'è una relazione tra le due dimensioni).
>   - **covarianza positiva** → le due dimensioni crescono/calano **insieme**;
>   - **covarianza negativa** → mentre una cresce, l'altra **cala**.

## Ripasso: Autovalori e Autovettori
> [!important] Definizione
> $$A\mathbf{x} = \lambda \mathbf{x}$$
> - $A$ = matrice **quadrata**;
> - $\mathbf{x}$ = **autovettore** (eigenvector): direzione che $A$ non ruota, solo "scala";
> - $\lambda$ = **autovalore** (eigenvalue): di quanto viene scalato.
>
> Gli autovalori si trovano risolvendo:
> $$\det(A - \lambda I) = 0$$

> [!example] Esempio
> Per $A = \begin{bmatrix} 2 & -12 \\ 1 & -5 \end{bmatrix}$: $\det(\lambda I - A) = (\lambda-2)(\lambda+5)+12 = \lambda^2+3\lambda+2 = (\lambda+1)(\lambda+2)$ → due autovalori $-1$ e $-2$.

## Ripasso: Eigenvalue Decomposition
> [!important] Decomposizione spettrale
> Data una matrice **simmetrica** $A \in \mathbb{R}^{m\times m}$, esistono $U = [\mathbf{u}_1, \dots, \mathbf{u}_m]$ e $\lambda = (\lambda_1, \dots, \lambda_m)^T$ tali che:
> $$A = U\Lambda U^T = \sum_{j=1}^{m}\lambda_j \mathbf{u}_j \mathbf{u}_j^T \qquad \text{e} \qquad U^T U = U U^T = I$$
> dove $\mathbf{u}_j$ è un autovettore e $\lambda_j$ il corrispondente autovalore. **Convenzione:** ordinamento decrescente $\lambda_1 \ge \lambda_2 \ge \dots \ge \lambda_m$. ($U$ ortogonale = gli autovettori sono perpendicolari tra loro.)

## Le componenti principali
> [!important] Prima componente principale
> La direzione unitaria che **massimizza la varianza** $\mathbf{w}^T C \mathbf{w}$:
> $$\mathbf{w}_1 \in \operatorname*{arg\,max}\{\mathbf{w}^T C \mathbf{w} \;:\; \mathbf{w}^T\mathbf{w} = 1\}$$
> Si dimostra che **l'autovalore più grande di $C$ è la varianza lungo la prima componente**, e la prima componente $\mathbf{w}_1$ è il corrispondente **autovettore**.

> [!note] Componenti successive
> **Seconda componente** (massima varianza, ma **ortogonale** alla prima):
> $$\mathbf{w}_2 \in \operatorname*{arg\,max}\{\mathbf{w}^T C \mathbf{w} \;:\; \mathbf{w}^T\mathbf{w} = 1,\; \mathbf{w} \perp \mathbf{w}_1\}$$
> **$i$-esima componente** (ortogonale a tutte le precedenti):
> $$\mathbf{w}_i \in \operatorname*{arg\,max}\{\mathbf{w}^T C \mathbf{w} \;:\; \mathbf{w}^T\mathbf{w} = 1,\; \mathbf{w} \perp \mathbf{w}_j \text{ per } 1 \le j < i\}$$
> In generale: l'$i$-esimo autovalore più grande di $C$ è la varianza lungo l'$i$-esima componente, e la componente è il corrispondente autovettore.

## PCA via Eigenvalue Decomposition (algoritmo)
> [!important] Algoritmo
> **Input:** punti $X = [\mathbf{x}_1, \dots, \mathbf{x}_n]$
> 1. **Centering:** $\;\bar{X} = X - \frac{1}{n}X \mathbf{1}_n \mathbf{1}_n^T$ (a ogni punto si sottrae la **media**);
> 2. **Matrice di covarianza:** $\;C = \frac{1}{n}\bar{X}\bar{X}^T$;
> 3. **Eigenvalue decomposition:** $\;U, \lambda = \text{eig}(C)$.
>
> **Output:** componenti principali $W = U = [\mathbf{u}_1, \dots, \mathbf{u}_m]$ e varianze $\lambda = (\lambda_1, \dots, \lambda_m)$.

## PCA via SVD (Singular Value Decomposition)
> [!note] Alternativa con la SVD
> **SVD:** data $A \in \mathbb{R}^{m\times n}$, esistono $U \in \mathbb{R}^{m\times k}$, valori singolari $s_1 \ge \dots \ge s_k > 0$ e $V \in \mathbb{R}^{n\times k}$ tali che:
> $$A = U S V^T \qquad \text{e} \qquad U^T U = V^T V = I$$
> **Algoritmo:** dopo il centering $\bar{X}$, si calcola $U, \mathbf{s}, V = \text{SVD}(\bar{X})$. Le componenti principali sono $U = [\mathbf{u}_1, \dots, \mathbf{u}_k]$ e le **varianze** sono $\left(\frac{s_1^2}{n}, \dots, \frac{s_k^2}{n}\right)$. (La SVD evita di calcolare esplicitamente la covarianza.)

## Ridurre la dimensionalità con PCA
> [!important] Proiezione sui $k$ componenti
> Sia $\hat{W} = [\mathbf{w}_1, \dots, \mathbf{w}_k]$ che contiene i **primi $k$ componenti principali**. Si cambia coordinate proiettando i dati centrati $\bar{X}$ sui $k$ componenti:
> $$T = \hat{W}^T \bar{X} \in \mathbb{R}^{k\times n}$$
> $T$ contiene i **principal component scores** (le coordinate dei punti nel nuovo sistema ridotto). Si possono usare eigenvalue decomposition o SVD che **evitano** di calcolare le decomposizioni complete.

> [!note] Interpretazione alternativa
> La prima componente principale può essere vista come la **retta nello spazio con distanza quadratica minima dai punti** (analoga interpretazione per le altre componenti). Quindi PCA = "miglior sottospazio" che approssima i dati.

> [!warning] Scaling delle variabili
> La **scala** delle feature conta! Se le feature sono espresse in **unità diverse**, è raccomandato **scalarle** in modo che abbiano **deviazione standard unitaria** (altrimenti la feature con valori più grandi domina la varianza).

## Esempio numerico (passo per passo)
> [!example] PCA su un dataset 2D
> 1. **Centering:** si sottrae la media → diventa la nuova origine.
> 2. **Covarianza:** $C = \begin{bmatrix} 0.616 & 0.615 \\ 0.615 & 0.716 \end{bmatrix}$ (elementi fuori diagonale **positivi** → $x$ e $y$ crescono insieme).
> 3. **Autovettori/autovalori:** $U = \begin{bmatrix} -0.735 & -0.677 \\ 0.677 & -0.735 \end{bmatrix}$, $[\lambda_1, \lambda_2] = [0.04,\ 1.28]$. (Gli autovettori sono perpendicolari; quello con autovalore $1.28$ è la 1ª componente.)
> 4. **Riduzione:** si possono tenere entrambi gli autovettori, oppure **scartare** quello meno significativo (autovalore piccolo $0.04$) → si passa da 2D a 1D perdendo poca informazione.

## Quante componenti principali?
> [!important] Cumulative explained variance
> Il **numero di componenti** dipende dall'obiettivo/applicazione. Non c'è un modo diretto di validarlo (a meno di usarlo dentro un metodo supervisionato). Si può però calcolare la **proporzione cumulativa di varianza spiegata** dai primi $k$ componenti:
> $$\text{(eigenvalue decomp.)} \quad \frac{\sum_{j=1}^{k}\lambda_j}{\sum_{j=1}^{m}C_{jj}} \qquad\qquad \text{(SVD)} \quad \frac{\sum_{j=1}^{k}s_j^2}{\sum_{ij}\bar{X}_{ji}^2}$$
> Questo permette di **stimare quanta informazione si perde** scartando le altre componenti.

## Kernel PCA e altre tecniche
> [!note] Kernel PCA (KPCA)
> PCA riduce la dimensionalità tramite una **trasformazione lineare**. Usando il **kernel trick** si può applicare PCA in uno spazio ad **alta dimensione**, ottenendo una trasformazione **non lineare** nello spazio originale.

> [!note] Altre tecniche di dimensionality reduction
> - **PCA:** trova la proiezione che **massimizza la varianza**.
> - **Multidimensional Scaling (MDS):** trova la proiezione che **preserva meglio le distanze** tra i punti.
> - **LDA (Linear Discriminant Analysis):** massimizza gli assi per la **separazione tra classi** (supervisionato).

# 3. Applicazione: Face Recognition (Eigenfaces)
> [!example] Riconoscimento facciale con PCA
> - Un'immagine di volto = **vettore di intensità** $\mathbf{x}$; un'immagine 100×100 ha **10.000 dimensioni**, ma pochissimi vettori a 10.000 dim sono volti validi → i volti vivono in un **sottospazio**, trovabile con **PCA**.
> - Gli autovettori principali si chiamano **eigenfaces**; la media è $\mu$.
> - **Rappresentazione** di un volto nelle coordinate del face space:
> $$\mathbf{x} \rightarrow \big[\mathbf{u}_1^T(\mathbf{x}-\mu),\ \dots,\ \mathbf{u}_k^T(\mathbf{x}-\mu)\big] = t_1, \dots, t_k$$
> - **Ricostruzione:** $\;\hat{\mathbf{x}} = \mu + \mathbf{u}_1 t_1 + \dots + \mathbf{u}_k t_k$ (più componenti $\Rightarrow$ ricostruzione più fedele).

> [!note] Algoritmo eigenfaces (detection & recognition)
> 1. Processa il database: **PCA** → eigenfaces; calcola i $K$ coefficienti per ogni immagine.
> 2. Per una nuova immagine $\mathbf{x}$: calcola i $K$ coefficienti.
> 3. **È un volto?** Distanza tra $\mathbf{x}$ e la sua ricostruzione < soglia.
> 4. **Di chi è?** Trova il volto etichettato più vicino nel database (**k-NN** nello spazio $K$-dimensionale).

# 4. K-Means Clustering
Setting unsupervised: ci vengono dati i **dati** (esempi), ma **nessuna etichetta**; vogliamo trovare i **raggruppamenti**. L'algoritmo di clustering più noto è **K-Means**.

> [!important] Funzione obiettivo
> Dati i punti $X = [\mathbf{x}_1, \dots, \mathbf{x}_n] \in \mathbb{R}^{d\times n}$, si **fissa il numero di cluster $k$** e si cerca la partizione dei punti in $k$ insiemi che **minimizza la variazione interna** a ogni cluster:
> $$\min_{\mathcal{C}_1, \dots, \mathcal{C}_k} \sum_{j=1}^{k} V(\mathcal{C}_j)$$
> dove la variazione di un cluster è la somma delle distanze quadratiche dal centroide:
> $$V(\mathcal{C}_j) = \sum_{i \in \mathcal{C}_j} \|\mathbf{x}_i - \boldsymbol{\mu}_j\|^2$$
> e il **centroide** è la media dei punti del cluster:
> $$\boldsymbol{\mu}_j = \frac{1}{|\mathcal{C}_j|}\sum_{i \in \mathcal{C}_j} \mathbf{x}_i$$

## Algoritmo
> [!important] K-Means (Lloyd)
> ```
> Inizializzazione: scegli k centroidi iniziali μ_1, ..., μ_k
> while i cluster cambiano:
>     # Step 1 — Assegnazione: ogni punto al centroide più vicino
>     C_j = { i ∈ {1,...,n} : j = argmin_ℓ ||x_i - μ_ℓ|| }
>     # Step 2 — Aggiornamento: ricalcola i centroidi
>     μ_1, ..., μ_k  (media dei punti di ogni cluster)
> ```
> Si alternano **assegnazione** (ogni punto al centroide più vicino) e **ricalcolo dei centroidi** finché le assegnazioni non cambiano più.

## Proprietà
> [!important] Convergenza
> - **Sensibile alla scala delle feature** → serve **normalizzare** se le feature hanno scale diverse.
> - **Garantito convergere**, perché migliora **strettamente** l'obiettivo a ogni cambio di cluster e l'insieme delle partizioni possibili è **finito**.
> - **NON** garantito trovare il **minimo globale**, solo uno **locale**.

> [!note] Perché ogni step non peggiora la loss
> - **Step 1 (assegnazione):** qualsiasi altra assegnazione darebbe una loss **maggiore** (ogni punto va al centroide più vicino);
> - **Step 2 (centroidi):** la **media** di un insieme di valori **minimizza l'errore quadratico**.
>
> Quindi entrambi i passi riducono (o lasciano uguale) l'obiettivo → convergenza. Ma la loss di K-Means **non è convessa** e ha **molti minimi** → si trova solo uno di essi.

## Selezione dei centroidi iniziali
> [!warning] L'inizializzazione conta
> I risultati possono variare **drasticamente** in base al seed casuale; alcuni seed danno convergenza lenta o clustering subottimi. Euristiche comuni:
> - punti casuali (non esempi) nello spazio;
> - esempi scelti a caso;
> - punti **meno simili** ai centri esistenti (*furthest centers*);
> - provare **più inizializzazioni** diverse;
> - inizializzare con il risultato di un altro metodo di clustering.

## Running time
> [!note] Complessità per iterazione
> - **Step 1 (assegnazione):** $O(kn)$ (ogni punto confrontato con $k$ centroidi);
> - **Step 2 (centroidi):** $O(n)$ (media di tutti i punti).

# 5. Issues con K-Means: la distanza
K-Means usa di default la **distanza euclidea**:
$$d(\mathbf{x}, \mathbf{y}) = \sqrt{\sum_{i=1}^{n}(x_i - y_i)^2}$$

> [!warning] La distanza euclidea non sempre va bene
> Esempio: **clustering di documenti**, una feature per parola (= quante volte appare). Due documenti possono avere distanza euclidea **grande** ma distribuzioni delle parole molto **simili** (uno è solo più lungo dell'altro). L'euclidea guarda la **lunghezza** dei vettori, non la loro **direzione**.

> [!important] Cosine similarity
> Misura legata all'**angolo** tra due vettori (ignora la lunghezza):
> $$sim(\mathbf{x}, \mathbf{y}) = \frac{\mathbf{x} \cdot \mathbf{y}}{\|\mathbf{x}\|\|\mathbf{y}\|} = \frac{\sum_{i=1}^{n} x_i y_i}{\sqrt{\sum_{i=1}^{n} x_i^2}\sqrt{\sum_{i=1}^{n} y_i^2}}$$
> - va da **0 a 1**;
> - ottima per **dati testuali** e molti dati reali;
> - **efficiente**: bastano le feature con valori **non nulli** in entrambi gli esempi.
>
> La **cosine distance** corrispondente:
> $$d(\mathbf{x}, \mathbf{y}) = 1 - sim(\mathbf{x}, \mathbf{y})$$

# Da padroneggiare
- **Unsupervised learning:** solo dati, **niente etichette**; 3 task → **dimensionality reduction**, **clustering**, **density estimation**.
- **PCA:** trova le **direzioni ortogonali di massima varianza** (= autovettori della **covarianza** $C$); la varianza lungo $\mathbf{w}$ è $\mathbf{w}^T C \mathbf{w}$, massimizzata sotto $\mathbf{w}^T\mathbf{w}=1$.
- **Componenti principali** = autovettori di $C$ ordinati per autovalore decrescente (l'autovalore = varianza lungo quella componente).
- **Algoritmo PCA:** centra i dati → covarianza $C = \frac{1}{n}\bar{X}\bar{X}^T$ → autovalori/autovettori (o SVD); riduzione: $T = \hat{W}^T\bar{X}$.
- **Quante componenti:** **cumulative explained variance** $\frac{\sum_{j=1}^k \lambda_j}{\sum_j C_{jj}}$ stima l'informazione preservata. Scalare le feature se in unità diverse.
- **Eigenfaces:** PCA sui volti; un volto si rappresenta come $\mathbf{u}_j^T(\mathbf{x}-\mu)$ e si ricostruisce con $\mu + \sum \mathbf{u}_j t_j$.
- **K-Means:** minimizza $\sum_j \sum_{i\in\mathcal{C}_j}\|\mathbf{x}_i - \boldsymbol{\mu}_j\|^2$; alterna **assegnazione** (al centroide più vicino) e **ricalcolo dei centroidi** (= media).
- **Proprietà K-Means:** converge sempre ma a un **minimo locale**; sensibile a **scala** e **inizializzazione**; iterazione $O(kn)$.
- **Distanza:** l'euclidea guarda la lunghezza; per testi conviene la **cosine similarity** (angolo tra vettori), con distanza $1 - sim$.
