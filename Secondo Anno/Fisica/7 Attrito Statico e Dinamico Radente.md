---
date: 2025/03/28
tags: 
Materia: "[[Fisica]]"
---
## Attrito statico e dinamico radente

- L’**attrito radente** è la forza che si oppone al moto (o al tentativo di moto) di un corpo che striscia su una superficie. È causato dalle interazioni microscopiche tra le superfici a contatto e agisce parallelamente alla superficie stessa, in direzione opposta a quella del moto o della tendenza al moto.

---

## Definizione di forza di attrito

- La forza di attrito può essere distinta in:
	- **Attrito statico**: quando il corpo è fermo o in procinto di muoversi.
	- **Attrito dinamico** (o cinetico): quando il corpo è già in movimento.

---

## Attrito statico

- L’attrito **statico** si manifesta quando il corpo non è ancora in moto. Se un oggetto è soggetto a una forza esterna (ad esempio la componente del peso lungo un piano inclinato), l’attrito statico si adatta (aumenta) fino a un valore massimo che può assumere, oltre il quale il corpo inizia a muoversi.

	- Il valore **massimo** dell’attrito statico è dato da 
 $$ 
  A_{s,\text{max}} = \mu_s \, N
  $$
  dove $\mu_s$ è il **coefficiente di attrito statico** e $N$ è la **forza normale**.

- In generale, l’attrito statico può variare da $0$ a $A_{s,\text{max}}$. Se la forza parallela alla superficie (ad esempio $mg \sin \theta$ su un piano inclinato) supera $A_{s,\text{max}}$, l’oggetto inizia a muoversi.

---

## Attrito dinamico

- Una volta che il corpo è in moto, l’attrito che agisce su di esso è detto **attrito dinamico** (o cinetico) ed è generalmente **costante** (a parità di condizioni, come velocità moderata e superficie uniforme).

- Il valore dell’attrito **dinamico** è 
 $$
  A_d = \mu_d \, N,
  $$
  dove $\mu_d$ è il **coefficiente di attrito dinamico** (tipicamente $\mu_d < \mu_s$).

- La forza di attrito dinamico si oppone sempre al moto, in direzione opposta alla velocità dell’oggetto.

---

## Esempio su piano inclinato

- Consideriamo un blocco di massa $m$ appoggiato su un piano inclinato di un angolo $\theta$. Le forze in gioco sono:
	1. La **forza peso** $P = mg$, diretta verticalmente verso il basso.
	2. La **reazione normale** $N$, perpendicolare al piano.
	3. L’**attrito** $A$, parallelo al piano e diretto in senso opposto allo scorrimento (o tendenza allo scorrimento).

### Componenti delle forze
- La componente del peso **normale** al piano è $mg \cos \theta$.
- La componente del peso **parallela** al piano è $mg \sin \theta$.

### Condizioni di equilibrio statico
- Se il blocco non scivola, la forza di attrito statico $A_s$ bilancia la componente parallela del peso:
$$
A_s = mg \sin \theta \quad \text{(se il blocco è fermo)}.
$$
- Ma l’attrito statico non può superare $A_{s,\text{max}} = \mu_s \, mg \cos \theta$.  
- Quindi, per rimanere fermo,
$$
mg \sin \theta \le \mu_s \, mg \cos \theta,
$$
- oppure
$$
\tan \theta \le \mu_s.
$$

### Se il blocco si muove
- Una volta superata la condizione di equilibrio (cioè se $mg \sin \theta > \mu_s \, mg \cos \theta$), il blocco inizia a muoversi. L’attrito diventa dinamico:
$$
A_d = \mu_d \, mg \cos \theta.
$$
- Tale forza si opporrà al moto, ma avrà un valore **costante** (a parità di velocità moderata e superficie uniforme) pari a $\mu_d \, mg \cos \theta$.

---

## Differenze principali tra attrito statico e dinamico

1. **Valore massimo vs. costante**:  
   - L’attrito statico può variare dal 0 fino a $\mu_s N$.  
   - L’attrito dinamico è costante, pari a $\mu_d N$.

2. **Coefficiente di attrito**:  
   - Per l’attrito statico si usa $\mu_s$.  
   - Per l’attrito dinamico si usa $\mu_d$.  
   In genere, $\mu_s > \mu_d$.

3. **Condizione di moto**:  
   - L’attrito statico agisce quando il corpo è fermo o sta per muoversi.  
   - L’attrito dinamico agisce quando il corpo è in movimento.