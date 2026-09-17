---
date: 2025/10/27
tags:
Materia: "[[Logica Computazionale]]"
---
# 🧠 Definizioni Fondamentali di Logica Computazionale

## **1. Linguaggio**

**Definizione $Language$**
Un linguaggio $L$ è definito come:
$$
L = \langle A, FR \rangle = {s}
$$
dove:

* $A$: alfabeto **insieme di simboli o concetti**
* $FR$: regole di formazione **formation rules**
* ${s}$: l’insieme di tutte le **frasi** o **asserzioni** generabili applicando $FR$ ai simboli di $A$.


---

## **2. Dominio**

**Definizione $Domain$**
$$
D = \langle U, {C}, {R} \rangle
$$
dove:

* $U = {u}$: universo di interpretazione **insieme delle unità**
* ${C}$: insieme di **classi** **es. tipi di entità o dati**
* ${R}$: insieme di **relazioni binarie** tra unità, con $R_i \subseteq U \times U$

---

## **3. Funzione di Interpretazione**

**Definizione $Interpretation Function$**
$$
I_a : L_a \to D
$$
La funzione di interpretazione associa ogni **asserzione linguistica** $a \in L_a$ a un **fatto** $f\in D$.
Si scrive:
$$
f = I_a(a) = a^I
$$
per indicare che $a$ è la descrizione linguistica del fatto $f$.


**Osservazioni:**

* È **non ambigua** *una asserzione ha un solo significato*.
* È **totale** *ogni elemento del linguaggio ha un’interpretazione*.
* Non è necessariamente **suriettiva** *non tutti i fatti del dominio sono descrivibili*.


---

## **4. Correttezza e Completezza del Linguaggio**

**Definizione *Language correctness and completeness***
Dato $L_a$ e $D$ e una funzione di interpretazione $I_a : L_a \to D$:

* **Correttezza:** se per ogni $a \in L_a$ , $I_a (a)= f \in D$, allora $L_a$ è corretto rispetto a $D$.
* **Completezza:** se per ogni $f \in D$, esiste $a \in L_a$ tale che $I_a(a)= f$, allora $L_a$ è completo rispetto a $D$.


---

## **5. Teoria e Modello**

**Definizione $Theory and Model$**

* Una **teoria** $T_a \subseteq L_a$ è un insieme di asserzioni.
* Un **modello** $M = {f} \subseteq D$ è un insieme di fatti che rendono vere le asserzioni di $T_a$.
  Un modello è detto **inteso** $intended model$ se rappresenta la situazione reale che la teoria vuole descrivere.


---

## **6. Entailment $Conseguenza logica / Mondo$**

**Definizione $World Entailment$**
$$
M \models_{L_a} T_a
$$
con $\models_{L_a} \subseteq D \times L_a$ tale che
$M$ è modello di $T_a$ se e solo se ogni asserzione di $T_a$ è vera in $M$.
Si scrive semplicemente $M \models T_a$.


**Intuizione:**
La relazione di entailment permette di dedurre **nuove asserzioni vere** a partire da ciò che è già noto.

---

## **7. World Logic**

**Proposizione $World Logic$**
Dato un modello del mondo $ W' = \langle L_a', D', I_a' \rangle $, la corrispondente logica del mondo è:
$$
L_W = \langle W, \models_W \rangle
$$
dove $ W = \langle L_a, D, I_a \rangle $ e $ L_a' \subseteq L_a, D' \subseteq D, I_a' \subseteq I_a $.


---

## **8. Logic of Entities $LoE$**

**Definizione $LoE$**
$$
LoE = \langle EG, \models_{LoE} \rangle
$$
con $ EG = \langle L_{LoE}, D_{LoE}, I_{LoE} \rangle $
dove:

* $ L_{LoE} $: linguaggio delle entità
* $ D_{LoE} $: dominio delle entità
* $ I_{LoE} $: funzione di interpretazione LoE


---

## **9. Logic of Descriptions $LoD$**

**Definizione $LoD$**
$$
LoD = \langle ETG, \models_{LoD} \rangle
$$
con
$ ETG = \langle L_{LoD}, D, I_{LoD} \rangle $
La LoD è la logica che descrive **i tipi di entità $etypes$**, **le proprietà**, e **le relazioni** tra tipi, non tra singole istanze.


---

## **10. Linguaggi LoD**

### **a. Linguaggio dei percetti di tipo $etype percepts$**

$$
L_T = \langle A_T, FR_T \rangle = {p_T}
$$

* $ A_T $: alfabeto per i percetti di tipo
* $ FR_T $: regole di formazione


### **b. Linguaggio dei percetti di tipo composito $composite etype percepts$**

$$
L_C = \langle A_C, FR_C \rangle = {p_C}
$$

* $\sqcap$: intersezione
* $\sqcup$: unione
* $\neg$: complemento


---

## **11. Descrizioni ed Equivalenze $LoD$**

**Definizione $LoD Description$**
$$
a_{LoD} ::= p_C \sqsubseteq p_C ;|; p_C \equiv p_C
$$

* ⊑ → *subsumption* $“is-a”$
* ≡ → *equivalence* $“same as”$


**Esempio:**
$$
Human \sqsubseteq Adult \sqcup Child
$$
$$
Driver \equiv Human \sqcap \exists controls.Vehicle
$$

---

## **12. Disjointness**

**Definizione $Etype Disjointness$**
$$
E_1 \sqsubseteq \neg E_2 \quad \text{oppure} \quad E_1 \perp E_2
$$
Significa che i due tipi non condividono alcuna istanza.


---

## **13. Entità e Tipi**

**Definizione $Data type, Entity type$**

* Un **etype** è una classe di entità $es. *Person*, *City*$
* Un **dtype** è una classe di valori $es. *Integer*, *String*$


---

## **14. Ontologia**

**Definizione $Ontology$**
Una **ontologia** è un grafo di concetti $Concept Graph$ che rappresenta le relazioni di inclusione e disgiunzione tra concetti del mondo reale.
È anche chiamata *language model* o *top-level ontology*.


---

## **15. World Model**

**Definizione $World Model$**
$$
W = \langle L_a, D, I_a \rangle
$$
È un modello del mondo che definisce:

* un linguaggio $ L_a $
* un dominio $ D $
* una funzione di interpretazione $ I_a $


---

# 📘 Riepilogo logiche principali

| Livello | Logica                | Cosa rappresenta                          | Esempio                          |
| ------- | --------------------- | ----------------------------------------- | -------------------------------- |
| **LoE** | Logic of Entities     | Entità e relazioni tra istanze            | `Student$Mario$`                 |
| **LoD** | Logic of Descriptions | Tipi di entità, relazioni e restrizioni   | `Driver ≡ Human ⊓ ∃controls.Car` |
| **LoW** | World Logic           | Entailment tra teoria e modello del mondo | `M ⊨ T`                          |

---

Vuoi che ti generi anche la **versione “flashcard Quizlet”** $termine – definizione$ basata su queste definizioni?
