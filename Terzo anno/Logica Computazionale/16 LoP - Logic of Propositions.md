---
date: 2025/12/17
tags:
Materia: "[[Logica Computazionale]]"
pdf: "[[2025-11-14.18 HP2T - LOP.pdf]]"
---
## 16 LoP - Logic of Propositions

LoP (Logic of Propositions) è la logica proposizionale che permette di ragionare su proposizioni composte usando connettivi logici.

---

## Posizione nella piramide HP2T

```
Perception → Conceptualization → Understanding → Reasoning
                                      (LoDE)        (LoP)
```

**LoP opera al livello Reasoning**: ragiona sulla **verità** delle assertions di LoDE, non sui fatti stessi.

| Livello | Logica | Opera su |
|---------|--------|----------|
| Understanding | LoE, LoD, LoC | Fatti/Assertions (`City(Trento)`) |
| Reasoning | LoP, LoI | Proposizioni (`"È vero che City(Trento)"`) |

---

## Motivazione: Limiti di LoDE

LoDE (LoE + LoD + LoC) **non può esprimere**:

1. **Disgiunzione**: ❌ `Color(maglietta, verde) ⊔ Color(maglietta, grigia)`
2. **Negazione**: ❌ `¬City(Milano)`
3. **Implicazioni**: ❌ `SE Fausto dorme ALLORA figli rumorosi`

**LoP risolve questi limiti** aggiungendo connettivi logici per ragionare su proposizioni.

---

## Definizione formale

### Linguaggio
```
L = ⟨A, FR⟩ = {φ}

dove:
- A = alfabeto di proposizioni atomiche {p₁, p₂, ..., pₙ}
- FR = formation rules (regole di formazione)
- φ = proposizione (formula ben formata)
```

### Formation Rules (BNF)
```
⟨φ⟩ ::= ⟨atomic proposition⟩ |
        ¬⟨φ⟩ |                     (negazione)
        ⟨φ⟩ ∧ ⟨φ⟩ |                (congiunzione)
        ⟨φ⟩ ∨ ⟨φ⟩ |                (disgiunzione)
        ⟨φ⟩ ⊃ ⟨φ⟩ |                (implicazione)
        ⟨φ⟩ ≡ ⟨φ⟩ |                (equivalenza)
        ⟨φ⟩ ⊕ ⟨φ⟩                  (XOR)

⟨atomic proposition⟩ ::= p₁ | p₂ | ... | pₙ
```

### Dominio
```
D_LoP = {T, F}

Modello M = {p₁⁺, p₂⁻, p₃⁺, ...} ⊆ D_LoP
```

**Vincolo**: Ogni modello contiene **esattamente una** tra pᵢ⁺ e pᵢ⁻ per ogni proposizione atomica pᵢ.

---

## Collegamento LoDE → LoP

Le **assertions di LoDE** diventano **proposizioni atomiche di LoP**:

```
LoDE assertion:        City(Trento)
LoP atomic props:      C⁺ = "È vero che City(Trento)"
                       C⁻ = "È falso che City(Trento)"
```

**Esempio completo**:
```
EG LoDE:
  Person(Mario#1)
  Person(Lucia#2)
  Friend(Mario#1, Lucia#2)

Proposizioni atomiche LoP:
  P₁ = "È vero che Person(Mario#1)"
  P₂ = "È vero che Person(Lucia#2)"
  F = "È vero che Friend(Mario#1, Lucia#2)"
```

**Conoscenza parziale (IDK)**:
Se in LoDE un fatto è IDK, in LoP generi **modelli multipli**:
```
LoDE: Friend(Mario#1, Paolo#1) = IDK

LoP crea 2 modelli:
- M₁: {F⁺} (il fatto è vero)
- M₂: {F⁻} (il fatto è falso)
```

---

## I 6 connettivi logici

### Truth Table completa

| A | B | ¬A | A ∧ B | A ∨ B | A ⊃ B | A ⊕ B | A ≡ B |
|---|---|----|-------|-------|-------|-------|-------|
| T | T | F  | T     | T     | **T** | F     | T     |
| T | F | F  | F     | T     | **F** | T     | F     |
| F | T | T  | F     | T     | **T** | T     | F     |
| F | F | T  | F     | F     | **T** | F     | T     |

### Dettaglio connettivi

#### 1. Negazione (¬)
```
¬A = "non A"
```
Inverte il valore di verità.

#### 2. Congiunzione (∧)
```
A ∧ B = "A e B"
```
Vera solo quando **entrambe** sono vere.

#### 3. Disgiunzione inclusiva (∨)
```
A ∨ B = "A o B (o entrambi)"
```
Vera quando **almeno una** è vera.

#### 4. Implicazione (⊃)
```
A ⊃ B = "se A allora B" = "A implica B"
```

**Interpretazione**:
- **A è condizione SUFFICIENTE per B**
- **B è condizione NECESSARIA per A**

**Falsa SOLO quando**: A = T e B = F

**Contronominale**: `A ⊃ B ≡ ¬B ⊃ ¬A`

**Esempi**:
- "Se piove, la strada si bagna" → `Piove ⊃ StradaBagnata`
- "Se sei un gatto, sei un mammifero" → `Gatto ⊃ Mammifero`
- "Per laurearti devi passare gli esami" → `Laurea ⊃ PassatoEsami`

#### 5. OR esclusivo (⊕)
```
A ⊕ B = "A o B ma non entrambi"
```
Vera quando A e B hanno **valori diversi**.

**Equivalenza**: `A ⊕ B ≡ ¬(A ≡ B)`

#### 6. Equivalenza (≡)
```
A ≡ B = "A se e solo se B" (iff)
```
Vera quando A e B hanno **lo stesso valore**.

**Equivalenza**: `A ≡ B ≡ (A ⊃ B) ∧ (B ⊃ A)`

---

## Traduzione NL → LoP

### Regole base

| Linguaggio naturale | LoP | Note |
|---------------------|-----|------|
| "A se B" | `B ⊃ A` | B è sufficiente per A |
| "A solo se B" | `A ⊃ B` | B è necessario per A |
| "A se e solo se B" | `A ≡ B` | Condizione necessaria E sufficiente |
| "A a meno che non B" | `A ∨ B` oppure `A ⊕ B` | Dipende dal contesto! |
| "A anche se B" | `A` | B non influisce |

### Varianti dell'implicazione

Tutte queste frasi si traducono con `A ⊃ B`:
- "Se A, allora B"
- "A implica B"
- "A quindi B"
- "B se A"
- "B purché A" / "B a condizione che A"
- "A è condizione sufficiente per B"
- "B è condizione necessaria per A"
- **"B solo se A"** (attenzione: l'ordine si inverte!)

---

## Errori comuni di traduzione

### Errore 1: AND che unisce nomi, non proposizioni

❌ **Sbagliato**:
```
"Bert ed Ernie sono fratelli" → B ∧ E
```

✓ **Corretto**:
```
"Bert ed Ernie sono fratelli" → Fratelli(Bert, Ernie)
```
Proposizione atomica unica, non scomponibile!

### Errore 2: "Unless" ambiguo

**OR inclusivo**:
```
"Vado alla festa a meno che non riceva un'altra offerta"
→ F ∨ O (posso andare anche se ricevo l'offerta)
```

**OR esclusivo**:
```
"Vado alla festa a meno che non ci sia Rufus"
→ F ⊕ R (se c'è Rufus NON vado)
```

### Errore 3: "Even if" = indipendenza

❌ **Sbagliato**:
```
"Vado alla festa anche se Mario non viene" → F ⊃ ¬M
```

✓ **Corretto**:
```
"Vado alla festa anche se Mario non viene" → F
(oppure F ∧ (M ∨ ¬M) per essere espliciti)
```

### Errore 4: Confondere "se" con "solo se"

| Frase | Traduzione | Spiegazione |
|-------|------------|-------------|
| "Vado se Mario viene" | `M ⊃ C` | Mario sufficiente |
| "Vado solo se Mario viene" | `C ⊃ M` | Mario necessario |
| "Vado se e solo se Mario viene" | `C ≡ M` | Equivalenza |

---

## Truth Tables e Reasoning

### Satisfiability
Una formula φ è **soddisfacibile** se esiste almeno un modello M tale che `M ⊨ φ`.

**Esempio**:
```
φ: A ∧ B

| A | B | A ∧ B |
|---|---|-------|
| T | T | **T** |  ← Questo modello soddisfa φ
| T | F | F     |
| F | T | F     |
| F | F | F     |

φ è soddisfacibile (1 modello la rende vera)
```

### Tautologia (Validità)
Una formula φ è una **tautologia** se è vera in **tutti i modelli**.

**Esempio**:
```
φ: A ∨ ¬A  (principio del terzo escluso)

| A | ¬A | A ∨ ¬A |
|---|----|--------|
| T | F  | **T**  |
| F | T  | **T**  |

φ è una tautologia
```

### Insoddisfacibilità
Una formula φ è **insoddisfacibile** se non esiste alcun modello che la rende vera.

**Esempio**:
```
φ: A ∧ ¬A  (contraddizione)

| A | ¬A | A ∧ ¬A |
|---|----|--------|
| T | F  | **F**  |
| F | T  | **F**  |

φ è insoddisfacibile
```

### Logical Entailment

`φ ⊨ ψ` significa: "φ implica logicamente ψ"

**Definizione**: **Tutti** i modelli che soddisfano φ devono anche soddisfare ψ.

**Verifica con truth table**:
```
| A | B | φ | ψ | φ ⊨ ψ? |
|---|---|---|---|---------|
| T | T | T | T | ✓       |
| T | F | T | F | ✗ VIOLA |
| F | T | F | ? | -       |
| F | F | F | ? | -       |
```
Se esiste anche un solo modello dove φ=T e ψ=F, allora φ NON implica ψ.

---

## Proprietà delle logiche

### Correttezza e Completezza (5 livelli)

1. **Language correctness/completeness**: linguaggio ↔ dominio
2. **Interpretation correctness/completeness**: assertions ↔ fatti
3. **Theory correctness/completeness**: teoria ↔ modello
4. **Entailment correctness/completeness**: modello ↔ nuova teoria
5. **Decision procedure correctness/completeness**: teoremi ↔ teoremi calcolabili

---

## Esempi pratici

### Esempio 1: Traduzione complessa
```
NL: "Se David viene alla festa, allora Bruno e Carlo vengono"
LoP: D ⊃ (B ∧ C)
```

### Esempio 2: Condizioni necessarie e sufficienti
```
NL: "Condizione sufficiente per Angelo venire è che Bruno e Carlo non vengano"
LoP: (¬B ∧ ¬C) ⊃ A

NL: "Condizione necessaria e sufficiente per Angelo venire è che Bruno e Carlo non vengano"
LoP: (¬B ∧ ¬C) ≡ A
```

### Esempio 3: Verifica satisfiability
```
φ: a ⊃ (b ⊃ a)

| a | b | (b ⊃ a) | a ⊃ (b ⊃ a) |
|---|---|---------|-------------|
| T | T | T       | T           |
| T | F | T       | T           |
| F | T | F       | T           |
| F | F | T       | T           |

Risultato: φ è una TAUTOLOGIA
```

---

## Relazione con T2MP

Nel ciclo inverso **T2MP (Theories → Machine Perception)**:
- LoP viene usata per **generare mondi possibili** coerenti con teorie proposizionali
- Le formule LoP descrivono **vincoli** che i modelli devono rispettare
- Reasoning proposizionale → istanziazione di scenari coerenti

---

## Key Notions

- **Proposizione atomica**: giudizio sulla verità di un'assertion LoDE
- **Proposizione complessa**: composizione di proposizioni con connettivi
- **Connettivi logici**: ¬, ∧, ∨, ⊃, ≡, ⊕
- **Modello**: assegnazione completa di valori T/F a proposizioni atomiche
- **Soddisfacibilità**: esistenza di almeno un modello
- **Tautologia**: verità in tutti i modelli
- **Entailment logico**: φ ⊨ ψ (tutti i modelli di φ soddisfano ψ)
- **Condizione sufficiente**: antecedente dell'implicazione
- **Condizione necessaria**: conseguente dell'implicazione

---

## Trucchi per l'esame

### Implicazione - Pattern da ricordare
```
A ⊃ B è FALSA solo quando: A=T e B=F
In tutti gli altri casi è VERA
```

### SE vs SOLO SE
```
"A se B"      → B ⊃ A  (freccia da B ad A)
"A solo se B" → A ⊃ B  (freccia da A a B)
"A iff B"     → A ≡ B  (doppia freccia)
```

### XOR rapido
```
A ⊕ B = "valori diversi"
  T ⊕ F = T ✓
  F ⊕ T = T ✓
  T ⊕ T = F ✗
  F ⊕ F = F ✗
```

### Verificare entailment rapidamente
1. Trova tutte le righe dove φ = T
2. Controlla che in TUTTE quelle righe anche ψ = T
3. Se trovi anche solo una riga con φ=T e ψ=F → NO entailment

---

## Collegamenti con altri moduli

- [[1 Human Perception to Theories]] - Reasoning è il livello più alto
- [[5 Theories HP2T]] - LoP formalizza teorie proposizionali
- [[6 Logics Pyramid]] - LoP è al vertice della piramide
- [[Language Logics]] - LoP è una delle due Language Logics (insieme a LoI)
- [[10 LoE]], [[11 LoD]], [[14 LoC]] - LoP ragiona sulle loro assertions

---

## Prossimi step

- **LoI (Logic of Interaction)**: First-Order Logic con variabili e quantificatori
- **CNF (Conjunctive Normal Form)**: Forma normale per reasoning efficiente
- **Decision Procedures**: Algoritmi per verificare satisfiability