---
date: 2026/06/12
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec6-Multi-class Classification.pdf]]"
---
## 6 Multi-class Classification

> [!abstract] Idea di fondo
> Finora abbiamo visto classificatori **binari** (2 classi). Nella realtà quasi tutti i problemi hanno **K > 2 classi** (riconoscere cifre, oggetti, sentiment...). Questa lezione risponde a: *come passiamo dal binario al multiclasse?* Due strade: **(1)** usare classificatori che gestiscono già più classi (k-NN, Decision Tree), oppure **(2)** scomporre il problema multiclasse in tanti problemi **binari** combinando un classificatore binario "black box" → le due tecniche chiave sono **One vs All (OVA)** e **All vs All (AVA)**. Infine vediamo come **valutare** un classificatore multiclasse (accuracy, micro/macro-averaging, confusion matrix).

# 1. Ripasso: il modello lineare
Un **modello lineare** assume che i dati siano **linearmente separabili**: lo spazio delle ipotesi è quello delle **funzioni lineari** (una retta/ iperpiano che separa le classi).

## Classificare con un modello lineare
Dato un esempio descritto dalle feature $f_1, f_2, \dots, f_n$, si calcola un punteggio e se ne guarda il **segno**:

$$b + \sum_{i=1}^{n} w_i f_i$$

> [!note] Come leggere la formula
> - $f_i$ = valore della **feature** $i$ dell'esempio.
> - $w_i$ = **peso** associato alla feature $i$ (quanto "conta" e in che direzione).
> - $b$ = **bias** (sposta il confine di decisione, è l'intercetta).
>
> Decisione in base al segno:
> $$b + \sum_{i=1}^{n} w_i f_i > 0 \;\Rightarrow\; \text{esempio POSITIVO} \qquad b + \sum_{i=1}^{n} w_i f_i < 0 \;\Rightarrow\; \text{esempio NEGATIVO}$$

## Algoritmo di apprendimento del Perceptron
Il perceptron **impara** i pesi $w_i$ e il bias $b$ così:

```
repeat until convergence (o per un certo # di iterazioni):
  for each training example (f_1, f_2, ..., f_n, label):
      prediction = b + Σ_{i=1}^{n} w_i f_i        # poi se ne prende il SIGN ∈ [-1, 1]
      if prediction è diversa da label:
          for each w_i:
              w_i = w_i + f_i * label
          b = b + label
```

> [!important] Le formule di update
> Quando la predizione **sbaglia** (segno diverso dal `label`, con `label` ∈ {-1, +1}):
> $$w_i \leftarrow w_i + f_i \cdot \text{label} \qquad\qquad b \leftarrow b + \text{label}$$
> - Si **sposta** l'iperpiano nella direzione dell'esempio mal classificato (`x` viene sommato/sottratto al vettore dei pesi `w`).
> - `prediction` passata al `sign` dà $-1$ o $+1$.

> [!warning] Quale retta trova il perceptron?
> Il perceptron è garantito trovare **una qualsiasi retta** che separa i dati, **non** necessariamente la "migliore". Se i dati sono separabili converge, ma la soluzione dipende dall'ordine degli esempi.

## A cosa serve un classificatore lineare?
Domanda chiave: **quanto è flessibile?** Possiamo applicarlo ad **altri problemi** oltre al binario? È proprio quello che esploriamo qui.

> [!note] Dove siamo (So far...)
> Finora abbiamo due classificatori:
> - **k-NN** → vota la classe maggioritaria tra i $k$ vicini.
> - **Perceptron** → classificatore lineare.

# 2. Dal binario al multiclasse

## Classificazione binaria (definizione formale)
> [!important] TASK: Binary Classification
> **Dato:**
> 1. uno spazio di input $\mathcal{X}$
> 2. una distribuzione sconosciuta $\mathcal{D}$ su $\mathcal{X} \times \{-1, +1\}$
> 3. un training set $D$ campionato da $\mathcal{D}$
>
> **Calcola:** una funzione $f$ che **minimizza** l'errore atteso:
> $$\mathbb{E}_{(\mathbf{x},y)\sim\mathcal{D}}\big[\, f(\mathbf{x}) \neq y \,\big]$$
> Cioè la probabilità che la predizione $f(\mathbf{x})$ sia **diversa** dall'etichetta vera $y$. Le etichette sono solo **due**: $-1$ e $+1$.

## Classificazione multi-class
La classificazione multiclasse è l'**estensione naturale** di quella binaria. L'obiettivo è sempre assegnare una **etichetta discreta** agli esempi; la differenza è che ora ci sono **$K > 2$** classi tra cui scegliere (es. *apple, orange, banana, pineapple*).

> [!example] Applicazioni reali
> Quasi tutte le applicazioni reali sono multiclasse: classificazione di documenti, riconoscimento della scrittura, riconoscimento di volti, sentiment analysis, veicoli autonomi, riconoscimento delle emozioni.

## Classificazione multi-class (definizione formale)
> [!important] TASK: Multiclass Classification
> **Dato:**
> 1. uno spazio di input $\mathcal{X}$ e un numero di classi $K$
> 2. una distribuzione sconosciuta $\mathcal{D}$ su $\mathcal{X} \times [K]$
> 3. un training set $D$ campionato da $\mathcal{D}$
>
> **Calcola:** una funzione $f$ che **minimizza** l'errore atteso:
> $$\mathbb{E}_{(\mathbf{x},y)\sim\mathcal{D}}\big[\, f(\mathbf{x}) \neq y \,\big]$$
> L'unica differenza rispetto al binario: le etichette stanno in $[K] = \{1, 2, \dots, K\}$ invece che in $\{-1, +1\}$.

# 3. I classificatori che già conosciamo funzionano?
Domanda: i classificatori visti finora funzionano "out of the box" sul multiclasse? Con piccole modifiche?

## k-NN → nessuna modifica
Per classificare un esempio $d$:
- trova i $k$ **nearest neighbors** di $d$;
- scegli come etichetta quella **maggioritaria** tra i $k$ vicini.

> [!success] No algorithmic changes!
> Il **maggioritario** funziona identico con 2 o con $K$ classi: k-NN gestisce il multiclasse **senza nessuna modifica** all'algoritmo.

## Perceptron → non basta una retta
Con 3+ classi (mele, banane, ananas) è **difficile separare** tutto con **una sola retta**.

> [!note] L'intuizione che useremo
> Una sola retta non basta, **ma possiamo combinarne di più**: scomponiamo il problema multiclasse in più problemi binari, ognuno risolto da un classificatore lineare. È l'idea alla base di OVA e AVA.

# 4. Approccio "black box" al multiclasse
Idea: *ti do un classificatore binario e tu devi usarlo per risolvere il multiclasse.* Trattiamo il classificatore binario come una **scatola nera** (input → output).

Dato un generico classificatore binario che calcola
$$prediction = b + \sum_{i=1}^{n} w_i f_i$$
e produce in output $+1$ oppure $-1$ (e **opzionalmente** anche un **confidence/score**), la domanda è: **possiamo risolvere il problema multiclasse con questo?**

La risposta è **sì**, combinando più classificatori binari. Due strategie:
- **One vs All (OVA)**
- **All vs All (AVA)**

# 5. Approccio 1: One vs All (OVA)

> [!important] Idea OVA
> **Training:** per ogni etichetta $k = 1, \dots, K$ si definisce un **problema binario**:
> - tutti gli esempi con etichetta $k$ sono **positivi** ($+1$);
> - tutti gli **altri** esempi sono **negativi** ($-1$).
>
> In pratica si imparano **$K$ classificatori binari** diversi (uno per classe): *apple vs not*, *orange vs not*, *banana vs not*, ...

## Esempio (frutti)
Con classi {apple, orange, banana} si costruiscono 3 dataset binari:

| esempio | apple vs not | orange vs not | banana vs not |
|---|:---:|:---:|:---:|
| apple | +1 | −1 | −1 |
| orange | −1 | +1 | −1 |
| apple | +1 | −1 | −1 |
| banana | −1 | −1 | +1 |
| banana | −1 | −1 | +1 |

Ogni colonna è un problema binario indipendente su cui si allena un classificatore (es. un perceptron).

## Come si classifica con OVA?
Ogni classificatore lineare divide il piano in due semipiani. Dato un nuovo esempio, possono succedere casi "ambigui":
- **più** classificatori dicono positivo;
- **nessun** classificatore dice positivo;
- una zona "none?" oppure "banana OR pineapple".

> [!important] Regola di decisione OVA (con confidence)
> I classificatori forniscono una **confidence** (confidenza). Allora:
> - **scegli il positivo più confidente** (most confident positive);
> - se **nessuno** vota positivo, scegli il **negativo meno confidente** (*least confident negative*).

### Ripasso: cos'è la confidence per il perceptron
Il classificatore divide il piano in due semipiani. Esempio con pesi $w = (1, 0)$ e bias $b=0$, sul punto $(f_1, f_2) = (-1, 1)$:
$$1 * f_1 + 0 * f_2 = 1 * (-1) + 0 * 1 = -1 \;\Rightarrow\; \text{NEGATIVE!}$$

> [!important] Confidence = distanza dall'iperpiano
> Per il perceptron la confidence di una predizione è proprio il valore (con segno) del punteggio:
> $$prediction = b + \sum_{i=1}^{n} w_i f_i$$
> Questo valore misura la **distanza dal confine di decisione (iperpiano)**: più è grande in valore assoluto, più il classificatore è "sicuro". Il segno dice la classe, il modulo dice quanto è confidente.

## OVA: confine di decisione
Combinando i $K$ classificatori, il piano si divide in regioni (APPLE / BANANA / PINEAPPLE): il confine di decisione complessivo è **lineare a tratti** (dato dalla competizione tra gli iperpiani).

## OVA: riassunto (algoritmi)
> [!note] Algorithm 13 — OneVersusAllTrain($D^{multiclass}$, BinaryTrain)
> ```
> for i = 1 to K do
>     D^bin ← rietichetta D^multiclass: classe i positiva, ¬i negativa
>     f_i  ← BinaryTrain(D^bin)
> end for
> return f_1, ..., f_K
> ```

> [!note] Algorithm 14 — OneVersusAllTest($f_1, \dots, f_K, \hat{\mathbf{x}}$)
> ```
> score ← ⟨0, 0, ..., 0⟩          # inizializza K punteggi a zero
> for i = 1 to K do
>     y ← f_i(x̂)
>     score_i ← score_i + y
> end for
> return argmax_k score_k
> ```
> La classe scelta è quella con **punteggio massimo**:
> $$\hat{y} = \operatorname*{arg\,max}_{k}\; score_k$$

# 6. Approccio 2: All vs All (AVA)

> [!important] Idea AVA (come un torneo sportivo)
> Analogia: $K$ squadre in un **torneo** in cui può giocare solo **una coppia alla volta**. Ogni squadra (=classe) gioca contro **ogni altra**; vince la classe che vince la **maggioranza** delle partite.

Formalmente si allenano
$$\frac{K(K-1)}{2} \text{ classificatori}$$
$$F_{ij}, \quad 1 \le i < j \le K$$
dove $F_{ij}$ è il classificatore che **discrimina la classe $i$ contro la classe $j$**.

> [!note] Come funziona ogni $F_{ij}$
> - riceve gli esempi della classe $i$ come **positivi** e quelli della classe $j$ come **negativi** (ignora le altre classi);
> - in test si valuta il punto su **tutti** gli $F_{ij}$;
> - ogni volta che $F_{ij}$ predice positivo, la classe $i$ prende un **voto**, altrimenti lo prende la classe $j$;
> - dopo aver eseguito tutti i $K(K-1)/2$ classificatori, **vince la classe con più voti**.

## Esempio (frutti)
Con classi {apple, orange, banana} si allenano $\frac{3\cdot 2}{2} = 3$ classificatori: *apple vs orange*, *apple vs banana*, *orange vs banana*. Sommando i voti si determina la classe (es. l'esempio "orange" raccoglie voti da più coppie → **orange**).

## AVA: training
> [!note] Pseudocodice training
> ```
> for i = 1 to (numero di label):
>     for j = i+1 to (numero di label):
>         allena un classificatore F_ij per distinguere label_j da label_i:
>           - crea un dataset con tutti gli esempi con label_j → positivi
>             e tutti gli esempi con label_i → negativi
>           - allena F_ij su questo sottoinsieme dei dati
> ```

## AVA: classificazione
Per classificare un esempio $\mathbf{x}$ lo si classifica con **ogni** $F_{ij}$. Per scegliere la classe finale ci sono due opzioni:
- **majority vote** (voto di maggioranza);
- **weighted vote** (voto pesato sulla confidence).

> [!important] Formule del weighted vote
> $$y = F_{ij}(\mathbf{x})$$
> $$score_j \mathrel{+}= y \qquad\qquad score_i \mathrel{-}= y$$
> Interpretazione:
> - se $y$ è **positivo**, il classificatore pensa che sia di tipo $j$ → **alza** lo score di $j$ e **abbassa** quello di $i$;
> - se $y$ è **negativo**, pensa che sia di tipo $i$ → **abbassa** lo score di $j$ e **alza** quello di $i$.
>
> (Usando la confidence $y$ come peso anziché un semplice $\pm 1$.)

## AVA: riassunto (algoritmi)
> [!note] Algorithm 15 — AllVersusAllTrain($D^{multiclass}$, BinaryTrain)
> ```
> f_ij ← ∅,  ∀ 1 ≤ i < j ≤ K
> for i = 1 to K-1 do
>     D^pos ← tutti gli x ∈ D^multiclass con label i
>     for j = i+1 to K do
>         D^neg ← tutti gli x ∈ D^multiclass con label j
>         D^bin ← {(x, +1) : x ∈ D^pos} ∪ {(x, -1) : x ∈ D^neg}
>         f_ij  ← BinaryTrain(D^bin)
>     end for
> end for
> return all f_ij
> ```

> [!note] Algorithm 16 — AllVersusAllTest(all $f_{ij}, \hat{\mathbf{x}}$)
> ```
> score ← ⟨0, 0, ..., 0⟩          # inizializza K punteggi a zero
> for i = 1 to K-1 do
>     for j = i+1 to K do
>         y ← f_ij(x̂)
>         score_i ← score_i + y
>         score_j ← score_j - y
>     end for
> end for
> return argmax_k score_k
> ```

# 7. OVA vs AVA (confronto)

| | **OVA** | **AVA** |
|---|---|---|
| **# classificatori** | $K$ | $\dfrac{K(K-1)}{2}$ |
| **Dati per classificatore** | tutto il dataset | sottoinsieme (solo 2 classi) |

> [!important] Trade-off
> - **Train time:** AVA impara **più** classificatori, ma ognuno è allenato su **molti meno** dati → tende a essere **più veloce** se le classi sono ben bilanciate.
> - **Test time:** AVA ha **più** classificatori, quindi spesso è **più lento** in test.
> - **Errore:** AVA si allena su dataset **più bilanciati** (è un vantaggio), *ma* testa con **più** classificatori → **più occasioni di errore**.

> [!note] Riassunto multiclasse
> - Se si parte da un classificatore **binario**, la cosa più comune è usare **OVA**.
> - Altrimenti, si usa un classificatore che gestisce **nativamente** più etichette:
>   - **Decision Tree** e **k-NN** funzionano ragionevolmente bene;
>   - metodi più sofisticati (es. **reti neurali**, prossime lezioni) funzionano meglio.

# 8. Valutazione di un classificatore multiclasse

## Accuracy
Si confrontano `label` (vero) e `prediction` (predetto) su ogni esempio. L'**accuracy** è la frazione di esempi classificati correttamente.

> [!example] Esempio
> Su 6 esempi, 4 predetti correttamente → **Accuracy = 4/6**.

> [!warning] Problema: data imbalance
> L'accuracy "normale" può ingannare quando le classi sono **sbilanciate** (alcune classi hanno pochissimi esempi): una classe rara può essere quasi ignorata senza che l'accuracy globale ne risenta molto.

## Microaveraging vs Macroaveraging

Quando ci sono più classi, "fare la media" dell'accuracy si può fare in **due modi diversi**, e la differenza sta in **cosa conta uguale**: ogni **esempio** oppure ogni **classe**.

> [!important] Le due definizioni
> - **Microaveraging** → media **sugli esempi**. Si mettono insieme tutti gli esempi del test set, si contano i corretti totali e si divide per il totale. È il modo "normale" di calcolare l'accuracy. **Ogni esempio conta uguale** → le classi con tanti esempi "pesano" di più.
> - **Macroaveraging** → media **sulle classi**. Si calcola prima l'accuracy **separatamente dentro ogni classe**, e poi si fa la media di questi numeri. **Ogni classe conta uguale** → una classe rara pesa quanto una frequente.

> [!note] La formula in due passi
> Sia $K$ il numero di classi, $c_k$ il numero di esempi **corretti** della classe $k$, e $n_k$ il numero **totale** di esempi della classe $k$.
>
> **Micro** = un'unica frazione su tutti gli esempi:
> $$\text{micro} = \frac{\sum_{k=1}^{K} c_k}{\sum_{k=1}^{K} n_k} = \frac{\text{corretti totali}}{\text{esempi totali}}$$
>
> **Macro** = prima l'accuracy per classe $\text{acc}_k = \dfrac{c_k}{n_k}$, poi la media:
> $$\text{macro} = \frac{1}{K} \sum_{k=1}^{K} \text{acc}_k = \frac{1}{K} \sum_{k=1}^{K} \frac{c_k}{n_k}$$

> [!example] Esempio numerico (quello delle slide, passo per passo)
> Abbiamo **6 esempi** di test e **4 classi**. Accuracy dentro ogni classe (corretti / totali della classe):
>
> | classe | corretti / totali | accuracy classe |
> |---|:---:|:---:|
> | apple | 1 / 2 | $0.5$ |
> | orange | 1 / 1 | $1$ |
> | banana | 1 / 2 | $0.5$ |
> | pineapple | 1 / 1 | $1$ |
>
> **Microaveraging** — conto i corretti su tutti i 6 esempi ($1+1+1+1 = 4$ corretti su $2+1+2+1 = 6$):
> $$\text{micro} = \frac{4}{6} \approx 0.67$$
>
> **Macroaveraging** — faccio la media delle 4 accuracy per classe (ognuna pesa $1/4$):
> $$\text{macro} = \frac{0.5 + 1 + 0.5 + 1}{4} = \frac{3}{4} = 0.75$$
>
> **Perché vengono diverse?** Nel micro, *apple* e *banana* (che hanno 2 esempi ciascuna) influenzano il conteggio più di *orange* e *pineapple* (1 esempio). Nel macro invece tutte e 4 le classi pesano $1/4$: il fatto che *orange* e *pineapple* siano perfette "tira su" la media, anche se sono classi piccole.

> [!warning] Quando la differenza diventa enorme (data imbalance)
> Il caso interessante è quello **sbilanciato**. Immagina un test con **990 esempi di classe A** e **10 di classe B**, e un classificatore pigro che indovina **tutta la A** ma **sbaglia tutta la B**:
> - $\text{acc}_A = \dfrac{990}{990} = 1$, $\quad \text{acc}_B = \dfrac{0}{10} = 0$
> - **Micro** $= \dfrac{990 + 0}{1000} = 0.99$ → sembra un ottimo classificatore!
> - **Macro** $= \dfrac{1 + 0}{2} = 0.50$ → rivela che su una delle due classi è **totalmente inutile**.
>
> Il micro è "ingannato" dalla classe dominante; il macro **smaschera** il problema perché dà alla classe rara lo stesso peso.

> [!important] Quale usare?
> - **Micro**: ti dice come va "in media su un esempio a caso" → utile se ti interessa la performance complessiva e le classi sono bilanciate.
> - **Macro**: mette **più enfasi sulle classi rare** (ognuna conta uguale) e offre una **dimensione di analisi** in più → fondamentale quando i dati sono **sbilanciati** e ti interessa che il modello funzioni **anche** sulle classi poco frequenti.

## Confusion matrix (matrice di confusione)
> [!important] Definizione
> L'elemento $(i, j)$ rappresenta il **numero di esempi con etichetta vera $i$ che sono stati predetti come $j$**. Spesso espressa in **percentuale**.
> - La **diagonale** ($i = j$) = predizioni corrette (idealmente alta).
> - Gli elementi **fuori diagonale** = errori, e mostrano *con quali* classi un modello fa confusione (es. *jogging* confuso con *running*).

> [!example] Lettura
> Riga = classe vera, colonna = classe predetta. Una riga "Class 1: 70, 10, 15, 5 (totale 100)" significa: dei 100 esempi veri di classe 1, 70 corretti e 30 distribuiti come errori sulle altre classi.

# Da padroneggiare
- **Multiclasse** = come binario ma con $K > 2$ classi; obiettivo: minimizzare $\mathbb{E}_{(\mathbf{x},y)\sim\mathcal{D}}[f(\mathbf{x}) \neq y]$ con $y \in [K]$.
- **k-NN** e **Decision Tree** gestiscono il multiclasse **senza modifiche** (voto di maggioranza / foglie).
- **Black box:** combinare classificatori **binari** per risolvere il multiclasse.
- **OVA (One vs All):** $K$ classificatori (classe $k$ vs tutto il resto). Classifica con **confidence**: positivo più confidente, o negativo meno confidente se nessun positivo. $\hat{y} = \arg\max_k score_k$.
- **AVA (All vs All):** $\frac{K(K-1)}{2}$ classificatori $F_{ij}$ (classe $i$ vs $j$). Voto di maggioranza o pesato ($score_j \mathrel{+}= y$, $score_i \mathrel{-}= y$).
- **Confidence del perceptron** = $b + \sum_i w_i f_i$ = **distanza dall'iperpiano**.
- **OVA vs AVA:** AVA = più classificatori ma su meno dati e più bilanciati; più lento in test, più occasioni d'errore.
- **Valutazione:** accuracy, e attenzione al **data imbalance** → **microaveraging** (sugli esempi) vs **macroaveraging** (sulle classi, pesa di più le classi rare).
- **Confusion matrix:** elemento $(i,j)$ = # esempi di classe vera $i$ predetti come $j$; diagonale = corretti.
