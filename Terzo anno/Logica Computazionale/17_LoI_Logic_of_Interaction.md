---
date: 2025/12/18
tags:
Materia: "[[Logica Computazionale]]"
pdf: "[[2025-11-20.21.25 HP2T - LOI.pdf]]"
---
## 17 LoI - Logic of Interaction (First-Order Logic)

LoI (Logic of Interaction), anche nota come **First-Order Logic (FOL)**, è una Language Logic che estende LoP aggiungendo variabili e quantificatori per esprimere proprietà generali sugli individui del dominio.

---

## Posizione nella piramide HP2T

```
Perception → Conceptualization → Understanding → Reasoning
                                      (LoDE)      (LoP, LoI)
```

**LoI opera al livello Reasoning**, insieme a LoP, ma con maggiore espressività:

| Logica | Opera su | Espressività |
|--------|----------|--------------|
| LoE, LoD, LoC | Assertions/Facts | Fatti specifici |
| LoP | Propositions | Connettivi booleani |
| LoI | Propositions + Quantification | Variabili, ∀, ∃ |

---

## Motivazione: Perché serve LoI?

### Limiti di LoP

**Problema 1: LoP non può quantificare**

Con dominio D = {Mario, Lucia, Paolo}, per dire "tutti frequentano Logica":
```
LoP: P₁ ∧ P₂ ∧ P₃  (dove Pᵢ = "i frequenta Logica")
```

⚠️ Se il dominio cambia (aggiungi Anna), devi riscrivere TUTTA la formula!

**Con LoI**:
```
∀x.Attend(x, Logic)
```
Funziona per qualsiasi dominio!

**Problema 2: LoP non può esprimere relazioni tra individui variabili**

LoP NON può dire:
- "Esiste qualcuno che è amico di Mario"
- "Ogni studente ha almeno un docente"  
- "Se qualcuno frequenta Logica, allora deve sostenere l'esame"

**Con LoI**:
```
∃y.Friend(y, Mario)
∀x.Student(x) ⊃ ∃d.Teacher(d) ∧ Teaches(d, x)
∀x.Attend(x, Logic) ⊃ MustTakeExam(x)
```

---

## LoI vs LoD: Differenza cruciale

**LoD** (Logic of Descriptions):
```
Person ⊑ LivingBeing
∃HasChild.Person
```
Opera sui **CONCETTI** (tipi, classi astratte) - Reasoning TERMINOLOGICO

**LoI** (Logic of Interaction):
```
∀x.Person(x) ⊃ LivingBeing(x)
∃x.HasChild(x, y) ∧ Person(y)
```
Opera sugli **INDIVIDUI** (istanze concrete) - Reasoning ASSERTIONALE

👉 **LoI è più vicina a LoE che a LoD!** Quantifica sugli stessi individui di LoE (Mario, Lucia...), non sui concetti.

---

## Sintassi di LoI

### Alfabeto

**Variabili**: x, y, z, x₁, x₂, ...
- Rappresentano individui NON specificati
- Possono essere legate (sotto quantificatore) o libere

**Costanti**: Mario, Lucia, Trento, Logic, ...
- Individui SPECIFICI del dominio

**Predicati**: P(x), Friend(x,y), Attend(x,c), ...
- Proprietà (arità 1): Person(x), Student(x)
- Relazioni (arità n>1): Friend(x,y), Teaches(x,y,z)

**Funzioni**: f(x), father(x), age(x), ...
- Mappano individui ad individui
- Esempio: father(Mario) restituisce un individuo

**Quantificatori**:
- ∀ (per ogni, universale)
- ∃ (esiste, esistenziale)

**Connettivi logici**: ¬, ∧, ∨, ⊃, ≡, ⊕
- Gli stessi di LoP!

---

### Termini (things)

```
t ::= x                    (variabile)
    | c                    (costante)
    | f(t₁, ..., tₙ)       (funzione applicata a termini)

Esempi:
- x
- Mario
- father(Mario)
- father(father(x))
- age(Mario)
```

---

### Formule atomiche

```
P(t₁, ..., tₙ)

Esempi:
- Person(x)
- Friend(Mario, y)
- Attend(x, Logic)
- OlderThan(father(x), x)
- Student(father(father(Mario)))
```

---

### Formule ben formate (wff)

```
φ ::= P(t₁, ..., tₙ)           (atomica)
    | ¬φ                        (negazione)
    | φ ∧ φ                     (congiunzione)
    | φ ∨ φ                     (disgiunzione)
    | φ ⊃ φ                     (implicazione)
    | φ ≡ φ                     (equivalenza)
    | ∀x.φ                      (quantificatore universale)
    | ∃x.φ                      (quantificatore esistenziale)
```

**Precedenza operatori** (dal più stretto al più largo):
1. ¬
2. ∧, ∨
3. ⊃, ≡
4. ∀, ∃

---

## Variabili: libere vs legate

**Variabile LEGATA**: sotto scope di un quantificatore  
**Variabile LIBERA**: NON sotto scope di un quantificatore

### Esempi

```
∀x.Person(x) ∧ Friend(x, y)
     ↑ legata       ↑ LIBERA!

∃y.Friend(x, y)
         ↑ LIBERA   ↑ legata

∀x.∃y.Friend(x, y)
         ↑ ↑ entrambe legate

∀x.(Person(x) ⊃ ∃y.Friend(x, y) ∧ Student(y))
      ↑ legata    ↑ legata         ↑ legata
```

### Sentence (formula chiusa)

**Sentence** = formula senza variabili libere

```
✓ ∀x.Person(x) ⊃ LivingBeing(x)     (sentence)
✗ Person(x) ⊃ LivingBeing(x)        (NON sentence, x libera)
✓ ∃x∃y.Friend(x, y)                 (sentence)
✗ ∀x.Friend(x, y)                   (NON sentence, y libera)
```

⚠️ **Solo le sentences hanno valore di verità definito!** Una formula con variabili libere è ambigua.

---

## Semantica: Domini e Interpretazioni

### Dominio D

**Dominio D** = insieme finito di individui (nel nostro corso, focus su domini finiti)

```
D = {Mario, Lucia, Paolo, Trento, Logic}
```

---

### Interpretazione I

**Interpretazione I**: assegna significato ai simboli non logici

Per ogni **predicato** P di arità n:
```
P^I ⊆ D^n    (insieme di n-tuple che soddisfano P)

Esempio con D = {Mario, Lucia, Paolo}:

Person^I = {Mario, Lucia, Paolo}
City^I = {Trento}
Student^I = {Mario, Lucia}
Professor^I = {Paolo}
Attend^I = {(Mario, Logic), (Lucia, Logic)}
Friend^I = {(Mario, Lucia), (Lucia, Mario), (Mario, Paolo)}
```

Per ogni **funzione** f di arità n:
```
f^I : D^n → D    (funzione totale)

Esempio:
father^I = {(Mario, Giovanni), (Lucia, Paolo), (Paolo, Antonio)}
```

Per ogni **costante** c:
```
c^I ∈ D

Esempio:
Mario^I = Mario
Logic^I = Logic
```

---

### Assignment (valutazione) α

**Assignment α**: assegna valori del dominio alle variabili

```
α : Variabili → D

Esempio:
α(x) = Mario
α(y) = Lucia
α(z) = Paolo
```

**Notazione**: α[x:=d] significa "α modificata assegnando d alla variabile x"

```
Se α(x) = Mario e α(y) = Lucia

Allora α[x:=Paolo] è:
  - (x) = Paolo     ← modificato
  - (y) = Lucia     ← invariato
```

---

## Soddisfacibilità: I,α ⊨ φ

**Quando I,α ⊨ φ?** (Interpretazione I con assignment α soddisfa φ)

### Formule atomiche

```
I,α ⊨ P(t₁, ..., tₙ)  
⟺  
(eval(t₁,α), ..., eval(tₙ,α)) ∈ P^I
```

Dove `eval(t,α)` valuta il termine t:
- `eval(x, α) = α(x)`
- `eval(c, α) = c^I`
- `eval(f(t₁,...,tₙ), α) = f^I(eval(t₁,α), ..., eval(tₙ,α))`

**Esempio**:
```
I,α ⊨ Attend(x, Logic)  
⟺  
(α(x), Logic) ∈ Attend^I

Se α(x) = Mario e (Mario, Logic) ∈ Attend^I
Allora I,α ⊨ Attend(x, Logic) ✓
```

---

### Connettivi logici

```
I,α ⊨ ¬φ          ⟺  I,α ⊭ φ
I,α ⊨ φ ∧ ψ       ⟺  I,α ⊨ φ  E  I,α ⊨ ψ
I,α ⊨ φ ∨ ψ       ⟺  I,α ⊨ φ  O  I,α ⊨ ψ
I,α ⊨ φ ⊃ ψ       ⟺  I,α ⊭ φ  O  I,α ⊨ ψ
I,α ⊨ φ ≡ ψ       ⟺  (I,α ⊨ φ ⟺ I,α ⊨ ψ)
```

---

### Quantificatore universale ∀

```
I,α ⊨ ∀x.φ  
⟺  
Per OGNI d ∈ D: I,α[x:=d] ⊨ φ
```

**In altre parole**: φ deve essere vera per TUTTE le possibili sostituzioni di x con elementi del dominio.

**Espansione su dominio finito** D = {a, b, c}:
```
∀x.φ(x)  ≡  φ(a) ∧ φ(b) ∧ φ(c)
```

---

### Quantificatore esistenziale ∃

```
I,α ⊨ ∃x.φ  
⟺  
Esiste ALMENO UN d ∈ D: I,α[x:=d] ⊨ φ
```

**In altre parole**: φ deve essere vera per ALMENO UNA sostituzione di x con un elemento del dominio.

**Espansione su dominio finito** D = {a, b, c}:
```
∃x.φ(x)  ≡  φ(a) ∨ φ(b) ∨ φ(c)
```

---

## Esempi concreti di valutazione

### Setup del mondo

**Dominio**:
```
D = {Mario, Lucia, Paolo}
```

**Interpretazione**:
```
Student^I = {Mario, Lucia}
Professor^I = {Paolo}
Attend^I = {(Mario, Logic), (Lucia, Logic)}
Friend^I = {(Mario, Lucia), (Lucia, Mario), (Mario, Paolo)}
```

---

### Esempio 1: ∀x.Student(x) ⊃ Attend(x, Logic)

**Significato**: "Ogni studente frequenta Logica"

**Valutazione**:
```
Devo verificare per OGNI d ∈ D:

d = Mario:
  Student(Mario) ⊃ Attend(Mario, Logic)
  = T ⊃ T = T ✓

d = Lucia:
  Student(Lucia) ⊃ Attend(Lucia, Logic)
  = T ⊃ T = T ✓

d = Paolo:
  Student(Paolo) ⊃ Attend(Paolo, Logic)
  = F ⊃ F = T ✓  (Paolo non è studente, implicazione vacuamente vera)

Risultato: T ∧ T ∧ T = T ✓
```

---

### Esempio 2: ∃x.Professor(x) ∧ Friend(x, Mario)

**Significato**: "Esiste un professore amico di Mario"

**Valutazione**:
```
Cerco ALMENO UN d ∈ D che soddisfi la formula:

d = Mario:
  Professor(Mario) ∧ Friend(Mario, Mario)
  = F ∧ F = F ✗

d = Lucia:
  Professor(Lucia) ∧ Friend(Lucia, Mario)
  = F ∧ T = F ✗

d = Paolo:
  Professor(Paolo) ∧ Friend(Paolo, Mario)
  = T ∧ T = T ✓ TROVATO!

Risultato: F ∨ F ∨ T = T ✓
```

---

### Esempio 3: ∀x.Student(x) ⊃ ∃y.Friend(x, y)

**Significato**: "Ogni studente ha almeno un amico"

**Valutazione doppiamente annidata**:

```
d₁ = Mario (studente):
  Student(Mario) = T
  Devo verificare: ∃y.Friend(Mario, y)
    - y = Mario: Friend(Mario, Mario) = F
    - y = Lucia: Friend(Mario, Lucia) = T ✓ TROVATO!
  ∃y.Friend(Mario, y) = T
  
  Student(Mario) ⊃ ∃y.Friend(Mario, y) = T ⊃ T = T ✓

d₁ = Lucia (studente):
  Student(Lucia) = T
  Devo verificare: ∃y.Friend(Lucia, y)
    - y = Mario: Friend(Lucia, Mario) = T ✓ TROVATO!
  ∃y.Friend(Lucia, y) = T
  
  Student(Lucia) ⊃ ∃y.Friend(Lucia, y) = T ⊃ T = T ✓

d₁ = Paolo (non studente):
  Student(Paolo) = F
  Student(Paolo) ⊃ ∃y.Friend(Paolo, y) = F ⊃ ? = T ✓

Risultato: T ∧ T ∧ T = T ✓
```

---

## Equivalenze dei quantificatori

### Negazione di quantificatori

Queste equivalenze sono **fondamentali**:

```
¬∀x.φ  ≡  ∃x.¬φ
"Non tutti soddisfano φ" = "Esiste almeno uno che non soddisfa φ"

¬∃x.φ  ≡  ∀x.¬φ  
"Non esiste nessuno che soddisfa φ" = "Tutti non soddisfano φ"
```

### Esempi

```
¬∀x.Student(x)           ≡  ∃x.¬Student(x)
"Non tutti sono studenti"   "C'è almeno un non-studente"

¬∃x.Professor(x)         ≡  ∀x.¬Professor(x)
"Non esiste un prof"        "Nessuno è professore"

¬∀x.Friend(x, Mario)     ≡  ∃x.¬Friend(x, Mario)
"Non tutti sono amici di M" "Qualcuno non è amico di M"
```

---

### Spostamento dei quantificatori

```
∀x.∀y.φ  ≡  ∀y.∀x.φ     (l'ordine di ∀ non cambia)
∃x.∃y.φ  ≡  ∃y.∃x.φ     (l'ordine di ∃ non cambia)

MA ATTENZIONE:
∀x.∃y.φ  ≢  ∃y.∀x.φ     (l'ordine di ∀ e ∃ CAMBIA il significato!)
```

**Esempio critico**:
```
∀x.∃y.Friend(x, y)
"Ogni persona ha almeno un amico"

∃y.∀x.Friend(x, y)
"Esiste una persona che è amica di TUTTI"

Queste NON sono equivalenti!
```

---

## Traduzione NL → LoI

### REGOLA D'ORO (cruciale!)

```
∀x → usa ⊃ (implicazione)
∃x → usa ∧ (congiunzione)
```

### Perché?

**Con ∀**:
```
❌ SBAGLIATO: ∀x.Student(x) ∧ Attend(x, Logic)
   Significato: "Tutti sono studenti E tutti frequentano Logic"
   
✅ CORRETTO: ∀x.Student(x) ⊃ Attend(x, Logic)
   Significato: "Se uno è studente, allora frequenta Logic"
```

**Con ∃**:
```
❌ SBAGLIATO: ∃x.Student(x) ⊃ Attend(x, Logic)
   Significato: "Esiste qualcuno tale che se è studente allora frequenta"
   → Sempre vera se c'è un non-studente! (F ⊃ T = T)
   
✅ CORRETTO: ∃x.Student(x) ∧ Attend(x, Logic)
   Significato: "Esiste uno studente che frequenta Logic"
```

---

### Pattern fondamentali

| Linguaggio Naturale | LoI | Note |
|---------------------|-----|------|
| "Tutti gli studenti..." | `∀x.Student(x) ⊃ ...` | Universale + implicazione |
| "Ogni persona che..." | `∀x.Person(x) ⊃ ...` | Stessa cosa |
| "Nessuno..." | `∀x.¬φ(x)` o `¬∃x.φ(x)` | Equivalenti! |
| "Esiste uno studente che..." | `∃x.Student(x) ∧ ...` | Esistenziale + congiunzione |
| "C'è qualcuno che..." | `∃x.Person(x) ∧ ...` | Stessa cosa |
| "Almeno uno..." | `∃x.φ(x)` | Solo esistenziale |
| "Solo gli studenti..." | `∀x.(...) ⊃ Student(x)` | Inverte l'implicazione! |

---

### Esempi pratici (tipo esame)

#### 1. "Ogni studente frequenta almeno un corso"
```
Analisi:
- "Ogni studente" → ∀x con Student(x)
- "frequenta almeno un corso" → ∃y con Course(y) ∧ Attend(x,y)

LoI: ∀x.Student(x) ⊃ (∃y.Course(y) ∧ Attend(x, y))
```

#### 2. "Nessun professore è studente"
```
Opzione 1: ∀x.Professor(x) ⊃ ¬Student(x)
Opzione 2: ¬∃x.Professor(x) ∧ Student(x)

Entrambe corrette ed equivalenti!
```

#### 3. "C'è uno studente che frequenta tutti i corsi"
```
Analisi:
- "C'è uno studente" → ∃x con Student(x)
- "frequenta tutti i corsi" → ∀y.Course(y) ⊃ Attend(x,y)

LoI: ∃x.Student(x) ∧ (∀y.Course(y) ⊃ Attend(x, y))
```

#### 4. "Solo gli studenti frequentano corsi" (TRABOCCHETTO!)
```
Analisi: "solo gli studenti" = "se frequenti un corso, sei studente"

LoI: ∀x.(∃y.Course(y) ∧ Attend(x, y)) ⊃ Student(x)

Oppure: ∀x.∀y.(Course(y) ∧ Attend(x, y)) ⊃ Student(x)
```

#### 5. "Tutti gli amici di Mario sono studenti"
```
LoI: ∀x.Friend(x, Mario) ⊃ Student(x)

Nota: "amici DI Mario" = Friend(x, Mario) con Mario nel secondo argomento
```

#### 6. "Esiste qualcuno che è amico di tutti i professori"
```
LoI: ∃x.∀y.Professor(y) ⊃ Friend(x, y)
```

---

## Cardinalità: "almeno n" e "al massimo n"

### "Almeno n" elementi

**Problema**: ∃x₁.∃x₂.φ(x₁) ∧ φ(x₂) NON garantisce che x₁ ≠ x₂!

**Soluzione**: Aggiungere vincoli di disuguaglianza

#### Almeno 1
```
∃x.φ(x)
```

#### Almeno 2
```
∃x₁.∃x₂.(φ(x₁) ∧ φ(x₂) ∧ x₁ ≠ x₂)
```

#### Almeno n (formula generale)
```
∃x₁...∃xₙ.(⋀ᵢ₌₁ⁿ φ(xᵢ) ∧ ⋀ᵢ≠ⱼ xᵢ ≠ xⱼ)
```

**Esempio**: "Almeno 2 studenti frequentano Logic"
```
∃x₁.∃x₂.(Student(x₁) ∧ Attend(x₁, Logic) ∧ 
         Student(x₂) ∧ Attend(x₂, Logic) ∧ 
         x₁ ≠ x₂)
```

---

### "Al massimo n" elementi

**Idea**: "Se ci sono n+1 elementi che soddisfano φ, almeno 2 devono essere uguali"

#### Al massimo 1
```
∀x₁.∀x₂.(φ(x₁) ∧ φ(x₂)) ⊃ x₁ = x₂
```

#### Al massimo 2
```
∀x₁.∀x₂.∀x₃.(φ(x₁) ∧ φ(x₂) ∧ φ(x₃)) ⊃ (x₁ = x₂ ∨ x₂ = x₃ ∨ x₁ = x₃)
```

#### Al massimo n (formula generale)
```
∀x₁...∀xₙ₊₁.(⋀ᵢ₌₁ⁿ⁺¹ φ(xᵢ)) ⊃ (⋁ᵢ≠ⱼ xᵢ = xⱼ)
```

**Esempio**: "Al massimo 2 studenti frequentano Logic"
```
∀x₁.∀x₂.∀x₃.(Student(x₁) ∧ Attend(x₁, Logic) ∧
              Student(x₂) ∧ Attend(x₂, Logic) ∧
              Student(x₃) ∧ Attend(x₃, Logic)) 
         ⊃ (x₁ = x₂ ∨ x₂ = x₃ ∨ x₁ = x₃)
```

---

### "Esattamente n" elementi

```
"Almeno n" ∧ "Al massimo n"
```

---

## Grounding: LoI → LoP

**Grounding** = processo di eliminare i quantificatori istanziando le variabili con tutti i valori del dominio, ottenendo una formula proposizionale equivalente.

### Processo di grounding

Dato dominio finito **D = {d₁, d₂, ..., dₙ}**:

#### 1. Quantificatore Universale ∀x
```
∀x.φ(x)  
→ 
φ(d₁) ∧ φ(d₂) ∧ ... ∧ φ(dₙ)
```
Diventa una **CONGIUNZIONE** di formule ground.

#### 2. Quantificatore Esistenziale ∃x
```
∃x.φ(x)
→
φ(d₁) ∨ φ(d₂) ∨ ... ∨ φ(dₙ)
```
Diventa una **DISGIUNZIONE** di formule ground.

#### 3. Predicati → Proposizioni atomiche
```
Student(Mario) → P₁
Student(Lucia) → P₂
Attend(Mario, Logic) → P₃
Attend(Lucia, Logic) → P₄
...
```

---

### Esempio completo di grounding

**Setup**:
- Dominio: D = {Mario, Lucia}
- Formula LoI: `∀x.Student(x) ⊃ Attend(x, Logic)`

**PASSO 1**: Espandi ∀x
```
[Student(Mario) ⊃ Attend(Mario, Logic)] 
∧ 
[Student(Lucia) ⊃ Attend(Lucia, Logic)]
```

**PASSO 2**: Crea proposizioni atomiche LoP
```
P₁ = Student(Mario)
P₂ = Student(Lucia)
P₃ = Attend(Mario, Logic)
P₄ = Attend(Lucia, Logic)
```

**PASSO 3**: Formula LoP finale
```
(P₁ ⊃ P₃) ∧ (P₂ ⊃ P₄)
```

Ora puoi valutare questa formula con truth tables di LoP!

---

### Esempio con ∃

**Formula LoI**: `∃x.Student(x) ∧ Attend(x, Logic)`

**Grounding**:
```
[Student(Mario) ∧ Attend(Mario, Logic)] 
∨ 
[Student(Lucia) ∧ Attend(Lucia, Logic)]

→ (P₁ ∧ P₃) ∨ (P₂ ∧ P₄)
```

---

### Esempio con quantificatori annidati

**Formula LoI**: `∃x∃y.Friend(x,y) ∧ x ≠ y`

**Grounding con D = {Mario, Lucia}**:

PASSO 1: Espando ∃x
```
[∃y.Friend(Mario,y) ∧ Mario ≠ y]
∨
[∃y.Friend(Lucia,y) ∧ Lucia ≠ y]
```

PASSO 2: Espando ∃y per ogni caso
```
Caso x=Mario:
  [Friend(Mario, Mario) ∧ Mario ≠ Mario]  ← F ∧ F = F
  ∨
  [Friend(Mario, Lucia) ∧ Mario ≠ Lucia]  ← Friend(Mario,Lucia) ∧ T

Caso x=Lucia:
  [Friend(Lucia, Mario) ∧ Lucia ≠ Mario]
  ∨
  [Friend(Lucia, Lucia) ∧ Lucia ≠ Lucia]  ← F ∧ F = F
```

PASSO 3: Semplifica
```
Friend(Mario, Lucia) ∨ Friend(Lucia, Mario)
```

PASSO 4: Proposizioni LoP
```
P₁ = Friend(Mario, Lucia)
P₂ = Friend(Lucia, Mario)

Formula LoP: P₁ ∨ P₂
```

---

## Collegamenti con altri moduli

### LoI ↔ LoDE

**LoDE** (Understanding): assertions sui fatti
```
Person(Mario#1)
Friend(Mario#1, Lucia#2)
Attend(Mario#1, Logic)
```

**LoI** (Reasoning): regole generali sugli individui
```
∀x.Person(x) ⊃ LivingBeing(x)
∀x∀y.Friend(x,y) ⊃ Friend(y,x)  (simmetria dell'amicizia)
∀x.Student(x) ⊃ ∃y.Course(y) ∧ Attend(x, y)
```

**Processo**: LoI esprime vincoli e regole → Grounding → LoP → Verifiche su assertions LoDE

---

### LoI ↔ LoP

| LoP | LoI |
|-----|-----|
| Proposizioni fisse | Variabili quantificate |
| Connettivi booleani | Connettivi + quantificatori |
| Dominio = {T, F} | Dominio = individui |
| Truth tables | Interpretazioni + assignments |
| SAT solving | Theorem proving |

**Ponte**: Grounding trasforma LoI in LoP per reasoning efficiente su domini finiti

---

### Piramide completa

```
              LoI (First-Order Logic)
               ↓ grounding
              LoP (Propositional Logic)
               ↓ 
         LoDE = LoE + LoD + LoC
               ↓
         Assertions/Facts
```

**LoI** è il livello più espressivo delle Language Logics:
- Quantificazione su individui (∀, ∃)
- Regole generali e universali
- Reasoning su relazioni variabili
- Approssima il linguaggio naturale

**LoP** è meno espressivo ma decidibile:
- No variabili
- Solo connettivi
- Efficiente per reasoning proposizionale

---

## Relazione con T2MP

Nel ciclo inverso **T2MP (Theories → Machine Perception)**:

1. **Teorie LoI**: formule con quantificatori esprimono vincoli
2. **Grounding**: istanzio le variabili su un dominio finito
3. **LoP**: ottengo formule proposizionali
4. **Generazione modelli**: trovo assegnamenti consistenti
5. **LoDE**: creo assertions concrete
6. **Percezione**: mondo istanziato

**Esempio**:
```
Teoria LoI: ∀x.Student(x) ⊃ Attend(x, Logic)
Dominio: D = {Mario, Lucia}

→ Grounding: (Student(Mario) ⊃ Attend(Mario, Logic)) ∧ 
             (Student(Lucia) ⊃ Attend(Lucia, Logic))

→ Modello LoP soddisfacente: {Student(Mario)ᵀ, Attend(Mario, Logic)ᵀ, 
                               Student(Lucia)ᵀ, Attend(Lucia, Logic)ᵀ}

→ LoDE assertions: Student(Mario#1), Attend(Mario#1, Logic), 
                   Student(Lucia#2), Attend(Lucia#2, Logic)
```

---

## Trucchi per l'esame

### Pattern di traduzione rapida

```
"Tutti X sono Y"              → ∀x.X(x) ⊃ Y(x)
"Nessun X è Y"                → ∀x.X(x) ⊃ ¬Y(x)  o  ¬∃x.X(x) ∧ Y(x)
"Esiste un X che è Y"         → ∃x.X(x) ∧ Y(x)
"Solo X sono Y"               → ∀x.Y(x) ⊃ X(x)
"X se e solo se Y"            → ∀x.X(x) ≡ Y(x)
"Ogni X ha almeno un Y"       → ∀x.X(x) ⊃ ∃y.Y(y) ∧ R(x,y)
"C'è un X che ha tutti gli Y" → ∃x.X(x) ∧ ∀y.Y(y) ⊃ R(x,y)
```

---

### Espansione rapida dei quantificatori

Per D = {a, b, c}:

```
∀x.φ(x)  ≡  φ(a) ∧ φ(b) ∧ φ(c)
∃x.φ(x)  ≡  φ(a) ∨ φ(b) ∨ φ(c)

∀x.∀y.φ(x,y)  ≡  φ(a,a) ∧ φ(a,b) ∧ φ(a,c) ∧
                  φ(b,a) ∧ φ(b,b) ∧ φ(b,c) ∧
                  φ(c,a) ∧ φ(c,b) ∧ φ(c,c)

∃x.∃y.φ(x,y)  ≡  φ(a,a) ∨ φ(a,b) ∨ φ(a,c) ∨
                  φ(b,a) ∨ φ(b,b) ∨ φ(b,c) ∨
                  φ(c,a) ∨ φ(c,b) ∨ φ(c,c)
```

---

### Negazione rapida

```
¬∀x.φ  →  ∃x.¬φ    (sposta negazione dentro, cambia ∀ in ∃)
¬∃x.φ  →  ∀x.¬φ    (sposta negazione dentro, cambia ∃ in ∀)
```

---

### Verifica satisfiability rapida (su dominio piccolo)

1. **Espandi tutti i quantificatori** (sostituisci con ∧ e ∨)
2. **Sostituisci predicati con valori T/F** del modello
3. **Calcola booleana** (usa regole LoP)

---

### Grounding rapido

1. **Identifica il dominio D**
2. **Per ogni ∀x**: scrivi φ(d₁) ∧ φ(d₂) ∧ ... ∧ φ(dₙ)
3. **Per ogni ∃x**: scrivi φ(d₁) ∨ φ(d₂) ∨ ... ∨ φ(dₙ)
4. **Rimuovi disuguaglianze** x ≠ y valutandole direttamente

---

## Key Notions

- **LoI (Logic of Interaction)**: First-Order Logic con variabili e quantificatori
- **Variabile**: segnaposto per individui del dominio (x, y, z)
- **Costante**: individuo specifico (Mario, Logic)
- **Predicato**: proprietà o relazione (Person(x), Friend(x,y))
- **Funzione**: mappa individui ad individui (father(x))
- **Quantificatore universale ∀**: "per ogni"
- **Quantificatore esistenziale ∃**: "esiste"
- **Variabile legata**: sotto scope di quantificatore
- **Variabile libera**: non sotto scope di quantificatore
- **Sentence**: formula senza variabili libere
- **Dominio D**: insieme di individui
- **Interpretazione I**: assegna significato a predicati e funzioni
- **Assignment α**: assegna valori alle variabili
- **Grounding**: eliminazione dei quantificatori istanziando le variabili
- **∀ → ∧**: universale diventa congiunzione
- **∃ → ∨**: esistenziale diventa disgiunzione
- **∀x → usa ⊃**: regola d'oro per traduzioni
- **∃x → usa ∧**: regola d'oro per traduzioni

---

## Prossimi step

- **Decision Procedures per LoI**: Theorem proving, resolution, unification
- **T2MP con LoI**: Da formule FOL a modelli LoDE
- **CNF in LoI**: Forma normale per reasoning
- **Skolemization**: Eliminare ∃ per theorem proving

---

## Collegamenti

- [[1_Human_Perception_to_Theories]] - LoI al livello Reasoning
- [[6_Logics_Pyramid]] - LoI al vertice della piramide
- [[16_LoP_Logic_of_Propositions]] - LoP è la versione senza quantificatori
- [[10_LoE]], [[11_LoD]], [[14_LoC]] - LoI ragiona sulle loro assertions
- [[20251211_T2MP__LOI_I2F__DecProcs.pdf]] - Materiale principale su LoI

---
