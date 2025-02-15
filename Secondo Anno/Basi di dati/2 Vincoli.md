---
date: 2024/10/11
tags: 
Materia: "[[Basi di dati]]"
---
## Vincoli
- **Vincoli impliciti** dipendono  dal data model stesso. `esempio il modello relazionale non ammettie liste come valore di un attributo`
- **Vincoli basati sullo schema (o espliciti)** sono definiti nello schema usando gli strumenti forniti dal modello.
- **Vincoli** **applicativi** o **semantici** vincoli oltre il modello, imposti a livello di programma applicativo. `esempio un libro che deve essere restituito entro 30gg` 

#### Vincoli di integrità relazionale
- Un vincolo è definito come una condizione che deve valere affinché lo stato di una relazione sia **valido**
- Principali tipi di **vincoli** **espliciti**:
	- Vincolo di **dominio**
	- Vincolo di **chiave**
	- Vincolo di **integrità delle entità**
	- Vincolo di **integrità** **referenziale**

#### Vincolo di chiave
- **Superchiave** di una relazione $R$ 
	- Insieme di attributi $S_{k}$ di $R$ tali che:
		- Non esistono due tuple di r(R) in cui gli attributi in $S_{k}$ hanno lo stesso valore $t_{1}, t_{2} \in r(R) \quad tc\quad t_{1}[S_{k}] \neq t_{2}[S_{k}]$
- **Chiave** di una relazione $R$
	- Una chiave è una superchiave **minimale** ovvero una superchiave tale che la rimozione di qualsiasi attributo da $S_k$ produrrebbe un insieme di attributi che non è più una superchiave di $R$ esempio `sid` è una chiave perché non puoi togliere nulla
- **Una chiave è sempre una superchiave ma non viceversa**

#### Vincolo di integrità di un'Entità
- gli attributi di una chiave primaria non possono avere valori NULL in alcuni tupla

#### Vincolo di integrità referenziale
- Un vincolo di integrità referenziale coinvolge due relazioni
	- una **relazione** **referenziante** $R_{1}$ 
	- una **relazione** **referenziata** $R_{2}$ 
- In $R1$ c'è un insieme di attributi **FK** chiamati (chiave esterna / Foreign Key) che fanno riferimento agli attributi della chiave primaria **PK** di $R_{2}$
- Una tupla $t_{1}$ in $R_{1}$ si dice che **referenzia** una tupla $t_{2}$ in $R_{2}$ se $t_{1}[FK]=t_{2}[PK]$

#### Vincoli di integrità semantica
- Sono riferiti al significato dell'applicazione e non sono quindi espressi nel modello 
 - in SQL-99 esistono dei concetti di trigger e asserzioni per definire condizioni. In MySQL esistono i `CHECK`
![[Pasted image 20241014151614.png]]

