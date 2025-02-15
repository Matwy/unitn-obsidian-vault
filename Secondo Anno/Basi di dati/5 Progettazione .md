---
date: 2024/11/06
tags: 
Materia: "[[Basi di dati]]"
---
## Fasi di Progettazione 
1) Analisi dei requisiti
2) Progettazione concettuale
3) Progettazione logica
4) Raffinamento dello schema logico (normalizzazione)
5) Progettazione del livello fisico
6) Progettazione applicativa e sicurezza
- 4, 5 e 6 possono essere anche intrecciate
- Per le fasi 1-3 dobbiamo rispondere a 
	- "Quali dati dovranno essere raccolti?"
	
- Per le fasi 4-6 dobbiamo rispondere a 
	- "Quali applicazioni useranno i dati?"
	- "Quali sono le operazioni più frequenti e quelle più costose?"


#### Costruzione modello
- Per costruire un modello che rappresenta i requisiti espressi da cliente è necessario rappresentare in modo semplificato il mini-mondo 
- Per le basi di dati il modello più noto è **Entity-Relationship ER**
# Modello ER
- Un'**entità** (entity) è un oggetto del mondo reale che si distingue da altri oggetti e vogliamo che sia nel DB
- A livello estensionale uno specifico insieme di entità tra loro simili si chiama **insieme di entità** (entity set)
- Un **tipo** **di** **entità** (entity type) è la definizione a livello intensionale delle entità che possono appartenere ad un entity set di quel tipo
- Gli **attributi** sono le proprietà utilizzate per descrivere un'entità
	- Ogni attributo è associato a un value set o data type ovvero il **dominio**
	- Tipi di attributi
		- **Semplice** Ogni entità ha un singolo valore atomico per quell'attributo
		- **Composto** possono avere più componenti ad esempio Nome Cognome un attributo composto può essere composto a sua volta
		- **Multi-valore** non ho capito
	- noi usiamo solo semplici

## Entity Type
#### Attributo chiave
- Ogni **entity** **type** ha un'attributo che identifica in modo univoco ogni entità si chiama **attributo** **chiave** dell'entity type
- un attributo chiave può essere **composto** da uno o più attributi
- un entity type può avere più di una chiave quindi si parla di chiavi candidate
	- se c'è più di una chiave bisogna sceglierne una come **chiave** **primaria**
	- la chiave primaria in ER è **sottolineata**
#### Rappresentazione entity type
- un **entity** **type** è rappresentato come un rettangolo con il nome del tipo di entità
- I suoi attributi sono rappresentati come ovali e sono collegati al rettangolo
- Gli attributi chiave sono sottolineati
![[Pasted image 20241106154624.png|center|500]]
## Le relazioni primo raffinamento
- La progettazione iniziale di solito non tiene conto delle **relazioni tra entity type**
- Una relazione dello stesso tipo si chiama **relationship** **type**
#### Grado
- Il numero di entity types che partecipano si chiama **grado** della relazione `l'esempio sotto grado due`
![[Pasted image 20241106155240.png]]

#### Attributi
- una relazione può avere uno o più **attributi** descrittivi
- gli attributi di una relazione sono informazioni riguardanti la relazione e **non** **sulle** **entità** che partecipano

#### Relationship Set
- **insieme di istanze della relazione** nella base di dati in un certo instante

#### Vincoli su relationship Types
- Vincoli di **chiave** (key constraints)
- Vincoli di **cardinalità** (cardinality ratio)
- Vincoli di **esistenza** o **partecipazione** (participation constraints)

##### Vincolo di chiave (key constraint)
- Il vincolo di chiave permette di imporre che un'**entità** può **partecipare** **solo** **una** **volta** in una relazione
- Esempio
![[Pasted image 20241106161126.png|center|500]]

##### Vincolo di cardinalità 
- Servono a specificare il numero massimo di volte in cui un'entità può **comparire** in un relationship set
- One to one (1:1)
- One to many (1:N)
- Many to one (N:1)
- Many to Many (N:M)

##### Vincolo di partecipazione
- I **vincoli** **di** **partecipazione** specificano il **minimo** **di volte** che un'entità deve comparire in una relazione
- Un'entità può non comparire in un relationship set -> **partecipazione parziale**
	- linea semplice in ER
- Un'entità deve comparire in un relationship set -> **partecipazione totale**
	- linea in grassetto in ER
###### Notazione (min, max)
- I vincoli di cardinalità possono essere specificati anche indicando che ogni entità in E partecipa in almeno min e al massimo max istanze di R
	- default $min=0$ e $max=N$
- `esempio`
![[Pasted image 20241106162956.png]]

#### Entity Types deboli
- Entità che non hanno un proprio attributo chiave e che quindi devono dipendere da altre entità per l'identificazione univoca.
- Un'entità debole deve partecipare a una **relazione** **identificante** a cui deve partecipare anche un'**entità** **identificante**
- Le entità deboli sono identificate da:
	- Una **chiave** **parziale**
	- La **chiave** **dell'entità identificante**
![[Pasted image 20241129094204.png|400]]

#### Gerarchie di classi
- Può essere necessario organizzare **Entity** **types** in gerarchie di classi
- può essere fatto per:
	- **Generalizzazione**: due Entity Type vengono generalizzati in un Entity Type che li ricomprende entrambi
	- **Specializzazione**: un entity type viene suddiviso in diversi sottoinsiemi ognuno dei quali contiene entità che hanno delle caratteristiche in comune

- La specializzazione può avvenire secondo diverse dimensioni nello stesso modello creando una **gerarchia multilivello**
![[Pasted image 20241129102637.png|300]]

##### Overlap
- Di default non c'è **overlap**
- In caso ci sia si scrive `entita OVERLAPS entita`
-  [[Argomento05 Entity Relationship.pdf#page=37&selection=4,0,4,7|esempio]]
##### Coverage
- Di default non c'è **coverage**
- In caso ci sia si scrive `entita and entita COVER entita`
-  [[Argomento05 Entity Relationship.pdf#page=38&selection=4,0,4,8|esempio]]
