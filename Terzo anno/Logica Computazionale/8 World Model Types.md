---
date: 2025/10/25
tags:
Materia: "[[Logica Computazionale]]"
---
## 8 World Model Types
- classificazione dei modelli del mondo

## Richiamo: la piramide della conoscenza e delle logiche

Il documento riprende la *Logics Pyramid* per inquadrarti nel livello corretto:

```
Reasoning Logics     → deduzione, proposizioni
World Logics         → ragionamento sul mondo
World Models         → rappresentazioni strutturate del mondo
Models               → percezioni organizzate
```

👉 Qui siamo nel livello “World Models”, dove le teorie vengono trasformate in **rappresentazioni strutturate**, cioè **grafi logici** di concetti, tipi e entità.

---

## 2. Tipi di base di World Model

Il documento definisce **tre modelli fondamentali** — le *building blocks* della conoscenza:

| Tipo di modello        | Cosa rappresenta                   | Esempio                                       | Equivalente nella conoscenza umana |
| ---------------------- | ---------------------------------- | --------------------------------------------- | ---------------------------------- |
| **Concept Graph (CG)** | relazioni tra concetti linguistici | “Woman ⊑ Person”, “Person ⊓ Animal = ∅”       | vocabolario / linguaggio           |
| **Etype Graph (ETG)**  | tipi di entità e loro proprietà    | “ItalianCity ⊑ City”, “hasPopulation: Number” | schemi concettuali                 |
| **Entity Graph (EG)**  | istanze reali con valori           | “Trento: ItalianCity, population=120000”      | memoria episodica / dati concreti  |

🧠 Questi tre livelli sono complementari:

* i **Concept Graphs** definiscono *il significato dei termini*;
* gli **Etype Graphs** definiscono *le strutture e le regole del mondo*;
* gli **Entity Graphs** descrivono *le cose che esistono davvero*.

---

## 3. Quattro tipi di modelli composti

Dai tre modelli di base si ottengono **modelli composti**, combinando due o più livelli:

| Tipo                               | Descrizione                                       | Esempio                                   |
| ---------------------------------- | ------------------------------------------------- | ----------------------------------------- |
| **Concept + Etype Graph**          | unisce linguaggio e tipi                          | “City (concetto)” + “ItalianCity (etype)” |
| **Concept + Entity Graph**         | collega linguaggio e istanze reali                | “Entity Trento” ↔ “Concept City”          |
| **Etype + Entity Graph**           | collega tipi e istanze                            | “ItalianCity” ↔ “Trento”                  |
| **Concept + Etype + Entity Graph** | modello completo del mondo (composed world model) | concetti + tipi + entità + relazioni      |

💡 Quest’ultimo è il più ricco: contiene la conoscenza linguistica, strutturale e fattuale.
È il formato base dei **Knowledge Graph semantici**.

---

## 4. Concetti fondamentali alla base dei modelli

### 🔹 Entities, Etypes, Properties

* **Entity:** un oggetto concreto percepito nel mondo (`Trento`, `Duomo`).
* **Etype:** un tipo o classe di entità (`City`, `Church`, `Person`).
* **Property:** un attributo o relazione che descrive un’entità o un’etipe (`hasName`, `worksAt`, `isIn`).

### 🔹 Data Types

Un **Data Type (dtype)** è un tipo di informazione atomica (numero, stringa, data, coordinate, ecc.).

* Serve per specificare i valori delle *data properties*.
* Esempi:

  * `Number`: 3, 45.2
  * `String`: “Trento”
  * `Date`: 24/10/2025

---

## 5. Differenza tra Data Types e Entity Types

| Tipo                    | Dominio                    | Esempio                         | Identificazione        |
| ----------------------- | -------------------------- | ------------------------------- | ---------------------- |
| **Data Type (dtype)**   | valori numerici o testuali | `age = 25`, `name = "Paolo"`    | confronto per valore   |
| **Entity Type (etype)** | classi di entità del mondo | `Person(Paolo)`, `City(Trento)` | confronto per identità |

👉 I *data types* servono per rappresentare attributi (es. età, nome),
mentre gli *entity types* rappresentano oggetti reali (persone, città, chiese).

---

## 6.  Etype Graphs (ETG)

Gli **Etype Graphs** sono grafi orientati e tipizzati che rappresentano relazioni tra tipi di entità.

### Struttura semantica:

* **Nodi:** etypes (`Person`, `City`, `River`)
* **Archi:** proprietà (`worksAt`, `flowsAcross`, `isIn`)
* **Relazioni MG/LG:** *More General / Less General* (gerarchia tra etypes)
* **Disjointness:** esclude l’intersezione tra etypes (es. `Person ⊓ Animal = ∅`)

### Esempio:

```
Person
  ├── Student
  └── Teacher
```

e relazioni:

```
Student ⊑ Person
Teacher ⊑ Person
teaches(Teacher, Student)
```

---

## 7. 🏙️ **Entity Graphs (EG)**

Gli **Entity Graphs** sono le istanze reali dei modelli del mondo.
Sono “schemi popolati”.

Esempio:

```
Trento : ItalianCity
population : 120000
hasSquare : PiazzaDuomo

PiazzaDuomo : Square
area : 2200 m²

Duomo : Church
isIn : PiazzaDuomo
```

👉 Sono ciò che trovi nei **Knowledge Graph concreti** (Google KG, Wikidata, DBpedia…).

---

## 8. 🧠 **Concept Graphs (CG)**

I **Concept Graphs** sono alla base di tutto:
definiscono il significato dei termini e le relazioni linguistiche.

### Struttura:

* **Concetti:** “Person”, “City”, “Square”
* **Relazioni semantiche:** “is-a” (isa), “disjoint-with”, “part-of”
* **Interpretazione:** concetti come insiemi di percezioni.

### Esempio:

```
Entity
 ├── Object
 │   ├── Location
 │   │   ├── City
 │   │   └── Square
 │   └── Organism
 │       ├── Person
 │       └── Animal
```

---

## 9. ⚙️ **Relazioni tra i modelli**

I modelli sono **collegati gerarchicamente**:

```
Concept Graph → definisce il linguaggio
Etype Graph → struttura la conoscenza
Entity Graph → la popola con dati concreti
```

E i modelli composti permettono di:

* navigare dal linguaggio alla realtà,
* unire schemi e istanze,
* costruire una **mappa semantica completa** del mondo.

---

## 10. 🧩 **Modelli semi-formali**

Il documento distingue tra:

* **modelli semi-formali:** ambigui o incompleti (usano linguaggio naturale o schemi parziali);
* **modelli formali:** completamente definiti secondo regole logiche.

👉 Esempio:

* Semi-formale: “un cane è un animale domestico” → linguaggio naturale.
* Formale: `Dog ⊑ Animal ⊓ hasOwner.Person` → linguaggio logico (non ambiguo).

---

## 11. 🔑 **Concetti chiave**

| Termine                | Significato                                                     |
| ---------------------- | --------------------------------------------------------------- |
| **Concept Graph (CG)** | struttura linguistica dei concetti                              |
| **Etype Graph (ETG)**  | struttura concettuale dei tipi di entità                        |
| **Entity Graph (EG)**  | struttura concreta delle istanze                                |
| **Data Type (dtype)**  | tipo di valore numerico o testuale                              |
| **Etype Property**     | relazione tra etypes (es. `hasFriend`)                          |
| **Data Property**      | relazione tra entità e valori (es. `age`, `name`)               |
| **MG/LG relation**     | gerarchia di generalità tra etypes                              |
| **Teleontology (TLO)** | insieme di relazioni MG/LG organizzate gerarchicamente          |
| **Schema Graph (SG)**  | teleologia in cui il nodo radice è implicito (schema logico)    |
| **Composed Model**     | combinazione di CG, ETG, EG per rappresentare il mondo completo |

---

## 📚 **In sintesi**

Questo modulo è la **grammatica dei mondi formali**:

* definisce *come* classificare i diversi tipi di rappresentazione (concettuale, tipologica, concreta);
* mostra *come combinarli* per ottenere una rappresentazione completa del mondo;
* introduce i concetti di **ontologia**, **teleologia**, **schema** e **Knowledge Graph**.

👉 È la base diretta per il prossimo file:
**📄 2025-10-14 – HP2T: World Logics.pdf**,
dove questi modelli vengono “attivati” — cioè usati per **inferire nuova conoscenza** tramite regole di logica del mondo.

---

Vuoi che nel prossimo (📄 *World Logics*) ti prepari anche **un mini schema visivo** che mostra la differenza tra *model*, *world model* e *world logic* (utile per capire come la macchina passa dalla rappresentazione al ragionamento)?
