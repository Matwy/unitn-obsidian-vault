---
date: 2025-03-19
tags: 
Materia: "[[Fisica]]"
---
# ⚡ Quantità di Moto e Impulso

# 📌 Quantità di Moto e Seconda Legge di Newton

## 🔹 **Definizione di quantità di moto**
- La **quantità di moto** (o **momento lineare**) è una grandezza fondamentale nella meccanica classica ed è definita come il prodotto tra la massa di un corpo e la sua velocità:

$$
\vec{p} = m \vec{v}
$$

dove:
- $\vec{p}$ è la quantità di moto (un vettore),
- $m$ è la massa del corpo (uno scalare, in kg),
- $\vec{v}$ è la velocità del corpo (un vettore, in m/s).

---

## 🔹 **Caratteristiche principali**
1. **È una grandezza vettoriale**: ha modulo, direzione e verso e segue l'algebra vettoriale.
2. **Unità di misura**: chilogrammo metro al secondo $(kg \cdot m/s)$.
3. **Seconda legge di Newton**: la variazione della quantità di moto nel tempo è uguale alla forza risultante applicata al corpo:

   $$
   \vec{F} = \frac{d\vec{p}}{dt}
   $$

   che nella forma più comune diventa:

   $$
   \vec{F} = m \vec{a}
   $$

 > se la massa è costante.

---

### 🔹 Conservazione della quantità di moto
- La quantità di moto si conserva in un sistema isolato, ovvero in assenza di forze esterne o quando le forze esterne si bilanciano. Questo principio è alla base di fenomeni come **le collisioni e il moto dei razzi**.

#### Esempi di applicazione
1. **Collisioni elastiche e anelastiche**: la somma vettoriale delle quantità di moto prima e dopo la collisione è la stessa.
2. **Effetto rinculo**: quando spariamo con un'arma, il proiettile va in una direzione e l'arma rincula nella direzione opposta per conservare la quantità di moto.
3. **Moto dei razzi**: il razzo espelle gas a grande velocità all'indietro, acquisendo così una quantità di moto nella direzione opposta.

---

## ⚡ Seconda Legge di Newton e Quantità di Moto

- La relazione tra quantità di moto e forza deriva dalla **Seconda Legge di Newton**, che nella sua forma più generale è espressa come:

$$
\vec{F} = \frac{d\vec{p}}{dt}
$$

- Questa equazione afferma che la **forza risultante** applicata a un corpo è uguale alla **variazione della sua quantità di moto nel tempo**.

---

### 🔹 Derivazione e interpretazione
- La quantità di moto è definita come:

$$
\vec{p} = m \vec{v}
$$

- Se la massa $m$ è **costante nel tempo**, possiamo derivare rispetto al tempo:

$$
\frac{d\vec{p}}{dt} = \frac{d}{dt} (m \vec{v}) = m \frac{d\vec{v}}{dt}
$$

- Poiché $\frac{d\vec{v}}{dt}$ è l'accelerazione $\vec{a}$, otteniamo la forma più comune della **Seconda Legge di Newton**:

$$
\vec{F} = m \vec{a}
$$

---

### 🔹 Caso in cui la massa non è costante
- Se la massa varia nel tempo, come nel caso di un **razzo che brucia carburante ed espelle gas**, dobbiamo applicare la **derivata del prodotto**:

$$
\frac{d\vec{p}}{dt} = \frac{d}{dt} (m \vec{v}) = m \frac{d\vec{v}}{dt} + \vec{v} \frac{dm}{dt}
$$

In questo caso, la forza risultante ha **due contributi**:
1. **$m \vec{a}$**: la classica legge di Newton per una massa costante.
2. **$\vec{v} \frac{dm}{dt}$**: un termine aggiuntivo che tiene conto della variazione di massa nel tempo (importante nei **motori a razzo** 🚀).

---

## 🔹 Conclusione
- La forza è direttamente legata alla **variazione della quantità di moto**.
- Se la massa è **costante**, la formula diventa **$\vec{F} = m\vec{a}$**.
- Se la massa **cambia nel tempo**, dobbiamo considerare anche il termine **$v \frac{dm}{dt}$**.

---
# Impulso
- L’**impulso** in fisica è una grandezza vettoriale che misura la variazione della quantità di moto di un corpo in un certo intervallo di tempo. È definito come il prodotto della forza applicata su un oggetto per il tempo durante il quale la forza agisce:


$I = vec{F} \cdot \Delta t$

dove:
- $( I )$ è l'**impulso**,
- $( \vec{F} )$ è la **forza** **applicata**,
- $( \Delta t )$ è l’**intervallo** **di** **tempo** durante il quale la forza è applicata.

### Relazione con la quantità di moto
- L'impulso è direttamente collegato alla variazione della quantità di moto $\vec{p}$, secondo il **teorema dell'impulso e quantità di moto**:

$$I = \Delta p = m v_f - m v_i
$$

dove:
- $m$ è la massa dell'oggetto,
- $v_{f}$ è la velocità finale,
- $v_{i}$ è la velocità iniziale.

- Questa relazione mostra che l'impulso non solo dipende dalla forza applicata, ma anche da quanto tempo essa agisce: una forza piccola applicata per un tempo lungo può produrre lo stesso cambiamento della quantità di moto di una forza grande applicata per un tempo breve.

### **Esempi pratici**
- **Un pugno su un sacco da boxe**: più tempo rimane a contatto, più l’impulso è distribuito e minore è la forza istantanea.
- **Una racchetta che colpisce una pallina da tennis**: l’impulso dato alla pallina ne cambia velocemente la quantità di moto.
- **Un airbag in un’auto**: aumenta il tempo di decelerazione in un impatto, riducendo la forza applicata sul corpo del guidatore.

In sintesi, l'impulso descrive il modo in cui una forza influisce sul moto di un corpo nel tempo ed è essenziale per comprendere collisioni, movimenti e interazioni dinamiche.