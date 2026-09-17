---
date: 2025/10/24
tags:
Materia: "[[Logica Computazionale]]"
---
## 4 Models
- come le teorie descrivono modelli del mondo, e come i modelli rendono vero o falso ciò che le teorie affermano.
## Dalle teorie ai modelli

Una **teoria** è un insieme di assertions (affermazioni linguistiche).
Un **modello** è una **struttura semantica** che interpreta quelle affermazioni nel mondo reale.

📘 **In simboli:**

```
M ⊨ T
```

significa che il modello **M** soddisfa la teoria **T**, cioè che **tutte le assertions di T sono vere in M**.

👉 In parole semplici:

> * La teoria è ciò che “diciamo” del mondo.
> * Il modello è “il mondo come è”, interpretato secondo le regole della teoria.

---

## Definizione di Modello

Formalmente, un modello è una **tripla**:

```
W = ⟨Lₐ, D, Iₐ⟩
```

dove:

* **Lₐ** → linguaggio assertionale (alfabeto e regole con cui si scrivono assertions)
* **D** → dominio (insieme dei fatti o oggetti di cui si parla)
* **Iₐ** → funzione di interpretazione, che collega simboli del linguaggio agli oggetti del dominio.

👉 Questa struttura permette di **collegare linguaggio e realtà** in modo rigoroso.

---

## Componenti del modello

| Componente               | Significato                                            | Esempio                                                  |
| ------------------------ | ------------------------------------------------------ | -------------------------------------------------------- |
| **Linguaggio (Lₐ)**      | Insieme di simboli e regole per esprimere affermazioni | `{Person, City, IsIn, Duomo, Trento}`                    |
| **Dominio (D)**          | Insieme di fatti o entità del mondo                    | `{Trento, Duomo, PiazzaDuomo, IsIn(Duomo, PiazzaDuomo)}` |
| **Interpretazione (Iₐ)** | Assegnazione del significato ai simboli                | `Iₐ(IsIn) = relazione di inclusione spaziale`            |

---

## Intuizione cognitiva: mente e modello

Il documento spiega che il modello del mondo è **l’equivalente formale della nostra rappresentazione mentale**:

* **Nel cervello umano:** memorizzi percezioni e relazioni.
* **Nella logica:** rappresenti entità e relazioni come **assertions interpretate** in un dominio.

💡 In altre parole:

> Il modello è il “mondo nella mente” (o nella macchina) — strutturato logicamente.

---

## Dai modelli ai mondi

Ci sono due prospettive:

1. **Analogica:** il mondo reale percepito (immagini, oggetti, relazioni).
2. **Linguistica:** la descrizione formale del mondo (concetti, entità, relazioni).

I **world models** uniscono queste due prospettive, trasformando percezioni in strutture logiche.

Esempio:

```
City(Trento)
Church(Duomo)
IsIn(Duomo, PiazzaDuomo)
IsIn(PiazzaDuomo, Trento)
```

→ rappresenta una porzione coerente di “mondo” interpretata nel modello.

---

## Teorie, modelli e verità

### 🔹 Relazione fondamentale:

```
M ⊨ a
```

significa che **l’assertion a è vera nel modello M**.

### 🔹 Se vale per tutte le assertions di una teoria T:

```
M ⊨ T
```

Allora M è **un modello di T**.

### 🔹 Se invece:

```
T ⊨ a
```

vuol dire che **a è logicamente deducibile da T** — cioè vera in tutti i modelli di T.

👉 Queste due relazioni (⊨ a livello di modello e di teoria) sono la base della **semantica logica**:

* *M ⊨ T* → verità nel mondo;
* *T ⊨ a* → conseguenza logica.

---

## Tipi di modelli (nelle logiche del mondo)

Nei PDF successivi (“World Models”) verranno introdotti vari tipi di modelli, tutti derivati da questa definizione base:

| Tipo                      | Significato                                     | Esempio                                            |
| ------------------------- | ----------------------------------------------- | -------------------------------------------------- |
| **Concept Graphs (CG)**   | rappresentano concetti e relazioni linguistiche | “Persona → Organismo → Entità”                     |
| **Etype Graphs (ETG)**    | rappresentano tipi di entità e loro proprietà   | “Church ⊑ Building ⊓ hasBellTower”                 |
| **Entity Graphs (EG)**    | rappresentano istanze reali                     | “Duomo è un Church, Trento è una City”             |
| **Composed World Models** | combinano concetti, tipi e istanze              | usati nei sistemi di conoscenza (Knowledge Graphs) |

👉 Questi modelli sono “mondi formalizzati” — ogni nodo o arco ha un significato preciso nel dominio.

---

## Interpretazione e soddisfacibilità

* L’**interpretazione** (Iₐ) traduce simboli in entità del dominio.
* Un’assertion è **soddisfatta** se l’interpretazione la rende vera.
* Una teoria è **soddisfacibile** se esiste almeno un modello che la rende vera.

Esempio:

```
IsIn(Duomo, PiazzaDuomo)
IsIn(PiazzaDuomo, Trento)
```

→ entrambe sono vere nel modello che contiene `Duomo`, `PiazzaDuomo`, `Trento` e le relazioni spaziali corrette.

---

## Dalla teoria al mondo: “Intended model”

Il documento introduce anche il concetto di:

> **Intended Model** → il modello “che abbiamo in mente” quando scriviamo una teoria.

Ma attenzione:

* spesso le teorie sono **incomplete**, quindi hanno **più modelli possibili**;
* il **canonical model** è quello **completo** rispetto alla teoria (nessuna informazione mancante).

👉 Questa incompletezza è una causa diretta del **semantic gap** anche nelle rappresentazioni logiche.

---

## Concetti chiave

| Termine                 | Significato                                                      |
| ----------------------- | ---------------------------------------------------------------- |
| **Model (M)**           | Interpretazione logica della realtà                              |
| **Theory (T)**          | Insieme di assertions che descrivono la realtà                   |
| **Domain (D)**          | Insieme di entità e relazioni che costituiscono il “mondo”       |
| **Interpretation (Iₐ)** | Mappa che assegna significato ai simboli del linguaggio          |
| **Satisfiability (⊨)**  | Relazione di verità tra modello e teoria                         |
| **Intended Model**      | Il modello mentale che una teoria vuole descrivere               |
| **Canonical Model**     | Il modello completo e coerente di una teoria                     |
| **Incomplete Theory**   | Teoria che non specifica tutto il necessario per un solo modello |

---

## In sintesi
 - [[2025-09-26 HP2T - Models.pdf]]
Questo modulo ti insegna che:

* Le **teorie** descrivono il mondo in forma linguistica.
* I **modelli** danno significato e verità a quelle teorie.
* La relazione `⊨` collega ciò che è scritto (linguaggio) con ciò che è reale (dominio).
* Esistono molti tipi di modelli, dai concettuali ai concreti, tutti derivati da questa struttura formale.

---
