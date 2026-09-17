---
date: 2025/10/25
tags:
Materia: "[[Logica Computazionale]]"
---
## 6 World Models
- costruire rappresentazioni  formali del mondo mentali o computazionali, attraverso modelli, grafi e tipi di conoscenza.

## 1. Il posto dei World Models nella piramide logica

Richiamo dalla *Logics Pyramid*:

```
Reasoning Logics     → ragionamento
World Logics         → logiche del mondo (entailment)
World Models         → modelli del mondo (rappresentazioni)
Models               → percezioni organizzate
```

👉 I **World Models** stanno tra:

* la **teoria linguistica (Theories)**
* e la **logica del mondo (World Logics)**

Sono quindi la **struttura intermedia** che dà forma alla conoscenza del mondo.

---

## Definizione di World Model

Un **World Model** è una rappresentazione formale del mondo (reale o mentale) costruita a partire da:

```
W = ⟨Lₐ, D, Iₐ⟩
```

dove:

* **Lₐ** → linguaggio assertionale (simboli e regole)
* **D** → dominio (entità, tipi, relazioni)
* **Iₐ** → interpretazione (collega simboli e realtà)

Questa è la **base semantica** di ogni tipo di rappresentazione del mondo.

---

## Tipi fondamentali di World Model

Il corso distingue **3 tipi base** di modelli, che corrispondono a diversi livelli di astrazione:

| Tipo di modello        | Che cosa rappresenta                | Esempio                                    | Rappresentazione                       |
| ---------------------- | ----------------------------------- | ------------------------------------------ | -------------------------------------- |
| **Concept Graph (CG)** | Concetti e relazioni linguistiche   | “Organism ⊑ Entity”                        | Ontologie linguistiche                 |
| **Etype Graph (ETG)**  | Tipi di entità e loro proprietà     | “Church ⊑ Building ⊓ hasBellTower”         | Modelli concettuali / Knowledge schema |
| **Entity Graph (EG)**  | Entità specifiche e relazioni reali | “Duomo is a Church; Duomo in Piazza Duomo” | Database / Knowledge Graph             |

👉 Tutti gli altri modelli (“composed world models”) sono **combinazioni** di questi tre livelli.

---

## Dal concetto all’entità (dalla lingua al mondo)

Il documento mostra la gerarchia della conoscenza in forma visiva e semantica:

```
Concept → Etype → Entity
```

| Livello     | Dominio               | Esempio                          | Finalità                  |
| ----------- | --------------------- | -------------------------------- | ------------------------- |
| **Concept** | idee generali         | “Person”, “Animal”, “Location”   | struttura del linguaggio  |
| **Etype**   | tipi di oggetti reali | “ItalianCity”, “River”, “Church” | organizzazione del sapere |
| **Entity**  | oggetti concreti      | “Trento”, “Adige”, “Duomo”       | dati del mondo            |

👉 Quindi:

* **Concept Graphs** definiscono il *vocabolario* (linguaggio del mondo);
* **Etype Graphs** definiscono la *struttura* del mondo;
* **Entity Graphs** definiscono *ciò che esiste* nel mondo.

---

## Esempio completo: Trento**

Nel file c’è un esempio ricorrente (usato in tutti gli HP2T):

* **Concetti:**

  ```
  City, Square, Church, Fountain
  ```
* **Etypes:**

  ```
  City(Trento)
  Church(Duomo)
  Fountain(Fontana del Nettuno)
  Square(Piazza Duomo)
  IsIn(Duomo, Piazza Duomo)
  IsIn(Fontana del Nettuno, Piazza Duomo)
  IsIn(Piazza Duomo, Trento)
  ```
* **Entità:**

  * “Trento” è una `City`
  * “Duomo” è una `Church`
  * “Fontana del Nettuno” è una `Fountain`
  * “Piazza Duomo” è una `Square`

👉 Da queste informazioni si può **dedurre** (tramite logica del mondo, LoE):

```
IsIn(Duomo, Trento)
IsIn(Fontana del Nettuno, Trento)
```

---

## Proprietà di un World Model

Ogni World Model deve rispettare:

| Proprietà                   | Descrizione                                                                                     |
| --------------------------- | ----------------------------------------------------------------------------------------------- |
| **Well-formedness**         | Ogni nodo e arco ha un solo tipo; proprietà coerenti con i tipi di dominio.                     |
| **Strong typing**           | I collegamenti rispettano la natura dell’oggetto (es. un “height” non può partire da un dtype). |
| **Consistency**             | Nessuna contraddizione interna.                                                                 |
| **Completeness (parziale)** | Descrive una porzione significativa, ma non necessariamente tutto il mondo.                     |

---

## Modelli “composed”

Oltre ai 3 modelli base (CG, ETG, EG), ci sono i **modelli composti**:

| Tipo                         | Descrizione                                            | Esempio                        |
| ---------------------------- | ------------------------------------------------------ | ------------------------------ |
| **Concept + Etype**          | L’ontologia linguistica si combina con i tipi concreti | “City” → “ItalianCity”         |
| **Etype + Entity**           | I tipi si popolano con entità reali                    | “ItalianCity” → “Trento”       |
| **Concept + Entity**         | Il linguaggio direttamente applicato agli oggetti      | “Entity ‘Trento’ è una ‘City’” |
| **Concept + Etype + Entity** | Tutti i livelli integrati → modello del mondo completo | Knowledge Graph semantico      |

💡 Questo ultimo tipo (Concept + Etype + Entity Graph) è ciò che oggi chiamiamo **Knowledge Graph** o **World Knowledge Base**.

---

## Formalizzazione generale

Ogni World Model segue la stessa struttura formale:

```
W = ⟨Lₐ, D, Iₐ⟩
```

e si espande in tre livelli:

| Livello            | Cosa contiene                        | Linguaggio corrispondente |
| ------------------ | ------------------------------------ | ------------------------- |
| **Conceptual**     | concetti e relazioni linguistiche    | linguaggio concettuale    |
| **Type-level**     | tipi di entità, attributi, relazioni | linguaggio dei tipi       |
| **Instance-level** | entità concrete e dati               | linguaggio delle entità   |

---

## World Models e piramide cognitiva

Nella mente umana (e nei sistemi AI), i world models corrispondono al livello dell’**Understanding**:

* traducono concetti in strutture di conoscenza,
* organizzano relazioni e tipi,
* e permettono la deduzione di nuovi fatti.

---

##  Concetti chiave

| Termine                  | Significato                                               |
| ------------------------ | --------------------------------------------------------- |
| **World Model (W)**      | rappresentazione formale del mondo                        |
| **Concept Graph (CG)**   | ontologia linguistica (concetti e relazioni)              |
| **Etype Graph (ETG)**    | tipi di entità, attributi, relazioni                      |
| **Entity Graph (EG)**    | istanze reali, dati concreti                              |
| **Composed World Model** | combinazione dei livelli                                  |
| **Well-formedness**      | regole di correttezza sintattica e semantica              |
| **Strong typing**        | vincolo di compatibilità tra entità e proprietà           |
| **Knowledge Ontology**   | struttura formale della conoscenza                        |
| **Teleontology (TLO)**   | insieme di relazioni MG/LG (più generale / meno generale) |
| **Taxonomy (KTAX)**      | teleontologia ad albero con un unico concetto radice      |

---

## 📚 **In sintesi**
- [[2025-10-09 HP2T - World Models.pdf]]

Questo modulo ti mostra **come costruire il mondo nella logica**:

1. Dalle teorie formali si passa a modelli del mondo (World Models).
2. Questi modelli organizzano concetti, tipi e istanze.
3. Ogni modello segue regole formali di struttura e interpretazione.
4. I modelli composti uniscono tutti i livelli per rappresentare la conoscenza reale (come nei Knowledge Graph).

👉 Nei prossimi PDF (*World Logics*, *LoE*, *LoD*) imparerai **come “usare” questi modelli per ragionare**, cioè come derivare conoscenza nuova tramite inferenza logica.
