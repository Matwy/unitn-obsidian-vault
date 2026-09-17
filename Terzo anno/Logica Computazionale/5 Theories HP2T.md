---
date: 2025/10/24
tags:
Materia: "[[Logica Computazionale]]"
---
## 5 Theories HP2T

- Come si passa da rappresentazioni linguistiche e modelli a vere e proprie **teorie logiche** che descrivono e spiegano il mondo
---

## Dal modello alla teoria

* Un **modello** è una rappresentazione concreta del mondo (una “fotografia” parziale della realtà).
* Una **teoria** è una **rappresentazione linguistica** e **formale** del modello.
   In pratica:

> Il modello rappresenta “ciò che esiste”.
> La teoria rappresenta “ciò che sappiamo” di ciò che esiste.

### Esempio:

> Modello: “Duomo di Trento è una chiesa situata in Piazza Duomo.”
> Teoria:

 ```
 Church(Duomo)
 IsIn(Duomo, PiazzaDuomo)
 ```

---

## Dal linguaggio naturale alla teoria formale

### Obiettivo:

Creare **una rappresentazione non ambigua e verificabile** di ciò che diciamo del mondo.

### Passaggi:

1. **Scegli un linguaggio logico** (insieme di simboli e regole).
2. **Scrivi le affermazioni (assertions)** che descrivono i fatti del mondo.
3. **Definisci la semantica** → cioè cosa significa ogni simbolo nel mondo reale.
4. **Usa l’inferenza logica** per derivare nuovi fatti o verificare la coerenza.

---

## Cos’è un linguaggio logico

Formalmente:

```
L = <A, FR> = {s}
```

dove:

* **A** → l’alfabeto (insieme di parole, simboli o concetti);
* **FR** → le regole di formazione (come costruire frasi corrette);
* **s** → le “sentences” (le affermazioni costruite applicando le regole a A).

📘 Esempio:
Alfabeto: {Person, City, IsIn, Trento, Duomo}
Regole: ogni affermazione ha la forma `Predicate(Arg1, Arg2)`
Allora: `IsIn(Duomo, Trento)` è una frase (assertion) del linguaggio.

---

## Assertions, Facts e Domain

* **Assertion:** una frase del linguaggio (es. `Church(Duomo)`).
* **Fact:** ciò che l’assertion rappresenta nel mondo reale (il “fatto”).
* **Domain:** l’insieme di tutti i fatti di riferimento — cioè ciò che può essere vero o falso nel modello.

👉 Quindi:

> L’assertion è linguaggio.
> Il fact è realtà.
> L’interpretazione collega le due cose.

---

## Dalle frasi ai modelli

Ogni linguaggio logico è **interpretato** da una funzione:

```
I : L → D
```

che assegna a ogni frase (assertion) un significato nel dominio (fact).

* Se l’assertion descrive correttamente un fatto del dominio → è **vera**.
* Se non lo fa → è **falsa** o **non nota**.

👉 Questa è la base di ogni logica formale:
**una frase è vera se è soddisfatta nel suo modello.**

---

## Teorie e modelli

Una **teoria** è un insieme coerente di frasi vere in un dato modello:

```
T = {a₁, a₂, a₃, …}
```

Un **modello M** soddisfa una teoria T (si scrive `M ⊨ T`) se ogni assertion di T è vera in M.

### Quindi:

* **Modello** = rappresentazione del mondo (semantica).
* **Teoria** = descrizione del mondo (sintassi).
* **Relazione tra i due** = *soddisfacibilità* (`⊨`).

---

## Linguaggi assertionali

Il documento spiega che i **linguaggi assertionali** (come quelli che userai in LoE e LoD):

* servono per **descrivere fatti** del mondo;
* hanno **alfabeti di parole** (entità, proprietà, relazioni);
* e **regole di composizione** che determinano la loro struttura.

Esempi:

* linguaggio naturale → ambiguo;
* linguaggio pseudo-naturale → semplificato (es. “A person lives in Trento.”);
* linguaggio tabellare → usato nei DB (entità, attributi, relazioni);
* linguaggio grafico → usato nei modelli concettuali (ER/EER, ETG).

👉 Tutti questi sono **linguaggi di rappresentazione** — ma solo i linguaggi logici sono pienamente **formali** (non ambigui e deduttivi).

---

## Assertions e ragionamento

* Un’**assertion** è atomica se non può essere scomposta (es. `City(Trento)`).
* Una **teoria** è un insieme di assertions coerenti.
* Con il **ragionamento logico (entailment)** puoi derivare nuove assertions:

  ```
  IsIn(Duomo, PiazzaDuomo)
  IsIn(PiazzaDuomo, Trento)
  ⇒ IsIn(Duomo, Trento)
  ```

Questa deduzione è la base del **reasoning logico**, e sarà formalizzata nel modulo *World Logics*.

---

## Concetti chiave

| Termine                | Significato                                         |
| ---------------------- | --------------------------------------------------- |
| **Assertion**          | Affermazione che descrive un fatto                  |
| **Fact**               | Fatti reali nel dominio                             |
| **Domain (D)**         | Insieme di tutti i fatti possibili                  |
| **Language (L)**       | Sistema di simboli e regole per scrivere assertions |
| **Interpretation (I)** | Mappa tra linguaggio e realtà                       |
| **Model (M)**          | Rappresentazione strutturata del dominio            |
| **Theory (T)**         | Insieme di assertions vere nel modello              |
| **Entailment (⊨)**     | Relazione di verità: il modello soddisfa la teoria  |
| **Formalization**      | Processo che collega linguaggio e logica            |

---

## In sintesi
- [[2025-10-02 HP2T - Theories.pdf]]
Questo modulo spiega **come nasce una teoria logica**:

1. Si parte da un linguaggio formale.
2. Si scrivono assertions che descrivono fatti.
3. Si definisce un modello e un dominio.
4. Si usa la relazione `⊨` per decidere se la teoria è vera nel modello.

È la **base concettuale di tutte le logiche del mondo (LoE, LoD, LoT)**:
a partire da qui, i prossimi PDF (World Models, World Logics, LoE/LoD/LoT) ti mostreranno **come costruire concretamente questi sistemi**.
