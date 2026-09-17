---
date: 2026-06-14
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec14-OptimizationCNN.pdf]]"
---
## 14 Reti Neurali II — Ottimizzazione e CNN

> [!abstract] Idea di fondo
> Questa lezione ha quattro blocchi. **(1) Come si addestra davvero una rete**: la backprop (vista in [[13 Introduzione alle Reti Neurali]]) calcola il gradiente, ma serve un **optimizer** per usarlo bene → da Gradient Descent "vanilla" a **Batch GD**, **SGD**, **mini-batch**, **Momentum** e i metodi a **learning rate adattivo**. **(2) Le CNN**: quando i dati hanno **struttura spaziale** (immagini), conviene sostituire la moltiplicazione matriciale con la **convoluzione** → filtri appresi, non-linearità, pooling. Una CNN impara una **gerarchia di feature** (da bordi a parti a oggetti). **(3) Le RNN**: quando input/output sono **sequenze a lunghezza variabile**, si introducono cicli con uno **stato** $h_t$. **(4) Gli autoencoder**: reti **non supervisionate** che imparano una rappresentazione compressa $z$ ricostruendo l'input. Il filo conduttore: scegliere l'**architettura giusta per la struttura dei dati**.

# PARTE 1 — Addestrare una rete neurale

## Ripasso: training come ottimizzazione

Una rete feed-forward approssima una funzione ideale $f^*: \mathcal{X} \to \mathcal{Y}$ con un mapping parametrico $f(\mathbf{x}; \Theta)$, descritto da un **DAG**. Tra le **scelte di modellazione** (loss, output, attivazioni, architettura) qui ci concentriamo sull'**optimizer**.

> [!important] Learning = Optimization
> Dati i campioni $T = \{(\mathbf{x}_1,\mathbf{y}_1), \dots, (\mathbf{x}_N,\mathbf{y}_N)\}$, si regolano tutti i pesi $\Theta$ per **minimizzare** una cost function:
> $$\min_\Theta \sum_i L\big(\mathbf{y}_i, f(\mathbf{x}_i; \Theta)\big)$$
> Si sceglie la loss (square loss, cross-entropy), si aggiornano i pesi con **gradient descent**, e si usa la **backpropagation** per calcolare il gradiente in modo efficiente. *La backprop calcola il gradiente; l'optimizer decide come muoversi con quel gradiente.*

## Gradient Descent

Le reti feed-forward si addestrano con il **Vanilla Gradient Descent**:
```
# Vanilla Gradient Descent
while True:
    weights_grad = evaluate_gradient(loss_fun, data, weights)
    weights += - step_size * weights_grad   # parameter update
```

> [!note] Cos'è il gradiente
> Il **gradiente** è il vettore delle derivate parziali rispetto a tutte le coordinate dei pesi:
> $$\nabla_\mathbf{w} L = \left[\frac{\partial L}{\partial w_1}\ \frac{\partial L}{\partial w_2}\ \cdots\ \frac{\partial L}{\partial w_M}\right]$$
> - ogni derivata parziale misura **quanto velocemente cambia la loss** muovendosi in una direzione; quando il gradiente è **zero** (tutte le parziali nulle) la loss non cambia in nessuna direzione.
> - **Problemi**: **minimi locali** e **punti di sella** (saddle points) — punti a gradiente nullo che non sono il minimo globale.

In sintesi: GD trova i parametri che rendono la loss più piccola possibile; il cambiamento dei parametri dipende dai gradienti della loss rispetto ai pesi; la **backprop** è il metodo per calcolare i gradienti. Ora vediamo **SGD** e altri optimizer.

### Batch Gradient Descent (BGD)

> [!example] Algoritmo
> **Input**: learning rate $\eta_k$, parametri iniziali $\mathbf{w}$.
> **while** criterio di stop non soddisfatto:
> - calcola la stima del gradiente su **tutti gli $N$ esempi**:
> $$\mathbf{g} \leftarrow \frac{1}{N}\nabla_\mathbf{w} \sum_i L\big(f(\mathbf{x}_i; \mathbf{w}), \mathbf{y}_i\big)$$
> - applica l'update: $\mathbf{w} \leftarrow \mathbf{w} - \eta_k\, \mathbf{g}$

- $\mathbf{g}$ → gradiente **medio** su tutto il training set; $\eta_k$ → learning rate, che **cambia a ogni step** (tipicamente decade linearmente).
- **Pro**: le stime del gradiente sono **stabili**. **Contro**: serve calcolare il gradiente su **tutto** il dataset per **un solo** update → lento.

### Stochastic Gradient Descent (SGD)

> [!example] Algoritmo
> **Input**: learning rate $\eta_k$, parametri iniziali $\mathbf{w}$.
> **while** criterio di stop non soddisfatto:
> - **campiona un solo** datapoint $(\mathbf{x}_i, \mathbf{y}_i)$ dal training set;
> - calcola la stima del gradiente su quell'esempio:
> $$\mathbf{g} \leftarrow \nabla_\mathbf{w} L\big(f(\mathbf{x}_i; \mathbf{w}), \mathbf{y}_i\big)$$
> - applica l'update: $\mathbf{w} \leftarrow \mathbf{w} - \eta_k\, \mathbf{g}$

- La differenza con BGD è **solo** nel gradiente: BGD usa la media su tutti gli $N$, SGD usa **un singolo** esempio. L'update $\mathbf{w} \leftarrow \mathbf{w} - \eta_k\mathbf{g}$ è identico.
- **BGD vs SGD**: BGD scende "liscio" verso il minimo; SGD fa un percorso "**rumoroso**" (a zig-zag) ma molto più **veloce** per update.

### Mini-batches

> [!important] Compromesso tra BGD e SGD
> - **Problema** di SGD: le stime del gradiente possono essere **molto rumorose**.
> - **Soluzione**: usare **mini-batch** (piccoli insiemi di esempi) → si calcola il gradiente medio su un batch.
> - **Vantaggi**: il tempo di calcolo per update **non dipende** da $N$; permette di lavorare su dataset **enormi**; spesso **parallelizzabile**; sulle **GPU** conviene usare batch di dimensione **potenza di 2** (l'hardware è più efficiente con certe dimensioni di array).

## Momentum

> [!warning] Problema di SGD
> Su certe superfici di errore (valli strette e allungate) SGD fa **progressi lentissimi** lungo la direzione "piatta" e **oscilla** (jitter) lungo quella ripida.

> [!important] Soluzione: la velocità
> Si introduce una nuova variabile $\mathbf{v}$, la **velocità**: una **media mobile a decadimento esponenziale** del gradiente negativo.
> $$\mathbf{v} \leftarrow \alpha\, \mathbf{v} - \eta_k\, \mathbf{g} \qquad \mathbf{w} \leftarrow \mathbf{w} + \mathbf{v}$$
> - $\alpha$ → **parametro di momentum** (quanto si "ricorda" della direzione passata, di solito $\sim 0.9$); $\mathbf{v}$ accumula i gradienti passati. Effetto: come una **palla che rotola** giù dalla valle — accelera nelle direzioni costanti e smorza le oscillazioni.

## Metodi a learning rate adattivo

- Finora abbiamo dato lo **stesso** learning rate a tutte le feature. Ma se le feature variano per **importanza e frequenza**, è una buona idea?
- Il learning rate è uno degli **iperparametri più difficili** da impostare nelle reti.
- Esistono metodi che **adattano** automaticamente il learning rate (per feature): **AdaGrad**, **RMSProp**, **AdaDelta**, **NAG** (Nesterov), oltre a SGD e Momentum. Sono utili soprattutto quando la superficie di loss è "difficile" (allungata, con feature di scale diverse).

# PARTE 2 — Convolutional Neural Networks (CNN)

## Dati strutturati

- Alcune applicazioni trattano per natura uno spazio di input **localmente strutturato**, cioè **spaziale** o **temporale**: **immagini**, linguaggio, ecc., a differenza di feature arbitrarie.
- Le reti neurali sono **estremamente potenti** in questo caso.

> [!note] Da pixel a label
> L'idea è **imparare una gerarchia di feature**: ogni layer estrae feature dall'output del layer precedente, e si **addestrano tutti i layer insieme** (jointly). In una CNN i primi layer imparano **bordi/orientamenti**, quelli intermedi **parti** (occhi, nasi), quelli alti **oggetti interi** (volti).

## Cos'è una convoluzione

> [!important] Definizione
> Le reti convoluzionali sono semplicemente reti neurali che usano la **convoluzione** al posto della moltiplicazione matriciale generale **in almeno uno dei loro layer**.
> $$S(i,j) = (I * K)(i,j) = \sum_m \sum_n I(m,n)\, K(i-m, j-n)$$
> - $I$ → l'**immagine** in input; $K$ → il **kernel** (o filtro), una piccola matrice di pesi; $S$ → l'**output** (feature map / immagine filtrata).
> - In pratica: il valore di un pixel centrale è dato **sommando i valori pesati di tutti i suoi vicini** (pesi = il kernel). La convoluzione è un'operazione **commutativa**.

> [!note] Ripasso convoluzione
> È un'operazione di **filtraggio** general-purpose per immagini: si fa scorrere il kernel sull'immagine e per ogni posizione si calcola la somma pesata. A seconda del kernel si può **smussare** (smooth), **affilare** (sharpen), **rilevare bordi** o **linee** (es. kernel di Sobel). L'output è una nuova immagine filtrata.

## Ispirazione: la corteccia visiva

- La corteccia visiva contiene cellule sensibili a piccole **sub-regioni** del campo visivo, dette **receptive field** (campo recettivo). Agiscono come **filtri locali** sull'input e sfruttano la forte **correlazione spaziale locale** delle immagini naturali.
- Due tipi base di cellule:
	- **Simple cells**: rispondono al massimo a specifici **pattern tipo bordo** nel loro campo recettivo;
	- **Complex cells**: hanno campi recettivi **più grandi** e sono **localmente invarianti** alla posizione esatta del pattern.

## L'architettura di una CNN

> [!important] Il "motif" della CNN
> Una CNN è una rete feed-forward con **struttura di connettività specializzata**. I layer trasformano la matrice di input in una predizione di classe. Tre operazioni distinte, ripetute:
> $$\text{Convolution (learned)} \to \text{Non-linearity} \to \text{Spatial pooling}$$

### Convoluzione (layer)

- È il **layer centrale** delle CNN. Consiste in un insieme di **filtri appresi** (learned filters).
- Ogni filtro copre una **piccola porzione spaziale** dell'input (il suo **receptive field**) ed è **convoluto** su tutte le dimensioni dell'input, producendo una **feature map** multi-dimensionale.
- **Intuizione**: la rete imparerà filtri che si **attivano** quando "vedono" un certo tipo di feature in una certa posizione spaziale.

### Non-linearità

Si applica **elementwise** dopo la convoluzione, tipicamente la **ReLU**:
$$h(x) = \max(0, x)$$
- Serve ad **aumentare la non-linearità** dell'intera architettura **senza modificare** i campi recettivi del layer convoluzionale.

### Pooling (spaziale)

> [!important] A cosa serve
> Riducendo progressivamente la **dimensione spaziale** della rappresentazione si **riduce il numero di parametri** e di calcoli, e si **controlla l'overfitting**. Dà inoltre **invarianza alle traslazioni**.
>
> Esempio: **max pooling** con filtro $2\times 2$ e stride 2 → di ogni blocco $2\times2$ si tiene solo il **valore massimo** (es. una mappa $224\times224 \to 112\times112$, profondità invariata).

## Architetture famose

- **LeNet (1998)** — la prima CNN di successo (riconoscimento cifre, LeCun et al.).
- **AlexNet (2012)** — framework simile a LeNet ma: **modello più grande** (7 hidden layer, 650K unità, 60M parametri), **più dati** ($10^6$ vs $10^3$ immagini), **implementazione GPU** (50× più veloce della CPU, addestrato su 2 GPU per una settimana). Vinse ImageNet → inizio della *deep learning revolution*.
- **VGG (2014)** — stesso motif di AlexNet, ma più profonda e regolare (sequenze di Conv + Pool + FC + Softmax).
- **GoogLeNet** — **12× meno parametri** di AlexNet; **elimina i layer fully-connected**; introduce l'**Inception Module**.
- **ResNet** — introduce il **Residual Block** per migliorare reti **molto profonde**:
$$\text{output} = \mathcal{F}(\mathbf{x}) + \mathbf{x}$$
	- risolve il **degradation problem**: la connessione **identity** $\mathbf{x}$ permette ai layer profondi di **propagare l'informazione** direttamente dai layer bassi. Introduce anche la **batch normalization** per migliorare il training.

> [!note] Going deeper
> Sulla ImageNet Challenge, l'errore **top-5** è crollato man mano che le reti si facevano più profonde (da AlexNet a ResNet a **152 layer**), superando le prestazioni umane.

## Oltre la classificazione

Le CNN sono **flessibili** a molti task:
- **Detection** (rilevamento oggetti): primo approccio **R-CNN** (Regions with CNN features) — propone ~2k regioni, calcola feature CNN, classifica ogni regione.
- **Semantic Segmentation**: classificare **ogni pixel**.
- **Structured Regression**: es. stima della posa.

> [!success] CNN: riassunto
> - In una rete feed-forward le unità sono in **layer** e ricevono input solo dal layer sottostante.
> - Le CNN sono feed-forward, ma le unità hanno una **disposizione spaziale**: a ogni layer sono organizzate in **griglie 2D**, le **feature map**.
> - Ogni feature map è il risultato di una **convoluzione**: lo **stesso filtro** è applicato in ogni posizione (**weight sharing**); i pesi sono **diversi** tra feature map diverse.
> - Un'unità in una certa posizione riceve input solo da unità in **posizione simile** nel layer sottostante (connettività **locale**).
> - Serve **dati etichettati** (modello **supervisionato**); è **flessibile** a molte applicazioni.

# PARTE 3 — Recurrent Neural Networks (RNN)

> [!important] Perché servono
> Finora i problemi avevano input/output di **dimensione fissa**. Ma se l'input e/o l'output è una **sequenza a lunghezza variabile**? Esempi: **classificazione di documenti**, **sentiment analysis**, **image captioning**, **video frame prediction**, **machine translation**.

- **Single2Single** (input singolo → output singolo) = **rete feed-forward** classica.
- **Multiple2Multiple / Multiple2Single / Single2Multiple** = **reti ricorrenti**, che gestiscono sequenze:
	- *Multiple2Single*: sentiment analysis (sequenza → un'etichetta);
	- *Single2Multiple*: image captioning (un'immagine → sequenza di parole);
	- *Multiple2Multiple*: machine translation / video frame prediction.

> [!important] L'equazione della RNN
> La RNN introduce **cicli/ricorrenze**: mantiene uno **stato nascosto** $h_t$ che si aggiorna nel tempo.
> $$h_t = f_W(x_t, h_{t-1})$$
> - $h_t$ → **nuovo stato** (al tempo $t$); $f_W$ → **funzione** parametrizzata da $W$ (gli **stessi pesi** a ogni passo temporale); $x_t$ → **input al tempo $t$**; $h_{t-1}$ → **stato precedente**.
> - L'idea chiave: lo stato $h_t$ fa da "**memoria**" che riassume tutta la sequenza vista finora. Un **classifier** sopra $h_t$ produce l'output $y_t$.

- Una RNN si può "**srotolare**" nel tempo ($t=1,2,3,\dots$): a ogni passo lo stato passa al successivo. Si addestra con la **backpropagation** (backpropagation through time).

# PARTE 4 — Autoencoder

> [!important] Cosa sono
> Approccio **non supervisionato** (collegato a [[11 Unsupervised Learning]]) per imparare una **rappresentazione a dimensione ridotta** $z$ da dati **non etichettati**. Le feature $z$ dovrebbero catturare i **fattori di variazione significativi** dei dati, con $z$ di solito **più piccolo** di $x$ → è **dimensionality reduction** appresa da una rete.

**Struttura encoder–decoder:**
- **Encoder**: comprime l'input $x$ nelle feature $z$.
- **Decoder**: ricostruisce l'input, $\hat{x}$, a partire da $z$.
- *Implementazione*: originariamente **lineare + non-linearità** (sigmoide); poi reti **deep fully-connected**; poi **CNN con ReLU** (e *upconv* nel decoder).

> [!important] Come si addestra
> Si allena affinché le feature possano **ricostruire** i dati originali → "**autoencoding**" (codificare sé stesso). La loss è la **L2** tra input e ricostruzione:
> $$L = \|x - \hat{x}\|^2$$
> - **Non usa le etichette!** (è non supervisionato). Minimizzare $\|x-\hat x\|^2$ costringe $z$ a conservare l'informazione necessaria a ricostruire $x$.

> [!note] A cosa serve dopo
> Finito l'addestramento si **butta via il decoder**; l'**encoder** può servire a **inizializzare un modello supervisionato**. Si mette un **classifier** sopra le feature $z$ e si fa **fine-tuning** dell'encoder insieme al classifier (utile quando si hanno pochi dati etichettati ma molti non etichettati).

---

# Da padroneggiare

- **Optimizer** (la backprop dà il gradiente, l'optimizer decide il passo):
	- **BGD**: $\mathbf{g} = \frac{1}{N}\nabla \sum_i L_i$ → stabile ma lento; **SGD**: gradiente su **1 esempio** → veloce ma rumoroso; **mini-batch** = compromesso (e GPU-friendly con batch potenza di 2).
	- **Momentum**: $\mathbf{v} \leftarrow \alpha\mathbf{v} - \eta\mathbf{g}$, $\mathbf{w} \leftarrow \mathbf{w} + \mathbf{v}$ → smorza le oscillazioni nelle valli strette.
	- **Adaptive LR** (AdaGrad, RMSProp, AdaDelta): learning rate **per feature**.
- **CNN**: convoluzione $S(i,j) = \sum_m\sum_n I(m,n)K(i-m,j-n)$ = filtri **appresi** + **weight sharing** + connettività **locale**. Motif: **Conv → ReLU → Pooling**. Il pooling (max pooling) riduce dimensione, parametri e overfitting, dà invarianza alle traslazioni. Imparano una **gerarchia di feature**. Architetture: LeNet → AlexNet → VGG → GoogLeNet → ResNet (residual $\mathcal{F}(x)+x$).
- **RNN**: per **sequenze a lunghezza variabile**; stato ricorrente $h_t = f_W(x_t, h_{t-1})$ (stessi pesi a ogni passo); srotolata nel tempo e addestrata con backprop.
- **Autoencoder**: non supervisionato; encoder $x \to z$, decoder $z \to \hat x$; loss $\|x-\hat x\|^2$ (niente etichette); l'encoder serve poi a inizializzare un modello supervisionato.
