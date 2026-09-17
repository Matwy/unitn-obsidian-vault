---
date: 2025/10/28
tags:
Materia: "[[Logica Computazionale]]"
---
## 13 LoD T2MP
- come la logica delle descrizioni (LoD) genera modelli e percezioni a partire da teorie concettuali.

---
## Contesto: T2MP e LoD

La **LoD** era stata introdotta in HP2T come logica che ragiona sui **tipi concettuali** (etype, dtype) e sulle loro relazioni — cioè la logica dei concetti.
Nel ciclo **T2MP (Theories → Models → Perception)**, questa stessa logica viene *rovesciata*:

> non serve più solo a ragionare *sulle* descrizioni, ma a **generare modelli** coerenti *da* descrizioni.

📘 In altre parole:

* In **HP2T**, la LoD serviva a formalizzare conoscenza concettuale.
* In **T2MP**, la LoD serve a **creare istanze, mondi e percezioni coerenti** partendo da quella conoscenza.

---

## Struttura formale della LoD

Formalmente rimane definita come:

```
LoD = ⟨ETG, ⊨LoD⟩
```

con:

```
ETG = ⟨LLoD, D, ILoD⟩
```

dove:

* **LLoD** è il linguaggio delle descrizioni (concetti e relazioni);
* **D** è il dominio di interpretazione (insieme di etypes e relazioni);
* **ILoD** è la funzione di interpretazione che collega concetti e mondo.

👉 Ma in T2MP, questa funzione non si limita a interpretare: **genera modelli coerenti con le teorie**.

---

## Ruolo della LoD nel ciclo T2MP

Nel ciclo *Theories → Models → Perception*:

```
Theory (TLoD)
    ↓ (interpretation)
World Model (W)
    ↓ (instantiation)
Perception (P)
```

la **LoD** agisce nel primo passaggio — *interpretare e materializzare concetti in un modello*.

> È la logica che permette di “rendere visibile” ciò che una teoria descrive.

Esempio:

```
Theory:  Church ⊑ Building ⊓ ∃hasBellTower.Tower
⇒ Model:  Duomo : Church
⇒ Perception: immagine o entità "Duomo" con campanile
```

---

## Definizioni principali riprese (recap teorico)

### ➤ **Dominio**

```
D = ⟨{C}, {R}⟩
```

dove:

* `{C}` contiene le **classi** (ET ∪ DT),
* `{R}` contiene le **relazioni binarie** (oggetto o dato).

### ➤ **Classi**

```
{C} = ET ∪ DT
ET = {Ei}, insieme degli entity types
DT = {Di}, insieme dei data types
```

### ➤ **Relazioni**

```
{R} = OR ∪ AR
OR = {Oi}, object properties (tra etypes)
AR = {Ai}, attributes (tra etype e dtype)
```

---

## Linguaggio della LoD

Il linguaggio si articola in tre livelli, come in HP2T, ma qui l’attenzione è su **generazione e valutazione semantica**:

| Livello                           | Significato                  | Esempio                    |
| --------------------------------- | ---------------------------- | -------------------------- |
| **Etype percepts (LT)**           | concetti elementari          | `∃hasFriend.Person`        |
| **Composite etype percepts (LC)** | combinazioni logiche         | `Person ⊓ ¬∀hasFriend.Cat` |
| **Descriptions (LLoD)**           | vincoli e regole concettuali | `Parent ⊑ Mother ⊔ Father` |

---

## Interpretazione (T2MP)

La funzione di interpretazione non si limita a “leggere” ma a **costruire**.
Le regole formali restano:

* per gli etype:

  ```
  IT(⊤) = U
  IT(⊥) = ∅
  IT(∃P.T) = {d ∈ U | ∃e. (d,e) ∈ I(P) ∧ e ∈ IT(T)}
  IT(∀P.T) = {d ∈ U | ∀e. (d,e) ∈ I(P) ⇒ e ∈ IT(T)}
  ```

* per i compositi:

  ```
  IC(p1 ⊓ p2) = IC(p1) ∩ IC(p2)
  IC(p1 ⊔ p2) = IC(p1) ∪ IC(p2)
  IC(¬p1) = U \ IC(p1)
  ```

💡 **In T2MP:**
queste regole vengono usate per **costruire le istanze** che soddisfano una teoria (e non solo per verificarle).

---

## 7. 🧩 **Descrizioni e Definizioni**

### **Descrizione (constraint):**

```
<pC1> ⊑ <pC2>
```

→ impone un vincolo tra tipi (es. `Cathedral ⊑ Church`)

### **Definizione (espansione):**

```
<E> ≡ <pC>
```

→ introduce un nuovo tipo definito in base ad altri (es. `Parent ≡ Mother ⊔ Father`)
	
💡 In T2MP le definizioni vengono usate per **espandere la teoria e creare nuove entità** nel modello generato.

---

## 8. ⚖️ **Interpretazione delle descrizioni**

La semantica rimane set-teoretica:

```
I(p1 ⊑ p2) ↔ IC(p1) ⊆ IC(p2)
I(p1 ≡ p2) ↔ IC(p1) = IC(p2)
```

ma in T2MP l’interpretazione viene usata **costruttivamente**:

* serve a verificare che un modello *aderisca* alle descrizioni;
* e anche a **costruire il modello minimo** che le soddisfa.

---

## 9. 🧮 **Entailment (⊨LoD)**

La relazione di entailment della LoD diventa:

> un operatore che genera i modelli coerenti con le teorie di descrizione.

Formalmente:

```
W ⊨LoD T  ⟺  per ogni descrizione a ∈ T,  I(a) = true in W
```

ma in T2MP può essere invertita:

```
T ⊨LoD W  ⟺  la teoria T genera un modello W coerente
```

👉 Quindi l’entailment è **bidirezionale**:

* in HP2T: verifica (“il modello soddisfa la teoria”)
* in T2MP: generazione (“la teoria costruisce il modello”)

---

## 10. 🧠 **Esempio pratico T2MP – LoD**

### Teoria logica:

```
Church ⊑ Building ⊓ ∃hasBellTower.Tower
Cathedral ⊑ Church
```

### Modello generato:

```
Entities:
  Duomo : Cathedral
  Building(Duomo)
  hasBellTower(Duomo)
```

La **LoD** genera automaticamente le entità e relazioni coerenti con le definizioni.

---

## 11. 🧩 **TBox e Terminologia**

In T2MP, come in Description Logics:

* la **TBox** è la parte terminologica (definizioni, relazioni tra tipi);
* può essere:

  * **acyclic** → non ci sono definizioni circolari;
  * **cyclic** → definizioni che si riferiscono a se stesse (come “Parent”).

💡 Le TBox cicliche consentono modelli più espressivi (e più complessi da generare).

---

## 12. 🔑 **Concetti chiave**

| Termine                                   | Significato                                            |
| ----------------------------------------- | ------------------------------------------------------ |
| **T2MP (Theories → Models → Perception)** | direzione generativa del ciclo                         |
| **LoD (Logic of Descriptions)**           | logica dei concetti e dei tipi                         |
| **Etype / Dtype**                         | tipi di entità e tipi di dati                          |
| **Interpretation Function (I)**           | genera il mondo coerente con la teoria                 |
| **Subsumption (⊑)**                       | relazione “is-a” tra concetti                          |
| **Equivalence (≡)**                       | sinonimia logica tra concetti                          |
| **Composite Etype**                       | combinazione di etype (⊓, ⊔, ¬)                        |
| **Entailment (⊨LoD)**                     | relazione di verità o generazione tra teoria e modello |
| **TBox**                                  | insieme delle definizioni concettuali                  |
| **Constructive entailment**               | generazione del modello coerente con la teoria         |

---

## 📚 **In sintesi**

La **T2MP – LoD** è la controparte generativa della logica concettuale:

* in **HP2T**, la LoD formalizza la conoscenza;
* in **T2MP**, la LoD **produce mondi coerenti** con quella conoscenza.

È la logica che permette di *ricostruire il mondo concettuale* della mente in forma percepibile per la macchina —
un ponte tra **sapere simbolico** e **percezione simulata**.
