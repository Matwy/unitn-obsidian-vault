---
date: 2024/12/08
tags: 
Materia:
---
# normalizzazione
## Normalizzazione via decomposizione
- La **decomposizione** di una relazione è la divisione di una relazione in più relazione tale che
	- Gli attributi della relazione originale vengano suddivisi tra le due relazioni

- In una decomposizione ci devono essere le seguenti **proprietà**
	- Decomposizione senza **perdita** **di** **informazione**: nel ricomporre mediante join le relazioni decomposte non devono comparire **tuple** **spurie** (ovvero non appartenenti alla relazione iniziale), [[Argomento08 Normalizzazione.pdf#page=7&selection=0,28,4,33|nelle slide]]
	- **Conservazione delle DF** la decomposizione deve conservare le DF della relazione originale, [[Argomento08 Normalizzazione.pdf#page=9&selection=0,22,0,22|slide]]
> la prima proprietà deve essere sempre **garantita**, la seconda può essere sacrificata

## Attributo primo e non primo
- un **attributo primo** è un attributo che appartiene ad almeno una chiave candidata
- un **attributo non-primo** e un attributo che non è primo
---
## Forme normali
### Prima forma normale (1NF)
- La **prima** **forma** **normale** prescrive che una relazione non debba avere:
	- tuple ripetute
	- attributi composti e/o multi-valore
	
### Seconda forma normale (2NF)
- è in **1NF** e ogni attributo **non-primo** dipende funzionalmente dall'intera chiave primaria
- [[Argomento08 Normalizzazione.pdf#page=17&selection=0,13,2,13|esempio]]

> può essere violata solo se la chiave primaria è composta da più attributi
> se violata porta a ridondanza dei dati

### Terza forma normale (3NF)
- è in **2NF** e non ci sono attributi **non-primi** che dipendono transitivamente dalla chiave
- [[Argomento08 Normalizzazione.pdf#page=20&selection=0,19,0,19|esempio]]


### Forma normale di Boyce-Codd (BCNF)
- deve essere in **2NF**
- per ogni DF $X->Y$      
	- $X$ deve essere superchiave di $R$
