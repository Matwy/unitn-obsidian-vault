---
date: 2025/10/28
tags:
Materia: "[[Logica Computazionale]]"
Argomento: "[[10 LoE]]"
---
## Livelli di rappresentazione: Informal, Semi-formal e Formal

Nella logica computazionale distinguiamo tre livelli principali di rappresentazione della conoscenza, che differiscono per grado di **formalizzazione**, **ambiguità** e **interpretabità logica**.

### Informal representation

* È la rappresentazione **in linguaggio naturale** (testi, frasi, descrizioni).
* È **comprensibile per l’uomo**, ma **ambigua** e non rigorosa.
* Si basa sul **contesto** e sul **buon senso** per essere interpretata.
* Esempio:

  > “Immanuel Kant was a German philosopher who wrote the *Critique of Pure Reason*.”

### Semi-formal representation

* È una rappresentazione **intermedia** tra linguaggio naturale e logica formale.
* È **strutturata** (spesso grafica o tabellare), ma non ancora completamente formale.
* Riduce l’ambiguità e permette una **traduzione sistematica** verso la forma logica.
* Esempio: un **Knowledge Graph (KG)** con nodi e relazioni:

  ```
  Philosopher(ImmanuelKant)
  livedIn(ImmanuelKant, Germany)
  wrote(ImmanuelKant, CritiqueOfPureReason)
  influenced(ImmanuelKant, Schopenhauer)
  ```
* Permette di collegare concetti con relazioni esplicite come `livedIn`, `wrote`, `influenced`.

### ⚙️ Formal representation

* È una rappresentazione completamente **formalizzata** in un **linguaggio logico** (es. LoE, LoD).
* Ogni elemento del linguaggio ha un significato definito tramite una **funzione di interpretazione** `I : L → D`.
* È **non ambigua**, **verificabile** e può essere **elaborata automaticamente** da un motore logico.
* Esempio:

  ```
  Philosopher(ImmanuelKant)
  ∃wrote.ImmanuelKant(CritiqueOfPureReason)
  livedIn(ImmanuelKant, Germany)
  ```

### Traduzioni tra livelli

* **I2SF (Informal → Semi-formal):** dal linguaggio naturale a una rappresentazione strutturata.
* **SF2F (Semi-formal → Formal):** dal grafo alla logica formale.
* **F2SF / F2I (Formal → Semi-formal / Informal):** traduzioni inverse per spiegare o verificare la teoria.

### Riferimenti

* File: **[[2025-10-14.bis HP2T - LOE.pdf]]**, sezioni *Types of problems* e *I2SF / SF2F*.
* Collegato anche al concetto di *semi-formal world models* nel file **[[2025-10-09 HP2T.bis - World Model types.pdf]]**.