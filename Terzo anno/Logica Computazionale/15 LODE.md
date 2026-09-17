---
date: 2025/11/04
tags:
Materia: "[[Logica Computazionale]]"
---
## LoDE – The Logic of Entity Bases (EBs)

-   la logica che integra linguaggio, conoscenza e mondo — è la base dei **Knowledge Graph (KG)** più completi e “intelligenti”.

---

## 1. Cos’è la LoDE

La **LoDE (Logic of Entity Bases)** è la logica che:

* **unifica** le tre logiche precedenti:
  🔹 *LoC* → linguaggio e significati (concetti)
  🔹 *LoD* → conoscenza e descrizioni (tipi)
  🔹 *LoE* → realtà e fatti (entità)
* rappresenta e gestisce la conoscenza in modo **integrato** e **ragionabile**;
* costituisce la base logica dei **sistemi di conoscenza artificiale** (AI semantica, basi di conoscenza, knowledge graphs, sistemi esperti).

💡 È quindi la logica che **formalizza il funzionamento interno di una “Entity Base” (EB)**, cioè una base di conoscenza che rappresenta il mondo.

---

## 2. Perché serve una logica delle Entity Bases

* I sistemi che ragionano sul mondo (AI, ontologie, basi di dati semantiche) devono **collegare parole, concetti e fatti reali**.
  LoDE è la logica che rende questo possibile.

* Mentre la **LoE** descrive solo fatti e relazioni,
  la **LoDE**:

  1. include il **significato delle parole** (LoC),
  2. include le **definizioni e vincoli concettuali** (LoD),
  3. collega tutto questo con i **fatti concreti** (LoE).

---

## 3. Componenti di una Entity Base (EB)

Un’Entity Base è composta da tre parti fondamentali:

| Simbolo | Componente   | Descrizione                                 | Logica corrispondente |
| ------- | ------------ | ------------------------------------------- | --------------------- |
| **L**   | Lexicon      | il linguaggio e il significato delle parole | LoC                   |
| **T**   | Teleontology | la conoscenza e le definizioni dei tipi     | LoD                   |
| **A**   | Assertions   | i fatti e le relazioni concrete             | LoE                   |

Quindi:

```
EB = <L, T, A>
```

➡️ Le **Entity Bases (EB)** sono le basi di conoscenza più ricche, che permettono di ragionare:

* sul linguaggio (come le parole significano),
* sulla conoscenza (come le cose sono collegate),
* sul mondo reale (come le cose esistono e interagiscono).

---

## 4. Definizione formale

```
LoDE = ⟨EGLoDE, ⊨LoDE⟩
```

con:

```
EGLoDE = ⟨LLoDE, DLoDE, ILoDE⟩
```

dove:

* **LLoDE** = linguaggio della logica (parole, regole);
* **DLoDE** = dominio (insieme di entità, tipi, relazioni);
* **ILoDE** = funzione di interpretazione (collega simboli e fatti);
* **⊨LoDE** = relazione di *entailment* (deduzione logica).

---

## 5. Come nasce la LoDE: composizione di logiche

La LoDE si costruisce unendo tre logiche:

```
LoE = ⟨EGLoE, ⊨LoE⟩     → entità e fatti
LoD = ⟨ETGLoD, ⊨LoD⟩     → tipi e descrizioni
LoC = ⟨CGLoC,  ⊨LoC⟩     → concetti e linguaggio
```

👉 La LoDE eredita:

* la struttura (grafica) da LoE,
* la conoscenza (schematica) da LoD,
* il significato (semantico) da LoC.

---

## 6 Domini e universi della LoDE

### 🔸 **Dominio**

```
D = <U, {C}, {R}>
```

dove:

* `U` = universo (tutte le unità del mondo: entità e valori),
* `{C}` = classi (etypes e dtypes),
* `{R}` = relazioni (oggetto e dati).

LoDE condivide **lo stesso dominio di LoE**, ma è più ricca perché collega anche i livelli LoD e LoC.

### 🔸 **Universo**

```
U = E ∪ V
```

* `E`: entità (oggetti reali o concettuali);
* `V`: valori (numeri, testi, date, coordinate...);
* `{E}` e `{V}` sono disgiunti.

---

## 7. Classi e relazioni

### Classi:

```
{C} = ET ∪ DT
```

* `ET`: insieme dei tipi di entità (`Person`, `City`, `River`);
* `DT`: insieme dei tipi di dati (`Integer`, `String`, `Date`).

### Relazioni:

```
{R} = OR ∪ AR
```

* `OR`: relazioni tra entità (`livesIn`, `worksAt`);
* `AR`: attributi o proprietà di dati (`age`, `name`).

👉 Tutte queste derivano da LoD e sono collegate ai concetti di LoC.

---

## 8. 🔤 **Linguaggio e alfabeto**

### Linguaggio:

```
Lₐ = <Aₐ, FRₐ> = {a}
```

* **Aₐ**: alfabeto delle asserzioni,
* **FRₐ**: regole di formazione (BNF),
* `{a}`: insieme di tutte le asserzioni formabili.

### Alfabeto:

```
Aₐ = <E, {T}, {P}>
```

* `E`: nomi di entità e valori;
* `{T}`: tipi (etypes e dtypes);
* `{P}`: proprietà (oggetto e dati).

---

## 9. 🧩 **BNF della LoDE**

Come LoE, ma estesa con LoD e LoC:

```
<aLoDE> ::= <aLoE> | <aLoD> | <aLoC>

<aLoE> ::= <etype>(<entity>)
          | <dtype>(<value>)
          | <objProp>(<entity>, <entity>)
          | <dataProp>(<entity>, <value>)

<aLoD> ::= <defEtype> ⊑ <pC> | <defEtype> ≡ <pC>
```

Significato:

* `<defEtype>` → tipo definito in LoD o concetto LoC;
* `<pC>` → composizione di etypes.

---

## 10. 🔎 **Interpretazione**

La **funzione di interpretazione ILoDE** collega simboli linguistici e fatti:

```
I : L → D
I = <IE, ID, IO, IA>
```

* `IE` → interpreta tipi di entità,
* `ID` → interpreta tipi di dati,
* `IO` → interpreta proprietà tra entità,
* `IA` → interpreta attributi tra entità e valori.

---

## 11. 🧠 **Esempio pratico**

### Linguaggio:

```
Person(Mario)
City(Trento)
livesIn(Mario, Trento)
age(Mario, 27)
```

### Interpretazione:

* `Mario` → entità reale;
* `Trento` → città;
* `livesIn` → relazione tra persona e città;
* `age` → attributo con valore numerico.

La LoDE consente di inferire anche:

```
Entity(Mario)
Entity(Trento)
Integer(27)
```

perché eredita da LoE, LoD e LoC.

---

## 12. ⚖️ **Entailment (⊨LoDE)**

La relazione di entailment permette di dedurre nuovi fatti combinando conoscenza e linguaggio:

* Se `Student ⊑ Person` (da LoD)
* e `Student(Mario)` (da LoE)
  👉 allora `Person(Mario)` è deducibile in LoDE.

💡 L’entailment in LoDE unisce:

* la semantica concettuale di LoC,
* le regole di tipo di LoD,
* i fatti concreti di LoE.

---

## 13. 🧩 **Ben formatezza**

Un **Entity Graph (EG)** è ben formato se:

* ogni nodo rappresenta una sola entità o valore;
* ogni nodo ha un solo etype o dtype;
* ogni arco ha una sola proprietà;
* i tipi e i dati sono coerenti con i concetti;
* non partono archi dai valori (solo dalle entità).

---

## 14. 🧭 **Concetti chiave**

| Termine                | Significato                                                    |
| ---------------------- | -------------------------------------------------------------- |
| **EB (Entity Base)**   | Base di conoscenza integrata su linguaggio, conoscenza e mondo |
| **LoDE**               | Logica più espressiva che unifica LoC, LoD, LoE                |
| **L (Lexicon)**        | linguaggio e significato (LoC)                                 |
| **T (Teleontology)**   | conoscenza concettuale (LoD)                                   |
| **A (Assertions)**     | fatti concreti (LoE)                                           |
| **Entity Graph (EG)**  | rappresentazione grafica di LoE                                |
| **Teleontology (TLO)** | schema di conoscenza (LoD)                                     |
| **Concept Graph (CG)** | base linguistica (LoC)                                         |
| **Entailment (⊨)**     | deduzione logica multi-livello                                 |

---

## In sintesi

La **LoDE (Logic of Entity Bases)**:

* è la **più potente e completa** logica del ciclo HP2T;
* integra le logiche del linguaggio (LoC), della conoscenza (LoD) e delle entità (LoE);
* è la base teorica per costruire **knowledge graphs semantici** e **motori di ragionamento**;
* unisce linguaggio, conoscenza e percezione in un unico modello coerente.

> In una frase:
> **La LoDE è la logica che connette il significato (LoC), la conoscenza (LoD) e la realtà (LoE) — il fondamento delle intelligenze artificiali basate sulla conoscenza.**

---

Vuoi che ti prepari un **diagramma finale che riassume l’intero ciclo HP2T (LoC → LoD → LoE → LoDE)** con le relazioni tra linguaggio, conoscenza e mondo?
