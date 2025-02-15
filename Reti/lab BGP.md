---
date: 2024/12/17
tags: 
Materia: "[[Reti]]"
---
## OSPF
- **IGP** Interior Gateway Protocol
- Link-state protocol
- Topologia **divisa** **in** **aree** per scalabilità
- viene usato per distribuire internamente le reti
- copertura veloce scalabile per minimizzare i prefissi in IGP

- Indirizzi IP loopback **always** **up**
---
## BGP
- **EGP** Exterior Gateway Protocol
- Usato per routing con altri AS
- più scalabile rispetto a **OSPF**
### Common Attributes
- servono a BGP per decidere le migliori rotte
#### AS Path
- Salva i percorsi per raggiungere gli AS
- vincono i percorsi più corti
#### Local Preference
- preferenza di una BGP route in un router
- path con la preference più alta vince
#### MED
- **Multi-Exit-Discriminator** è opzionale non transitivo
- trasmesso solo agli AS vicini
- usato per influenzare il traffico in arrivo
- path con MED più basso vince
#### Next hop

---
## Multiple Routes for the same destination
- Routing basato su **LONGEST PREFIX MATCH**

---
## eBGP vs iBGP
- **external**
	- peering tra diversi **AS**
	- implementa **routing** **policy**
	- quando annunci una rotta il next hop della rotta è l'ip usato per il peering
	- BGP ha **TTL 1**
	- ogni rotta ricevuta da eBGP viene **annunciata** a tutti gli altri **eBGP** e **IBGP**
	
- **internal**
	- peering con lo stesso AS
	- può essere usato per local/customer prefixes
	- quando annunci una rotta non cambia il next hop
	- ogni rotta ricevuta da un iBGP non viene annunciata ad altri iBGP peers

>   **BGP** è più scalabile di **OSPF** 

#### Fully meshed dentro a iBGP
- servirebbe ma sono troppi collegamenti

#### Route Reflector
1) reflector riceve percorsi da client a non client
2) seleziona la path migliore
3) se la path migliore è da un client, viene riflessa agli altri client non-client
4) se la path migliore è da un non-client allora la rifletto solo ai client

> non-meshed clients, iBGP full-mesh solo tra route reflectors

----
## Altra terminologia
- **BGP** **Peering** 
	- sessioni BGP tra due BGP speakers
- tipologie di peering
	- **Upstream**/**Transit** : permettono di accedere a tutte le routing table di internet
	- Peer altri **BGP** provider che espongono route per il proprio network
- IPX/Internet Exchange un posto dove più provider creano peerings l'uno con l'altro

