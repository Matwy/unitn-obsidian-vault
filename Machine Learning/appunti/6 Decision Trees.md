---
date: 2026/06/11
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec6 - Decision_Trees.pdf]]"
---
## 6 Decision Trees

> [!abstract] Idea di fondo
> Un **Decision Tree** fa previsioni **splittando ricorsivamente** sugli attributi seguendo una struttura ad albero: a ogni nodo si pone una "domanda" su una feature e si segue il ramo corrispondente fino a una foglia, che dà la predizione. È semplice, **intuitivo** e **interpretabile** (simile a come ragiona un umano). Il "learning" sta nel decidere **quale attributo** e **quale valore** usare per ogni split.

# 1. Cos'è un Decision Tree
- Predice **splittando ricorsivamente** sugli attributi secondo una struttura ad albero.
- Esempio guida: classificare un frutto come **arancia o limone** usando le feature **width (larghezza)** e **height (altezza)**.
- Si parte dalla radice, si risponde alle domande nei nodi e si scende fino a una **foglia** → la foglia è la predizione.

## Attributi continui → soglie
- Per attributi **continui**, lo split è del tipo **"minore o maggiore di una soglia"** (es. `width > 6.5 cm`).
- Di conseguenza lo spazio di input è diviso in **regioni con bordi paralleli agli assi** (split "rettangolari", una feature alla volta).

## La parte di "learning"
Dato un training set, l'albero deve **imparare**:
1. **quale attributo** usare per lo split (es. width);
2. **quale valore/soglia** di quell'attributo usare (es. `width > 6.5 cm`).

# 2. Struttura dell'albero (input discreti)
Gli attributi possono anche essere **discreti** (esempio classico: decidere se aspettare o no al ristorante → output T/F).

> [!note] Anatomia di un albero
> - **Nodi interni** → testano un **attributo**.
> - **Rami (branching)** → determinati dal **valore** dell'attributo.
> - **Nodi foglia** → sono gli **output / predizioni**.

# 3. Classification tree vs Regression tree
Ogni **percorso radice → foglia** definisce una **regione $R_m$** dello spazio di input. Gli esempi di training che cadono in $R_m$ sono i $k$ esempi:
$$\{(\mathbf{x}^{(m_1)}, t^{(m_1)}),\ \dots,\ (\mathbf{x}^{(m_k)}, t^{(m_k)})\}$$
dove $t^{(m_i)}$ è la **label vera** dell'esempio $m_i$. Il valore $y^m$ assegnato alla foglia dipende dal tipo di albero.

## Classification tree
- **Output discreto**: $y \in \{1, \dots, C\}$ (una tra $C$ classi).
- Valore della foglia = **classe più comune** nella regione (**majority vote**):
$$y^m \leftarrow \operatorname*{arg\,max}_{t\in\{1,\dots,C\}} \sum_{m_i} \mathbb{1}\{t = t^{(m_i)}\}$$
> [!note] Come leggere la formula
> $\mathbb{1}\{t = t^{(m_i)}\}$ è la **funzione indicatrice**: vale **1** se l'esempio $m_i$ ha label $t$, **0** altrimenti. La sommatoria **conta** quanti esempi della regione appartengono alla classe $t$; l'$\arg\max$ sceglie la classe **più frequente**. → È esattamente il **voto di maggioranza**.

## Regression tree
- **Output continuo**: $y \in \mathbb{R}$.
- Valore della foglia = **media** dei valori target nella regione:
$$y^m = \frac{1}{k}\sum_{i=1}^{k} t^{(m_i)}$$
> [!note] Intuizione
> In regressione non c'è una "classe di maggioranza": la previsione migliore costante per una regione (che minimizza l'errore quadratico) è la **media** dei target che ci cadono dentro.

> [!note] Focus del corso
> Ci concentriamo sulla **classificazione**.

# 4. Come si impara un Decision Tree?
Vogliamo un albero **"semplice"** che spieghi bene i dati. Desiderata:
- **Piccolo / semplice**: numero **minimo** di nodi.
- **Abbastanza campioni per regione**: ogni foglia deve avere abbastanza esempi per essere affidabile.

> [!warning] È un problema NP-completo
> Trovare l'albero **più piccolo** che classifica correttamente il training set è **NP-completo** → non esistono soluzioni efficienti.

## Euristica greedy
Si ricorre a un'euristica **greedy**:
- Parti da albero **vuoto** + training set completo.
- **Splitta** (partiziona) sul **"miglior" attributo**.
- **Ricorri** sulle sotto-partizioni.

Restano due domande: **quando fermarsi?** e **qual è l'attributo "migliore"?**

> [!important] Notion of Gain
> Definiamo un **guadagno (gain)** di uno split = variazione di un certo **criterio** prima/dopo lo split. Si sceglie lo split con il gain migliore. Esistono **diverse nozioni di gain** (accuracy gain, information gain, Gini).

# 5. Primo tentativo: Accuracy Gain
Usiamo come criterio l'**accuratezza**, cioè l'**errore di misclassificazione** $L$ (numero di classificazioni sbagliate).

- Regione $R$ con errore $L(R)$.
- La splittiamo in $R_1$ e $R_2$ su qualche attributo.
- **Errore dopo lo split** (media pesata sui due figli):
$$\frac{|R_1|}{|R|}L(R_1) + \frac{|R_2|}{|R|}L(R_2)$$
dove $\frac{|R_i|}{|R|}$ è la **frazione di campioni** nell'$i$-esimo split.

- **Accuracy gain**:
$$L(R) - \frac{|R_1|L(R_1) + |R_2|L(R_2)}{|R|}$$

Split diversi → accuracy gain diverso. Si sceglierebbe quello con gain più alto.

## Perché l'accuratezza NON basta
> [!warning] Esempio: accuracy gain = 0 ma lo split è utile!
> Split `width > 6.5 cm` su 100 limoni + 49 arance:
> - **YES** → 50 limoni, 0 arance (**foglia pura!**)
> - **NO** → 50 limoni, 49 arance
> $$L(R) - \frac{|R_1|L(R_1)+|R_2|L(R_2)}{|R|} = \frac{49}{149} - \frac{50\times 0 + 99\times \frac{49}{99}}{149} = 0$$
> Abbiamo **ridotto l'incertezza** (un ramo è diventato puro!), ma l'**accuracy gain è zero**. L'accuratezza non "vede" che abbiamo isolato un gruppo puro → serve un criterio migliore: l'**incertezza**.

# 6. Misurare l'incertezza: Teoria dell'Informazione
Idea: usare come criterio la **riduzione di incertezza** di una foglia.
- Tutti gli esempi della foglia nella **stessa classe** → **bassa incertezza** (buono).
- Ogni classe ugualmente rappresentata → **alta incertezza** (cattivo).

## Entropia
> [!important] Entropia
> L'**entropia** misura la **"sorpresa" attesa**: quanto siamo incerti sul valore estratto da una distribuzione.
> $$H(X) = -\mathbb{E}_{X\sim p}[\log_2 p(X)] = -\sum_{x\in X} p(x)\,\log_2 p(x)$$
> - **Unità di misura: bit**.
> - Una **moneta equa** (50/50) ha **1 bit** di entropia (massima incertezza per 2 esiti).

**Esempi di calcolo:**
- Distribuzione $\{8/9,\ 1/9\}$: $\ -(\tfrac{8}{9}\log_2\tfrac{8}{9} + \tfrac{1}{9}\log_2\tfrac{1}{9}) \approx 0.5$ → poco incerta.
- Distribuzione $\{4/9,\ 5/9\}$: $\ -(\tfrac{4}{9}\log_2\tfrac{4}{9} + \tfrac{5}{9}\log_2\tfrac{5}{9}) \approx 0.99$ → quasi massima incertezza.

> [!note] Alta vs Bassa entropia
> - **Alta entropia**: distribuzione **uniforme**, istogramma piatto → valori **poco prevedibili**.
> - **Bassa entropia**: distribuzione con **picchi e valli** → valori **più prevedibili**.

# 7. Information Gain
> [!important] Information Gain
> Misura la **riduzione attesa di entropia** dopo uno split:
> $$IG = H(R) - \left\{\frac{|R_1|}{|R|}H(R_1) + \frac{|R_2|}{|R|}H(R_2)\right\}$$
> dove $H(R)$ è l'entropia del **nodo padre** e $H(R_1), H(R_2)$ quelle dei **figli**.
> Si sceglie **l'attributo + valore con l'information gain più alto**.

## Esempio numerico — Split 1 vs Split 2
Radice: **100 limoni + 49 arance** (totale 149). Entropia della radice:
$$H(\text{root}) = -\left(\tfrac{100}{149}\log_2\tfrac{100}{149} + \tfrac{49}{149}\log_2\tfrac{49}{149}\right) \approx 0.910$$

**🟢 Split 1 — `width > 6.5 cm`:**
- Sinistra: 50 limoni, 0 arance → $H(\text{left}) = 0$ (**pura**).
- Destra: 50 limoni, 49 arance → $H(\text{right}) = -(\tfrac{50}{99}\log_2\tfrac{50}{99} + \tfrac{49}{99}\log_2\tfrac{49}{99}) \approx 1$.
- Pesi: $\tfrac{|R_1|}{|R|} = \tfrac{50}{149}$, $\tfrac{|R_2|}{|R|} = \tfrac{99}{149}$.
$$IG = 0.910 - \left(\tfrac{50}{149}\times 0 + \tfrac{99}{149}\times 1\right) = \mathbf{0.24}$$

**🔴 Split 2 — `height > 9.5 cm`:**
- Sinistra: 30 limoni, 30 arance → $H(\text{left}) = 1$ (massima incertezza).
- Destra: 70 limoni, 19 arance → $H(\text{right}) = -(\tfrac{70}{89}\log_2\tfrac{70}{89} + \tfrac{19}{89}\log_2\tfrac{19}{89}) \approx 0.748$.
- Pesi: $\tfrac{60}{149}$ e $\tfrac{89}{149}$.
$$IG = 0.910 - \left(\tfrac{60}{149}\times 1 + \tfrac{89}{149}\times 0.748\right) = \mathbf{0.001}$$

> [!success] Conclusione
> $IG_{\text{split1}} = 0.24 \gg IG_{\text{split2}} = 0.001$ → lo **Split 1 è migliore** (riduce di più l'incertezza). Nota: questo è proprio lo split che l'accuracy gain aveva valutato 0!

# 8. GINI Index
> [!important] GINI Index
> Altra metrica molto usata. Misura l'**impurità** (non-omogeneità) di un nodo $R$:
> $$\text{GINI}(R) = 1 - \sum_{j} p(j\mid R)^2$$
> dove $p(j\mid R)$ è la **frequenza della classe $j$** nel nodo $R$.

- Intuizione: probabilità di **classificare male** un elemento scelto a caso.
- **GINI alto** → più probabilità di errore (più impuro). **Gini basso** → nodo più puro.
- Per uno split, si calcola il Gini **medio pesato** dei figli e si **favoriscono gli split con Gini più basso**.

## Esempio numerico — Gini
**🟢 Split 1 (`width > 6.5`):**
- Left (50 limoni, 0 arance): $\text{Gini} = 1 - [(\tfrac{50}{50})^2 + (\tfrac{0}{50})^2] = 0$.
- Right (50 limoni, 49 arance): $\text{Gini} = 1 - [(\tfrac{50}{99})^2 + (\tfrac{49}{99})^2] \approx 0.5$.
- Split: $\tfrac{50}{149}\times 0 + \tfrac{99}{149}\times 0.5 = \mathbf{0.332}$.

**🔴 Split 2 (`height > 9.5`):**
- Left (30 limoni, 30 arance): $\text{Gini} = 1 - [(\tfrac{30}{60})^2 + (\tfrac{30}{60})^2] = 0.5$.
- Right (70 limoni, 19 arance): $\text{Gini} = 1 - [(\tfrac{70}{89})^2 + (\tfrac{19}{89})^2] \approx 0.335$.
- Split: $\tfrac{60}{149}\times 0.5 + \tfrac{89}{149}\times 0.335 = \mathbf{0.401}$.

> [!success] Conclusione
> $\text{Gini}_{\text{split1}} = 0.332 < \text{Gini}_{\text{split2}} = 0.401$ → si **preferisce lo Split 1** (impurità più bassa). Gini e Information Gain qui **concordano**.

# 9. Costruzione dell'albero
A ogni livello bisogna scegliere **quale attributo** e **quale valore** splittare, prendendo quello che dà:
- **accuracy gain più alto**, **OPPURE**
- **information gain più alto**, **OPPURE**
- **Gini index più basso**.

## Algoritmo
```
Start: albero vuoto + training set completo
  - Split sull'attributo più informativo
  - Ricorri sulle sotto-partizioni
Condizione di stop (possibile):
  fermati se tutti gli esempi nella sotto-partizione
  hanno la STESSA classe (foglia pura)
```

# 10. Cosa rende un albero "buono"?
> [!important] Trade-off dimensione (Occam's Razor)
> - **Non troppo piccolo**: deve cogliere distinzioni importanti (anche sottili) nei dati.
> - **Non troppo grande**:
> 	- evitare **overfitting**;
> 	- servono **abbastanza campioni per regione** per decidere l'output con sicurezza;
> 	- **efficienza** computazionale (evitare attributi ridondanti/spuri);
> 	- **interpretabilità** umana.
>
> **Rasoio di Occam**: a parità di tutto il resto, preferisci il modello **più semplice**. → Vogliamo **alberi piccoli con i nodi informativi vicino alla radice**.

## Problemi / limiti strutturali
- Ai livelli **bassi** hai **esponenzialmente meno dati**.
- Un albero grande **overfitta**.
- I DT **non raggiungono necessariamente il minimo globale** (euristica greedy).
- Gli **errori ai livelli alti si propagano** verso il basso.
- Possono fare anche **regressione**: si scelgono gli split per **minimizzare l'errore quadratico** invece di massimizzare l'information gain.

# 11. Decision Trees e Overfitting
- La struttura dell'albero è **determinata dai dati** → molto **flessibile**, fitta facilmente il training set → **alto rischio di overfitting**.
- Tecniche standard di generalizzazione si applicano anche qui (**data augmentation**, **ensembling**).
- **Pruning** (potatura): tecnica **a posteriori** per ridurre la complessità → si **sostituisce un intero sottoalbero con una foglia**.

# 12. Confronto con k-NN
> [!note] Vantaggi dei DT rispetto a [[4 KNN|k-NN]]
> - Buoni con attributi **discreti**.
> - Gestiscono facilmente i **valori mancanti** (basta trattarli come un altro valore).
> - **Robusti alla scala** degli input (niente standardizzazione necessaria).
> - Ottimi quando ci sono **tanti attributi ma pochi importanti**.
> - **Veloci in fase di test/inferenza** (k-NN invece è lento, lazy).
> - Più **interpretabili**.

## Riepilogo DT
| Punti di forza | Debolezze |
|---|---|
| Veloce e semplice da implementare | Split **univariato** (una feature alla volta) |
| Convertibile in **regole** | Richiede vettori di feature a **lunghezza fissa** |
| Interpretabile | **Non incrementale** (metodo batch) |

# 13. Verso le Random Forest: Bootstrapping
> [!info] Vedi anche
> Bagging e Random Forest sono casi particolari di **[[Ensemble Learning]]** (insieme a boosting e stacking).

> [!important] Problema dei DT: alta varianza
> I DT sono stimatori ad **alta varianza**: piccole variazioni nei dati → alberi molto diversi (come stimare l'altezza media di una scuola da **un solo** campione: poco affidabile per la variabilità di campionamento).

**Bootstrapping**: tecnica di **resampling** che estrae ripetutamente campioni dal dataset **con reinserimento (with replacement)**. Crea **più dataset** che introducono variabilità → aiuta a ridurre l'overfitting.

## Bagging (Bootstrap Aggregating)
- Si allenano **più alberi** su **bootstrap sample diversi**.
- Si combinano gli output: **media** (regressione) o **majority voting** (classificazione).
- **Riduce la varianza** e migliora la **stabilità** del modello.

## Feature Randomness (Random Forest)
- Oltre al bootstrapping, le **Random Forest** aggiungono **casualità sulle feature**: ogni albero usa un **sottoinsieme casuale di feature**.
- Questo **decorrela** gli alberi → migliora l'accuratezza media.
- Evita che **feature molto predittive** producano **split simili** in tutti gli alberi (alberi troppo correlati).

> [!note] Random Forest — vantaggi
> - Riduce l'**overfitting** rispetto al singolo albero.
> - Funziona bene su **dataset grandi e ad alta dimensionalità**.
> - **Robusta** a valori mancanti e rumore.

> [!example] Applicazione reale: Kinect (Xbox)
> Le Random Forest sono usate nel **Kinect** per la **stima della posa umana in tempo reale** (Shotton et al.).

# Da padroneggiare
1. Come predice un DT: **split ricorsivi**, nodi interni = test, foglie = output; per attributi continui split a **soglia** → regioni con bordi **paralleli agli assi**.
2. Classification tree (**majority vote**) vs Regression tree (**media**).
3. Learning = euristica **greedy** (NP-completo trovare l'albero minimo); scelta del **best split** tramite un **gain**.
4. **Accuracy gain** e perché **non basta** (esempio con gain = 0 su uno split utile).
5. **Entropia** $H = -\sum p\log_2 p$ (bit; moneta equa = 1 bit) e **Information Gain** $= H(R) - \sum \frac{|R_i|}{|R|}H(R_i)$.
6. **Gini index** $= 1 - \sum p_j^2$; saper calcolare IG e Gini su un esempio e scegliere lo split (più IG / meno Gini).
7. **Occam's razor**, trade-off dimensione e **overfitting** → **pruning**.
8. Confronto con **k-NN** e limiti dei DT (univariato, batch, alta varianza).
9. **Bootstrapping → Bagging → Random Forest** (feature randomness, decorrelazione, riduzione varianza).
