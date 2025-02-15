---
date: 2024/12/06
tags: 
Materia: "[[Basi di dati]]"
---
## Dipendenze funzionali
- sia $r$ una relazione sullo schema $R(X)$ 
- siano $Y$ e $Z$ due sottoinsiemi non vuoti di $X$
- $Z$ dipende funzionalmente da $Y(Y \rightarrow Z)$  se per ogni coppia di tuple $t_{1}$ e $t_{2}$ di $r$ vale che 
$$
t_{1}[Y] =t_{2}[Y] \,\text{  allora  } t_{1}[Z]=t_{2}[Z]
$$
> ovvero se $t_{1}$ e $t_2$ hanno gli stessi valori su $Y$ allora hanno gli stessi valori anche su $Z$ 
----
#### DF banali
- una **DF** Y->A è **banale** se A appartiene a Y
	- esempio `Impiegato, stipendio -> stipendio` 
- una **DF** **non** **banale** è tale se nessun attributo in A appartiene a Y
----
#### DF e chiavi
- se prendiamo una chiave $K$ di una relazione $R$ si può verificare che esiste una DF tra $K$ e ogni altro attributo dello schema $R$
- Quindi **il concetto di DF generalizza quello di vincolo di chiave**
- Una DF Y->Z su uno schema $R(X)$ degenera in un vincolo di chiave se $Y \cup Z=X$. In tal caso $Y$ è una super chiave per lo schema $R(X)$
---
#### Anomalie
- Una DF che contiene una  chiave nella sua parte sinistra per definizione non può generare ridondanze.
---
## Chiusura di un insieme di dipendenze funzionali
- Dato un insieme $F$ di dipendenze funzionali è possibile calcolare altre DF logicamente implicate da $F$
	- esempio se $X \Rightarrow Y$ e $Y \Rightarrow Z$ allora $X \Rightarrow Z$

- L'insieme di **tutte** le **DF** logicamente implicate da $F$ si chiama la **chiusura** di $F$ e viene indicata con la notazione  $F^{+}$

#### Assiomi di Armstrong
- Gli **AA** sono in grado di generare **tutte e sole** le **DF** logicamente implicate da $F$
- $F^{+}$ può essere calcolato mediante gli **Assiomi di Armstrong (AA)**
	- **Assioma di riflessività**: se $Y \subseteq X$, allora $X \to Y$  
	- **Assioma di aumento**: se $X \to Y$, allora $XZ \to YZ$  
	- **Assioma di transitività**: se $X \to Y$ e $Y \to Z$, allora $X \to Z$  

Dagli AA si possono ottenere altre due regole derivate:
	- **Unione**: Se $X \to Y$ e $X \to Z$, allora $X \to YZ$  
	- **Scomposizione**: Se $X \to YZ$, allora $X \to Y$ e $X \to Z$

---
## Algoritmo per calcolare la chiusura di un insieme di attributi

La **chiusura** di un insieme di attributi $X$, denotata con $X^+$, è l'insieme di tutti gli attributi che possono essere derivati da $X$ utilizzando le dipendenze funzionali (DF) di un insieme $F$. Ecco come calcolare la chiusura:
### Algoritmo
1. **Inizializzazione**:  
   Poniamo $X^+ = X$, ovvero la chiusura iniziale di $X$ contiene gli stessi attributi di $X$.
   
2. **Applicazione delle dipendenze funzionali**:  
   Per ogni dipendenza funzionale $Z \to W$ in $F$, verifica se $Z \subseteq X^+$ (ovvero se tutti gli attributi di $Z$ sono già nella chiusura $X^+$).  
   - Se sì, aggiungi gli attributi di $W$ a $X^+$.  

3. **Ripeti il processo**:  
   Continua ad applicare le dipendenze funzionali finché non è possibile aggiungere ulteriori attributi a $X^+$.

4. **Risultato**:  
   La chiusura $X^+$ sarà l'insieme di tutti gli attributi derivabili da $X$.

---

### Esempio: Calcolo della chiusura di $A$

#### Dati
- Insieme di dipendenze funzionali:  
  $F = \{ A \to B, B \to C, AC \to D \}$  

- Insieme iniziale di attributi: $X = \{ A \}$

#### Passaggi
1. **Inizializzazione**:  
   Poniamo $X^+ = \{ A \}$.

2. **Prima iterazione**:  
   - Consideriamo la DF $A \to B$: $A \subseteq X^+$, quindi aggiungiamo $B$ a $X^+$.  
   - Ora $X^+ = \{ A, B \}$.

3. **Seconda iterazione**:  
   - Consideriamo la DF $B \to C$: $B \subseteq X^+$, quindi aggiungiamo $C$ a $X^+$.  
   - Ora $X^+ = \{ A, B, C \}$.

4. **Terza iterazione**:  
   - Consideriamo la DF $AC \to D$: $A, C \subseteq X^+$, quindi aggiungiamo $D$ a $X^+$.  
   - Ora $X^+ = \{ A, B, C, D \}$.

5. **Fine**:  
   Non è più possibile aggiungere altri attributi a $X^+$. La chiusura di $A$ è quindi:  
   $$A^+ = \{ A, B, C, D \}$$
---
## Copertura minimale di un insieme di DF

Una **copertura minimale** di un insieme di dipendenze funzionali (DF) $F$ è un insieme $F_{\text{min}}$ che soddisfa le seguenti proprietà:

1. **Equivalenza logica**: $F_{\text{min}}^+ = F^+$ (le chiusure di $F_{\text{min}}$ e $F$ sono identiche).
2. **Forma standard**: Ogni DF in $F_{\text{min}}$ è nella forma $X \to A$, dove $A$ è un singolo attributo.
3. **Irreducibilità**:
   - Non è possibile rimuovere una DF da $F_{\text{min}}$ senza perdere l'equivalenza con $F$.
   - Non è possibile rimuovere un attributo dal lato sinistro di una DF in $F_{\text{min}}$ senza perdere l'equivalenza con $F$.

### Algoritmo
#### Step 1: Normalizzazione
Ogni DF con più di un attributo sul lato destro ($X \to ABC\ldots$) deve essere trasformata in forma canonica, ovvero in un insieme di DF della forma:
- $X \to A$  
- $X \to B$  
- $X \to C$  
#### Step 2: Rimozione di attributi estranei
Identificare e rimuovere gli attributi ridondanti dal lato sinistro delle DF:  
1. Prendi una DF della forma $XA \to B$.
2. Verifica se $B \in X^+$ usando il resto delle DF (senza $XA \to B$):
   - Se sì, allora $A$ è ridondante. Sostituisci $XA \to B$ con $X \to B$.
   - Altrimenti, $A$ non può essere rimosso.

![[Pasted image 20241213170143.png]]
#### Step 3: Eliminazione delle DF ridondanti
Rimuovere eventuali DF superflue:  
1. Prendi una DF della forma $X \to A$.
2. Rimuovila temporaneamente dall'insieme, ottenendo $M'$.
3. Verifica se $A \in X^+$ usando $M'$:
   - Se sì, la DF $X \to A$ è ridondante e può essere eliminata.
   - Altrimenti, la DF non è ridondante e deve essere mantenuta.

---
