## SO
- Il sistema operativo si occupa di gestire gli interrupt generati dalle periferiche
- Solo il kernel può accederci
- Spesso le operazioni di **I/O** hanno problemi di concorrenza
#### Funzionalità richieste al SO
- Garantire che un utente abbia accesso agli IO a cui ha diritto
- Fornire comandi di alto livello per gestire operazioni di basso livello
- Gestire gli interrupt (**Interrupt** **Handling**)
- Gestire la concorrenza

#### Requisiti
- per implementare queste funzionalità
	- SO deve inviare comandi alle periferiche
	- i dispositivi devono notificare l'esito di un'operazione
	- consentire trasferimenti di dati diretti da dispositivo e memoria
#### Impartire comandi ai dispositivi
- **Memory mapped IO** Scrivendo leggendo in particolare locazioni di memoria
- Tramite alcune istruzioni speciali

- Per verificare che l'istruzione sia andata a buon fine il processore può fare dei controlli periodici sul bit dedicato (**polling**)
