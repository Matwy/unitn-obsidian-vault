---
date: 2025/12/09
tags:
Materia: "[[Fisiologia]]"
pdf: "[[0 Introduzione al sistema nervoso25-26.pdf]]"
---
# Sistema Nervoso - Neuroni e Potenziale di Membrana

---

## Gradiente di Concentrazione

Le sostanze si muovono spontaneamente da dove sono **più concentrate** a dove sono **meno concentrate** (diffusione passiva).

Nella membrana del neurone:

| Ione | Più concentrato |
|------|-----------------|
| **Na⁺** (sodio) | Fuori dalla cellula |
| **K⁺** (potassio) | Dentro la cellula |
| **Cl⁻** (cloro) | Fuori dalla cellula |

---

## Potenziale di Membrana a Riposo (-70mV)

### Come si mantiene

Due componenti lavorano insieme:

#### 1. La Pompa Na⁺/K⁺ ATPasi
- È un **trasportatore attivo** (consuma ATP)
- **Non è un canale** - lavora contro il gradiente
- Ad ogni ciclo:
  - Butta fuori **3 Na⁺**
  - Porta dentro **2 K⁺**
- Mantiene il gradiente di concentrazione

#### 2. I Canali a Riposo
- Sono **passivi** (non consumano ATP)
- **Sempre aperti**
- Principalmente per il K⁺
- Il potassio esce seguendo il gradiente
- Questo rende l'interno negativo

### Perché l'equilibrio si ferma a -70mV

Il K⁺ sente due forze opposte:

| Forza | Direzione | Spiegazione |
|-------|-----------|-------------|
| Gradiente di concentrazione | Spinge K⁺ **fuori** | C'è più K⁺ dentro |
| Attrazione elettrica | Tira K⁺ **dentro** | L'interno è negativo, il K⁺ è positivo |

A **-70mV** queste due forze si bilanciano perfettamente.

---

## Canali Ionici

### Caratteristiche comuni
- Sono **proteine** nella membrana
- Formano un **poro** per il passaggio degli ioni
- Sono **selettivi** (ogni canale lascia passare solo certi ioni)
- Il passaggio è **passivo** (no ATP)
- Possono essere aperti o chiusi

### Classificazione

```
CANALI IONICI (passivi, no ATP)
│
├── SEMPRE APERTI (canali a riposo)
│   └── Mantengono il potenziale di riposo (-70mV)
│
└── AD APERTURA REGOLATA (normalmente chiusi)
    │
    ├── Voltaggio-dipendenti
    │   └── Si aprono con cambio di carica elettrica
    │
    ├── A controllo di ligando
    │   └── Si aprono quando una molecola si lega (es. neurotrasmettitore)
    │
    ├── Regolati meccanicamente
    │   └── Si aprono con stiramento/pressione
    │
    └── A controllo di fosforilazione
        └── Si aprono con aggiunta di gruppo fosfato
```

---

## Potenziale d'Azione

### Le fasi

| Fase | Cosa succede | Voltaggio |
|------|--------------|-----------|
| **Riposo** | Canali regolati chiusi | -70mV |
| **Soglia** | Stimolo sufficiente | -55mV |
| **Depolarizzazione** | Si aprono canali Na⁺ voltaggio-dipendenti, entra Na⁺ | fino a +30mV |
| **Ripolarizzazione** | Canali Na⁺ si inattivano, si aprono canali K⁺, esce K⁺ | torna verso -70mV |
| **Periodo refrattario** | Canali Na⁺ bloccati temporaneamente | — |

### Dettaglio delle fasi

**Depolarizzazione:**
- Quando si raggiunge la soglia (-55mV), i canali Na⁺ voltaggio-dipendenti si aprono
- Il Na⁺ entra di corsa (spinto sia dal gradiente che dall'attrazione elettrica)
- L'interno diventa positivo (+30mV)

**Ripolarizzazione:**
- I canali Na⁺ si inattivano automaticamente
- I canali K⁺ voltaggio-dipendenti (più lenti) si aprono
- Il K⁺ esce → l'interno torna negativo

**Periodo refrattario:**
- I canali Na⁺ sono bloccati
- Impedisce al segnale di tornare indietro
- Garantisce la direzione unidirezionale del segnale

---

## Propagazione del Potenziale d'Azione

> **Nota:** Nel sistema nervoso si muovono **ioni** (atomi carichi disciolti nei liquidi), non elettroni come nei fili elettrici.

### Senza mielina (~2 m/s) - Conduzione continua
- Il segnale si rigenera punto per punto lungo l'assone
- Le cariche si disperdono continuamente attraverso la membrana
- Processo lento

### Con mielina (~60 m/s) - Conduzione saltatoria
- La **guaina mielinica** isola l'assone
- I canali Na⁺ sono concentrati solo nei **nodi di Ranvier**
- Le cariche scorrono veloci nelle zone isolate
- Il potenziale d'azione "salta" da nodo a nodo

---

## Sinapsi

### Tipi di sinapsi

#### 1. Sinapsi elettriche
- Collegamento diretto tramite **giunzioni comunicanti** (gap junctions)
- Gli ioni passano direttamente da un neurone all'altro
- Molto veloci, ma poco controllo
- Rare nei mammiferi

#### 2. Sinapsi chimiche
- Usano **neurotrasmettitori** come messaggeri
- Le più comuni nel nostro sistema nervoso

### Sequenza della trasmissione sinaptica chimica

1. Il potenziale d'azione arriva al **terminale assonico**
2. Si aprono **canali Ca²⁺ voltaggio-dipendenti** → entra calcio
3. Il calcio fa fondere le **vescicole sinaptiche** con la membrana
4. Le vescicole rilasciano **neurotrasmettitori** nella fessura sinaptica
5. I neurotrasmettitori si legano ai **recettori** (canali a controllo di ligando)
6. Si aprono canali ionici nel neurone post-sinaptico

### Effetti eccitatori e inibitori

| Tipo | Neurotrasmettitore | Cosa succede | Effetto |
|------|-------------------|--------------|---------|
| **Eccitatorio** | Glutammato | Entra Na⁺ | Depolarizzazione |
| **Inibitorio** | GABA, Glicina | Entra Cl⁻ o esce K⁺ | Iperpolarizzazione |

### Sommazione

Un singolo segnale spesso non basta a raggiungere la soglia. Il neurone "somma" più segnali:

- **Sommazione temporale:** tanti segnali dallo stesso neurone in rapida successione
- **Sommazione spaziale:** segnali da neuroni diversi che arrivano contemporaneamente

I segnali inibitori **sottraggono** dal totale.

---

## Neurotrasmettitori Principali

### Amminoacidi
| Neurotrasmettitore | Effetto |
|-------------------|---------|
| **Glutammato** | Eccitatorio (il più comune nel cervello) |
| **GABA** | Inibitorio (il più comune inibitore) |
| **Glicina** | Inibitorio (soprattutto nel midollo spinale) |

### Amine biogene
| Neurotrasmettitore | Coinvolto in |
|-------------------|--------------|
| **Acetilcolina** | Movimento muscolare, memoria |
| **Dopamina** | Ricompensa, movimento |
| **Noradrenalina** | Attenzione, allerta |
| **Serotonina** | Umore, sonno |
| **Istamina** | Veglia |

### Neuropeptidi
- Endorfine, encefaline, sostanza P
- Coinvolti nella modulazione del dolore

---

## Cellule Gliali

Non trasmettono segnali elettrici, ma hanno ruoli di supporto fondamentali.

### Nel Sistema Nervoso Centrale (SNC)

| Tipo | Funzione |
|------|----------|
| **Oligodendrociti** | Formano la guaina mielinica (un oligodendrocita avvolge più assoni) |
| **Astrociti** | Supporto metabolico, regolano ambiente chimico, barriera emato-encefalica |
| **Microglia** | Difesa immunitaria, eliminano detriti |
| **Cellule ependimali** | Rivestono cavità cerebrali, producono liquido cerebrospinale |

### Nel Sistema Nervoso Periferico (SNP)

| Tipo | Funzione |
|------|----------|
| **Cellule di Schwann** | Formano la guaina mielinica (una cellula avvolge un solo assone) |
| **Cellule satellite** | Supporto ai corpi cellulari nei gangli |

---

## Sistema Nervoso Centrale vs Periferico

### Sistema Nervoso Centrale (SNC)
- **Componenti:** Cervello + Midollo spinale
- **Protezione:** Cranio e vertebre
- **Barriera emato-encefalica (BBB):** molto selettiva
- **Rigenerazione:** scarsa

### Sistema Nervoso Periferico (SNP)
- **Componenti:** Nervi cranici, nervi spinali, nervi e gangli autonomi (incluso sistema nervoso enterico)
- **Protezione:** non protetto da ossa
- **Barriera emato-nervosa:** meno selettiva
- **Rigenerazione:** maggiore capacità

---

## Sviluppo Embrionale del Sistema Nervoso

Il sistema nervoso deriva dall'**ectoderma**.

### Formazione del tubo neurale
1. L'ectoderma si ispessisce → **placca neurale**
2. I bordi si sollevano → **pieghe neurali**
3. Si chiudono → **tubo neurale**
4. Dal tubo neurale derivano **cervello e midollo spinale**

### Cellule della cresta neurale
- Si trovano ai bordi delle pieghe neurali
- Migrano e formano gran parte del SNP:
  - Neuroni sensoriali
  - Neuroni autonomici post-gangliari
  - Cellule di Schwann
  - Sistema nervoso enterico
  - Cellule della midollare del surrene
  - Melanociti

---

## Schema Riassuntivo Finale

```
SISTEMA NERVOSO
│
├── SNC (Cervello + Midollo spinale)
│   └── Mielina formata da: Oligodendrociti
│
└── SNP (Nervi cranici, spinali, autonomi)
    └── Mielina formata da: Cellule di Schwann

SEGNALE NERVOSO
│
├── Potenziale di riposo (-70mV)
│   ├── Pompa Na⁺/K⁺ (attiva)
│   └── Canali a riposo (passivi)
│
├── Potenziale d'azione
│   ├── Soglia: -55mV
│   ├── Depolarizzazione: canali Na⁺ → +30mV
│   └── Ripolarizzazione: canali K⁺ → -70mV
│
└── Trasmissione sinaptica
    ├── Elettrica (gap junctions)
    └── Chimica (neurotrasmettitori)
```