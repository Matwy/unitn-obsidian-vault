---
date: 2026/06/12
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec10-Regularization.pdf]]"
---
## 10 Regularization

> [!abstract] Idea di fondo
> Minimizzare la loss **solo sul training set** porta a **overfitting**: il modello si adatta troppo ai dati di training e generalizza male sul test. La **regularization** aggiunge alla loss un secondo termine — il **regularizer** — che penalizza i modelli "complessi" (tipicamente i **pesi grandi**), spingendo l'apprendimento verso soluzioni più semplici e robuste. La nuova funzione obiettivo diventa **loss + λ·regularizer**, dove $\lambda$ bilancia i due termini. Vedremo i regolarizzatori più comuni (**L1** e **L2**), come modificano la regola di update del gradient descent, e come tanti metodi noti (Ridge, Lasso, Logistic Regression) siano semplicemente combinazioni **loss + regolarizzatore**.

# 1. Ripasso: model-based ML
Una "ricetta" in 3 passi (vista nelle lezioni precedenti):
1. **scegli un modello** (es. iperpiano $0 = b + \sum_{j=1}^m w_j f_j$); i parametri sono $w, b$;
2. **scegli un criterio da ottimizzare** (objective / loss function);
3. **sviluppa un algoritmo di apprendimento** che minimizza il criterio.

Con la **exponential loss** come surrogate, l'obiettivo era:
$$\operatorname*{arg\,min}_{w,b} \sum_{i=1}^{n} \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big)$$
risolto col **gradient descent** ($w_j = w_j - \eta \frac{d}{dw_j}loss$), il cui update assomiglia al perceptron.

# 2. Il problema: overfitting
$$\operatorname*{arg\,min}_{w,b} \sum_{i=1}^{n} \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big)$$

> [!warning] Stiamo minimizzando sul TRAINING set
> Il minimo della loss **sul training set** in generale **NON** è il minimo sul **test set**. Spingere la loss di training a zero significa adattarsi anche al **rumore** dei dati → **overfitting** (confine di decisione contorto che memorizza gli esempi invece di catturare il pattern).

# 3. Regularization
> [!important] Definizione
> Un **regularizer** è un **criterio aggiuntivo** alla loss function che serve a **non andare in overfitting**.
> - si chiama così perché cerca di tenere i parametri più "**normali/regolari**";
> - è un **bias sul modello** che forza l'apprendimento a **preferire certi tipi di pesi** rispetto ad altri.
>
> La nuova funzione obiettivo:
> $$\operatorname*{arg\,min}_{w,b} \sum_{i=1}^{n} loss(y y') + \lambda\, regularizer(w, b)$$

> [!note] In altra notazione
> Si trova spesso scritto come "errore regolarizzato":
> $$E_{reg}(f; \mathcal{D}_n) = E(f; \mathcal{D}_n) + \lambda_n\, \Omega(f)$$
> dove $E$ = errore (loss) sul training, $\Omega(f)$ = termine che penalizza le soluzioni **complesse**, e $\lambda_n$ = **trade-off parameter** (quanto pesa la regolarizzazione). Sommando i due grafici (loss che scende + regolarizzatore che cresce con la complessità) si ottiene un minimo a complessità **intermedia**.

# 4. Che pesi preferiamo?
Per un modello lineare $0 = b + \sum_{j=1}^n w_j f_j$, ha senso chiedersi: dobbiamo permettere **tutti** i possibili pesi? Cosa rende un modello lineare "più semplice"?

> [!important] Principi
> - **Non vogliamo pesi enormi:** se i pesi sono grandi, un **piccolo cambiamento** in una feature può causare un **grande cambiamento** nella predizione (modello instabile, sensibile al rumore).
> - **Potremmo preferire pesi a 0** per le feature **non utili** (selezione automatica delle feature).
>
> Domanda operativa: come **incoraggiamo pesi piccoli** / **penalizziamo pesi grandi**? Mettendo un $regularizer(w,b)$ che misura la "grandezza" dei pesi.

# 5. Regolarizzatori comuni
> [!important] Le due scelte classiche
> - **Somma dei pesi (norma L1):**
> $$r(w, b) = \sum_j |w_j|$$
> - **Somma dei pesi al quadrato (norma L2):**
> $$r(w, b) = \sqrt{\sum_j |w_j|^2}$$

> [!note] Qual è la differenza?
> - i **pesi al quadrato (L2)** penalizzano di più i **valori grandi** (un peso da 10 contribuisce 100);
> - la **somma dei pesi (L1)** penalizza relativamente di più i **valori piccoli** → tende a portarli **esattamente a 0** (soluzioni *sparse*).

## p-norm
> [!important] Generalizzazione
> $$r(w, b) = \sqrt[p]{\sum_j |w_j|^p} = \|w\|^p$$
> - **L1** = caso $p=1$ (somma dei pesi);
> - **L2** = caso $p=2$ (somma dei quadrati).
>
> - valori **piccoli di $p$ ($p<2$)** → incoraggiano vettori **sparsi** (tanti pesi a 0);
> - valori **grandi di $p$** → penalizzano di più i pesi grandi e tendono a rendere i pesi **simili tra loro**.
>
> Tutte le p-norm penalizzano i pesi grandi; cambia *come* lo fanno.

> [!note] Visualizzazione L1 vs L2 (perché L1 dà sparsità)
> Disegnando le "palle" $\{w : r(w) \le \text{cost}\}$: la **palla L1** è un **rombo con gli spigoli sugli assi**, la **palla L2** è un **cerchio liscio**. Quando le curve di livello della loss "toccano" la palla, con L1 è molto **probabile** che il punto di contatto cada su uno **spigolo** (cioè con qualche $w_j = 0$ → sparsità); con L2 il contatto cade quasi sempre **fuori dagli assi** (nessun peso esattamente 0).

# 6. Minimizzare con un regolarizzatore: serve la convessità
Il nuovo schema in 3 passi:
$$\operatorname*{arg\,min}_{w,b} \sum_{i=1}^{n} loss(y y') + \lambda\, regularizer(w)$$

> [!important] Perché la convessità conta
> Sappiamo risolvere problemi **convessi** col gradient descent. Se **sia la loss sia il regolarizzatore sono convessi**, allora **anche la loro somma è convessa** → possiamo ancora usare il gradient descent.

> [!note] Definizione di funzione convessa
> $f$ è convessa se il **segmento** tra due punti qualsiasi del grafico sta **sopra** la funzione. Formalmente, per ogni $x_1, x_2$:
> $$f\big(t x_1 + (1-t) x_2\big) \le t f(x_1) + (1-t) f(x_2) \qquad \forall\, 0 < t < 1$$
> A sinistra: valore della funzione in un punto **intermedio** tra $x_1$ e $x_2$. A destra: valore sul **segmento** che congiunge $f(x_1)$ e $f(x_2)$. Convessa = la curva sta sotto la corda.

> [!success] Le p-norm sono convesse per $p \ge 1$
> Quindi L1 ($p=1$) e L2 ($p=2$) sono entrambe convesse → usabili come regolarizzatori col gradient descent.

# 7. Il criterio finale (exp loss + L2)
> [!important] Funzione obiettivo regolarizzata
> $$\operatorname*{arg\,min}_{w,b} \sum_{i=1}^{n} \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big) + \frac{\lambda}{2}\|w\|^2$$
> - **Loss function** (1° termine): penalizza gli esempi dove la **predizione è diversa dall'etichetta**;
> - **Regularizer** (2° termine): penalizza i **pesi grandi**.
>
> **Chiave:** questa funzione è **convessa** → possiamo usare il gradient descent. (Il $\frac{1}{2}$ è solo per comodità: sparisce quando si deriva.)

# 8. Gradient descent con regolarizzatore
La regola di update ora deriva **loss + regolarizzatore**:
$$w_j = w_j - \eta\, \frac{d}{dw_j}\big(loss(w) + regularizer(w, b)\big)$$

Calcolando la derivata dell'obiettivo (exp loss + L2):
$$\frac{d}{dw_j}\, objective = -\sum_{i=1}^{n} y_i x_{ij}\, \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big) + \lambda w_j$$

> [!note] La derivata del regolarizzatore
> La derivata di $\frac{\lambda}{2}\|w\|^2 = \frac{\lambda}{2}\sum_j w_j^2$ rispetto a $w_j$ è $\lambda w_j$ (ecco perché il $\frac{1}{2}$ è comodo: cancella il 2).

Sostituendo nella regola di update (il doppio meno sulla loss diventa un più):
$$w_j = w_j + \eta \sum_{i=1}^{n} y_i x_{ij}\, \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big) - \eta \lambda w_j$$

## Effetto del regolarizzatore L2
$$w_j = w_j + \underbrace{\eta\, y_i x_{ij}\, \exp(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b))}_{\text{correzione dalla loss}} - \underbrace{\eta \lambda w_j}_{\text{regolarizzazione}}$$
con i pezzi: $\eta$ = learning rate, $y_i x_{ij}$ = direzione dell'update, $\exp(\dots)$ = costante "quanto sono lontano dal corretto", $\eta\lambda w_j$ = termine di regolarizzazione.

> [!important] L2 "restringe" i pesi verso 0 (in proporzione)
> Il termine $-\eta\lambda w_j$:
> - se $w_j$ è **positivo** → lo **riduce**;
> - se $w_j$ è **negativo** → lo **aumenta**;
>
> → in entrambi i casi **muove $w_j$ verso 0**. La spinta è **proporzionale al valore** di $w_j$ (pesi grandi vengono ridotti molto, pesi piccoli poco).

# 9. Regolarizzazione L1
Con L1 il regolarizzatore è $\|w\| = \sum_j |w_j|$. La sua derivata rispetto a $w_j$ è $\lambda\, sign(w_j)$:
$$\frac{d}{dw_j}\bigg(\sum_i \exp(-y_i(\mathbf{w}\cdot\mathbf{x}_i+b)) + \lambda\|w\|\bigg) = -\sum_{i=1}^{n} y_i x_{ij}\exp(-y_i(\mathbf{w}\cdot\mathbf{x}_i+b)) + \lambda\, sign(w_j)$$

L'update diventa:
$$w_j = w_j + \eta\, y_i x_{ij}\exp(-y_i(\mathbf{w}\cdot\mathbf{x}_i+b)) - \eta\lambda\, sign(w_j)$$

> [!important] L1 "restringe" i pesi verso 0 (di una costante fissa)
> Il termine $-\eta\lambda\, sign(w_j)$:
> - se $w_j$ è **positivo** → lo riduce **di una costante**;
> - se $w_j$ è **negativo** → lo aumenta **di una costante**;
>
> → muove $w_j$ verso 0 **indipendentemente dalla sua grandezza**. Questa "spinta costante" è ciò che porta molti pesi **esattamente a 0** (sparsità), a differenza di L2 che li rimpicciolisce solo proporzionalmente.

## Update con le varie norme
> [!note] Confronto (loss_correction = la parte che viene dalla loss)
> - **L1:** $\;w_j = w_j + \eta\,(loss\_correction - \lambda\, sign(w_j))$
> - **L2:** $\;w_j = w_j + \eta\,(loss\_correction - \lambda\, w_j)$
> - **Lp:** $\;w_j = w_j + \eta\,(loss\_correction - \lambda\, c\, w_j^{p-1})$

# 10. Regolarizzatori a confronto
> [!important] Quale scegliere
> - **L1** è popolare perché tende a dare soluzioni **sparse** (tanti pesi a zero → selezione di feature). **Però non è differenziabile** (nello 0), quindi funziona **solo con solver basati su gradient descent**.
> - **L2** è popolare perché per alcune loss si può risolvere **direttamente** (senza gradient descent, anche se spesso si usano comunque solver iterativi).
> - **Lp** è meno popolare perché tende a **non restringere abbastanza** i pesi.

> [!note] Il gradient descent non è l'unico modo
> Per trovare $w, b$ che minimizzano l'obiettivo convesso ci sono **molti** metodi (alcuni non richiedono nemmeno l'iterazione). Il campo che li studia si chiama **convex optimization**.

# 11. Altre loss (update generico)
> [!note] Senza regolarizzazione, l'update generico è
> $$w_j = w_j + \eta\, y_i x_{ij}\, c$$
> dove la costante $c$ dipende dalla loss scelta:
> - **exponential:** $c = \exp(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b))$
> - **hinge loss:** $c = \mathbb{1}[y y' < 1]$ (aggiorna solo se dentro il margine)
> - **squared error:** $\;w_j = w_j + \eta\,(y_i - (\mathbf{w}\cdot\mathbf{x}_i + b))\, x_{ij}$

# 12. Tanti metodi = loss + regolarizzatore
> [!important] Metodi famosi visti come combinazioni
> | Metodo | Loss | Regolarizzazione |
> |---|---|---|
> | **(Ordinary) Least Squares** | squared loss | nessuna |
> | **Ridge regression** | squared loss | **L2** |
> | **Lasso regression** | squared loss | **L1** |
> | **Elastic regression** | squared loss | **L1 + L2** |
> | **Logistic regression** | logistic (log) loss | — |

## Regressione: Ridge e Lasso
> [!important] Le formule
> **Ridge** (squared loss + L2):
> $$L(\mathbf{w}) = \sum_{i=1}^{n}(y_i - \mathbf{x}_i^T \mathbf{w})^2 + \lambda \sum_{j=1}^{p} w_j^2$$
> **Lasso** (squared loss + L1):
> $$L(\mathbf{w}) = \sum_{i=1}^{n}(y_i - \mathbf{x}_i^T \mathbf{w})^2 + \lambda \sum_{j=1}^{p} |w_j|$$
> Il primo termine $(y_i - \mathbf{x}_i^T\mathbf{w})^2$ è l'**errore quadratico** tra valore vero e predetto (in regressione si predice un numero, non una classe).

## Logistic Regression
> [!important] Log loss / binary cross-entropy
> $$L(\mathbf{w}) = -\sum_{i=1}^{n}\big[\, y_i \log(\hat{y}_i) + (1 - y_i)\log(1 - \hat{y}_i)\,\big]$$
> dove la predizione passa per la **sigmoide**:
> $$\hat{y}_i = \sigma(\mathbf{x}_i^T \mathbf{w}) \qquad \sigma(z) = \frac{1}{1 + e^{-z}}$$
> La sigmoide schiaccia il punteggio in $[0,1]$ → si interpreta come **probabilità** (es. probabilità che sia "maligno"); si classifica con soglia $0.5$.

# Da padroneggiare
- **Overfitting:** minimizzare la loss **solo sul training** non dà il minimo sul **test** → serve regolarizzare.
- **Regularizer** = termine aggiuntivo alla loss che penalizza i modelli complessi (pesi grandi): $\operatorname{arg\,min} \sum loss + \lambda\, regularizer$. $\lambda$ = trade-off.
- **Perché pesi piccoli:** pesi grandi → modello instabile (piccoli cambi nelle feature → grandi cambi nella predizione).
- **L1** $= \sum|w_j|$ → soluzioni **sparse** (pesi a 0), non differenziabile. **L2** $= \sqrt{\sum w_j^2}$ → restringe i pesi proporzionalmente, differenziabile.
- **p-norm** $\|w\|^p$: $p<2$ → sparsità; $p>2$ → pesi simili. Convesse per $p \ge 1$.
- **Convessità** ($f(tx_1+(1-t)x_2) \le tf(x_1)+(1-t)f(x_2)$): loss + regolarizzatore convessi → somma convessa → gradient descent OK.
- **Update L2:** $-\eta\lambda w_j$ → muove $w_j$ verso 0 **proporzionalmente** alla sua grandezza.
- **Update L1:** $-\eta\lambda\, sign(w_j)$ → muove $w_j$ verso 0 **di una costante**, indipendentemente dalla grandezza → produce zeri.
- **Metodi noti come loss + regolarizzatore:** Ridge = squared+L2, Lasso = squared+L1, Elastic = squared+L1+L2, Logistic = log loss (con sigmoide $\sigma(z)=\frac{1}{1+e^{-z}}$).
