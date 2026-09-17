---
date: 2025/10/24
tags:
Materia: "[[Logica Computazionale]]"
---
## 3 Theories to Machine Perception
- come le rappresentazioni mentali umane si traducono in rappresentazioni computazionali

### Continuità con HP2T

* In HP2T avevi visto che la conoscenza nasce dal processo:
  **Percezione → Concettualizzazione → Comprensione → Ragionamento.**
* In T2MP si inverte la direzione:
  **Theories → Models → Perception.**
  👉 Obiettivo: partire da teorie astratte per creare sistemi che percepiscano come (o meglio di) noi.

---

### Dal mentale al computazionale

#### Due tipi di rappresentazioni rimangono fondamentali:

1. **Analogiche** → nel mondo computazionale corrispondono a dati percettivi grezzi
   (immagini, segnali, feature visive, vettori numerici).
2. **Linguistiche** → corrispondono a rappresentazioni simboliche
   (grafi, ontologie, logiche, linguaggi di descrizione).

💡 L’idea chiave: un sistema intelligente deve **integrare analogico e linguistico** —
cioè combinare **percezione sensoriale e simbolismo logico.**

---

### Rappresentazioni e “semantic gap” nelle macchine

* Il **semantic gap** non riguarda solo le persone, ma anche le macchine.
* In AI è la distanza tra:

  * **feature di basso livello** (pixel, bordi, suoni, ecc.)
  * e **concetti di alto livello** (“persona”, “cane”, “felice”).
* Le reti neurali riducono questo gap, ma non lo eliminano:
  interpretano pattern, non significati.

---

### Rappresentazioni mentali e machine models

* Le **rappresentazioni mentali umane** (analogiche + linguistiche) ispirano
  la costruzione di **rappresentazioni computazionali**:

  * **analogiche** → reti neurali, feature maps, embeddings;
  * **linguistiche** → grafi semantici, logiche descrittive, ontologie.
  
* Questi due mondi devono dialogare:
  * il **livello simbolico** (logica, linguaggio) organizza la conoscenza;
  * il **livello percettivo** (sensori, immagini) fornisce i dati grezzi.

👉 È la base della **cognitive AI** o **neuro-symbolic AI.**

---

##  Caratteristiche delle rappresentazioni computazionali

Riprendendo i concetti umani, il testo mostra che anche le rappresentazioni in AI sono:

* **Parziali:** non coprono tutta la realtà; dipendono dal training.
* **Multiple:** diversi modelli (reti, ontologie) descrivono lo stesso fenomeno.
* **Diverse:** variano nel tempo e nel contesto d’uso.
* **(In)consistenti:** due modelli possono contraddirsi (es. classificatore vs regole).

---

## Dal “percepito” alla conoscenza artificiale

Il documento spiega il **flusso della rappresentazione** nel contesto macchina:

1. **Input sensoriale (analogico)** → dati numerici.
2. **Feature extraction** → rappresentazione intermedia.
3. **Concettualizzazione linguistica** → etichette, concetti, ontologie.
4. **Comprensione e ragionamento** → teorie, previsioni, decisioni.

Questa pipeline mappa **i livelli cognitivi umani** su **livelli computazionali**.

---

## 7. Key Notions

| Termine                                    | Significato                                                  |
| ------------------------------------------ | ------------------------------------------------------------ |
| **Semantic Gap**                           | Distanza tra percezione (feature) e significato (concetto)   |
| **Analogical Representation**              | Dati sensoriali o percettivi (immagini, audio, input grezzi) |
| **Linguistic Representation**              | Rappresentazioni simboliche (parole, grafi, concetti)        |
| **Mental Representation**                  | In AI: modello interno del mondo (rete, logica, o entrambi)  |
| **Neuro-symbolic approach**                | Integrazione tra apprendimento neurale e ragionamento logico |
| **Partiality / Diversity / Inconsistency** | Limiti e differenze nelle rappresentazioni computazionali    |

---

## In sintesi

- [[2025-09-18 T2MP - Representations.pdf]]
Questo PDF è la **traduzione cognitiva del primo modulo HP2T in chiave AI**:
come **le rappresentazioni mentali umane diventano strutture formali** che una macchina può manipolare, combinando
– **percezione analogica (neurale)** e **linguaggio simbolico (logico)**.