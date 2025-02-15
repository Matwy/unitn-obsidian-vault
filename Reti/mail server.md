---
date: 2025/01/08
tags: 
Materia: "[[Reti]]"
---
# mail server
## SMTP
- connessioni persistenti
- protocollo **push**
- intestazione e corpo in **ASCII** **a** **7 bit**
- fine del messaggio con `<CR><LF>.<CR><LF>`
### MIME
- estensioni di messaggi di posta **multimediali**
- nell'intestazione specifichiamo alcune info sui dati che vogliamo mandare
#### Codifica base 64
- usa la codifica in **base64** per i dati
- ogni gruppo di **6** **bit** viene codificato in **8** **bit**
- questo permette di usare il codice **ASCII** delle mail

## POP3 Post Office protocol
- **autenticazione** (agente <> server) e download
- in **POP3** di solido la modalità è **scarica leggi cancella**
- complicato con più client
## IMAP Internet Mail Access Protocol
- più funzioni 
- permette di **organizzare** i messaggi sul **server** in **cartelle**
- **mantiene i messaggi sul server**
- **segna cosa è stato letto o meno**
