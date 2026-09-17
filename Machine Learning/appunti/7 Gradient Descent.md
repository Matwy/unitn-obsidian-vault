---
date: 2026/06/12
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec7-GradientDescent.pdf]]"
---
## 7 Gradient Descent

> [!abstract] Idea di fondo
> Questa lezione formalizza **come si impara** un modello lineare. L'approccio è il **model-based machine learning**, fatto di 3 ingredienti: **(1)** scegli un **modello** (es. un iperpiano), **(2)** scegli una **funzione obiettivo** (objective / loss) che misura quanto sbagli, **(3)** sviluppi un **algoritmo** che **minimizza** quella loss. Il problema: la loss "vera" (la **0/1 loss**, cioè il numero di errori) è **impossibile da minimizzare direttamente** (NP-hard, a gradini). La soluzione: sostituirla con una **surrogate loss** continua e **convessa**, e minimizzarla con il **Gradient Descent** — l'algoritmo che "scende" lungo la pendenza (derivata) fino al minimo. Scopriremo che il **Perceptron** è in pratica un caso particolare di gradient descent.

# 1. Ripasso: modelli lineari
Un **modello lineare** assume che i dati siano **linearmente separabili** e cerca un'ipotesi nello spazio delle **funzioni lineari** (una retta/iperpiano che separa le classi).

Un modello lineare in uno spazio a $n$ dimensioni (cioè $n$ feature) è definito da **$n+1$ pesi**.

> [!important] La stessa idea in più dimensioni
> - **2 dimensioni** → una **retta**: $\;0 = w_1 f_1 + w_2 f_2 + b$
> - **3 dimensioni** → un **piano**: $\;0 = w_1 f_1 + w_2 f_2 + w_3 f_3 + b$
> - **$n$ dimensioni** → un **iperpiano**:
> $$0 = b + \sum_{i=1}^{n} w_i f_i$$
> $f_i$ = feature, $w_i$ = pesi, $b$ = bias. I **$w_i$ e $b$ sono i parametri da imparare**.

## Ripasso: algoritmo del Perceptron
```
repeat until convergence (o per un certo # di iterazioni):
  for each training example (f_1, ..., f_n, label):
      prediction = b + Σ_{i=1}^{n} w_i f_i
      if prediction * label ≤ 0:          # "non sono d'accordo" (segni diversi)
          for each w_i:
              w_i = w_i + f_i * label
          b = b + label
```

> [!note] La condizione di errore
> $$prediction \cdot label \le 0$$
> Se la predizione e l'etichetta hanno **segno diverso** (o il prodotto è $0$), il loro prodotto è $\le 0$: vuol dire che il perceptron ha **sbagliato** → si aggiornano pesi e bias. Il perceptron è garantito trovare **una** retta che separa i dati, non la migliore.

# 2. Model-based machine learning
È una "ricetta" generale in **3 passi**:

> [!important] I 3 ingredienti
> 1. **Scegli un modello** (es. un iperpiano, un decision tree, ...). Un modello è definito da una **collezione di parametri**.
> 2. **Scegli un criterio da ottimizzare** (aka **objective function** / funzione obiettivo), es. il **training error**.
> 3. **Sviluppa un algoritmo di apprendimento** che cerca di **minimizzare** quel criterio (a volte in modo euristico/non ottimale, a volte esatto).

> [!note] Quali sono i parametri? E il criterio?
> - **Decision Tree:** la struttura dell'albero, su quali feature splitta ogni nodo, le predizioni alle foglie.
> - **Perceptron:** i **pesi** $w$ e il **bias** $b$.
>
> Per i modelli lineari il passo 1 è già fisso: $\;0 = b + \sum_{j=1}^{m} w_j f_j\;$ → **i parametri da imparare sono $w$ e $b$**. Restano da definire il passo 2 (la loss) e il passo 3 (l'algoritmo).

# 3. Notazione utile

## Funzione indicatrice
Notazione comoda per trasformare risposte **vero/falso** in **numeri** (così si possono sommare/contare):
$$\mathbb{1}[x] = \begin{cases} 1 & \text{se } x = \text{True} \\ 0 & \text{se } x = \text{False} \end{cases}$$

## Prodotto scalare (dot product)
Usiamo una **notazione vettoriale**: un esempio $f_1, f_2, \dots, f_m$ diventa un unico vettore $\mathbf{x}$.
- pedice $j$ = indice della **feature**, es. $x_j$;
- pedice $i$ = indice dell'**esempio** nel dataset, es. $\mathbf{x}_i$.

Anche i pesi $w_1, \dots, w_m$ diventano un vettore $\mathbf{w}$. Il **prodotto scalare** tra due vettori $a$ e $b$:
$$a \cdot b = \sum_{j=1}^{m} a_j b_j$$

> [!note] Perché serve
> Con questa notazione il punteggio del modello lineare $b + \sum_i w_i f_i$ si scrive in modo compatto come $\mathbf{w} \cdot \mathbf{x} + b$.

# 4. La funzione obiettivo: 0/1 loss
Per i modelli lineari, una scelta naturale di criterio (passo 2) è:
$$\sum_{i=1}^{n} \mathbb{1}\big[\, y_i (\mathbf{w} \cdot \mathbf{x}_i + b) \le 0 \,\big]$$

> [!important] Cosa dice questa formula
> - $\mathbf{w} \cdot \mathbf{x}_i + b$ = **distanza dall'iperpiano**; il suo **segno è la predizione**.
> - $y_i$ = etichetta vera ($\pm 1$). Quindi $y_i(\mathbf{w}\cdot\mathbf{x}_i + b) \le 0$ è **vero quando predizione ed etichetta NON concordano** (segni diversi) → cioè quando c'è un **errore**.
> - La funzione indicatrice mette $1$ a ogni errore, $0$ altrimenti. La somma è quindi il **numero totale di errori**, detto **0/1 loss** (training error).

Il passo 3 (learning algorithm) diventa quindi: trovare i parametri che la minimizzano.
$$\operatorname*{arg\,min}_{\mathbf{w}, b} \sum_{i=1}^{n} \mathbb{1}\big[\, y_i (\mathbf{w} \cdot \mathbf{x}_i + b) \le 0 \,\big]$$
cioè: **trova $\mathbf{w}$ e $b$ che minimizzano la 0/1 loss** (l'errore sul training).

# 5. Perché minimizzare la 0/1 loss è difficile
La 0/1 loss in funzione di $w$ è una **funzione a gradini** (a scalini): ogni volta che cambiamo $w$ tanto da rendere un esempio giusto/sbagliato, la loss **scende/sale di colpo**. Ogni nuova feature (peso) aggiunge una dimensione a questo spazio.

> [!warning] Il problema: è NP-HARD
> Minimizzare la 0/1 loss è un problema **NP-HARD**. Tre difficoltà:
> - **piccoli cambiamenti** in un $w$ possono dare **grandi salti** nella loss (non è continua);
> - ci possono essere **moltissimi minimi locali**;
> - in un punto qualsiasi **non abbiamo informazione** su dove andare per migliorare (la funzione è piatta a tratti → derivata nulla quasi ovunque, nessuna "direzione").

# 6. Funzioni di loss più gestibili
Quali **proprietà** vogliamo dalla loss?

> [!important] Loss ideale
> - **Continua / differenziabile** → così ci dà un'**indicazione della direzione** in cui minimizzare (la pendenza).
> - **Un solo minimo** (così non restiamo intrappolati in minimi locali).
>
> Una funzione a forma di "ciotola" (parabola) ha entrambe le proprietà.

## Funzioni convesse
> [!note] Definizione (intuitiva)
> Una funzione è **convessa** se il **segmento** che congiunge due punti qualsiasi del grafico sta **sopra** (o sulla) la funzione. Forma a "ciotola" in 2D, a "scodella" in 3D. Le funzioni convesse hanno **un unico minimo (globale)** → facili da minimizzare.

# 7. Surrogate loss functions
Idea: la 0/1 loss è quella che vorremmo davvero minimizzare, ma è scomoda. Allora la **rimpiazziamo** con una **surrogate loss** (loss surrogata).

> [!important] Definizione
> Una **surrogate loss function** è una loss che fornisce un **upper bound** (limite superiore) sulla loss vera (qui la 0/1). Cerchiamo surrogate **convesse**, così sono facili da minimizzare. Minimizzando l'upper bound, "spingiamo giù" anche la 0/1.
>
> Il **cuore di una loss** è *come penalizza la differenza* tra l'etichetta vera $y$ e quella predetta $y'$.

> [!example] Le loss più comuni
> Definendo le loss in funzione di $y$ (vero) e $y'$ (predetto):
> - **0/1 loss:** $\;l(y, y') = \mathbb{1}[\, y y' \le 0\,]$ → conta solo se sbagli (non convessa)
> - **Hinge:** $\;l(y, y') = \max(0,\; 1 - y y')$ → usata dalle SVM
> - **Exponential:** $\;l(y, y') = \exp(-y y')$
> - **Squared loss:** $\;l(y, y') = (y - y')^2$
>
> Il prodotto $y y'$ è grande e positivo quando predizione ed etichetta concordano con confidenza → la loss è bassa; è negativo quando sbagli → la loss è alta. Tutte queste (tranne la 0/1) sono **convesse** e sono un **upper bound** della 0/1.

## Mettendo insieme il tutto
Scegliendo la **exponential loss** come surrogate, i 3 passi del model-based ML diventano:
> [!important] Ricetta completa (con exp loss)
> 1. **Modello:** $\;0 = b + \sum_{j=1}^{m} w_j f_j$
> 2. **Criterio (objective):** $\;\displaystyle\sum_{i=1}^{n} \exp\big(-y_i(\mathbf{w} \cdot \mathbf{x}_i + b)\big)$
> 3. **Algoritmo:** $\;\displaystyle\operatorname*{arg\,min}_{\mathbf{w},b} \sum_{i=1}^{n} \exp\big(-y_i(\mathbf{w} \cdot \mathbf{x}_i + b)\big)$ → trova $\mathbf{w}, b$ che minimizzano la **surrogate loss**.

# 8. Gradient Descent
Domanda: come troviamo il **minimo** di una funzione (convessa)? Risposta: **Gradient Descent** (discesa del gradiente).

> [!important] L'idea
> Le **derivate parziali** ci danno la **pendenza** (slope), cioè **in che direzione muoversi** in quella dimensione.
>
> **Approccio:**
> - scegli un **punto di partenza** $w$;
> - **ripeti** finché la loss non smette di diminuire in nessuna dimensione:
>   - scegli una dimensione;
>   - **muoviti di poco** in quella dimensione **verso la loss decrescente** (usando la derivata).

## La regola di aggiornamento
$$w_j = w_j - \frac{d}{d w_j}\, loss$$

> [!important] Perché il segno meno?
> La derivata $\frac{d}{dw_j}loss$ punta nella direzione in cui la loss **cresce**. Noi vogliamo **diminuirla**, quindi ci muoviamo nella direzione **opposta** → segno **negativo**.

### Il learning rate
$$w_j = w_j - \eta\, \frac{d}{d w_j}\, loss$$

> [!note] $\eta$ = learning rate
> $\eta$ (eta) controlla **quanto** ci muoviamo nella direzione dell'errore a ogni passo. È un **iperparametro molto importante** e spesso **cambia nel tempo** (si riduce man mano).

# 9. Derivazione del gradiente (per la exp loss)
Calcoliamo la derivata della nostra loss exp rispetto a $w_j$. Usando la regola della catena:
$$\frac{d}{dw_j} loss = \frac{d}{dw_j} \sum_{i=1}^{n} \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big)$$
$$= \sum_{i=1}^{n} \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big)\, \frac{d}{dw_j}\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big)$$
$$= \sum_{i=1}^{n} -\,y_i\, x_{ij}\, \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big)$$

> [!note] Il passaggio chiave
> La derivata di $\exp(g)$ è $\exp(g)\cdot g'$ (regola della catena). E $\frac{d}{dw_j}\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big) = -y_i x_{ij}$, perché nel prodotto scalare $\mathbf{w}\cdot\mathbf{x}_i = \sum_j w_j x_{ij}$ solo il termine con $w_j$ sopravvive e la sua derivata è $x_{ij}$.

Sostituendo nella regola di gradient descent ($w_j = w_j - \eta \frac{d}{dw_j}loss$), il doppio segno meno diventa un più:
$$w_j = w_j + \eta \sum_{i=1}^{n} y_i\, x_{ij}\, \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big)$$

# 10. La regola di update assomiglia al Perceptron!
Considerando **un esempio alla volta** $\mathbf{x}_i$ (senza la sommatoria):
$$w_j = w_j + \eta\, y_i\, x_{ij}\, \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big)$$

In pratica si può riscrivere come:
$$w_j = w_j + x_{ij}\, y_i\, c \qquad \text{dove} \qquad c = \eta\, \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big)$$

> [!important] Il collegamento col Perceptron
> Confronta con l'update del perceptron $\;w_i = w_i + f_i \cdot label$. È **la stessa forma**! ($x_{ij}$ = feature, $y_i$ = label). Quindi **il perceptron è (quasi) gradient descent con exponential loss**, a meno del learning rate e della costante $c$.
>
> **Differenza chiave:** il perceptron aggiorna **solo quando sbaglia** (`if prediction*label ≤ 0`), mentre il gradient descent aggiorna **sempre** (a ogni esempio, anche se è già classificato bene).

## La costante $c$
$$c = \eta\, \exp\big(-y_i(\mathbf{w}\cdot\mathbf{x}_i + b)\big)$$
dove $\eta$ = learning rate, $y_i$ = label, $(\mathbf{w}\cdot\mathbf{x}_i + b)$ = prediction.

> [!note] Quando $c$ è grande/piccola?
> - se **label e prediction hanno lo stesso segno** (esempio classificato bene): più la prediction è grande (confidente), **più piccolo** l'update → "tanto è già giusto, non toccare troppo";
> - se **hanno segno diverso** (errore): più sono diversi, **più grande** l'update → "ho sbagliato di brutto, correggi forte".

# 11. Il gradiente (caso multidimensionale)
Con più pesi, la "direzione di discesa" è data dal **gradiente**, cioè il **vettore di tutte le derivate parziali**:
$$\nabla_{\mathbf{w}} L = \left[ \frac{\partial L}{\partial w_1},\ \frac{\partial L}{\partial w_2},\ \dots,\ \frac{\partial L}{\partial w_N} \right]$$

> [!note] Proprietà del gradiente
> - ogni derivata parziale misura **quanto cambia la loss** muovendosi in quella dimensione;
> - quando il gradiente è **zero**, non ci muoviamo → siamo a un minimo (o punto stazionario);
> - il gradiente (negato) **punta sempre verso un minimo**.

## Algoritmo generale
> [!important] Algorithm 21 — GradientDescent($\mathcal{F}, K, \eta_1, \dots$)
> ```
> z^(0) ← ⟨0, 0, ..., 0⟩          # inizializza la variabile da ottimizzare
> for k = 1 ... K do
>     g^(k) ← ∇_z F |_{z^(k-1)}    # calcola il gradiente nel punto corrente
>     z^(k) ← z^(k-1) - η^(k) g^(k) # fai un passo "giù" lungo il gradiente
> end for
> return z^(K)
> ```
> $K$ = numero di iterazioni, $\eta^{(k)}$ = learning rate (può variare a ogni passo $k$).

# 12. Problemi del Gradient Descent

> [!warning] Minimi locali
> Se il problema di ottimizzazione è **non-convesso**, probabilmente ha **minimi locali**: il gradient descent può rimanere intrappolato in un minimo locale invece di trovare il **minimo globale**. (Per questo per molto tempo si preferirono metodi che garantivano l'ottimo; le **reti neurali** sono un esempio di problema non-convesso.)

> [!warning] Saddle points (punti di sella)
> Un **punto di sella**: alcune direzioni curvano **in su**, altre **in giù**. Lì il gradiente è **0 anche se non siamo a un minimo**:
> - se siamo **esattamente** sul punto di sella → restiamo bloccati;
> - se siamo **leggermente di lato** → riusciamo a sbloccarci.
>
> I punti di sella sono **molto comuni in alta dimensione**!

> [!warning] Learning rate: iperparametro critico
> Il valore di $\eta$ è cruciale:
> - **troppo piccolo** (es. $0.03$) → converge **lentissimo**, tanti passi;
> - **giusto** (es. $0.4$) → scende dritto al minimo;
> - **troppo grande** (es. $1.02$) → **rimbalza** avanti e indietro e **diverge** (la loss esplode invece di scendere).

# Da padroneggiare
- **Model-based ML** = 3 passi: **(1)** modello, **(2)** objective/loss function, **(3)** algoritmo di minimizzazione.
- **Modello lineare** in $n$ dim = iperpiano $0 = b + \sum_i w_i f_i$, definito da $n+1$ pesi; i parametri da imparare sono $\mathbf{w}, b$.
- **0/1 loss** = numero di errori: $\sum_i \mathbb{1}[y_i(\mathbf{w}\cdot\mathbf{x}_i+b)\le 0]$. È quella che vorremmo minimizzare, ma è **NP-hard** (a gradini, tanti minimi locali, nessuna direzione).
- **Surrogate loss** = loss continua e **convessa** che fa da **upper bound** alla 0/1. Esempi: **hinge** $\max(0,1-yy')$, **exponential** $\exp(-yy')$, **squared** $(y-y')^2$.
- **Funzione convessa** = segmento tra due punti sta sopra la curva → **un solo minimo** → facile da minimizzare.
- **Gradient Descent:** $\;w_j = w_j - \eta \frac{d}{dw_j}loss$. Segno **meno** perché ci si muove **contro** il gradiente (verso la loss decrescente). $\eta$ = **learning rate**.
- **Gradiente** = vettore delle derivate parziali $\nabla_\mathbf{w} L = [\partial L/\partial w_1, \dots]$; è $0$ al minimo (e ai saddle point).
- Con la exp loss l'update è $w_j = w_j + \eta\, y_i x_{ij}\exp(-y_i(\mathbf{w}\cdot\mathbf{x}_i+b))$ → **stessa forma del Perceptron** (modulo learning rate). Differenza: GD aggiorna **sempre**, il perceptron **solo sugli errori**.
- **Problemi:** minimi locali (non-convesso), **saddle points** (gradiente 0 senza minimo, comuni in alta dim), e **learning rate** troppo grande/piccolo → diverge / converge lentamente.
