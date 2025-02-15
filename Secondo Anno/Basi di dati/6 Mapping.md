---
date: 2024/12/08
tags: 
Materia: "[[Basi di dati]]"
---
# 6 Mapping
##### Obbiettivi
- preservare il più possibile la conoscenza rappresentata nel modello concettuale
- Mantenere i vincoli (per quanto possibile)
	- Alcuni vincoli non sono esprimibili nel modello relazionale
	- cardinalità diverse da 1 ed N
	- vincoli di partecipazione per relazioni con grado > 2
- Minimizzare i valori NULL

> Le procedure di mapping che vediamo sono implementate in molti tool commerciali

---
#### Da Entity Type a Tabelle
- Per ogni Entity type $E$ nello schema **ER**, creare una tabella $R$ che ha come attributi tutti gli attributi di $E$
- Porre uno degli attributi chiave di $E$ come chiave primaria per $R$
- Se la chiave di $E$ è composta, la chiave di $R$ sarà composta a sua volta

---
## Mapping relazioni 
#### Mapping da relazioni (senza vincoli)
- Data una relazione (nel senso di **ER**) tra due Entity Types, creare una relazione con i seguenti attributi 
	- La chiave primaria di ogni entità partecipante (come chiave esterna)
	- Gli attributi descrittivi della relazione
- Gli attributi non descrittivi di questa nuova relazione sono una superchiave (se non ci sono vincoli di chiave in ER, sono una chiave candidata)

#### Mapping da relazioni: vincolo di chiave
- prendiamo due entità $E_{1}$ ed $E_{2}$  legate da una relazione $R$ e supponiamo che su $E_{2}$ esista un vincolo di chiave
- Il mapping di base non va bene perchè solo i valori di $PK_{2}$ non possono ripetersi
	- La coppia $<PK_{1},PK_{2}>$ quindi è una superchiave, quindi non può essere una chiave candidata
- Soluzioni:
	- Creare una nuova relazione $R_{A}$ che ha come attributi $PK_{1}$ e $PK_{2}$ (chiavi esterne)  ma solo $PK_{2}$ come chiave primaria + eventuali attributi descrittivi
	- Creare una nuova relazione $R_{B}$ ottenuta aggiungendo a $E_{2}$ un nuovo attributo (chiave esterna) che referenzia la chiave primaria di $E_{1}$ (sfruttando il fatto che comunque il valore di $PK_{2}$ non può ripetersi a causa diel vincolo di chiave) + eventuali attributi descrittivi

> [[Argomento06 Mapping ER nel modello relazionale.pdf#page=9&selection=4,0,4,12|Pro e contro A vs B]]

#### Mapping da relazioni: vincolo di partecipazione
- Il vincolo di **partecipazione** **parziale** non richiede alcuna specifica particolare, corrisponde all'assenza di vincoli
-  Il vincoli di **partecipazione totale** non può essere rappresentato in modo completo senza perdere info dal modello ER
	- Si può avere una partecipazione totale aggiungendo un **NOT NULL** sulla foreign key della tabella referenziante

> [[Argomento06 Mapping ER nel modello relazionale.pdf#page=11&selection=0,0,0,47|Esempio]]

#### Mapping di relazioni: weak entities
- Le entità deboli
	- partecipano sempre a una relazione $1:N$ con l'entità identificante
	- hanno un vincolo di chiave
	- hanno un vincolo di partecipazione totale

- Le due caratteristiche di cui tenere conto
	- hanno solo una chiave parziale
	- devono essere cancellate se viene cancellata l'entità da cui dipendono
---
#### Mapping di gerarchie IS-A
- Assumiamo di dover mappare il seguente diagramma ER
![[Pasted image 20241208110529.png|400]]
- Due approcci
	- Generale: creare 4 diverse entità una per ogni classe del diagramma ER
	- Eliminare l'entità più generale EMPLOYEES e limitarsi a mappare le due sottoclassi
---
#### Mapping di aggregazioni
![[Pasted image 20241208111057.png|400]]
- Approccio generale: Le entità EMPLOYEES, PROJECTS e DEPARTMENT sono mappate come al solito
- Anche la relazione Sponsors è mappata come in precedenza
- La relazione MONITORS, creiamo una nuova tabella con il seguente schema
	- `MONITORS(PK ssn, PK did, PK pid, until)`

- Si può semplificare quando
	-  la relazione esterna all'aggregazione (SPONSORS) non ha attributi descrittivi
	- L'aggregazione ha un vincolo di partecipazione totale in MONITORS ( ovvero ogni coppia progetto dipartimento deve avere un impiegato che la controlla)
- Se queste condizioni valgono la relazione SPONSORS può essere rimossa dal mapping, visto che tutte le sue istanze possono essere ricavate dalle colonne `pid, did` della relazione MONITORS

