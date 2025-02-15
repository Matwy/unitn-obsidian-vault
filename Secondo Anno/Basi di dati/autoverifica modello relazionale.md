---
date: 2024/10/22
tags: 
Materia: "[[Basi di dati]]"
---
## autoverifica modello relazionale
Schema di una relazione: lo schema di una relazione definisce la relazione a livello intensionale. definisce quindi  il nome della relazione il nome degli attributi e il dominio degli attributi

Lo schema di una base di dati definisce tutti gli schemi delle relazioni presenti nelle basi di dati e le loro relazioni

Un attributo è una "colonna della relazione" un attributo ha un nome e un dominio

Il dominio di un attributo è un insieme formato da tutti i valori che può assumere l'attributo

L'instanza di una relazione è la sua definizione estensionale. Quindi l'insieme delle tuple instanziate che rispettano le regole dello schema

Il  grado di una relazione è indicata dal numero dei suoi attributi e viene anche chiamata arietà

La cardinalità di una relazione è il numero di tuple instanziate in quella relazione

Una superchiave è un insieme di attributi tali che una volta instanziati non si possano ripetere in più tuple. Quindi data una superchiave possiamo sapere a che tupla si riferisce. Una chiave invece è una superchiave minimale, quindi una superchiave a cui non possiamo rimuovere più attributi senza violare l'unicità.
E' possibile che una relazione abbia più di una superchiave e anche che non ne abbia nessuna
Una chiave candidata è una chiave ed è possibile che esista più di una chiave in una relazione mentre la chiave primaria è solamente una in quanto viene scelta tra le chiavi candidate.

Con certezza possiamo dire che name e age non sono delle chiavi in quanto ci sono dei duplicati

Un vincolo di integrità referenziale tra R e S dove
- R è la tabella referenziante
- S è la tabella referenziata
- la chiave esterna di R deve puntare alla chiave primaria di S

Per chiave esterna intendiamo un attributo nella tabella referenziante che ha il valore della chiave primaria della tabella referenziata
Per integrità referenziale di una base di dati si intende la validità delle relazioni. Quindi
- la chiave esterna se non nulla deve essere una chiave primaria valida della tabella referenziata

Works ha due FK
- eid che punta alla chiave primaria di Emp
- did che punta alla chiave primaria di Dept

Se vogliamo cancellare una tupla solamente dalla tabella dept dobbiamo assicurarci che la tupla che vogliamo eliminare non sia referenziata dalla tabella works