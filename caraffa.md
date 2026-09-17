---
date: 2025/09/17
tags: 
Materia:
---
# 🤖 Progetto Robot Versatore – Team Proposal

## 🎯 Obiettivo
Realizzare un **robot autonomo** con ruote omnidirezionali in grado di:
- Seguire una **linea a terra** per raggiungere più punti di servizio.
- **Riconoscere un bicchiere** tramite marker (ArUco/AprilTag) e sensore ToF.
- **Verificare se il bicchiere è pieno** grazie a un ToF montato in alto.
- **Versare liquido** da una caraffa montata in cima, usando una **pompa a membrana** per controllo preciso.
- Gestire il tutto da **Raspberry Pi + Arduino**, con possibilità di **telemetria e controlli via app**.

---

## 🏗️ Architettura Meccanica
- **Forma**: robot cilindrico Ø ~240–260 mm, altezza ~300 mm.
- **Caraffa**: posizionata sulla parte superiore, pescante in silicone.
- **Pompa a membrana 12 V**: autoadescante, con valvola di non ritorno e beccuccio verticale.
- **Ruote omnidirezionali**: 3 ruote a 120° (configurazione Kiwi) → movimenti fluidi in tutte le direzioni.
- **Camera + ToF**:  
  - Camera per seguire la linea e riconoscere i marker ArUco/AprilTag.  
  - ToF frontale per confermare presenza bicchiere.  
  - **ToF verticale** per controllare il livello del liquido nel bicchiere ed evitare traboccamenti.

---

## ⚡ Architettura Elettronica
- [x] **Batteria**: 3S Li-ion 12 V (4–6 Ah). ✅ 2025-09-17
- [x] **Alimentazione**: buck 12→5 V per Raspberry Pi e sensori. ✅ 2025-09-17
- [x] **Raspberry Pi**: visione, logica missione, comunicazione app. ✅ 2025-09-17
- [x] **Arduino Nano**: controllo real-time (motori, QTR, ToF, pompa). ✅ 2025-09-17
- [ ] **Driver motori**: da verificare quali sono disponibili.
- [x] **Controllo pompa**: MOSFET logic-level (da acquistare, ma idea confermata). ✅ 2025-09-17

---

## 🧠 Flusso di Funzionamento
1. **FOLLOW_LINE** – il robot segue la linea fino a rilevare un marker ArUco.
2. **ALIGN** – si posiziona usando la posa del marker + offset calibrato del beccuccio.
3. **CONFIRM** – il ToF frontale verifica che ci sia effettivamente un bicchiere.
4. **CHECK_LEVEL** – il ToF verticale misura la distanza dal livello del liquido per capire se il bicchiere è già pieno o parzialmente pieno.
5. **POUR** – la pompa si attiva fino a raggiungere il livello target.
6. **DRIP_STOP** – breve stop/reverse per evitare gocciolamento.
7. **RESUME** – riprende la linea per il prossimo punto di servizio.

---

## 📱 App di Controllo
- Possibilità di **selezionare da smartphone** quale bicchiere riempire.
- Impostazione di **volume target** (es. 150 ml).
- Dashboard con **statistiche**: quantità erogate, numero di riempimenti, allarmi (bicchiere mancante o pieno).

---
## 🔗 Link Utili ai Componenti
- **Valvola solenoide (opzione alternativa alla pompa)**  
  [amazon.it – Elettrovalvola 12 V NC](https://www.amazon.it/Solenoide-Elettrovalvola-Elettrica-Normalmente-Depuratore/dp/B07DPMQP5X?utm_source=chatgpt.com)

- **Pompe a membrana 12 V (consigliate)**  
  [RUNCCI-YUN Membrana Elettrica autoadescante – Modello 1](https://www.amazon.it/RUNCCI-YUN-Membrana-Elettrica-autoadescante-macchina/dp/B0CB3QGFX2/)  
  [RUNCCI-YUN Membrana Elettrica autoadescante – Modello 2](https://www.amazon.it/RUNCCI-YUN-Membrana-Elettrica-autoadescante-macchina/dp/B0DLM6235R/)  
  [AliExpress – Mini pompa a membrana 12 V](https://it.aliexpress.com/item/1005003641040999.html)
- **Motori e ruote** 
https://it.aliexpress.com/item/1005003641040999.html?spm=a2g0o.productlist.main.20.2b4bowmLowmLIR&algo_pvid=5441eb6b-aa82-4838-b3a5-91d7286f3d8c&algo_exp_id=5441eb6b-aa82-4838-b3a5-91d7286f3d8c-19&pdp_ext_f=%7B%22order%22%3A%221%22%2C%22eval%22%3A%221%22%2C%22fromPage%22%3A%22search%22%7D&pdp_npi=6%40dis%21EUR%2112.88%2111.59%21%21%2114.92%2113.43%21%40211b876e17581106860804912e5e60%2112000026613466143%21sea%21IT%210%21ABX%211%210%21n_tag%3A-29910%3Bd%3Ac5288323%3Bm03_new_user%3A-29895&curPageLogUid=VMaxVyVLPk2x&utparam-url=scene%3Asearch%7Cquery_from%3A%7Cx_object_id%3A1005003641040999%7C_p_origin_prod%3A

---

## 📐 Schema Semplificato

[Caraffa] + pescante
│
[Pompa a membrana] + antivibrazioni
│
[Elettronica: Pi + Nano + driver]
│
[Batteria 12 V]
│
[Base con 3 ruote omni + sensori QTR + ToF]

---
## 🔧 Perché è un Ottimo Progetto di Embedded Systems

Questo progetto è un **caso reale e completo** di applicazione di sistemi embedded, perché integra:

- **Controllo in tempo reale**:  
  - Lettura sensori (QTR, ToF, encoder motori) e risposta rapida per seguire la linea e fermarsi con precisione.
  - Attuazione in tempo reale (pompa, motori, MOSFET).
- **Integrazione hardware-software**:  
  - Microcontrollore (Arduino) per il controllo “hard real-time”.
  - Microprocessore (Raspberry Pi) per la visione artificiale e la logica di alto livello.
  - Comunicazione seriale tra i due mondi per sincronizzare azioni e sensori.
- **Multidisciplinarità**:  
  - Meccanica (ruote omni, struttura cilindrica).
  - Elettronica (driver motori, power management, protezioni).
  - Informatica (algoritmi PID, elaborazione immagini, protocollo di comunicazione).
- **Interazione con il mondo fisico**:  
  - Riconoscimento bicchiere → decisione di fermarsi → versata → controllo anti-trabocco.

### 🚀 Una Sfida Stimolante
- **Coordinare più sottosistemi** (locomozione, visione, dosaggio) senza conflitti.
- **Gestione dell’energia**: ottimizzare consumi per pompa e motori su batteria.
- **Sicurezza e robustezza**: garantire che non versi se il bicchiere non c’è o è già pieno.
- **Precisione**: posizionarsi correttamente e dosare la quantità di liquido con tolleranza di pochi ml.
- **Scalabilità**: possibilità di servire più bicchieri, aggiungere app di controllo, logging e telemetria.

> 💡 **In breve:** è un progetto che tocca *tutti i pilastri* dell’Embedded Systems (sensing, actuation, control, communication) e produce un risultato **tangibile, interattivo e divertente** da dimostrare.

