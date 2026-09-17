---
date: 2025/10/26
tags:
Materia: "[[Logica Computazionale]]"
---
## 9 World logics
- Collegare i modelli del mondo (World Models), con i meccanismi di inferenza e deduzione (World Entailment)
## Dove si colloca nella piramide

Richiamo dalla *Logics Pyramid*:

```
Reasoning Logics     → deduzione astratta
World Logics         → ragionamento sui modelli del mondo
World Models         → rappresentazioni formali del mondo
Models               → percezioni organizzate
```

👉 **World Logics** = il livello che **usa i World Models per fare inferenze**.
Serve per capire se una certa affermazione è **vera, falsa o sconosciuta** nel mondo rappresentato.

---

## Che cos’è una World Logic

Una **World Logic** è una coppia:

$$
L_W = ⟨W, ⊨_W⟩
$$

dove:

* **W** è il *World Model* di riferimento (cioè ⟨Lₐ, D, Iₐ⟩);
* **⊨_W** è la relazione di **entailment del mondo** (*world entailment*), che stabilisce se un’assertion è conseguenza del modello.

👉 In altre parole:

> Una *world logic* è “un mondo + le regole per dedurre verità da quel mondo”.

---

## World Entailment (⊨ₗₐ)

### Definizione:

Sia

```
W = ⟨Lₐ, D, Iₐ⟩
```

un world model,
allora l’**entailment del mondo** è una relazione:

```
⊨ₗₐ ⊆ D × Lₐ
```

che stabilisce se una certa assertion è vera nel dominio D, data l’interpretazione Iₐ.

📘 **Si scrive:**

```
M ⊨ₗₐ Tₐ
```

quando il modello **M** è un modello della teoria **Tₐ**.
In pratica, M “soddisfa” Tₐ.

---

## Intuizione: cosa fa l’entailment

L’entailment (⊨) permette di **derivare nuove assertions** che sono logicamente implicate da quelle note nel modello.

### Esempio:

```
Church(Duomo)
Church ⊑ Building ⊓ hasBellTower
```

⇒

```
Building(Duomo)
hasBellTower(Duomo)
```

👉 Così funziona il ragionamento formale nel mondo:
dalle affermazioni note → si deducono quelle implicite.

---

## World Logic = World Model + Regole di Entailment

| Componente               | Descrizione                         | Esempio                                      |
| ------------------------ | ----------------------------------- | -------------------------------------------- |
| **World Model (W)**      | rappresenta il mondo e i suoi fatti | “Duomo è una Chiesa”                         |
| **World Entailment (⊨)** | regole per derivare conseguenze     | “Quindi Duomo è anche un Edificio”           |
| **World Logic (L_W)**    | unisce rappresentazione e inferenza | “Nel mondo: Church(Duomo) ⇒ Building(Duomo)” |

---

## Truth, Falsity e IDK (I don’t know)

Il documento introduce tre stati di verità fondamentali in una *world logic*:

| Stato                  | Significato                                                  |
| ---------------------- | ------------------------------------------------------------ |
| **True**               | l’assertion è soddisfatta nel modello                        |
| **False**              | l’assertion è contraddetta nel modello                       |
| **IDK (I don’t know)** | l’assertion non è né vera né falsa perché manca informazione |

💡 Questi tre valori sono fondamentali nelle logiche del mondo, che spesso operano con conoscenza **incompleta**.

---

## World Entailment vs Interpretation

È un punto chiave del file: le due operazioni sono simili ma **inverse**.

| Operazione               | Direzione            | Scopo                                        |
| ------------------------ | -------------------- | -------------------------------------------- |
| **Interpretation (I)**   | Linguaggio → Dominio | costruisce il mondo a partire dal linguaggio |
| **World Entailment (⊨)** | Dominio → Linguaggio | verifica o deduce frasi vere nel mondo       |

👉 Quindi:

* *interpretation* “crea il significato” dei simboli;
* *entailment* “valuta la verità” delle affermazioni su quel significato.

---

## Entailment: la relazione modello–teoria

### Due forme di entailment:

1. **World entailment (M ⊨ T)**
   → il modello soddisfa la teoria.
2. **Logical entailment (T ⊨ a)**
   → l’assertion *a* è conseguenza logica della teoria T (cioè vera in tutti i modelli di T).

### Esempio:

```
M = modello del mondo
T = teoria {City(Trento), IsIn(Duomo, PiazzaDuomo), IsIn(PiazzaDuomo, Trento)}
```

Allora:

```
M ⊨ T
```

e, per deduzione logica:

```
T ⊨ IsIn(Duomo, Trento)
```

---

##  Proprietà delle World Logics

| Proprietà                     | Significato                                                                       |
| ----------------------------- | --------------------------------------------------------------------------------- |
| **Many-to-many**              | più teorie possono avere più modelli compatibili                                  |
| **Non-completezza**           | un modello non descrive tutto il mondo                                            |
| **Non-bidirezionalità**       | l’entailment non è simmetrico: da “A implica B” non segue “B implica A”           |
| **Estensione del linguaggio** | le World Logics ampliano il linguaggio base per includere connettivi come ∧, ∨, ¬ |

Esempi di estensioni linguistiche possibili:

* **Conjunction (∧)** → “Una madre è una donna **e** un genitore.”
* **Disjunction (∨)** → “Una persona è un uomo **o** una donna.”
* **Negation (¬)** → “Una donna **non è** un uomo.”

👉 Queste operazioni non sono possibili nei modelli “puri” ma solo nelle **logiche del mondo**.

---

## World Entailment come ragionamento

La logica del mondo diventa un meccanismo di Q/A (“question answering”):

> *Domanda*: è vero che `Duomo` è un edificio?
> *Risposta*: sì, perché `Church(Duomo)` e `Church ⊑ Building`.

Formalmente:

```
M ⊨ a   ⇔   a è vero in M
```

oppure

```
T ⊨ a   ⇔   a è conseguenza di T
```

---

## World Logic e Canonical Models

Nel file si riprende anche il concetto di **canonical model**:

* è il modello *massimale* e *completo* rispetto alla teoria (nessuna informazione mancante);
* quando una teoria è completa, il suo *intended model* e il *canonical model* coincidono;
* se la teoria è incompleta, la world logic serve per **dedurre ciò che manca**.

👉 È così che la logica compensa la parzialità del modello.

---

## 12. 🔑 **Concetti chiave**

| Termine                                  | Significato                                   |
| ---------------------------------------- | --------------------------------------------- |
| **World Model (W)**                      | rappresentazione strutturata del mondo        |
| **World Logic (L_W)**                    | mondo + regole di inferenza                   |
| **World Entailment (⊨)**                 | relazione tra modello e teoria                |
| **Logical Entailment**                   | relazione tra teoria e assertion              |
| **Interpretation (I)**                   | traduzione linguaggio → mondo                 |
| **Truth / False / IDK**                  | stati di verità di un’assertion               |
| **Canonical Model**                      | modello completo di una teoria                |
| **Many-to-many entailment**              | più modelli per una stessa teoria e viceversa |
| **Conjunction / Negation / Disjunction** | estensioni linguistiche per ragionamento      |
| **Question Answering**                   | verifica della verità tramite entailment      |

---

##  In sintesi
- [[2025-10-14 HP2T - World Logics.pdf]]

Questo modulo ti insegna che:

* I **World Models** rappresentano il mondo,
* Le **World Logics** permettono di **ragionare** su quei modelli,
* L’**entailment** (⊨) è il ponte tra realtà e conoscenza: decide cosa è vero nel mondo.
* Ogni ragionamento logico (umano o artificiale) si basa su questo schema:

  ```
  Teoria + Modello  →  Verità + Nuova conoscenza
  ```

