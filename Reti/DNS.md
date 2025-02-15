---
date: 2025/01/08
tags: 
Materia: "[[Reti]]"
---
# DNS Domain Name System
- **Database distribuito** gerarchico
- **protocollo a livello applicazione**
## Servizi DNS
- Traduzione degli **hostname** in **indirizzi**
- Host **aliasing** (host con più nomi)
- mail server aliasing
- **distribuzione** del **carico**
	- server web replicati
#### Perchè non centralizzarlo
- singolo punto di guasto
- volume di traffico
- manutenzione
- non scalabile

## Database distribuiti e gerarchici

![[Pasted image 20250108085956.png|500]]

### 13 server DNS radice

![[Pasted image 20250108090346.png|600]]

### Top level domain
- Server **TLD** top-level domain
- si occupano dei domini
### Server di competenza **authoritative** **server**
- tutti i servizi web ad esempio devono fornire un record DNS di pubblico dominio che mappa un nome al loro indirizzo

## Server DNS Local
- non appartiene alla gerarchia dei server
- tutti gli ISP hanno un **DNS** **locale** anche chiamato **default** **name** **server**
![[Pasted image 20250108091039.png|500]]

## DNS caching
## Resource Record RR
- **formato** `name, value, type, ttl`
### Tipo A
- associazione standard tra host e indirizzo ip
### Tipo NS
- name è il dominio
- nome del server di competenza
### Tipo CNAME
- name è l'alias di un nome canonico
### Tipo MX
- value è il nome del server di posta associato a name   

## Inserire un record nel db DNS
- il **registrar** ha l'autorità di farlo
- inserisce due RR
	- uno che associa l'alias al dominio del DNS `dns.example.com NS`
	- uno che effettivamente associa il dominio all'indirizzo `dns.example.com 12.12.1.2 A`

