---
date: 2024/10/26
tags: 
Materia: "[[Reti]]"
---
## Controllo di congestione
- controllo di congestione **end-to-end**
	- capisce se c'è congestione osservando perdite di pacchetti e ritardi 
	- usato da TCP
- controllo di congestione assistito dalla rete
	- I router forniscono feedback agli host sullo stato della rete
	- Esempio un singolo bit per indicare la congestione
#### TCP congestion control AIMD
- **Additive Increase Multiplicative Decrease**
- Il mittente aumenta il tasso di trasmissione (cioè la dimensione della finestra) cercando di occupare la banda disponibile fino a quando non si rilevano perdite
	- **Addictive** **increase**: aumenta la finestra di 1 MSS ogni RTT finché non ci sono perdite
	- **Multiplicative** **decrease**: riduci la finestra della metà quando si rileva una perdita

##### Perché AIMD
- Si usa perchè garantisce equità: se K sessioni TCP si dividono lo stesso link di banda R che fa da collo di bottiglia, le sessioni dovrebbero percepire la stessa banda $\frac{R}{K}$
pag 79

#### Meccanismi per il controllo di congestione
- **CWND** numero di byte che il trasmettitore può inviare nella rete senza saturarla (Congestion Window)
- In TCP ci sono diversi algoritmi per adattare la CWND
- no perdite
	- **slow** **start**

- $|W_{T}| = min(CWND, \, RWND) = min(CWND, \, |W_{R}|)$
#### Finestre
- Una **finestra** è un insieme di dati (byte o segmenti)
- Finestra di congestione **CWND**
	- Insieme di dati che si possono inviare nella rete
	- La sua dimensione di adatta alla quantità massima di dati che il trasmettitore può inviare nella rete
- Finestra di ricezione **RWND**
	- Insieme di dati che può essere gestito dal ricevitore
	- La sua dimensione è il limite massimo di dati che il ricevitore può immagazzinare nel buffer di ricezione
- Finestra di trasmissione 
	- Insieme di dati che si possono inviare senza saturare la rete e senza sovraccaricare il ricevitore
	- per questo $|W_{T}| = min(CWND, \, RWND) = min(CWND, \, |W_{R}|)$

## meccanismi di congestione

### Slow start [[reti3.pdf#page=85&selection=0,0,0,21|page 85]]
- per ogni ACK valido ricevuto aumento CWND di 1 MSS
- CWND aumenta esponenzialmente
	- Inizio con CWND = 1 MSS
	- ricevo ACK dopo un RTT CWND = 2 MSS
	- ricevo ACK dopo un RTT CWND = 4 MSS
- quando CWND raggiunge o supera una soglia (slow start threshold SSTHRESH) passa alla modalità congestion avoidance
### Congestion avoidance
- Per ogni ACK valido ricevuto, aumento la CWND di $MSS* \frac{MSS}{CWND}$ 
	- se ragioniamo in segmenti, aumento la CWND di $\frac{1}{CWND}$
- In sostanza per ogni RTT in cui ricevo esattamente CWND ACK aumento CWND di 1 MSS
- Aumento lineari di CWND nel tempo

### Fast re-transmit
- Al **3** **ACK** **duplicato**
	- Ritrasmetto il segmento indicato dall'ACK
	- Entro in **Fast** **Recovery**
- Mi ricordo il valore di $W_{UP}$ (puntatore all'ultimo elemento della finestra) per sapere quanti segmenti sono in volo 
	- $RECOVER = W_{UP}$
	- questo mi permette di capire quando la fase è completata
	
- In pratica se la rete funziona continuo a trasmettere
### Fast Recovery
- Al **3** **ACK** **duplicato**
	- Ritrasmetto il segmento indicato dall'ACK
	- Entro in **Fast** **Recovery**