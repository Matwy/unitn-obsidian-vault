---
date: 2024-05-15
Materia: "[[Calcolatori]]"
Argomento: "[[Memoria]]"
---
# Memorie RAM
- Memorizzano singoli bit normalmente organizzati in **byte** e/o **word**
- Data una capacità N (esempio 512 `Kbit`) la memoria può essere organizzata in diversi modi a seconda del parallelismo P (esempio 1, 4 ,8)
	- `512Kx1` 
	- `128x4` 
	- `64Kx8` 
- L'organizzazione influenza in numero di pin di I/O del **circuito** **integrato** (**banco**) che implementa la memoria
#### Organizzazione dei bit in un banco di memoria `16x8`
**Esempio**
- In totale nella memoria avremo **16** **word** dobbiamo quindi avere **4** **bit** nel **banco** $2^{4} = 16$ 
- Una volta selezionata la word tramite i 4 bit avremo 8 bit disponibili
	- se vogliamo scrivere `Read=0 Write=1`
	- se vogliamo leggere `Read=1 Write=0`
![[Pasted image 20240515090155.png|center|500]]
---
## Memorie statiche SRAM
- I bit possono essere tenuti indefinitamente (con alimentazione)
- Estremamente veloci
- poca corrente non scaldano
- expensive
##### Cella di memoria SRAM
- Questo circuito permette la memorizzazione di $b$ e $\overline{b}$ contemporaneamente garantendo la robustezza della memoria
![[Pasted image 20240515090557.png|center|400]]
- In caso di **scrittura** verrà fatto passare un segnale alto sulla **word** **line** chiudendo $T_{1}$ e $T_{2}$ a questo punto il valore che passa per $b$ e $\overline{b}$ verrà salvato nel latch a doppio not
- In **lettura** la linea word è alta esponendo su $b$ e $\overline{b}$ in questo modo il circuito sense write visto prima leggerà il dato
- Quando la linea word è bassa il dato non viene esposto e rimane memorizzato utilizzando poca corrente
---
## Memorie dinamiche DRAM
- Sono le memorie più diffuse
- Economiche e a densità elevata (un solo componente per ogni cella)
	- la memoria viene ottenuta sotto forma di carica di un condensatore
- Hanno bisogno di un aggiornamento continuo del dato per questo usano molta corrente
##### Cella di memoria DRAM
![[Pasted image 20240515091636.png|center|400]]

- In **scrittura** la word line sarà alta in modo da salvare la bit line sul condensatore
- In **lettura** la word line sarà alta consentendo di leggere il dato dal **sense** **amplifier**
	- Se la tensione del condensatore supera una certa soglia la bit line andrà ad 1
	- se la tensione del condensatore è sotto questa soglia la bit line andrà a 0 scaricando completamente il condensatore
##### Tempi di rinfresco
- Quando T viene aperto il condensatore tende a scaricarsi per la sua natura
- E' necessario quindi rinfrescare la memoria prima che si scarichi basterà quindi fare un **ciclo di lettura**
- Solitamente il chip di memoria contiene un circuito per il refresh
##### Multiplazione degli indirizzi
- Avendo un grande numero di celle il numero di pin per gli indirizzi è un problema
- per questo vengono usati gli **stessi** pin per righe e colonne, **multiplando l'indirizzo nel tempo**
- L'indirizzo inoltre si riferisce ai byte non ai bit
![[Pasted image 20240515094716.png|center|450]]
- per accedere alla memoria in modo più rapido possiamo evitare di selezionare la riga ogni volta e scorrere solamente le colonne di una riga
#### DRAM sincrone SDRAM
- Le DRAM viste prima sono dette asincrone perchè non c'è una temporizzazione di accesso ma viene tutto gestito dai segnali **RAS** e **CAS**
- Il processore deve tenere conto di questa possibile asincronicità
- Aggiungendo dei buffer (latch) di memorizzazione degli ingressi e delle uscite si può ottenere un funzionamento sincrono disaccoppiando lettura e scrittura dal rinfresco e si ha un **accesso pilotato dal clock**. (accesso **FPM** Fast Page Mode)
![[Pasted image 20240515100728.png|center|450]]
#### Velocità e prestazioni
- **latenza** tempo di accesso ad una singola parola
- **velocità** o **banda** velocità di trasferimento massima in **FPM**

#### Double Data Rate SDRAM (DDR-SDRAM)
- Consentono il trasferimento dei dati sia nel fronte di salita sia nel fronte di **discesa** in modalità **FPM**
- Latenza uguale ma banda **doppia**
- La memoria viene organizzata in due banchi separati
	- uno contiene le posizioni **pari**, fronte positivo
	- uno contiene le posizioni **dispari**, fronte negativo
