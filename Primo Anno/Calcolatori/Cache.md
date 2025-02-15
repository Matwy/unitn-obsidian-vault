---
date: 2024/05/20
tags: 
Materia: "[[Calcolatori]]"
Argomento: "[[Memoria]]"
---
## Cache
- Significa posto sicuro "nascosto" dove riporre le cose
- Nascosto perchè il programmatore non vi accede è un meccanismo completamente trasparente

#### Cache miss
- Quando vogliamo accedere ad un dato che **non si trova all'interno della cache**

#### Cache a mappatura diretta
- Ad ogni indirizzo della memoria corrisponde una precisa locazione della cache
- $\text{Indirizzo in cache} = \text{Indirizzo blocco modulo numero di blocchi in cache}$
- Si prendono i bit meno significativi dell'indirizzo in numero pari al logaritmo in base due della dimensione della cache
	- $\text{bit meno significativi da prendere} = log_{2}(dimensione\, cache)$
![[Pasted image 20240520112527.png|center|300]]
##### Riconoscimento del dato
- Dato che più blocchi possono essere associati allo stesso blocco di cache usiamo dei **tag** per distinguerli
- Possiamo ad esempio associare **ad ogni blocco di cache un tag** che **distingue** il blocco in memoria salvato in quell'instante
- Ad esempio prendendo le prime due cifre dell'indirizzo in memoria del dato in cache
##### Validità 
- E' inoltre presente un **bit** **di** **validità** per indicare se il dato memorizzato è valido
---
#### Trade off (località spaziale e località temporale)
- **pochi blocchi molto grandi**
	- **poco efficace a livello di località temporale** (non sfruttiamo i blocchi continui)
	- **buona la località spaziale** (diminuiamo la probabilità di miss)
	- Inoltre in caso di **miss** bisogna spostare molti byte 
![[Pasted image 20240521084840.png|center|450]]

---
## Cosa succede alla pipeline
- Il processore non si accorge della presenza della cache in caso di **hit**
- in caso di **miss** bisogna generare uno **stallo** nella pipeline e gestire il **trasferimento** da memoria principale alla cache  (circuiteria di controllo)
#### Gestione delle scritture
A livello di scrittura possiamo agire secondo diverse policy
##### Write-through
- Ogni scrittura viene fatta **in** **memoria** (sia che ci sia un miss o una hit)
- Così non ci sono problemi di consistenza ma sono costose
##### Write-back
- Se il blocco è in cache la **scrittura viene fatta in cache** e solo quando il blocco viene rimpiazzato scriviamo in memoria (oppure quando un altro processore prova ad accedere al blocco)
---
## Cache associative
- La cache a mappatura diretta che abbiamo visto fino ad adesso ha lo svantaggio che in caso di utilizzo di due blocchi di memoria che vanno scritti nello stesso blocco di cache c'è un continuo di **cache** **miss**
- Con le cache associative scriviamo un qualsiasi blocco in un qualsiasi posto in cache
	- questo però ci porta a dover **cercare tra tutti i blocchi** di cache
	- **costoso** dal punto di vista hardware (serve un comparatore per ogni cella)
	- si fa solo per cache **piccole**

---
## Cache set-associativa
- E' una via di mezzo tra le due
- Ogni blocco di memoria può essere mappato su una linea di n blocchi diversi di cache
	- Associamo ciascun blocco ad una certa linea 
	- All'interno della linea facciamo la ricerca parallela
---
#### Policy Cache associative
##### FIFO (First In First Out)
##### Least Recently Used
- Richiede una serie di bit in più per contare l'ultimo accesso
---
## Mappatura del blocco
#### Mappatura diretta
- `(indirizzo blocco) modulo (numero blocchi della cache)`
#### Set-associativa
- `(indirizzo blocco) modulo (numeo linee della cache)`
- poi si confrontano i **tag**
---
