---
date: 2026/05/25
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec5-Perceptron.pdf]]"
---
## 5 Perceptron

> [!abstract] Idea di fondo
> I **modelli lineari** assumono che le classi siano separabili da una **retta / iperpiano**. Il **Perceptron** è l'algoritmo che impara quell'iperpiano, **online** (un esempio alla volta), correggendo i pesi ogni volta che sbaglia.

# 1. Assunzioni dei modelli e Bias
- Alcuni modelli fanno **assunzioni forti** sui dati:
	- se le assunzioni sono **vere** → performance migliori, servono **meno** esempi.
	- se sono **false** → il modello fallisce miseramente.
- Modelli con **poche assunzioni** → imparano da dati più vari, ma più soggetti a **overfitting** e richiedono **più** dati.

> [!important] Bias di un modello
> Il **bias** è quanto forti sono le assunzioni del modello.
> - **Low-bias** (poche assunzioni): k-NN, decision trees → possono imparare separazioni arbitrarie.
> - **High-bias** (assunzioni forti): **modelli lineari** → assumono la **separabilità lineare**.

# 2. Modelli lineari

## Cos'è un modello lineare
Assume che i dati siano **linearmente separabili**:
- in 2D → una **retta**;
- in 3D → un **piano**;
- in $n$ dimensioni → un **iperpiano**.

Un modello lineare in spazio $n$-dimensionale (n feature) è definito da **n+1 pesi**: i pesi $w_1, \dots, w_n$ + il **bias/intercetta** $b$.
$$f(x) = w_1 x_1 + w_2 x_2 + \dots + w_n x_n + b = \mathbf{w}\cdot\mathbf{x} + b$$

## Geometria
- Il vettore dei pesi $\mathbf{w}=(w_1,w_2)$ definisce una retta **perpendicolare a $\mathbf{w}$** passante per l'origine.
- Il termine **$b$ sposta la retta dall'origine** (senza $b$ la retta passa sempre per (0,0)).

## Classificazione: il segno
Si classifica controllando il **segno** di $\mathbf{w}\cdot\mathbf{x} + b$:
$$\hat{y} = \text{sign}(\mathbf{w}\cdot\mathbf{x} + b)$$
- segno **positivo** → un lato della retta (classe +);
- segno **negativo** → l'altro lato (classe −).
Il segno indica **da che parte** dell'iperpiano cade il punto.

# 3. Online Learning (il setting del Perceptron)

> [!note] Online vs Batch
> - **Batch**: tutti i dati $\{(x_i,y_i)\}$ disponibili insieme (tipicamente i.i.d.).
> - **Online**: i dati arrivano **uno alla volta**:
> 	1. l'algoritmo riceve un esempio **non etichettato** $x_i$;
> 	2. **predice** la classe;
> 	3. gli viene rivelata la risposta corretta $y_i$ e **aggiorna** il modello.

**Quando serve l'online learning:** data stream, dataset su larga scala, applicazioni privacy-preserving.

# 4. L'intuizione dell'aggiornamento
Quando il modello sbaglia su un esempio positivo $(-1,1)$ il cui score "dovrebbe" essere positivo:
- una componente ha **contribuito nella direzione sbagliata** → bisogna **correggerla**;
- una feature positiva con peso 0 **poteva contribuire ma non lo ha fatto** → bisogna **aumentarne** il peso.

→ Si **spostano i pesi** nella direzione che rende corretta la predizione di quell'esempio.

# 5. Algoritmo del Perceptron
Con **label ∈ {−1, +1}**:

```
repeat until convergence (or for some # of iterations):
   for each training example (f1, ..., fn, label):
      check if it is correct based on the current model
      if prediction != label:          # se sbaglia
         for each wi:
            wi = wi + fi * label
         b  = b + label
```

- **Aggiorna SOLO quando sbaglia** (mistake-driven).
- L'update $w_i \mathrel{+}= f_i \cdot \text{label}$ spinge l'iperpiano verso la classificazione corretta dell'esempio.

# 6. Proprietà e garanzie

## Convergenza
- Se i dati sono **linearmente separabili** → il perceptron **converge** (trova un iperpiano separatore in un numero finito di passi).
- Se i dati **NON** sono linearmente separabili → **non converge mai** (continua a oscillare).

> [!warning] Quale retta trova?
> È garantito solo che trova **una** retta che separa i dati, **non la migliore**. (Esistono infinite rette separatrici; il perceptron ne trova una qualsiasi — questo motiverà le SVM più avanti, che cercano il margine massimo.)

## Linear separability
Le istanze sono **linearmente separabili** se esiste un iperpiano che separa le due classi.

## Numero di iterazioni
Limitare il numero di iterazioni serve a **limitare l'overfitting**.

## Ordine degli esempi
L'ordine in cui si presentano gli esempi **conta** (influenza la soluzione). Variante: **campionare casualmente** un esempio a ogni passo invece di scorrerli in ordine fisso.

# Da padroneggiare
1. Cos'è il **bias** di un modello (low vs high) e perché i modelli lineari sono high-bias.
2. Forma di un modello lineare ($\mathbf{w}\cdot\mathbf{x}+b$), ruolo di $\mathbf{w}$ (direzione) e di $b$ (offset), classificazione tramite **segno**.
3. Differenza **online vs batch** e quando serve l'online.
4. La **regola di update** del perceptron ($w_i \mathrel{+}= f_i \cdot y$, $b \mathrel{+}= y$) e che aggiorna solo sugli errori.
5. **Convergenza**: garantita ⇔ dati linearmente separabili; trova *una* retta, non la ottima.
6. Effetto del numero di iterazioni (overfitting) e dell'ordine degli esempi.
