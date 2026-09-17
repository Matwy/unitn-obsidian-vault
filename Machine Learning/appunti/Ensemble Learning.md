---
date: 2026/06/15
tags:
Materia: "[[Machine Learning]]"
---
## Ensemble Learning

> [!abstract] Idea di fondo
> L'**ensemble learning** combina **più modelli** (*weak learner* / *base learner*) per costruire un unico modello finale (*strong learner*) che predice **meglio** di ciascun modello singolo. È la "**saggezza della folla**": molti modelli mediocri ma **diversi** tra loro commettono errori **poco correlati**, che si **compensano** quando le predizioni vengono aggregate.

# 1. Perché funziona: bias e varianza
L'errore atteso di un modello si scompone in tre termini:
$$\text{Errore} = \underbrace{\text{Bias}^2}_{\text{errore sistematico}} + \underbrace{\text{Varianza}}_{\text{sensibilità ai dati}} + \underbrace{\sigma^2}_{\text{rumore irriducibile}}$$

L'ensemble agisce su questa scomposizione:
- **Bagging** → riduce soprattutto la **varianza** (modelli ad alta varianza, es. [[6 Decision Trees|Decision Tree]] profondi).
- **Boosting** → riduce soprattutto il **bias** (modelli deboli, es. alberi poco profondi / *stumps*).

## Condizioni perché un ensemble migliori
1. I modelli base devono essere **migliori del caso** (accuratezza $> 0.5$ nella classificazione binaria).
2. I modelli devono essere **sufficientemente diversi / decorrelati** (altrimenti sbagliano tutti allo stesso modo e combinarli non porta vantaggio).

> [!example] Intuizione del voto di maggioranza
> Con $M$ classificatori **indipendenti**, ognuno con errore $\epsilon < 0.5$, la probabilità che la **maggioranza** sbagli è:
> $$P(\text{errore}) = \sum_{k > M/2} \binom{M}{k}\,\epsilon^{k}(1-\epsilon)^{M-k}$$
> che **tende a 0** al crescere di $M$. Il guadagno svanisce se i modelli sono correlati.

# 2. Come si aggregano le predizioni
- **Classificazione**
	- *Hard voting* → **voto di maggioranza** sulle classi predette.
	- *Soft voting* → **media delle probabilità** $\hat{p}_c = \frac{1}{M}\sum_{m=1}^{M} p_c^{(m)}$, poi $\arg\max_c \hat{p}_c$.
- **Regressione** → **media** (eventualmente pesata): $\hat{y} = \frac{1}{M}\sum_{m=1}^{M} y^{(m)}$.

# 3. Bagging (Bootstrap Aggregating)
- Si allenano **$M$ modelli in parallelo**, ognuno su un **bootstrap sample** diverso (resampling **con reinserimento**).
- Si **combinano** gli output: media (regressione) o majority voting (classificazione).
- **Riduce la varianza** e migliora la **stabilità**; non aumenta il bias.

> [!note] Random Forest
> È un bagging di [[6 Decision Trees|Decision Tree]] + **feature randomness**: ogni split considera solo un **sottoinsieme casuale di feature**. Questo **decorrela** gli alberi (evita che feature molto predittive producano split simili ovunque) → ensemble più efficace. *(Dettagli in [[6 Decision Trees]].)*

# 4. Boosting
Modelli addestrati **in sequenza**: ogni nuovo modello si concentra sugli **errori** del precedente. Riduce il **bias**, costruendo uno strong learner da tanti weak learner.

## AdaBoost (Adaptive Boosting)
Mantiene un **peso** $w_i$ per ogni esempio (inizialmente $w_i = 1/N$). A ogni round $m$:
1. Allena un weak learner $h_m$ minimizzando l'errore pesato.
2. Calcola l'errore pesato:
$$\epsilon_m = \frac{\sum_{i} w_i \,\mathbb{1}[h_m(\mathbf{x}_i) \neq t_i]}{\sum_{i} w_i}$$
3. Calcola il peso del modello:
$$\alpha_m = \frac{1}{2}\ln\!\left(\frac{1-\epsilon_m}{\epsilon_m}\right)$$
4. Aggiorna i pesi degli esempi (↑ a quelli **sbagliati**, ↓ a quelli giusti) e rinormalizza:
$$w_i \leftarrow w_i \, e^{\,\alpha_m\, \mathbb{1}[h_m(\mathbf{x}_i)\neq t_i]}$$

Predizione finale (somma pesata dei voti):
$$H(\mathbf{x}) = \text{sign}\!\left(\sum_{m=1}^{M} \alpha_m\, h_m(\mathbf{x})\right)$$

## Gradient Boosting
Generalizza il boosting come **discesa del gradiente nello spazio delle funzioni**: ogni nuovo modello viene addestrato a predire i **residui** (il gradiente negativo della loss) del modello corrente.
$$F_m(\mathbf{x}) = F_{m-1}(\mathbf{x}) + \nu\, h_m(\mathbf{x})$$
dove $\nu$ è il **learning rate**. Implementazioni note: **XGBoost**, **LightGBM**, **CatBoost**.

# 5. Stacking (Stacked Generalization)
- Si addestrano **modelli base eterogenei** (es. SVM + k-NN + albero).
- Un **meta-modello** impara a **combinare** le loro predizioni (usate come nuove feature), invece di una semplice media/voto.
- Sfrutta i punti di forza di modelli **diversi tra loro**.

# 6. Confronto

| Metodo | Addestramento | Modelli base | Effetto principale | Esempio |
|---|---|---|---|---|
| **Bagging** | parallelo | uguali, alta varianza | ↓ **varianza** | Random Forest |
| **Boosting** | sequenziale | deboli, alto bias | ↓ **bias** | AdaBoost, XGBoost |
| **Stacking** | a livelli | eterogenei | combina punti di forza | — |
| **Voting** | parallelo | qualsiasi | combinazione semplice | — |

# 7. Pro e contro
> [!note] Vantaggi
> - Maggiore **accuratezza** e **robustezza** rispetto al singolo modello.
> - Bagging ↓ overfitting; boosting ↓ underfitting.

> [!warning] Svantaggi
> - **Costo computazionale** e di memoria più alti (molti modelli).
> - **Minore interpretabilità** (modello "scatola nera").
> - Il boosting può **overfittare** il rumore se non regolarizzato (troppi round, $\nu$ alto).

# Da padroneggiare
1. Definizione: weak learner → strong learner; perché serve la **diversità** tra modelli.
2. Scomposizione **bias-varianza** e quale termine riduce **bagging** vs **boosting**.
3. **Bagging** (bootstrap + aggregazione) e legame con le **Random Forest** (feature randomness, decorrelazione).
4. **Boosting** sequenziale; **AdaBoost**: formule di $\epsilon_m$, $\alpha_m$, update dei pesi, predizione finale $H(\mathbf{x})$.
5. **Gradient Boosting** come fit dei residui; ruolo del learning rate $\nu$.
6. **Stacking** vs **voting**; *hard* vs *soft voting*.
7. Pro/contro: accuratezza vs costo e **interpretabilità**.
