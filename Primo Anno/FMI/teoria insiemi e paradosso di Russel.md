---
date: 2024-02-26
tags:
  - insiemi
Materia: "[[FMI]]"
---
# Cenni di teoria degli insiemi
- Intenderemo come primitivi i concetti di **insieme** e di **elemento di un insieme**
- La nozione di appartenenza può esser messa a fondamento di tutta la teoria degli insiemi
 $x\in A$ x appartiene ad A dove x è un elemento e A è un insieme
 $x\notin A$ x appartiene ad A dove x è un elemento e A è un insieme

**OSS** Un insieme può essere un elemento. Un elemento non può essere considerato n insieme.
**ESEMPIO** $X = {1, 2,3}$ $P(x) = \{ \varnothing, \{1\}, \{2\}, \{3\}, \{1, 2\}, \{2, 3\}, \}$
 
La proprietà fondamentale che si richiede per poter parlare di un insieme è la seguente:
Per ogni elemento x dobbiamo essere in grado di stabilire se x appartiene o meno all'insieme assegnato

Ci chiediamo se:
$A=\{x|x\notin x\}$
Dunque $A$ è l'insieme di tutti gli insiemi x tali che $x$ visto come elemento, non appartiene a x visto come insieme.
Poiché $A$ è un insieme per ipotesi, $A$ è anche un elemento.
Dunque  
$A\notin A$ Assurdo 
$A\in A$ Funziona 
$A$ Quindi A non è un insieme

### ASSIOMA 1.1 (Estensionalità)
Dati due insiemi $A$ e $B$ vale:
$A= B <=> \forall x: x\in A <=> x\in B$

### DEF 1.5 Siano X e Y due insiemi Scriveremo:
$X\subset Y$  oppure $Y \supset X$ $(\forall x\,|\, x \in X => x \in Y)$
Allora si dice che $X$ è un sottoinsieme di $Y$

Inoltre se $X\subset Y$ e $X\neq Y$ allora si dice che $X$ è un sottoinsieme di proprio e si scrive $X \subsetneq Y$  e $Y\supsetneq X$ si dice **contenuto strettamente**

### ASSIOMA 1.6 (Di separazione)
Sia $X$ un insieme.
Supponiamo che ad ogni $x\in X$ sia associata una affermazione $P(x)$ 
Allora $\{x| x\in X, P(x) vera \} = \{x\in X \} P(x)\}$ è un insieme.

**OSS** L'INSIEME DI TUTTI GLI INSIEMI NON ESISTE

Supponiamo che un insieme $Y$ i cui elementi sono tutti e soli gli insiemi
$\{x | x\notin X\}$ $= \{x \in Y | x \notin X \}$
A sinistra per russel non è un insieme a destra è un insieme => ASSURDO
