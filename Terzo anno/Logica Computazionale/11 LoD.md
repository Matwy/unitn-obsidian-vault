---
date: 2025/10/27
tags:
Materia: "[[Logica Computazionale]]"
---
## 11 LoD

-  come **formalizzare** e **dedurre** conoscenza sulle descrizioni del mondo, non sulle singole istanze.

---

##  Posizione nella Logics Pyramid

Ricapitolando:

```
Reasoning Logics     → proposizioni e teorie generali
World Logics         → ragionamento sui modelli del mondo
 ├── LoE (Entities)  → entità e relazioni concrete
 └── LoD (Descriptions) → concetti e relazioni astratte
World Models         → rappresentazioni del mondo
```

👉 La **LoD** si colloca **sopra la LoE**:
non ragiona su “Trento” o “Duomo”, ma su “City”, “Church”, “Building” e le loro relazioni concettuali.

---

## Dal mondo concreto al mondo concettuale

* **LoE**: “Duomo è una Chiesa”, “Duomo è in Piazza Duomo”.
* **LoD**: “Ogni Chiesa è un Edificio che ha un campanile.”

💡 La LoE deduce nuovi **fatti**,
la LoD deduce nuove **proprietà generali o relazioni tra tipi**.

---

## Definizione generale di LoD

Una **LoD (Logic of Descriptions)** è una *world logic* in cui le assertions riguardano **descrizioni generali** del dominio, non istanze.

Formalmente:
$$
L_D = ⟨W, ⊨_D⟩
$$

dove:

* **W** = il world model dei tipi (Etype Graph),
* **⊨_D** = la relazione di entailment per le descrizioni (regole logiche sui tipi).

---

## Cosa rappresenta la LoD

La LoD lavora su **assertions generali** come:

```
Church ⊑ Building ⊓ hasBellTower
City ⊑ Location
River ⊑ FlowingBodyOfWater
```

e permette di **dedurre** nuovi concetti o relazioni:

```
Cathedral ⊑ Church
⇒ Cathedral ⊑ Building ⊓ hasBellTower
```

👉 È il livello logico che “espande” la conoscenza concettuale, partendo da regole di inclusione (⊑), intersezione (⊓), e disgiunzione (⊔).

---

## Linguaggio logico della LoD

Le assertions LoD si costruiscono con operatori logici concettuali:

| Simbolo | Significato                       | Esempio                               |
| ------- | --------------------------------- | ------------------------------------- |
| ⊑       | *inclusione concettuale* (“is-a”) | `Church ⊑ Building`                   |
| ⊓       | *intersezione (and)*              | `Mother ⊑ Woman ⊓ Parent`             |
| ⊔       | *unione (or)*                     | `Person ⊑ Man ⊔ Woman`                |
| ¬       | *negazione*                       | `Woman ⊑ ¬Man`                        |
| ∃R.C    | *esistenza di una relazione*      | `Church ⊑ ∃hasBellTower.BuildingPart` |
| ∀R.C    | *universalità di una relazione*   | `Parent ⊑ ∀hasChild.Person`           |

💡 Questi operatori derivano dalle **Description Logics (DL)**,
il fondamento teorico dei moderni sistemi di **ontologie (es. OWL, RDF, Protégé)**.

---

## Esempio pratico

### Assertions (LoD Language):

```
Church ⊑ Building ⊓ ∃hasBellTower.Tower
Cathedral ⊑ Church
```

### Entailment (inferenze dedotte):

```
Cathedral ⊑ Building
Cathedral ⊑ ∃hasBellTower.Tower
```

👉 Queste nuove relazioni vengono “derivate” automaticamente grazie alle regole di LoD.

---

## World Entailment nella LoD

Come per LoE, l’entailment della LoD stabilisce se un concetto o una relazione è *vera nel modello*:

```
M ⊨ Church ⊑ Building
```

significa: nel modello del mondo, tutte le istanze di “Church” sono anche istanze di “Building”.

---

## LoE vs LoD: confronto diretto

| Aspetto              | **LoE (Logic of Entities)**                     | **LoD (Logic of Descriptions)**          |
| -------------------- | ----------------------------------------------- | ---------------------------------------- |
| **Dominio**          | entità e istanze reali                          | concetti e tipi                          |
| **Esempio**          | `Church(Duomo)`                                 | `Church ⊑ Building ⊓ hasBellTower`       |
| **Risultato**        | nuovi fatti su oggetti concreti                 | nuove relazioni tra concetti             |
| **Inferenza tipica** | transitività di “isIn”, attributi delle istanze | ereditarietà e inclusione concettuale    |
| **Stato di verità**  | True / False / IDK                              | Vero o non derivabile                    |
| **Finalità**         | ragionamento sui dati                           | ragionamento sulle strutture concettuali |

---

## Ereditarietà concettuale

La LoD formalizza la **propagazione delle proprietà** lungo la gerarchia dei concetti:

Esempio:

```
Building ⊑ PhysicalObject
Church ⊑ Building ⊓ hasBellTower
Cathedral ⊑ Church
```

⇒ per transitività:

```
Cathedral ⊑ PhysicalObject
```

💡 Questo è il principio logico che consente di costruire **ontologie coerenti**: ogni sotto-concetto eredita tutte le proprietà dei suoi antenati.

---

## Proprietà delle LoD (come World Logic)

| Proprietà                | Descrizione                                                           |
| ------------------------ | --------------------------------------------------------------------- |
| **Transitività**         | se A ⊑ B e B ⊑ C, allora A ⊑ C                                        |
| **Monotonia**            | aggiungere conoscenza non riduce ciò che è vero                       |
| **Soddisfacibilità**     | ogni concetto deve avere almeno un modello possibile                  |
| **Completezza parziale** | non tutte le relazioni sono note (ci può essere IDK)                  |
| **Consistenza**          | nessun concetto può essere contemporaneamente disgiunto e sovrapposto |

---

## LoD come base dei linguaggi ontologici

La LoD è la logica che sta dietro:

* **OWL (Web Ontology Language)**
* **Description Logics (DL)**
* **Knowledge Graph reasoners** (es. HermiT, FaCT++, Pellet)

👉 Tutti questi sistemi implementano il tipo di inferenza che la LoD descrive formalmente.

---

## Concetti chiave

| Termine                         | Significato                                          |
| ------------------------------- | ---------------------------------------------------- |
| **LoD (Logic of Descriptions)** | logica che ragiona su concetti, non su istanze       |
| **⊑ (is-a)**                    | inclusione concettuale (“ogni A è un B”)             |
| **⊓, ⊔, ¬**                     | operatori logici per combinare concetti              |
| **∃R.C / ∀R.C**                 | esistenza e universalità delle relazioni             |
| **Transitività**                | ereditarietà di relazioni logiche                    |
| **Monotonia**                   | aggiungere conoscenza non elimina verità precedenti  |
| **Ereditarietà concettuale**    | propagazione automatica delle proprietà              |
| **World Entailment (⊨)**        | verifica della verità di una descrizione nel modello |
| **Consistency**                 | assenza di contraddizioni tra concetti               |
| **Description Logic (DL)**      | base teorica della LoD                               |

---

## 📚 **In sintesi**

- [[2025-10-16 H2PT - LOD.pdf]]
La **LoD (Logic of Descriptions)** estende la LoE passando:

* dagli **oggetti concreti (entità)** ai **concetti astratti (tipi)**,
* dalle **relazioni osservabili** alle **regole generali del mondo**,
* dal **dato** alla **semantica**.

È la logica che consente a un sistema di conoscenza (umano o artificiale) di:

* comprendere cosa significa “essere una chiesa”,
* collegare concetti con relazioni (isa, part-of, ecc.),
* e dedurre nuove verità generali.

👉 Il prossimo modulo (📄 *2025-10-17.bis – T2MP: LoE.pdf*) ti farà vedere come la logica delle entità (LoE) viene **implementata in senso inverso**:
cioè come **da teorie logiche si può ricostruire la percezione** nel percorso *Theories → Models → Perception (T2MP)*.

---
