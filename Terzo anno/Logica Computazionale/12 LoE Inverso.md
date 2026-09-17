---
date: 2025/10/27
tags: 
Materia:
---
## 12 LoE Inverso

- come applicare la logica delle entità (LoE) in direzione inversa — dalle teorie astratte alla percezione artificiale.

---

## Contesto generale: HP2T vs T2MP

| Percorso                                 | Direzione                  | Obiettivo                                                                     |
| ---------------------------------------- | -------------------------- | ----------------------------------------------------------------------------- |
| **HP2T (Human Perception → Theories)**   | dal mondo reale alla mente | capire come rappresentiamo e formalizziamo la realtà                          |
| **T2MP (Theories → Machine Perception)** | dalla mente alla macchina  | insegnare alla macchina a ricostruire il mondo a partire da modelli e logiche |

👉 In *HP2T* la mente costruiva modelli per comprendere;
in *T2MP*, i modelli vengono **usati per generare percezioni e comportamenti**.

---

## Ruolo della LoE nel ciclo T2MP

Nel contesto T2MP, la **LoE** non serve più solo per *ragionare sulle entità esistenti*,
ma per **istanziare entità nuove nel mondo**, a partire da teorie e descrizioni logiche.

Esempio:

```
Theory:
Church ⊑ Building ⊓ hasBellTower
```

→ può generare un **modello percettivo**:

```
Entity: Duomo
Type: Church
Inferred: Building(Duomo), hasBellTower(Duomo)
```

💡 Qui la logica è “attiva”: *produce* rappresentazioni e percezioni artificiali coerenti con la teoria.

---

## Struttura formale di riferimento

Come nel caso HP2T:

```
LW = ⟨W, ⊨W⟩
```

ma nel ciclo T2MP la direzione è **inversa**:

```
⊨W : L → D   (ragionamento astratto → percezione concreta)
```

La LoE diventa così un **motore generativo di conoscenza percettiva**,
che traduce descrizioni simboliche in oggetti del mondo simulato.

---

## Intuizione: dal simbolico al percettivo

Nel cervello umano:

* la percezione crea concetti, e le teorie descrivono il mondo (HP2T);
  nella macchina:
* le teorie logiche vengono tradotte in strutture che *simulano* la percezione (T2MP).

📘 Questo passaggio avviene grazie alla LoE:
le regole di inferenza che in HP2T deducevano *nuove verità*,
in T2MP vengono usate per *ricostruire i mondi possibili* coerenti con una teoria.

---

## Il flusso T2MP – “dal sapere al vedere”

Il documento mostra lo schema inverso del flusso HP2T:

```
Theories
   ↓ (interpretation)
World Models
   ↓ (instantiation)
Models
   ↓ (simulation)
Perception
```

👉 In HP2T avevi:
**Perception → Conceptualization → Understanding → Reasoning**
in T2MP hai:
**Reasoning → Understanding → Conceptualization → Perception**

È un percorso speculare e ricorsivo:
le macchine usano la logica per **costruire rappresentazioni percettive**.

---

## Esempio pratico: generazione del mondo

Partiamo da una teoria logica:

```
Church ⊑ Building ⊓ hasBellTower
City ⊑ Location
IsIn(Church, City)
```

La LoE in T2MP genera il mondo corrispondente:

```
Entities:
  Duomo : Church
  Trento : City
Facts:
  Building(Duomo)
  hasBellTower(Duomo)
  IsIn(Duomo, Trento)
```

👉 È l’operazione inversa rispetto a HP2T:
anziché dedurre regole dal mondo, si *creano fatti coerenti con le regole*.

---

## Ruolo del World Entailment nella generazione

Nel contesto T2MP, l’**entailment del mondo (⊨W)** non è solo verifica, ma anche **costruzione**:

* in HP2T: `M ⊨ T` → il modello *soddisfa* la teoria;
* in T2MP: `T ⊨ M` → la teoria *genera* un modello coerente.

💡 L’entailment diventa bidirezionale:

* “verifica di verità” nel verso HP2T,
* “creazione del mondo” nel verso T2MP.

---

## LoE come motore di ricostruzione semantica

Nel ciclo T2MP, la **LoE** svolge funzioni tipiche di:

* **reasoner** logico (deduzione);
* **generator** di mondo (instanziazione).

Essa permette di:

1. dedurre *nuove entità* coerenti con le regole logiche,
2. completare modelli parziali,
3. risolvere inconsistenze (creando nuovi mondi coerenti).

---

## Canonical vs Intended Models (inversi)

| Tipo di modello     | Nella direzione HP2T                          | Nella direzione T2MP                             |
| ------------------- | --------------------------------------------- | ------------------------------------------------ |
| **Intended Model**  | il mondo reale che la teoria vuole descrivere | la teoria “che genera” il mondo percettivo       |
| **Canonical Model** | il modello completo coerente con la teoria    | il modello generato automaticamente dalla teoria |

👉 In T2MP, il *canonical model* diventa un **prodotto** dell’entailment logico.

---

## Relazione con AI e generative reasoning

La logica T2MP–LoE è la base teorica di:

* **neuro-symbolic AI** → unisce reti neurali (percezione) e logiche formali (teoria);
* **knowledge-based simulation** → costruzione automatica di scenari coerenti con regole;
* **generative models** → costruzione di “mondi possibili” coerenti con conoscenze pregresse.

👉 È la logica che trasforma le teorie in *percezioni sintetiche*.

---

## Esempio di ragionamento generativo

Data la teoria:

```
City ⊑ Location
Church ⊑ Building
Building ⊑ PhysicalObject
```

la LoE può generare:

```
Entity: Duomo
→ Church(Duomo)
→ Building(Duomo)
→ PhysicalObject(Duomo)
```

👉 Queste deduzioni, nel contesto T2MP, equivalgono alla *ricostruzione percettiva* di un oggetto coerente con la teoria.

---

## Concetti chiave

| Termine                                   | Significato                                                      |
| ----------------------------------------- | ---------------------------------------------------------------- |
| **T2MP (Theories → Models → Perception)** | direzione inversa rispetto a HP2T                                |
| **LoE (Logic of Entities)**               | logica usata per istanziare entità dal sapere                    |
| **World Entailment (⊨)**                  | passa da verifica a generazione                                  |
| **Intended Model**                        | teoria “di partenza” da cui generare mondo                       |
| **Canonical Model**                       | mondo generato automaticamente dalla teoria                      |
| **Reasoner**                              | motore logico deduttivo                                          |
| **Generator**                             | motore che produce entità e relazioni coerenti                   |
| **Bidirectional entailment**              | relazione tra teoria e modello nei due sensi                     |
| **Generative AI**                         | applicazione computazionale del ciclo T2MP                       |
| **Reconstruction of perception**          | creazione di un mondo coerente a partire da conoscenza simbolica |

---

## In sintesi
- [[2025-10-17.bis T2MP - LoE.pdf]]

La **T2MP – LoE** chiude il cerchio della conoscenza logica:

* in **HP2T**, la mente costruiva modelli dal mondo;
* in **T2MP**, la macchina costruisce il mondo dalle teorie.

La **LoE** diventa così uno strumento non solo per “verificare” ma per **generare conoscenza percettiva**:

> dalle regole alla realtà, dai simboli agli oggetti, dalla teoria alla percezione.
