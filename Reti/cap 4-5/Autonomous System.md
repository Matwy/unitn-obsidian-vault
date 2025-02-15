---
date: 2025/01/02
tags: 
Materia: "[[Reti]]"
---
## Autonomous System
- Internet è formato da "sottoreti" **Autonomous** **System** **AS** 
- **Def** Uno **AS** è un gruppo di router sotto lo stesso controllo amministrativo
- Ogni **AS**  è identificato da un numero assegnato centralmente dai registri ICANN
- **Intra**-**AS** routing vs. **Inter-AS** routing

## Intra-AS OSPF
- **Open Shortest Path First**
- OSPF protocolla routing basato su link state
	- Dissemina pacchetti con lo stato dei link
	- topologia nota a tutti i router
	- Calcola i percorsi usando Dijkstra

- Usa datagrammi IP
	- Non si serve di nessun livello di trasporto
	- Invia i pacchetti di aggiornamento dei link all'indirizzo multicast `224.0.0.5`

- Implementa tre procedure
	- Protocollo di "Hello": Messaggi di mantenimento, controllano i link funzionanti e verificano quali altri nodi sono vicini
	
	- Protocollo di "Exchange": Usato per informare i vicini che si sono appena conosciuti sulla topologia della rete
	
	- Protocollo di "Flooding": Informa tutti i router di un cambio nello stato dei link

#### Flooding controllato
- Invia messaggi ricevuti su un'interfaccia su tutte le altre interfacce
![[Pasted image 20250102134137.png|600]]

#### OSPF gerarchico
- Usato in reti con molti router
- Gerarchia a due livelli
	- **backbone**
	- reti di area
- I messaggi con i link state circolano solo nelle reti di area
- I nodi conoscono la topologia di rete solo all'interno della propria area e uno shortest path verso le altre aree
- la dorsale è un'area, i router nella dorsale usano OSPF solo per la dorsale
- I router di bordo connettono altri AS