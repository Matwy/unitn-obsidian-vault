---
date: 2024/10/16
tags: 
Materia: "[[Basi di dati]]"
---
## operazioni di aggiornamento su relazioni
- insert 
- delete
- modify
- queste non devono portare a una violazione di alcuni vincolo di integrità
#### Soluzioni alle violazioni
- **RESTRICT** (NO ACTION, REJECT) impedisce l'esecuzione dell'operazione che causa la violazione
- **CASCADE**, **SET** **NULL**, **SET DEFAULT** avvia altri aggiornamenti per eliminare la violazione
- routine specifiche definite dall'utente
- eseguire l'operazione informando l'utente della violazione

#### Violazioni per INSERT
- L'operazione `INSERT` può violare tutti i vincoli

- vincoli di **dominio** Il valore di uno o più attributi non appartiene al dominio specificato
- vincoli di **chiave** inserimento di tupla con chiave già esistente
- **integrità referenziale** valore della FK che fa riferimento a una chiave non esistente
- **integrità dell'entità** il valore della chiave primaria della nuova tupla è **NULL**
#### Violazioni per DELETE
- L'operazione `DELETE` può violare vincoli :
- **integrità referenziale** se viene rimossa una tupla che è referenziata da altre tuple
#### Violazioni per UPDATE
- L'operazione `UPDATE` può violare tutti i vincoli :
- **integrità referenziale** se viene rimossa una tupla che è referenziata da altre tuple
 - **UPDATE** della chiave primaria (**PK**):
	  - Integrità **referenziale** 
  - **UPDATE** di una chiave esterna (**FK**): 
	  - Integrità **referenziale** 
  - **UPDATE** di un **attributo** ordinario (non PK né FK): 
	  - Vincoli di **dominio** o vincoli UNIQUE e NOT NULL

## Preservare l'integrità referenziale
##### RESTRICT (NO ACTION)
- rifiutare l'operazione
##### CASCADE 
- cancellare tutte le tuple che referenziavano la chiave primaria della tupla cancellata o modificata
##### SET NULL
- assegnare il valore NULL alla chiave esterna delle tuple che referenziavano la tupla eliminata o modificata
##### SET DEFAULT
- assegnare un valore di default alla chiave esterna delle tuple che referenziavano la tupla eliminata o modificata

- SET NULL e SET DEFAULT non sono disponibili se la FK  è anche la PK della tabella

