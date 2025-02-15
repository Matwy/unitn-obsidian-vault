---
date: 2024/10/10
tags: 
Materia: "[[Basi di dati]]"
---
## Relazione
- Una **relazione** può essere vista come una tabella
- due livelli di definizione
	- Lo **schema della relazione**  (**livello intensionale**)
	- **istanze della relazione**  (**livello estensionale**)


#### Schema di una relazione (definizione intensionale)
- definisce
	- **nome** `esempio STUDENTI`
	- **nome degli attributi** `esempio SID NOME`
	- **dominio degli attributi**  insieme dei valori che l'attributo può assumere `esempio STRING INTEGER`

- Il numero degli attributi definisce il **grado** o arietà della relazione
##### Esempio
- grado 5
```
Students(sid:string, name:string, login:string, age:integer, gpa:real)
```

#### Relazioni (definizione estensionale)
- Una istanza di uno schema di relazione è un insieme di **tuple** o **record**
	- essendo un insieme NO duplicati
	- l'ordine non ha significato

- numero di istanze = **cardinalità**

#### Stato di una relazione
- Lo **stato di una relazione** è un sottoinsieme del prodotto cartesiano dei domini dei suoi attributi
![[Pasted image 20241010165220.png]]
![[Pasted image 20241010165344.png]]

#### Chiave di una relazione
- Ogni riga di una relazione può essere identificata con una **chiave**. La chiave può essere formata da uno o più campi.

#### Immagine riassuntiva
![[Pasted image 20241010165723.png]]
