---
date: 2025/10/26
tags:
Materia: "[[Logica Computazionale]]"
---
## 10 LoE

-  come ragionare logicamente sulle entità del mondo, partendo dai modelli formali che le rappresentano.

---

## Posizione nella piramide logica

Richiamo sintetico della *Knowledge & Logics Pyramid*:

```
Reasoning Logics     → proposizioni e deduzioni astratte
World Logics         → ragionamento sul mondo
World Models         → rappresentazioni strutturate del mondo
Models               → percezioni organizzate
```

La **LoE (Logic of Entities)** è il **primo strato concreto** delle *World Logics*:
usa i **World Models** per fare inferenze **sulle entità** e le loro relazioni nel mondo.

---

## Contesto: da modelli a logiche

Ricordiamo:

* Un **World Model** rappresenta il mondo (entità, tipi, relazioni).
* Una **World Logic** serve per dedurre cosa è vero in quel mondo.
* La **LoE** è la logica specifica che opera *al livello delle entità*.

Formalmente:

$$
L_W = ⟨W, ⊨_W⟩
$$

e la LoE è una sua istanza dove:

* **W** è il *World Model delle entità*
* **⊨_W** è l’operatore di *world entailment* su entità e proprietà

---

## Definizione di “World Logic” (ripresa generale)

Una **World Logic** è:

> una rappresentazione del mondo che consente di dedurre nuove verità a partire da ciò che è noto.

Formalmente:

$$
L_W = ⟨W, ⊨W⟩
$$

dove:

* W = ⟨Lₐ, D, Iₐ⟩ è un World Model;
* ⊨W è la relazione di entailment definita per quel modello.

---

## World Entailment (⊨ₗₐ) e logica del mondo

L’entailment è ciò che consente di *ragionare* sul modello.

> Esempio (LoE):
> Se “Duomo è una Chiesa” e “ogni Chiesa è un Edificio che ha un Campanile”,
> allora possiamo dedurre:
>
```
Building(Duomo)
hasBellTower(Duomo)
```

👉 È così che la **LoE** trasforma conoscenza implicita in conoscenza esplicita.

---

## Cosa distingue la LoE dalle altre logiche

| Logica                          | Dominio di applicazione             | Oggetto del ragionamento                     |
| ------------------------------- | ----------------------------------- | -------------------------------------------- |
| **LoE (Logic of Entities)**     | entità e loro proprietà             | “Duomo è una Chiesa”, “Trento è una Città”   |
| **LoD (Logic of Descriptions)** | descrizioni e concetti              | “Ogni Chiesa è un Edificio con un campanile” |
| **LoT (Logic of Theories)**     | teorie generali e meta-ragionamento | “Questa teoria è consistente e completa”     |

👉 La **LoE** è il livello più “concreto” delle tre: lavora su oggetti e fatti osservabili.

---

## World Entailment in pratica

### Definizione formale

Sia

```
W = ⟨Lₐ, D, Iₐ⟩
```

un *World Model*;
allora la relazione di entailment è:

```
⊨ₗₐ ⊆ D × Lₐ
```

e si dice che:

```
M ⊨ₗₐ Tₐ
```

se M è modello della teoria Tₐ, cioè se le assertions di Tₐ sono vere in M.

---

## Esempio LoE completo

### Linguaggio LoE:

```
Church(Duomo)
Church ⊑ Building ⊓ hasBellTower
```

### Inferenza tramite LoE:

```
⊨ Building(Duomo)
⊨ hasBellTower(Duomo)
```

👉 La LoE permette quindi di dedurre proprietà **a partire dai tipi** (Etypes) e dalle relazioni tra essi.

---

## 8. World Entailment vs Logical Entailment

| Tipo di entailment             | Significato                                                 | Esempio                                                                          |
| ------------------------------ | ----------------------------------------------------------- | -------------------------------------------------------------------------------- |
| **World Entailment (M ⊨ T)**   | verifica se una teoria è vera in un modello                 | il mondo soddisfa le assertions note                                             |
| **Logical Entailment (T ⊨ a)** | verifica se un’assertion è conseguenza logica di una teoria | “Se Duomo è una Chiesa e ogni Chiesa è un Edificio → allora Duomo è un Edificio” |

👉 In sintesi:

* *World entailment* valuta la verità nel mondo;
* *Logical entailment* valuta la coerenza logica della teoria.

---

## Proprietà delle World Logics (e quindi della LoE)

| Proprietà          | Descrizione                                                         |
| ------------------ | ------------------------------------------------------------------- |
| **Many-to-many**   | una teoria può avere più modelli e viceversa                        |
| **Parzialità**     | i modelli non descrivono mai tutto il mondo                         |
| **Derivazione**    | nuove assertions possono essere derivate tramite regole logiche     |
| **Non-simmetria**  | da A ⇒ B non segue B ⇒ A                                            |
| **Completabilità** | una teoria può essere resa completa aggiungendo assertions mancanti |

---

## Verità, falsità e incertezza nella LoE

In LoE una assertion può essere:

* **True** → se è soddisfatta nel modello;
* **False** → se è contraddetta dal modello;
* **IDK** (*I don’t know*) → se il modello non contiene abbastanza informazione.

Esempio:

```
Church(Duomo)     → True
Building(Duomo)   → True (dedotto)
hasBellTower(Duomo) → True (dedotto)
Museum(Duomo)     → IDK (non specificato)
```

---

## World Logic come sistema di Q/A (Question Answering)

La LoE consente di rispondere a domande del tipo:

> “È vero che il Duomo è un edificio?”
> “È vero che Piazza Duomo è in Trento?”
> “Ci sono entità che non appartengono a nessun tipo?”

Ogni risposta deriva dall’entailment del modello:

```
M ⊨ a  →  True
¬(M ⊨ a)  →  False
¬(M ⊨ a) ∧ ¬(M ⊨ ¬a) → IDK
```

👉 In pratica, la LoE è la logica che implementa la base del “reasoning engine”.

---

## Canonical World Logic

Un **canonical world logic** è una world logic costruita su un **modello canonico** —
cioè un modello in cui la teoria è **massimale** e **completa**.
In quel caso:

* il modello rappresenta tutto ciò che è vero nel mondo;
* ogni assertion vera o falsa è decidibile tramite entailment.

Quando la teoria è incompleta, la LoE opera con conoscenza parziale e può rispondere solo *True / IDK*.

---

## 13. Concetti chiave

| Termine                     | Significato                                                   |
| --------------------------- | ------------------------------------------------------------- |
| **LoE (Logic of Entities)** | logica del mondo che ragiona su entità e relazioni            |
| **World Entailment (⊨)**    | relazione tra modello e teoria                                |
| **Logical Entailment**      | deduzione logica tra teoria e assertions                      |
| **World Logic (L_W)**       | modello + operatore di entailment                             |
| **Canonical Model**         | modello completo e massimale                                  |
| **True / False / IDK**      | stati di verità di un’assertion                               |
| **Question Answering**      | verifica di assertions tramite LoE                            |
| **Many-to-many entailment** | più modelli per la stessa teoria                              |
| **Partiality**              | incompletezza dei modelli reali                               |
| **Entailment rules**        | regole di deduzione sulle entità (es. transitività di “isIn”) |

---

## In sintesi
-[[2025-10-17.bis T2MP - LoE.pdf]]

La **Logic of Entities (LoE)** è la prima logica “operativa” del corso:

* prende i **World Models** come base,
* applica regole di **entailment** per dedurre nuovi fatti,
* gestisce **verità, falsità e incertezza**,
* permette il **ragionamento automatico** su entità e proprietà.

👉 Nei moduli successivi (*LoD* e *LoT*) vedrai come queste logiche si estendono:

* **LoD (Logic of Descriptions)**: ragiona sui concetti e le descrizioni generali (non sulle singole entità);
* **LoT (Logic of Theories)**: ragiona sulle teorie stesse (meta-logica).

