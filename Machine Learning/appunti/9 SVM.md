---
date: 2026/06/12
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec9-SVM.pdf]]"
---
## 9 Support Vector Machines

> [!abstract] Idea di fondo
> Il Perceptron trova **una** retta qualsiasi che separa i dati, ma non la migliore. Le **Support Vector Machines (SVM)** scelgono l'iperpiano con il **margine più grande**: la distanza dai punti più vicini (i **support vector**) è massimizzata. Questo si traduce in un **problema di ottimizzazione quadratica** (minimizzare $\|w\|^2$ con vincoli). Per gestire dati **non perfettamente separabili** si introducono le **slack variables** (soft margin), che si rivelano essere la **hinge loss** → l'SVM è "regularized loss minimization". Infine, con il **kernel trick** l'SVM diventa **non-lineare**: mappa implicitamente i dati in uno spazio ad alta dimensione dove diventano separabili, senza mai calcolare quella mappa esplicitamente.

# 1. Quale iperpiano scegliere?
Quando i dati sono separabili, esistono **infinite** rette che li separano. I classificatori lineari differiscono per **due aspetti**:
- **quale iperpiano** scelgono quando i dati sono linearmente separabili;
- **come gestiscono** i dati **non** linearmente separabili.

> [!note] Il Perceptron finora
> - **separabile:** trova **una** (qualsiasi) iperpiano che separa i dati;
> - **non separabile:** continua ad aggiustarsi iterando sugli esempi → l'iperpiano finale dipende da **quali esempi ha visto di recente** (instabile).
>
> L'SVM risolve entrambi i punti deboli.

# 2. Large margin classifiers
> [!important] Definizione di margine
> Il **margine** di un classificatore è la **distanza dai punti più vicini** di ciascuna classe. I **large margin classifiers** cercano di **massimizzare** questa distanza.

## Support vectors
Per ogni iperpiano separatore esiste un insieme di "**punti più vicini**": sono i **support vector**.
- in $n$ dimensioni ci sono **almeno $n+1$** support vector;
- **solo i support vector contano**: gli altri esempi di training sono **ignorabili** (spostarli non cambia l'iperpiano). Questa è la proprietà che rende l'SVM robusto.

# 3. Misurare il margine
Per poter massimizzare il margine, prima dobbiamo scriverlo come formula in funzione di $w$ e $b$.

Un iperpiano non cambia se moltiplichiamo $w$ e $b$ per una stessa costante: $w\cdot x + b = 0$ e $5w\cdot x + 5b = 0$ rappresentano lo stesso identico iperpiano. Abbiamo quindi libertà di fissarne la "scala", e l'SVM la fissa imponendo che sui support vector la funzione valga esattamente $\pm 1$:
$$w \cdot x_i + b = +1 \quad \text{(support vector lato positivo)} \qquad w \cdot x_i + b = -1 \quad \text{(lato negativo)}$$
Questo $1$ è solo una **normalizzazione**: indica il valore della funzione su quei punti, non la loro distanza geometrica dall'iperpiano.

La distanza di un punto $x_i$ dall'iperpiano si calcola con una formula nota dall'algebra lineare (la versione $n$-dimensionale della distanza punto-retta $\frac{|ax_0+by_0+c|}{\sqrt{a^2+b^2}}$):
$$\text{distanza} = \frac{|w \cdot x_i + b|}{\|w\|}$$
Si divide per $\|w\|$ perché $w$ è il vettore perpendicolare all'iperpiano e in generale non ha lunghezza unitaria. Sui support vector il numeratore vale $1$ per la normalizzazione scelta, quindi la distanza dell'iperpiano dal punto più vicino è semplicemente:
$$\text{margine} = \frac{1}{\|w\|}$$

> [!important] Il margine dipende solo da $\|w\|$
> Una volta fissato il numeratore a $1$, il margine $\frac{1}{\|w\|}$ dipende **solo dalla norma dei pesi**: $\|w\|$ funziona come la "pendenza" della funzione $w\cdot x + b$. Se $\|w\|$ è grande la funzione passa da $-1$ a $+1$ in poco spazio (margine stretto); se è piccolo cambia lentamente (margine largo). Il bias $b$ sposta solo *dove* sta l'iperpiano, non quanto è larga la banda, quindi non compare nella formula. La larghezza totale (da un support vector all'altro) è $\frac{2}{\|w\|}$.
>
> Di conseguenza, **massimizzare il margine equivale a minimizzare $\|w\|$**.

# 4. Massimizzare il margine
> [!important] Problema di ottimizzazione vincolato
> Seleziona l'iperpiano col margine **più grande** dove i punti sono classificati **correttamente** e **fuori dal margine**:
> $$\max_{w, b}\ \text{margin}(w, b) \qquad \text{subject to:} \quad y_i(w \cdot x_i + b) \ge 1 \quad \forall i$$
> Il vincolo $y_i(w\cdot x_i + b) \ge 1$ significa: ogni punto è dal lato giusto **e** oltre il margine ($y_i = \pm 1$ moltiplica così che il prodotto è $\ge 1$ quando la classificazione è corretta e confidente).

Poiché $\text{margin} = \frac{1}{\|w\|}$, riscriviamo:
$$\max_{w,b}\ \frac{1}{\|w\|} \quad \Longleftrightarrow \quad \min_{w,b}\ \|w\| \quad \Longleftrightarrow \quad \min_{w,b}\ \|w\|^2$$

> [!note] Perché queste forme sono equivalenti
> Massimizzare $\frac{1}{\|w\|}$ equivale a **minimizzare $\|w\|$** (più piccola è la norma, più largo è il margine). Si usa $\|w\|^2$ invece di $\|w\|$ perché è **più comodo da derivare** (niente radice quadrata) e dà lo stesso minimo. I **vincoli** garantiscono che i dati restino separati correttamente.

## Il problema SVM (hard margin)
> [!important] Formulazione base
> $$\min_{w,b}\ \|w\|^2 \qquad \text{subject to:} \quad y_i(w \cdot x_i + b) \ge 1 \quad \forall i$$
> È un **problema di ottimizzazione quadratica** (quadratic optimization): minimizzare una funzione quadratica soggetta a vincoli lineari. È detto **problema primale (primal)**.

# 5. Soft Margin Classification
Problema: e se i dati **non** sono linearmente separabili (o vogliamo tollerare qualche errore)? I vincoli $y_i(w\cdot x_i + b)\ge 1$ sarebbero **impossibili** da soddisfare. Vorremmo "imparare qualcosa" anche così, ma i vincoli non lo permettono.

## Slack variables
> [!important] Si "allentano" i vincoli
> Si introduce una **slack variable** $\varsigma_i \ge 0$ (una per ogni esempio):
> $$\min_{w,b}\ \|w\|^2 + C \sum_i \varsigma_i \qquad \text{subject to:} \quad y_i(w \cdot x_i + b) \ge 1 - \varsigma_i, \quad \varsigma_i \ge 0 \quad \forall i$$
> - $\varsigma_i$ = di **quanto** un punto può "sforare" il margine (slack penalty) → **gli è permesso sbagliare**;
> - $C \sum_i \varsigma_i$ = penalità: più un punto è lontano dal "corretto", più paga;
> - $C$ = **trade-off** tra massimizzare il margine e penalizzare le violazioni.
>
> Rimane un **problema di ottimizzazione quadratica**.

## Il parametro $C$
> [!important] $C$ controlla l'overfitting (è un parametro di regolarizzazione)
> - **$C$ piccolo** → i vincoli si possono ignorare facilmente → **margine largo** (più tolleranza agli errori, modello più semplice);
> - **$C$ grande** → i vincoli sono difficili da ignorare → **margine stretto** (si forza il fit sul training);
> - **$C = \infty$** → impone **tutti** i vincoli → **hard margin** (il caso separabile di prima).
>
> $C$ "bilancia" l'importanza relativa di **massimizzare il margine** e **fittare i dati di training**.

## Capire le slack variables
Data la soluzione ottima $(w, b)$, quanto vale $\varsigma_i$ per ogni punto? Ragioniamo per casi:
- **punto fuori (o sul) margine E classificato bene** ($y_i(w\cdot x_i+b)\ge 1$) → $\varsigma_i = 0$ (non serve slack, il vincolo è già soddisfatto);
- **punto dentro il margine oppure mal classificato** → $\varsigma_i = 1 - y_i(w\cdot x_i + b)$ (la "distanza" che gli manca per arrivare al margine).

> [!important] Definizione a casi → hinge loss
> $$\varsigma_i = \begin{cases} 0 & \text{se } y_i(w \cdot x_i + b) \ge 1 \\ 1 - y_i(w \cdot x_i + b) & \text{altrimenti} \end{cases}$$
> Che si scrive in modo compatto:
> $$\varsigma_i = \max\big(0,\ 1 - y_i(w \cdot x_i + b)\big) = \max(0,\ 1 - y y')$$
> Questa è esattamente la **hinge loss** vista nella lezione sul gradient descent!

# 6. SVM = regularized loss minimization
Sostituendo $\varsigma_i = \max(0, 1 - y_i(w\cdot x_i + b))$ nel problema, i vincoli **spariscono**:
$$\min_{w,b}\ \|w\|^2 + C \sum_i \max\big(0,\ 1 - y_i(w \cdot x_i + b)\big)$$

> [!success] È un problema NON vincolato (unconstrained)!
> Eliminando le slack tramite la hinge loss, l'SVM diventa una minimizzazione **senza vincoli**.

Scrivendolo con la loss esplicita:
$$\min_{w,b}\ \|w\|^2 + C \sum_i loss_{hinge}(y_i, y_i')$$

> [!important] La forma generale: loss + regolarizzatore
> $$\operatorname*{arg\,min}_{w,b} \sum_{i=1}^{n} loss(y y') + \lambda\, regularizer(w, b)$$
> L'SVM è un caso di questo schema generale: **hinge loss** + regolarizzatore $\|w\|^2$ (che è la **L2 / norma dei pesi**). Massimizzare il margine = regolarizzare con $\|w\|^2$.

# 7. Dati non linearmente separabili: feature spaces
> [!important] Idea generale
> Lo spazio delle feature originale può **sempre** essere mappato in uno spazio a **dimensione più alta** dove il training set diventa **separabile**.
> $$\Phi: \mathbf{x} \rightarrow \varphi(\mathbf{x})$$
> Esempio 1D: dati rossi-blu-rossi su una retta non sono separabili da una soglia; mappandoli in $(x, x^2)$ (2D) diventano separabili da una retta. La mappa $\varphi$ "apre" i dati in dimensione superiore.

# 8. Il problema duale
Per risolvere l'SVM si passa spesso al **problema duale**. Le SVM sono un caso di **quadratic programming**; ricordiamo le classi di problemi di ottimizzazione:

> [!note] Classi di problemi di ottimizzazione
> - **Linear Programming (LP):** obiettivo lineare, vincoli lineari.
> - **Quadratic Programming (QP):** obiettivo **quadratico**, vincoli lineari → **convesso** se la matrice $Q$ è semidefinita positiva. ← *l'SVM sta qui*
> - **Nonlinear Programming (NLP):** in generale **non convesso**.

> [!important] Formulazione duale
> Si associa un **moltiplicatore di Lagrange** $\alpha_i$ a ogni vincolo di disuguaglianza del primale:
> $$\max_{\boldsymbol{\alpha}}\ \sum_i \alpha_i - \frac{1}{2}\sum_i \sum_j \alpha_i \alpha_j\, y_i y_j\, \mathbf{x}_i^T \mathbf{x}_j \qquad \text{s.t.} \quad \sum_i \alpha_i y_i = 0, \quad \alpha_i \ge 0 \ \forall i$$
> Si massimizza rispetto agli $\alpha_i$.

## La soluzione
> [!important] Dal duale al primale
> Data la soluzione $\alpha_1, \dots, \alpha_n$ del duale, la soluzione del primale è:
> $$\mathbf{w} = \sum_i \alpha_i y_i \mathbf{x}_i \qquad\qquad b = y_k - \sum_i \alpha_i y_i \mathbf{x}_i^T \mathbf{x}_k$$
> - ogni $\alpha_i \neq 0$ indica che il corrispondente $\mathbf{x}_i$ è un **support vector** (gli altri hanno $\alpha_i = 0$ → non contano);
> - la **funzione di classificazione** (non serve $\mathbf{w}$ esplicitamente):
> $$f(\mathbf{x}) = \sum_i \alpha_i y_i\, \mathbf{x}_i^T \mathbf{x} + b$$

> [!note] Due osservazioni chiave
> - la soluzione dipende dal **prodotto interno** $\mathbf{x}_i^T \mathbf{x}$ tra il punto di test e i support vector;
> - risolvere il problema richiede di calcolare i **prodotti interni tra tutti i punti** di training.
>
> ⟵ Questa osservazione è ciò che rende possibile il **kernel trick**.

## Duale con soft margin
> [!note] Caso non separabile
> È identico ma con un vincolo in più sugli $\alpha$:
> $$\max_{\boldsymbol{\alpha}}\ \sum_i \alpha_i - \frac{1}{2}\sum_i \sum_j \alpha_i \alpha_j y_i y_j \mathbf{x}_i^T \mathbf{x}_j \qquad \text{s.t.} \quad \sum_i \alpha_i y_i = 0, \quad 0 \le \alpha_i \le C \ \forall i$$
> Gli $\alpha_i$ sono "tappati" a $C$ (prima erano solo $\ge 0$). Di nuovo, i punti con $\alpha_i \neq 0$ sono i support vector.

> [!note] Riassunto SVM lineare
> - il classificatore è un **iperpiano separatore**;
> - i punti più "importanti" sono i **support vector**: definiscono l'iperpiano;
> - algoritmi di ottimizzazione quadratica trovano quali punti sono support vector ($\alpha_i \neq 0$);
> - **sia nel duale sia nella soluzione i punti compaiono solo dentro prodotti interni** $\mathbf{x}_i^T \mathbf{x}_j$.

# 9. Kernel Trick
> [!important] L'intuizione
> Sia il duale sia la soluzione usano solo **prodotti interni**. Definiamo:
> $$K(\mathbf{x}_i, \mathbf{x}_j) = \mathbf{x}_i^T \mathbf{x}_j$$
> Se mappiamo ogni punto in alta dimensione con $\Phi: \mathbf{x} \rightarrow \varphi(\mathbf{x})$, il prodotto interno diventa:
> $$K(\mathbf{x}_i, \mathbf{x}_j) = \varphi(\mathbf{x}_i)^T \varphi(\mathbf{x}_j)$$
> Una **kernel function** è una funzione **equivalente a un prodotto interno in qualche feature space**.

> [!success] Il trucco
> Una kernel function **mappa implicitamente** i dati in uno spazio ad alta dimensione, **senza dover calcolare esplicitamente $\varphi(\mathbf{x})$**. Basta saper calcolare $K$, che spesso è molto più economico della mappa $\varphi$.

> [!example] Esempio (kernel polinomiale di grado 2)
> Per vettori 2D $\mathbf{x} = [x_1, x_2]$, sia $K(\mathbf{x}_i, \mathbf{x}_j) = (1 + \mathbf{x}_i^T \mathbf{x}_j)^2$. Espandendo si dimostra che:
> $$K(\mathbf{x}_i, \mathbf{x}_j) = \varphi(\mathbf{x}_i)^T \varphi(\mathbf{x}_j), \quad \text{con } \varphi(\mathbf{x}) = [1,\ x_1^2,\ \sqrt{2}\,x_1 x_2,\ x_2^2,\ \sqrt{2}\,x_1,\ \sqrt{2}\,x_2]$$
> Calcolare $K$ (un prodotto + un quadrato) è molto più rapido che costruire il vettore $\varphi$ a 6 dimensioni e poi farne il prodotto interno.

## Quali funzioni sono kernel?
> [!note] Teorema di Mercer
> Verificare a mano che $K(\mathbf{x}_i,\mathbf{x}_j) = \varphi(\mathbf{x}_i)^T\varphi(\mathbf{x}_j)$ può essere scomodo. **Teorema di Mercer:**
> - ogni **funzione simmetrica semidefinita positiva** è un kernel;
> - corrisponde a una **matrice di Gram** simmetrica semidefinita positiva (la matrice $K$ con entry $K(\mathbf{x}_i,\mathbf{x}_j)$).
>
> *Ricorda:* una matrice simmetrica è semidefinita positiva sse tutti gli **autovalori sono $\ge 0$**.

## Kernel comuni
> [!important] I tre kernel da sapere
> - **Lineare:** $\;K(\mathbf{x}_i, \mathbf{x}_j) = \mathbf{x}_i^T \mathbf{x}_j$ (nessuna mappa, SVM lineare normale)
> - **Polinomiale di grado $p$:** $\;K(\mathbf{x}_i, \mathbf{x}_j) = (1 + \mathbf{x}_i^T \mathbf{x}_j)^p$
> - **Gaussiano (RBF, radial-basis function):** $\;K(\mathbf{x}_i, \mathbf{x}_j) = e^{-\frac{\|\mathbf{x}_i - \mathbf{x}_j\|^2}{2\sigma^2}}$
>   - corrisponde a una mappa $\varphi(\mathbf{x})$ **a dimensione infinita**! (impossibile da calcolare esplicitamente, ma il kernel sì).

## Problema SVM non lineare
> [!important] Duale + soluzione con kernel
> Basta **sostituire $\mathbf{x}_i^T \mathbf{x}_j$ con $K(\mathbf{x}_i, \mathbf{x}_j)$**:
> $$\max_{\boldsymbol{\alpha}}\ \sum_i \alpha_i - \frac{1}{2}\sum_i \sum_j \alpha_i \alpha_j y_i y_j\, K(\mathbf{x}_i, \mathbf{x}_j) \qquad \text{s.t.} \quad \sum_i \alpha_i y_i = 0, \ \alpha_i \ge 0$$
> Soluzione (classificatore):
> $$f(\mathbf{x}) = \sum_i \alpha_i y_i\, K(\mathbf{x}_i, \mathbf{x}) + b$$
> Le **tecniche di ottimizzazione per trovare gli $\alpha_i$ restano le stesse**! Cambia solo il kernel.

# 10. Osservazioni finali (SVM Remarks)
> [!note] Note pratiche
> - le SVM furono proposte da **Boser, Guyon e Vapnik (1992)**, popolari a fine anni '90;
> - applicate con successo da testo a dati genomici;
> - con kernel ad hoc gestiscono **dati complessi** (grafi, sequenze, dati relazionali);
> - estese a regressione, PCA, ecc.;
> - gli algoritmi più usati (es. **SMO**) ottimizzano un sottoinsieme di $\alpha_i$ alla volta;
> - **tuning = "black art":** scegliere kernel e parametri ($C$, $\sigma$, $p$) si fa per **grid search** (prova-e-vedi).

> [!example] Applicazione: pedestrian detection (HOG + SVM)
> Rilevare persone in un'immagine come **classificazione binaria** (finestra: contiene una persona o no?). Ogni finestra è rappresentata da un vettore di feature **HOG** ($\mathbf{x}_i \in \mathbb{R}^d$, es. $d = 1024$); si allena un SVM e in test si usa uno **sliding window classifier** $f(x) = \mathbf{w}^T \mathbf{x} + b$.

# Da padroneggiare
- **SVM = large margin classifier:** sceglie l'iperpiano col **margine massimo** (distanza dai punti più vicini).
- **Support vector** = i punti più vicini all'iperpiano; **solo loro contano** (hanno $\alpha_i \neq 0$). In $n$ dim ce ne sono almeno $n+1$.
- **Margine** $= \frac{1}{\|w\|}$ → massimizzarlo equivale a $\min \|w\|^2$.
- **Problema primale (hard margin):** $\min \|w\|^2$ s.t. $y_i(w\cdot x_i + b) \ge 1$ → **quadratic optimization**.
- **Soft margin:** slack $\varsigma_i$ permettono errori → $\min \|w\|^2 + C\sum \varsigma_i$ s.t. $y_i(w\cdot x_i+b) \ge 1 - \varsigma_i$.
- **$C$** = regolarizzazione: piccolo → margine largo (semplice); grande → margine stretto; $\infty$ → hard margin.
- **Slack = hinge loss:** $\varsigma_i = \max(0, 1 - y_i(w\cdot x_i + b))$ → SVM è **hinge loss + regolarizzatore $\|w\|^2$** (problema non vincolato).
- **Duale:** moltiplicatori $\alpha_i$; $w = \sum \alpha_i y_i x_i$; $f(x) = \sum \alpha_i y_i\, x_i^T x + b$. I punti compaiono **solo in prodotti interni**.
- **Kernel trick:** $K(x_i, x_j) = \varphi(x_i)^T \varphi(x_j)$ = prodotto interno in uno spazio ad alta dim, calcolato **implicitamente** senza costruire $\varphi$.
- **Kernel comuni:** lineare $x_i^T x_j$, polinomiale $(1+x_i^T x_j)^p$, **gaussiano/RBF** $e^{-\|x_i-x_j\|^2/2\sigma^2}$ (mappa a dim infinita).
- **SVM non lineare:** stesso duale ma con $K(x_i,x_j)$ al posto di $x_i^T x_j$; $f(x) = \sum \alpha_i y_i K(x_i, x) + b$.
