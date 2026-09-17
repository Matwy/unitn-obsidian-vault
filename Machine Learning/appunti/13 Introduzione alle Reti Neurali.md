---
date: 2026/06/13
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec13-Intro2NN.pdf]]"
---
## 13 Introduzione alle Reti Neurali

> [!abstract] Idea di fondo
> Torniamo al **supervised learning**, ma superiamo il limite dei modelli lineari. Un **perceptron** (visto in [[6 Multi-class Classification]]) è in realtà un **neurone artificiale**: somma pesata degli input + una **funzione di attivazione** non-lineare. Il problema è che un singolo perceptron **non sa risolvere lo XOR** (dati non linearmente separabili). La soluzione è impilare i neuroni in una **rete multi-strato** (MLP): una **composizione di funzioni non-lineari** capace di approssimare *qualsiasi* funzione. Il prezzo è che non possiamo più usare la regola di apprendimento del perceptron per i layer nascosti → serve la **backpropagation**, cioè la **regola della catena** applicata in modo efficiente per calcolare il gradiente di tutti i pesi e poi fare **gradient descent** (visto in [[7 Gradient Descent]]). Questa lezione costruisce la rete pezzo per pezzo (neurone → layer → rete profonda), elenca le **scelte di modellazione** (loss, output, attivazioni, architettura) e deriva la backpropagation.

# 1. Dai modelli lineari ai neuroni

- Un **modello lineare** assume che i dati siano **linearmente separabili**. Abbiamo studiato il **perceptron**.
- Ripasso della **regola di update del perceptron** (label $\in \{-1, +1\}$): per ogni esempio si calcola $\text{prediction} = \sum_j w_j x_{ij} + b$; se $\text{prediction}\cdot y_i \le 0$ (predizione ed etichetta **non concordano**) si aggiorna:
$$w_j = w_j + x_{ij}\, y_i \qquad b = b + y_i$$
- **Connessione con il gradient descent** (vista in [[7 Gradient Descent]]): l'update del perceptron è un caso particolare. Con la exp loss l'update da GD è
$$w_j = w_j + \eta\, y_i x_{ij} \exp(-y_i(w\cdot x_i + b))$$
che si può scrivere $w_j = w_j + x_{ij} y_i c$ con $c = \eta \exp(-y_i(w\cdot x_i + b))$. Differenza chiave: **nel gradient descent aggiorniamo sempre** (non solo quando si sbaglia).

## Il perceptron come neurone artificiale

> [!important] Definizione
> Un **neurone artificiale** (perceptron) è una **funzione parametrica non-lineare con output a range ristretto**. Prende gli input $x_1, \dots, x_n$, ognuno con un **peso** $w_i$, ne fa la **somma pesata** $\Sigma$, e applica una **funzione di attivazione** $h$ per produrre l'output $\hat{y}$.

**Rosemblatt (1958)** — il perceptron come macchina per la classificazione lineare:
- un peso per ogni input; si moltiplicano i pesi per gli input e si **aggiunge il bias**;
- se il risultato supera una **soglia** restituisce 1, altrimenti 0. Il bias si scrive $b = w_0$ (peso di un input fittizio sempre $=1$).
- La funzione di attivazione è la **threshold function**:
$$h(x) = \begin{cases} 1 & x \ge 0 \\ 0 & x < 0 \end{cases}$$
È sostanzialmente la stessa idea della funzione segno vista per il perceptron.

# 2. Il problema dello XOR e la nascita degli MLP

> [!warning] Minsky & Papert (1969)
> Lo **XOR** (OR esclusivo) **non può essere risolto con un perceptron**. AND e OR sono **linearmente separabili** (esiste una retta che separa le due classi); lo **XOR non lo è** (nessuna retta separa i punti). Questo risultato bloccò la ricerca → **primo "inverno" dell'AI**.

| Input 1 | Input 2 | XOR |
|---|---|---|
| 1 | 1 | 0 |
| 1 | 0 | 1 |
| 0 | 1 | 1 |
| 0 | 0 | 0 |

> [!success] Multi-Layer Perceptron (MLP)
> Lo XOR si risolve con un **Multi-Layer Perceptron**: si **connettono densamente** più neuroni artificiali per realizzare **composizioni di funzioni non-lineari**. Un MLP ha un **input layer**, uno o più **hidden layer** e un **output layer**, e può affrontare task supervisionati arbitrari (classificazione, regressione, ecc.).

# 3. Reti Feed-forward

> [!important] Cosa sono
> In una rete **feed-forward** l'informazione va **dagli input agli output** senza cicli: è un **Directed Acyclic Graph (DAG)**. La rete calcola **una o più funzioni non-lineari**, ottenute per **composizione** di funzioni algebriche implementate dalle connessioni, dai pesi e dai bias degli strati nascosti e di output. Gli **hidden layer** calcolano **rappresentazioni intermedie**.

Costruiamo la rete partendo dal singolo neurone e aggiungendo complessità.

**Perceptron** (un neurone, un output):
$$\hat{y} = h\left(\sum_i w_i x_i + w_0\right) = h(\mathbf{w}^T \mathbf{x} + w_0)$$
- $\mathbf{w}^T\mathbf{x}$ → la somma pesata degli input; $w_0$ → il bias; $h$ → l'attivazione non-lineare.

**Modello semplificato** (si separa la somma dall'attivazione):
$$z = \sum_i w_i x_i + w_0 \qquad \hat{y} = h(z)$$
- $z$ è la **pre-attivazione** (somma pesata grezza), $h(z)$ è l'**attivazione**.

**Output multipli** (più neuroni in parallelo, ognuno coi suoi pesi):
$$z_j = \sum_i w_{i,j} x_i + w_{0,j}$$
- l'indice $j$ identifica il neurone di output; $w_{i,j}$ → peso dall'input $i$ al neurone $j$.

**Rete a singolo strato nascosto** (due "stadi" di pesi, $(1)$ e $(2)$):
$$z_j = \sum_i w^{(1)}_{i,j} x_i + w^{(1)}_{0,j} \qquad \hat{y}_k = f\left(\sum_i w^{(2)}_{i,k}\, h(z_i) + w^{(2)}_{0,k}\right)$$
- $w^{(1)}$ → pesi **input → hidden**; $h(z_i)$ → output del neurone nascosto $i$; $w^{(2)}$ → pesi **hidden → output**; $f$ → attivazione dell'output. È la composizione di due trasformazioni: prima si calcolano le rappresentazioni nascoste $h(z_i)$, poi da queste si calcola l'output.

# 4. Una rete è una composizione di funzioni

> [!note] Modular Learning
> Una rete neurale è: (1) una **composizione di moduli** (building block); (2) una **serie di funzioni connesse gerarchicamente**, ognuna con i **propri parametri**. Questo è il passaggio dal **machine learning tradizionale** (feature *handcrafted* + classificatore) al **deep learning** (la rete impara da sola le feature, layer dopo layer).

> [!important] Definizione formale
> **Goal**: approssimare una funzione ideale sconosciuta $f^*: \mathcal{X} \to \mathcal{Y}$.
> La rete definisce un **mapping parametrico** $f(\mathbf{x}; \Theta)$ e si **imparano i parametri** $\Theta$ per ottenere una buona approssimazione di $f^*$ dai dati disponibili.
> La funzione $f$ è una **composizione di più funzioni**:
> $$f(\mathbf{x}) = f^{(3)}\big(f^{(2)}(f^{(1)}(\mathbf{x}))\big)$$
> - $f^{(1)}$ è il **primo layer**, $f^{(2)}$ il secondo, ecc. La **profondità** (depth) è il massimo $i$ nella catena di composizione. L'ultimo layer è l'**output layer**; gli intermedi sono **hidden** perché i dati di training **non specificano** il loro output.

## Training

- **Training**: ottimizzare $\Theta$ per avvicinare $f(\mathbf{x};\Theta)$ a $f^*(\mathbf{x})$.
- I **dati di training** sono $f^*(\mathbf{x})$ valutata su vari $\mathbf{x}$ (cioè gli output attesi). Specificano **solo l'output dell'output layer**; l'output degli strati intermedi non è specificato → da qui il nome *hidden*.
- Addestrare una rete **non è molto diverso** dall'addestrare qualsiasi modello con **gradient descent**, MA:
	- il problema diventa **non convesso** (vedi convessità in [[10 Regularization]]);
	- **nessuna garanzia di convergenza** all'ottimo globale.
- Per applicare GD servono: un **modello**, una **cost function** e la **rappresentazione dell'output**.

# 5. Scelte di modellazione

> [!example] Cosa va scelto
> - **Cost function** (la loss)
> - **Form of output** (come è fatto l'output)
> - **Activation functions**
> - **Architecture** (numero di layer, ecc.)
> - **Optimizer**

## Cost function

Misura **quanto è buona la rete sui dati di training**:
$$\mathcal{L} = \text{distance}\big(f_\theta(x), y\big)$$
- $f_\theta(x)$ → output della rete (predizione); $y$ → label (ground truth); la loss misura l'**errore** tra i due.
- Si possono usare le loss già viste (es. **square loss** per la regressione).
- Per la **classificazione** è comune convertire gli output in **probabilità** con la **softmax**:
$$S(l_i) = \frac{e^{l_i}}{\sum_k e^{l_k}}$$
- $l_i$ → gli **score/logit** grezzi del neurone $i$; l'esponenziale li rende positivi e la divisione per la somma li **normalizza** a probabilità (sommano a 1). Esempio: logit $[0.1, 2, 1] \to$ probabilità $[0.1, 0.7, 0.2]$.

> [!important] Cross-Entropy
> La loss di classificazione associata alla softmax è la **cross-entropy**:
> $$\mathcal{L}_i = -\sum_k y_k \log\big(S(l_k)\big) = -\log\big(S(l)\big)$$
> - $y_k$ → label in **one-hot** (vale 1 solo per la classe corretta, 0 altrove). Per questo la somma **collassa** in un solo termine: $-\log(S(l))$, la log-probabilità della **classe giusta** cambiata di segno. Minimizzarla = spingere la rete a dare **alta probabilità** alla classe corretta.
> - La scelta della loss è legata alla scelta dell'**output unit**.

## Output units

**Lineari** — date le feature $h$ (output dell'ultimo hidden layer):
$$\hat{y} = W^T h + b$$
- Le unità lineari **non saturano**, quindi danno poca difficoltà agli algoritmi basati sul gradiente. Un gradiente dell'output **vicino a 0 è problematico** (l'apprendimento si blocca).

**Softmax** — quando si vogliono **probabilità normalizzate** in output. Un layer lineare produce **log-probabilità non normalizzate**; la softmax (formula sopra) le normalizza.

## Hidden units

> [!important] Cosa succede dentro un'unità nascosta
> 1. accetta l'input $\mathbf{x}$;
> 2. calcola la **trasformazione affine** $\mathbf{z} = W^T\mathbf{x} + \mathbf{b}$;
> 3. applica una **funzione non-lineare elementwise** $h(\mathbf{z})$;
> 4. produce l'output $h(\mathbf{z})$.
>
> La scelta di $h$ è un'area di ricerca attiva.

**ReLU (Rectified Linear Unit)** — la più usata:
$$h(x) = \max(0, x)$$
- gradiente **0 oppure 1**; simile alle unità lineari → **facile da ottimizzare**; dà gradienti **grandi e consistenti** quando è attiva. Non è differenziabile in $x=0$, ma in pratica non è un problema (si usa la derivata da un lato).

**ReLU generalizzate** — varianti (**Leaky ReLU**, **PReLU**, **Randomized Leaky ReLU**) che risolvono il problema delle unità che "**muoiono**" quando il gradiente è 0 (dando una piccola pendenza $a_i x_i$ anche per $x<0$).

**Sigmoide e Tanh** — non-linearità di tipo "**squashing**" che comprimono l'output in $[0,1]$ o $[-1,1]$:
$$\sigma(x) = \frac{1}{1+e^{-x}} \qquad \tanh(x) = \frac{e^x - e^{-x}}{e^x + e^{-x}}$$
- **Problema**: **saturano** su gran parte del dominio (sono sensibili solo vicino a zero) → la saturazione rende **difficile l'apprendimento basato sul gradiente** (gradiente quasi nullo nelle code). Per questo nelle reti profonde si preferisce la ReLU.

## Architecture

- Come scegliere **profondità e larghezza**? Pochi risultati teorici, perlopiù **empirici**.
- **Risultato teorico [Cybenko, 1989]** — *teorema di approssimazione universale*: una rete a **2 layer** con output lineare e una non-linearità *squashing* negli hidden può **approssimare qualsiasi funzione continua** su dominio compatto con **precisione arbitraria** (dati abbastanza neuroni nascosti). Vale anche per altre non-linearità (es. ReLU).
- **Implicazione**: qualunque funzione vogliamo imparare, sappiamo che un MLP grande **può rappresentarla**. **Però** non è garantito che il **training** riesca a impararla (problemi di ottimizzazione, overfitting).

# 6. Backpropagation

> [!important] Idea (in tre passi)
> 1. **Forward propagation**: somma gli input, produce le attivazioni, propaga in avanti fino all'output.
> 2. **Error estimation**: confronta l'output con l'etichetta corretta → **segnale di errore**.
> 3. **Back-propagate** il segnale di errore all'indietro e usalo per **aggiornare i pesi**.

**Learning = Optimization.** Dati i campioni $T = \{(\mathbf{x}_1, \mathbf{y}_1), \dots, (\mathbf{x}_N, \mathbf{y}_N)\}$, si regolano **tutti i pesi** $\Theta$ così da minimizzare una cost function:
$$\min_\Theta \sum_i L\big(\mathbf{y}_i, f(\mathbf{x}_i; \Theta)\big)$$
- Si sceglie la loss (es. square loss); si aggiornano i pesi di ogni layer con **gradient descent**; si usa la **backpropagation del segnale di errore per calcolare il gradiente in modo efficiente**.

> [!note] Perché serve la backprop
> Con la regola del perceptron **non possiamo** addestrare gli hidden layer: essa richiede di conoscere il **target desiderato**, che per i layer nascosti **non conosciamo** (lo conosciamo solo per l'output). La backprop risolve proprio questo: dai dati non sappiamo *cosa dovrebbero fare* le unità nascoste, ma possiamo calcolare **quanto velocemente cambia l'errore** al variare di un'attività nascosta.

## I tre passi nel dettaglio

Usiamo **gradient descent**: servono le derivate dell'errore rispetto a **tutti** i pesi. Esempio per un peso del primo layer:
$$w^{(1)}_{11} := w^{(1)}_{11} - \eta\, \frac{\partial L}{\partial w^{(1)}_{11}}$$
- $\eta$ → learning rate; $\frac{\partial L}{\partial w}$ → quanto la loss cambia variando quel peso. Il problema è calcolare **tutte** queste derivate; ogni unità nascosta influenza **molte** unità di output con effetti separati, che vanno **combinati**.

### Step 1 — Feedforward

Dall'input all'output (rete con un hidden layer, output lineare):
$$\hat{y}(\mathbf{x}; \mathbf{w}) = f\left(\sum_{j=1}^{m} w^{(2)}_j\, h\Big(\sum_{i=1}^{d} w^{(1)}_{ij} x_i + w^{(1)}_{0j}\Big) + w^{(2)}_0\right)$$
- somma interna → pre-attivazione del neurone nascosto $j$; $h(\cdot)$ → sua attivazione; somma esterna → combinazione pesata delle attivazioni nascoste; $f$ → attivazione di output.

### Step 2 — Calcolo dell'errore

Errore della rete sul training set (esempio con square loss):
$$L(X; \mathbf{w}) = \sum_{i=1}^{N} \frac{1}{2}\big(y_i - \hat{y}(\mathbf{x}_i; \mathbf{w})\big)^2$$
- Il fattore $\frac{1}{2}$ serve solo a semplificare la derivata. **Non c'è soluzione in forma chiusa** → si usa gradient descent, e serve la derivata di $L$ su un singolo esempio. Per un semplice modello lineare $\hat{y} = \sum_j w_j x_{ij}$:
$$\frac{\partial L(\mathbf{x}_i)}{\partial w_j} = \underbrace{(\hat{y}_i - y_i)}_{\text{errore}}\, x_{ij}$$
- la derivata è il prodotto del **segnale di errore** $(\hat{y}_i - y_i)$ per l'input $x_{ij}$. Questa è la struttura che la backprop generalizza a ogni layer.

### Step 3 — Backpropagation (la regola della catena)

Attivazione generica di un'unità in una rete multistrato:
$$a_t = \sum_j w_{jt} z_j \qquad z_t = h(a_t) = h\left(\sum_j w_{jt} z_j\right)$$
- $a_t$ → pre-attivazione dell'unità $t$ (somma pesata degli output $z_j$ delle unità che la alimentano); $z_t = h(a_t)$ → suo output.

La loss $L$ dipende da $w_{jt}$ **solo attraverso** $a_t$, quindi per la **regola della catena**:
$$\frac{\partial L}{\partial w_{jt}} = \frac{\partial L}{\partial a_t}\, \frac{\partial a_t}{\partial w_{jt}} = \underbrace{\frac{\partial L}{\partial a_t}}_{\delta_t}\, z_j = \delta_t\, z_j$$
- si definisce $\delta_t = \dfrac{\partial L}{\partial a_t}$, il **segnale di errore** dell'unità $t$. La derivata rispetto al peso è semplicemente $\delta_t$ (errore a valle) $\times\; z_j$ (input dal lato a monte). Calcolare i $\delta$ è il cuore della backprop.

> [!important] Come si calcolano i $\delta$
> **Unità di output** (attivazione lineare): il $\delta$ è direttamente l'errore di predizione
> $$\delta_t = \hat{y} - y$$
> *(le slide lo scrivono come $y - \hat{y}$: è solo una convenzione di segno; con $L = \tfrac12(y-\hat y)^2$ si ha $\frac{\partial L}{\partial a} = \hat y - y$).*
>
> **Unità nascosta** $t$ che manda il suo output alle unità $S$ (a valle):
> $$\delta_t = \sum_{s \in S} \frac{\partial L}{\partial a_s} \frac{\partial a_s}{\partial a_t} = h'(a_t) \sum_{s \in S} w_{ts}\, \delta_s$$
> - **questa è la formula chiave**: il $\delta$ di un'unità nascosta si ottiene **sommando i $\delta$ delle unità a valle**, pesati dai pesi $w_{ts}$ che la connettono ad esse, il tutto moltiplicato per $h'(a_t)$ (derivata della sua attivazione). L'errore **scorre all'indietro**: dall'output verso l'input → *back*-propagation.

## Esempio completo (output lineare, hidden con tanh)

Attivazioni:
- **Output**: $f(a) = a$ (lineare).
- **Hidden**: $h(a) = \tanh(a) = \dfrac{e^a - e^{-a}}{e^a + e^{-a}}$, con derivata comoda $h'(a) = 1 - h(a)^2$.

**Forward** (dato $\mathbf{x}$):
$$a_j = \sum_{i=0}^{d} w^{(1)}_{ij} x_i \qquad z_j = \tanh(a_j) \qquad \hat{y} = a = \sum_{j=0}^{m} w^{(2)}_j z_j$$
- $a_j$ → pre-attivazione del neurone nascosto $j$; $z_j$ → sua attivazione; $\hat{y}$ → output (combinazione lineare delle $z_j$).

**Errore** su un esempio e **$\delta$ dell'output**:
$$L = \tfrac{1}{2}(y - \hat{y})^2 \qquad \delta = \frac{\partial L}{\partial a} = \hat{y} - y$$

**$\delta$ delle unità nascoste** (applicando la formula chiave, con $h'(a_j) = 1 - z_j^2$):
$$\delta_j = (1 - z_j^2)\, w^{(2)}_j\, \delta$$
- $(1 - z_j^2)$ è $h'(a_j)$ per la tanh; $w^{(2)}_j \delta$ è l'errore che torna indietro dall'output. *(Sulle slide compare $(1-z_j)^2$, ma la derivata corretta della tanh è $1 - z_j^2$.)*

**Derivate rispetto ai pesi** e **update**:
$$\frac{\partial L}{\partial w^{(1)}_{ij}} = \delta_j x_i \qquad \frac{\partial L}{\partial w^{(2)}_j} = \delta z_j$$
$$w^{(2)}_j \leftarrow w^{(2)}_j - \eta\, \delta z_j \qquad w^{(1)}_{ij} \leftarrow w^{(1)}_{ij} - \eta\, \delta_j x_i$$
- Ogni peso si aggiorna sottraendo $\eta \times$ (errore a valle) $\times$ (input a monte): è gradient descent, col gradiente fornito dalla backprop.

## Output multidimensionale

Con $K$ output, la loss somma su tutte le componenti:
$$L = \frac{1}{2} \sum_{k=1}^{K} (y_k - \hat{y}_k)^2$$
- **$\delta$ di ogni unità di output**: $\delta_k = \hat{y}_k - y_k$ *(slide: $y_k - \hat y_k$, stessa convenzione di segno)*;
- **$\delta$ di un'unità nascosta** $j$: ora raccoglie i contributi di **tutte** le $K$ uscite:
$$\delta_j = (1 - z_j^2) \sum_{k=1}^{K} w^{(2)}_{jk}\, \delta_k$$
- è la stessa formula chiave: si sommano i $\delta_k$ di tutte le unità a valle, pesati dai $w^{(2)}_{jk}$, per $h'(a_j)$.

---

# Da padroneggiare

- **Neurone = perceptron**: somma pesata $z = \sum_i w_i x_i + w_0$ + attivazione $h(z)$. Bias $b = w_0$.
- **XOR non è linearmente separabile** → serve un **MLP** (Minsky & Papert 1969).
- **Rete feed-forward** = DAG, **composizione di funzioni** $f(\mathbf{x}) = f^{(3)}(f^{(2)}(f^{(1)}(\mathbf{x})))$; gli hidden layer imparano **rappresentazioni intermedie**. **Profondità** = lunghezza della catena.
- **Approssimatore universale** (Cybenko 1989): un MLP abbastanza grande può rappresentare qualsiasi funzione continua (ma il training non è garantito).
- **Scelte di modellazione**: loss, output, attivazioni, architettura, optimizer.
- **Softmax** $S(l_i) = \frac{e^{l_i}}{\sum_k e^{l_k}}$ (logit → probabilità) + **cross-entropy** $\mathcal{L} = -\log S(l_\text{classe giusta})$ per la classificazione.
- **Attivazioni**: **ReLU** $\max(0,x)$ (facile da ottimizzare, gradiente 0/1) → preferita; **sigmoide/tanh** saturano (gradiente che svanisce). Tanh: $h'(a) = 1 - h(a)^2$.
- **Backpropagation** = **regola della catena** + **gradient descent**. Il gradiente di un peso è $\frac{\partial L}{\partial w_{jt}} = \delta_t z_j$.
	- **Output**: $\delta = \hat{y} - y$.
	- **Hidden** (formula chiave): $\delta_t = h'(a_t) \sum_{s} w_{ts}\, \delta_s$ → l'errore **scorre all'indietro** dall'output verso l'input.
- Allenare una rete = come ogni modello con GD, ma problema **non convesso** e **senza garanzie di convergenza**.
