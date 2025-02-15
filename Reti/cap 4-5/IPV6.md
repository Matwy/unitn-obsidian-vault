---
date: 2024/11/09
tags: 
Materia: "[[Reti]]"
---
## IPV6
- Il formato dell'header velocizza l'elaborazione dei datagrammi 
- Formato del datagramma ipv6
	- **lunghezza fissata dell'header** di esattamente 40 byte
	- **frammentazione proibita**

#### Formato datagramma
- flow label: etichetta per tutti i datagrammi dello stesso flusso
- priority identifica la priorità dei datagrammi che fanno parte dello stesso flusso
- next header livello 4 incapsulato
-  checksum rimosso
- options rimosse dall'header 

- **ICMPv6**
	- messaggi aggiuntivi di errore
	- funzioni di gestione per i gruppi multicast

#### Transizione da IPv4 a IPv6
- per fa coesistere le due tecnologie
- **Tunneling**:
	-  i datagrammi IPv6 viaggiano come dati incapsulati dentro datagrammi IPv4

![[Pasted image 20241109103240.png]]
![[Pasted image 20241109103257.png]]

- 128 bit quindi ordine di $10^{38}$ indirizzi
#### I prefissi funzionano allo stesso modo
![[Pasted image 20241109103850.png]]

#### Indirizzi speciali
- questo computer `::/128` tutti 0
- Loopback `::1/128` tutti 0 e 1 alla fine
- Indirizzo IPv4 mappato su IPv6
	- `::ffff::xxyy::zzww` dove `xx.yy.zz.ww` sono bit dell'indirizzo IPv4
	- esempio
		- IPv4 = `193.175.55.16` = `c1.af.37.10`
		- IPv6 = `::ffff:c1af:3710`
- Multicast `ff00::/8`
- Link-local unicast `fe80::/10`