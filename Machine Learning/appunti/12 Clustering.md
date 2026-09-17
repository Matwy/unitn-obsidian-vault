---
date: 2026/06/13
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec12-Clustering.pdf]]"
---
## 12 Clustering

> [!abstract] Idea di fondo
> Il **clustering** è il task di unsupervised learning in cui vogliamo **raggruppare** un insieme di oggetti in classi di oggetti simili, **senza etichette** (nessuna supervisione). La lezione parte da **K-Means** (visto in [[11 Unsupervised Learning]]) e ne mostra i **limiti** (assume cluster sferici, assegnamento netto), poi introduce algoritmi via via più potenti: **EM clustering** (cluster ellittici + assegnamento *soft* probabilistico, basato su mixture di gaussiane), **Spectral clustering** (basato su grafo, gestisce forme non-convesse) e **Hierarchical clustering** (produce un dendrogramma, non serve fissare $k$). Il filo conduttore è: *quale algoritmo usare a seconda della forma dei cluster, del tipo di assegnamento e di quanto sappiamo su $k$*.

# 1. Cos'è il clustering

> [!important] Definizione
> **Clustering**: il processo di raggruppare un insieme di oggetti in **classi di oggetti simili**.

- Siamo in **unsupervised learning**: ci vengono dati i dati (esempi) **ma nessuna etichetta**.
- Pipeline tipica: **Raw Data → Feature Extraction → Feature Vectors → Clustering Algorithm → Clusters**. Cioè ogni oggetto viene prima trasformato in un **vettore di feature** $f_1, f_2, \dots, f_d$, e l'algoritmo di clustering lavora su quei vettori.

Le due domande chiave della lezione sono:
1. **Quali algoritmi** di clustering possiamo usare?
2. Quali sono i **problemi** (issues) del clustering?

# 2. I problemi (issues) del clustering

Prima di scegliere un algoritmo, dobbiamo decidere quattro cose:

| Issue | Domanda |
|---|---|
| **Representation** | Come rappresentiamo gli esempi? Tipicamente come **vettori di feature**. |
| **Similarity Metric** | Quale **distanza / misura di similarità** usare tra gli esempi? |
| **Clustering Type** | La struttura deve essere **flat** (partizioni) o **gerarchica** (alberi)? |
| **Number of Clusters** | $k$ è **fissato a priori** dall'utente o va scoperto **dai dati** (data-driven)? |

> [!note] Perché contano
> Queste scelte determinano *quale* algoritmo è adatto: ad esempio la **similarity metric** sbagliata raggruppa male i dati (vedi cosine vs euclidea in [[11 Unsupervised Learning]]), e la scelta **flat vs gerarchico** decide se otteniamo una sola partizione o un'intera famiglia di partizioni annidate.

# 3. Tipi di algoritmi di clustering

> [!example] Due grandi famiglie
> **Flat Algorithms** — producono una sola partizione "piatta":
> - K-Means clustering
> - Spectral clustering
>
> **Hierarchical Algorithms** — producono una gerarchia di cluster:
> - **Bottom-up, agglomerative** (parto dai singoli punti e li fondo)
> - **Top-down, divisive** (parto da un unico cluster e lo divido)

## Hard vs. Soft clustering

- **Hard clustering**: ogni esempio appartiene a **esattamente un** cluster.
	- Esempio: **K-Means**.
- **Soft clustering**: un esempio può appartenere a **più di un cluster** (assegnamento **probabilistico**).
	- Ha più senso per applicazioni come la creazione di **gerarchie navigabili**: es. un paio di sneakers può stare in due cluster, *(i) abbigliamento sportivo* e *(ii) scarpe*.

# 4. I problemi di K-Means

K-Means (visto in [[11 Unsupervised Learning]]) è l'algoritmo più usato, ma ha due **limiti** fondamentali.

> [!warning] Limite 1 — assume cluster SFERICI
> K-Means assegna ogni punto al **centroide più vicino** in distanza euclidea. Questo equivale ad assumere che i cluster siano **sferici** (blob tondi, tutti della stessa "larghezza" in ogni direzione). Se i veri cluster sono **allungati / ellittici** o di forma irregolare, K-Means li taglia male.

> [!warning] Limite 2 — assegnamento HARD
> Ogni punto finisce in un solo cluster, anche quando sta "a metà strada" tra due gruppi. Si perde l'informazione sull'**incertezza** dell'assegnamento.

Da qui la domanda: *e se i cluster non fossero sferici?* La risposta è **EM clustering**.

# 5. EM Clustering (Expectation-Maximization)

> [!important] Idea
> **Expectation Maximization (EM)**: assumiamo che i dati siano stati generati da una **mixture di gaussiane** (quindi dati **ellittici**) e assegniamo ogni punto a un cluster **con una certa probabilità** → è un **soft clustering**.

**Soft assignment (esempio):** un punto può avere $p(\text{red}) = 0.8$, $p(\text{blue}) = 0.2$; un altro $p(\text{red}) = 0.9$, $p(\text{blue}) = 0.1$. Le probabilità di appartenenza ai cluster **sommano a 1** per ogni punto.

EM è **molto simile a K-Means ad alto livello**: si itera tra *assegnare i punti* e *ricalcolare i centri*. Ci sono però **due differenze principali**:
1. Assumiamo cluster **ellittici** (invece che sferici);
2. È un algoritmo di **soft clustering** (invece che hard).

## Il modello: mixture di gaussiane

> [!important] Modello generativo
> La probabilità di un punto $x_n$ è una **somma pesata** di $K$ gaussiane:
> $$p(x_n) = \sum_{k=1}^{K} \pi_k \, \mathcal{N}(x_n \mid \mu_k, \Sigma_k)$$
> con i **vincoli**:
> $$\sum_{k=1}^{K} \pi_k = 1, \qquad \pi_k \ge 0$$

Cosa è cosa nella formula:
- $\mathcal{N}(x_n \mid \mu_k, \Sigma_k)$ → la **$k$-esima gaussiana** (componente della mixture), con **media** $\mu_k$ (il *centro* del cluster) e **matrice di covarianza** $\Sigma_k$ (la *forma e orientamento* dell'ellisse del cluster);
- $\pi_k$ → i **mixing coefficients** (coefficienti di mescolamento): il "peso" della componente $k$, cioè quanto quel cluster è grande/probabile a priori. I vincoli dicono che sono numeri **non negativi** che **sommano a 1**, quindi si comportano come una distribuzione di probabilità sulle componenti.

> [!note] Ripasso — gaussiana in 2D
> Una gaussiana 2D è una "collina" di probabilità. È la **matrice di covarianza** $\Sigma$ a determinare la **forma dei suoi contorni** (le curve di livello): sferica se $\Sigma$ è multipla dell'identità, ellittica e ruotata se $\Sigma$ ha termini fuori diagonale. È proprio questa libertà sulla forma che rende EM più flessibile di K-Means.

## Il processo EM

> [!example] Schema generale
> **Initialization** → si parte da alcuni centri di cluster iniziali (cioè dai parametri iniziali).
>
> **E-Step** (*Expectation / Soft Assignment*): assegnamento soft dei punti → si calcola la **probabilità che ogni punto appartenga a ogni cluster**.
>
> **M-Step** (*Maximization / Update*): si ricalcolano i centri → si calcolano i **nuovi parametri** dei cluster, quelli di **massima verosimiglianza** dato l'attuale soft clustering.
>
> Si **itera** tra E-step e M-step fino a **convergenza**.

### Inizializzazione & E-Step

Si inizializzano i parametri delle $K$ componenti:
$$\{\pi_k^{(0)}, \mu_k^{(0)}, \Sigma_k^{(0)}\}_{k=1}^{K}$$

Nell'**E-step** si calcolano le **responsabilità** (responsibilities) $\gamma_{nk}$ per ogni punto $n$ e ogni componente $k$:
$$\gamma_{nk} = P(z_n = k \mid x_n) = \frac{\pi_k \, \mathcal{N}(x_n \mid \mu_k, \Sigma_k)}{\sum_{j=1}^{K} \pi_j \, \mathcal{N}(x_n \mid \mu_j, \Sigma_j)}$$

Cosa è cosa:
- $z_n$ → la variabile (nascosta) che dice "a quale cluster appartiene il punto $n$"; $\gamma_{nk}$ è la **probabilità a posteriori** che il punto $n$ sia stato generato dal cluster $k$;
- il **numeratore** $\pi_k \mathcal{N}(x_n \mid \mu_k, \Sigma_k)$ → quanto "bene" la componente $k$ spiega il punto $x_n$, pesata per la sua importanza $\pi_k$;
- il **denominatore** $\sum_j \pi_j \mathcal{N}(\dots)$ → la somma su **tutte** le componenti, serve a **normalizzare** così che $\sum_k \gamma_{nk} = 1$. È esattamente il "soft assignment": invece di dire "0 oppure 1" come K-Means, $\gamma_{nk}$ è un numero tra 0 e 1.

### M-Step

Si aggiornano i parametri usando le responsabilità appena calcolate. Prima il **numero effettivo di punti** assegnati (in modo soft) alla componente $k$:
$$N_k = \sum_{n=1}^{N} \gamma_{nk}$$
È come "contare" i punti del cluster $k$, ma contando ogni punto solo per la sua frazione di appartenenza.

**Aggiorna i mixing coefficients** (la frazione di massa totale catturata dal cluster $k$):
$$\pi_k = \frac{N_k}{N}$$

**Aggiorna le medie** (centro del cluster = media dei punti **pesata** dalle responsabilità):
$$\mu_k = \frac{1}{N_k} \sum_{n=1}^{N} \gamma_{nk} \, x_n$$

**Aggiorna le covarianze** (la forma dell'ellisse, sempre pesata dalle responsabilità):
$$\Sigma_k = \frac{1}{N_k} \sum_{n=1}^{N} \gamma_{nk} (x_n - \mu_k)(x_n - \mu_k)^T$$

> [!note] Come leggere queste formule
> Sono le **stesse formule** di media e covarianza viste in [[11 Unsupervised Learning]], ma con un **peso** $\gamma_{nk}$ davanti a ogni punto. I punti "molto sicuri" di appartenere al cluster $k$ contribuiscono molto a $\mu_k$ e $\Sigma_k$; quelli incerti contribuiscono poco. Da qui la frase nelle slide: *i centri ricevono un contributo **pesato** dai punti*. Il prodotto esterno $(x_n - \mu_k)(x_n - \mu_k)^T$ è una matrice (non uno scalare) e cattura come i dati si "spalmano" nelle varie direzioni → cioè l'orientamento e l'allungamento dell'ellisse.

## EM: riepilogo

- **Simile a K-Means**: l'E-step è il passo di "**assegnamento**", l'M-step è il passo di "**update**".
- Ogni iterazione **aumenta la likelihood** dei dati ed è **garantito convergere** (ma a un **ottimo locale**, non necessariamente globale).
- Il numero di componenti $K$ resta un **parametro libero** (come $k$ in K-Means).
- Si consigliano **restart multipli**: il risultato può variare molto tra esecuzioni diverse (per via dei minimi locali).
- EM **non serve solo per il clustering**, mentre K-Means serve solo per quello: EM è un **approccio generale** per addestrare un modello quando **non si hanno etichette**.

# 6. Spectral Clustering

> [!warning] Il problema dei dati non-gaussiani
> K-Means ed EM **faticano** con geometrie complesse, **non sferiche** (es. due cerchi concentrici, "lune"). Come nella classificazione, c'è una distinzione tra confini **globali** (lineari) e **locali** (tipo k-NN). La **soluzione** per le forme arbitrarie è lo **Spectral Clustering**.

> [!important] Idea
> **Raggruppare i punti in base ai collegamenti (link) in un grafo**, non in base alla loro vicinanza euclidea diretta. Costruisco un grafo dove i punti simili sono connessi, poi "taglio" il grafo nei punti deboli.

## Step 1 — Costruire un grafo

- Possiamo costruire un **grafo completamente connesso** (fully connected) oppure un **grafo dei $K$ vicini più vicini** (K-nearest neighbor graph), in cui ogni nodo è connesso solo ai suoi $K$ nodi più vicini.
- Mettiamo sugli archi una **nozione di similarità** tra i nodi. È comune usare un **kernel gaussiano**:
$$W(i,j) = \exp\!\left( \frac{-|x_i - x_j|^2}{\sigma^2} \right)$$

Cosa è cosa:
- $W(i,j)$ → il **peso dell'arco** tra il nodo $i$ e il nodo $j$ (quanto sono simili);
- $|x_i - x_j|^2$ → distanza (al quadrato) tra i due punti: più sono **vicini**, più $W$ è **vicino a 1**; più sono **lontani**, più $W \to 0$;
- $\sigma$ → parametro di "scala" che decide quanto velocemente la similarità decade con la distanza.

> [!warning] Costo
> Un grafo completamente connesso ha $O(n^2)$ archi → **costoso per dataset grandi**.

## Step 2 — Partizionare il grafo

Definisco una **matrice di similarità** (la matrice $W$) e poi **taglio il grafo**: lo partiziono in $K$ gruppi rimuovendo gli archi **meno numerosi / più leggeri** (i collegamenti deboli). I punti dello stesso cluster restano fortemente connessi tra loro.

## Terminologia sui grafi

> [!note] Grado di un nodo
> $$d_i = \sum_j w_{i,j}$$
> Somma dei pesi di **tutti gli archi** che toccano il nodo $i$ → quanto quel nodo è "connesso" complessivamente.

> [!note] Volume di un insieme
> $$vol(A) = \sum_{i \in A} d_i, \qquad A \subseteq V$$
> Somma dei gradi dei nodi che stanno nell'insieme (cluster) $A$ → una misura della "dimensione/massa" del cluster nel grafo.

## Graph cut

- Considero una partizione del grafo in due parti $A$ e $B$.
- $Cut(A,B)$ → la **somma dei pesi degli archi che collegano i due gruppi** (gli archi "tagliati").
- Obiettivo intuitivo: trovare la partizione che **minimizza il cut** (taglio i collegamenti più deboli).
	- *Esempio dalle slide:* con due gruppi collegati da archi di peso 0.1 e 0.2, $Cut(A,B) = 0.3$.

> [!warning] Perché il min-cut "puro" non basta
> Minimizzare solo $Cut(A,B)$ tende a **isolare un singolo punto** (o pochissimi): basta tagliare i suoi pochi archi deboli. Serve **normalizzare**.

## Normalized cut

> [!important] Obiettivo da minimizzare
> $$NCut(A,B) = \frac{Cut(A,B)}{Vol(A)} + \frac{Cut(A,B)}{Vol(B)}$$

- Dividendo per il **volume** di ciascun cluster, si **scoraggiano partizioni minuscole e isolate**: un cluster piccolo ha volume piccolo → il rapporto esplode → la soluzione viene penalizzata. Così i due lati del taglio tendono ad essere **bilanciati**.
- Questo problema si può formalizzare come un problema di **ottimizzazione discreta**, poi **rilassato nel dominio continuo**, diventando un **problema agli autovalori generalizzato** (da qui il nome *spectral*, lo "spettro" = gli autovalori). Si riusa quindi l'algebra di autovalori/autovettori vista per la [[11 Unsupervised Learning|PCA]], ma applicata al **Laplaciano del grafo**.

## L'algoritmo di Ng et al.

Il **Normalized Cut** è la **fondazione teorica** (e il primo algoritmo); l'algoritmo di **Ng, Jordan & Weiss** ne è una **variante pratica**. Dati $n$ punti $S = \{s_1, \dots, s_n\}$ da raggruppare in $k$ cluster:

1. Costruisci la **matrice di affinità** $A \in \mathbb{R}^{n \times n}$ con $A_{ij} = \exp(-\|s_i - s_j\|^2 / \sigma^2)$ se $i \ne j$, e $A_{ii} = 0$ (zero sulla diagonale).
2. Definisci $D$ come la **matrice diagonale** il cui elemento $(i,i)$ è la **somma della $i$-esima riga** di $A$ (cioè i gradi), e costruisci $L = D^{-1/2} A D^{-1/2}$ (il **Laplaciano normalizzato**).
3. Trova $x_1, x_2, \dots, x_k$, i **$k$ autovettori più grandi** di $L$, e impilali in colonna formando la matrice $X \in \mathbb{R}^{n \times k}$.
4. Forma $Y$ **rinormalizzando ogni riga** di $X$ a lunghezza unitaria.
5. Tratta ogni **riga di $Y$** come un punto in $\mathbb{R}^k$ e raggruppale in $k$ cluster con **K-Means**.
6. Assegna il punto originale $s_i$ al cluster $j$ **se e solo se** la riga $i$ di $Y$ è stata assegnata al cluster $j$.

> [!note] L'intuizione
> Spectral clustering **non** raggruppa i punti nello spazio originale: prima li **rimappa** (tramite gli autovettori del grafo) in un nuovo spazio in cui i cluster diventano **sferici e ben separati**, e *lì* applica K-Means. È così che riesce a separare forme che K-Means da solo non saprebbe gestire — es. **due cerchi concentrici**, **spirali/squiggles**, cerchi annidati.

# 7. Hierarchical Clustering

> [!important] Idea
> Produce un insieme di **cluster annidati** organizzati come un **albero gerarchico**. L'albero si chiama **dendrogramma**. Esempio classico: i **profili genici** (gene profiles), dove si vuole vedere quali geni si comportano in modo simile a vari livelli.

Il **vantaggio** chiave: **non** richiede di fissare $k$ a priori — il dendrogramma rappresenta *tutte* le partizioni possibili, e si sceglie il livello a cui "tagliarlo".

## Agglomerative clustering (bottom-up)

> [!example] Algoritmo
> **Idea**: prima fondo le istanze molto simili, poi costruisco incrementalmente cluster più grandi a partire da quelli piccoli.
>
> - All'inizio, **ogni istanza è un proprio cluster**.
> - **Ripeti**:
> 	- scegli i **due cluster più vicini**;
> 	- **fondili** in un nuovo cluster;
> 	- **fermati** quando resta **un solo cluster**.
>
> Non produce una singola partizione, ma **una famiglia di clustering** rappresentata dal **dendrogramma**.

## Come definire "più vicino"? (Linkage)

Quando i cluster hanno **più elementi**, cosa vuol dire "distanza tra due cluster"? Scelte diverse (il **linkage criterion**) danno soluzioni diverse:

| Linkage | "Distanza" tra cluster = |
|---|---|
| **Nearest / Single** | distanza della **coppia più vicina** di punti |
| **Farthest / Complete** | distanza della **coppia più lontana** di punti |
| **Average** | **media** di tutte le distanze tra le coppie |

> [!note] Effetto pratico
> La scelta del linkage cambia la **forma** dei cluster e quindi l'aspetto del dendrogramma: *single linkage* tende a creare catene allungate, *complete linkage* cluster più compatti, *average* sta nel mezzo.

# 8. Riepilogo degli algoritmi

| Proprietà | **K-Means** | **EM** | **Spectral** | **Hierarchical (Agglom.)** |
|---|---|---|---|---|
| **Assegnamento** | Hard | Soft (probabilistico) | Hard (via K-Means) | Hard |
| **Forma cluster** | Solo sferici | Ellittici | Qualsiasi forma | Qualsiasi (dipende dal linkage) |
| **Richiede $k$** | Sì | Sì | Sì | No |
| **Scalabilità** | Eccellente | Moderata | Scarsa | Scarsa |
| **Punto di forza** | Veloce, scalabile | Membership soft/incerta | Cluster non-convessi | Niente $k$, gerarchia |
| **Uso tipico** | Dati su larga scala | Cluster sovrapposti | Forme non-lineari | Espressione genica |

> [!success] Quale usare?
> - **K-Means** = veloce → *provalo per primo*.
> - **EM** = quando serve assegnamento **soft** / cluster ellittici sovrapposti.
> - **Spectral** = quando conta la **forma** (cluster non-convessi, non-lineari).
> - **Hierarchical** = quando $k$ è **sconosciuto** e vuoi una gerarchia.

---

# Da padroneggiare

- **Issues del clustering**: representation, similarity metric, flat vs gerarchico, numero di cluster.
- **Hard vs soft**: K-Means è hard; EM è soft (probabilistico).
- **Limiti di K-Means**: assume cluster **sferici** + assegnamento **hard**.
- **EM**: mixture di gaussiane $p(x_n) = \sum_k \pi_k \mathcal{N}(x_n \mid \mu_k, \Sigma_k)$; E-step calcola le **responsabilità** $\gamma_{nk}$; M-step aggiorna $\pi_k, \mu_k, \Sigma_k$ con somme **pesate** da $\gamma_{nk}$. Converge a un **ottimo locale**, aumenta la likelihood, è generale (non solo clustering).
- **Spectral clustering**: costruisci un grafo (kernel gaussiano $W(i,j) = \exp(-|x_i-x_j|^2/\sigma^2)$), poi **taglia** il grafo minimizzando il **Normalized Cut** $\frac{Cut(A,B)}{Vol(A)} + \frac{Cut(A,B)}{Vol(B)}$ → problema agli **autovalori** sul Laplaciano. Gestisce **forme arbitrarie**.
- **Grafi**: grado $d_i = \sum_j w_{i,j}$, volume $vol(A) = \sum_{i \in A} d_i$, $Cut(A,B)$ = peso degli archi tra i due gruppi.
- **Hierarchical (agglomerative)**: bottom-up, fonde i due cluster più vicini → **dendrogramma**; non serve $k$; il **linkage** (single / complete / average) decide cosa vuol dire "vicino".
