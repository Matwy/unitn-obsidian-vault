---
date: 2026-06-14
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec15-Generative Models.pdf]]"
---
## 15 Modelli Generativi (Deep Generative Models)

> [!abstract] Idea di fondo
> Finora abbiamo per lo più costruito modelli **discriminativi** (predire $y$ dato $x$). Un **modello generativo** punta invece a modellare la **distribuzione dei dati** $p_{data}$, così da poter **generare** nuovi campioni realistici (immagini, volti, ecc.). Il problema centrale è la **density estimation**: trovare una distribuzione $q$ che assomigli il più possibile a $p_{data}$, misurando la "distanza" con una **divergenza** (es. KL). La lezione presenta i due grandi approcci del deep learning: i **VAE** (density *esplicita*, una versione probabilistica degli autoencoder di [[14 Reti Neurali II - Ottimizzazione e CNN|Lec14]]) e le **GAN** (density *implicita*, un gioco a due giocatori tra generatore e discriminatore). Entrambi partono da una **distribuzione semplice** (un prior gaussiano) e imparano un **decoder/generatore** che la trasforma nella complessa distribuzione dei dati reali.

# 1. Generativo vs Discriminativo

> [!important] Definizioni
> - **Modelli generativi**: modelli statistici della **distribuzione dei dati** $p_X$ (solo input) oppure $p_{XY}$ (input + target), a seconda della disponibilità di etichette.
> - **Modelli discriminativi**: modelli statistici della **distribuzione condizionata** $p_{Y|X}$ del target dato l'input.

Un modello discriminativo si può **costruire da uno generativo** tramite la regola di Bayes (ma **non viceversa**):
$$p_{Y|X}(y \mid x) = \frac{p_{XY}(x, y)}{\sum_{y'} p_{XY}(x, y')} = \frac{p_{XY}(x,y)}{p_X(x)}$$
- numeratore → probabilità **congiunta** di $(x,y)$; denominatore $\sum_{y'} p_{XY}(x, y') = p_X(x)$ → la **marginale** su $x$ (somma su tutte le possibili $y'$), che **normalizza**. Cioè: se conosco la congiunta posso ricavare la condizionata, ma conoscere solo la condizionata non basta a ricostruire la congiunta. *I modelli generativi "sanno di più".*

# 2. Density estimation: esplicita vs implicita

> [!important] Esplicita
> Trovare una **distribuzione di probabilità** $f \in \Delta(\mathcal{Z})$ che **fitti i dati**, dove $z \in \mathcal{Z}$ è campionato da una distribuzione **sconosciuta** $p_{data} \in \Delta(\mathcal{Z})$.
> - In **supervised learning** $\mathcal{Z} = \mathcal{X} \times \mathcal{Y}$ (dati + etichette); in **unsupervised learning** $\mathcal{Z} = \mathcal{X}$ (solo dati).
> - "Esplicita" perché il modello fornisce **direttamente** la densità $f(z)$ (posso valutare quanto è probabile un punto).

> [!important] Implicita
> Trovare una **funzione** $f \in \mathcal{Z}^{\Omega}$ che **genera dati** $f(\omega) \in \mathcal{Z}$ a partire da un input $\omega$ campionato da una distribuzione **predefinita** $p_\omega \in \Delta(\Omega)$, in modo che la **distribuzione dei campioni generati** assomigli a $p_{data}$.
> - "Implicita" perché **non** ho una formula per la densità: so solo **campionare** (genero $\omega$ semplice → $f$ lo trasforma in un dato $x$). $f$ trasporta il prior semplice $p_\omega$ verso la complessa $p_{data}$.

# 3. L'obiettivo comune

> [!important] Schema generale
> 1. Definisci uno **spazio delle ipotesi** $\mathcal{H} \subset \Delta(\mathcal{Z})$ di modelli che rappresentano distribuzioni (in modo implicito o esplicito).
> 2. Definisci una **misura di divergenza** $d$ tra distribuzioni (es. **Kullback-Leibler**).
> 3. Trova l'ipotesi $q^\star$ che **meglio fitta** i dati distribuiti secondo $p_{data}$:
> $$q^\star \in \arg\min_{q \in \mathcal{H}} d(p_{data}, q)$$
> - $d(p_{data}, q)$ → quanto la distribuzione candidata $q$ è "lontana" dai dati reali; cerchiamo la $q$ che minimizza questa distanza. *Nel resto della lezione si assume $\mathcal{Z} = \mathcal{X}$ (caso non supervisionato).*

I due metodi di oggi:
- **Variational AutoEncoders (VAE)** → **density esplicita**.
- **Generative Adversarial Networks (GAN)** → **density implicita**.

# 4. Variational AutoEncoders (VAE)

Introdotti nel 2014 da **Kingma e Welling**. **Idea**: dare un "**twist probabilistico**" agli autoencoder tradizionali.

## Ripasso: autoencoder

(Vedi [[14 Reti Neurali II - Ottimizzazione e CNN]].) Un autoencoder comprime dati ad alta dimensione in una rappresentazione a bassa dimensione: un **encoder** mappa $x$ in una **rappresentazione compressa** $\omega$ che conserva i fattori di variazione significativi (la **PCA** è un encoder lineare). Si addestra tramite un **decoder** che rimappa $\omega$ all'input ottenendo la ricostruzione $\hat{x}$ — minimizzando la **divergenza tra input e ricostruzione**. Finito il training si **butta il decoder**; l'encoder serve a inizializzare/pre-calcolare feature per modelli supervisionati.

## L'autoencoder è un modello generativo?

> [!warning] No (così com'è)
> Il decoder **potrebbe** generare nuovi dati (gli dai un $\omega$ a caso e produce $\hat{x}$), ma **non** genererà dati secondo $p_{data}$. Generando $\omega$ a caso si finisce in regioni dello spazio latente che l'encoder non ha mai "riempito" → il decoder produce **dati non validi**. Manca un **controllo sulla distribuzione del latente**.

> [!note] Cosa vorremmo
> Vorremmo che, **campionando** $\omega$ da una **distribuzione prior** $p(\omega)$ semplice e passandolo nel decoder, si ottenessero punti ad **alta probabilità** sotto $p_{data}$. Cioè: il decoder deve trasformare il prior nella distribuzione dei dati.

## In formule

> [!important] Modello
> La densità del modello è
> $$q_\theta(x) = \mathbb{E}_{\omega \sim p_\omega}\big[q_\theta(x \mid \omega)\big]$$
> - $q_\theta(x \mid \omega)$ → il **decoder** (probabilità di generare $x$ dato il latente $\omega$), con parametri $\theta$; $p_\omega$ → il **prior** sul latente; l'**aspettazione** media su tutti i possibili $\omega$.
> - **Obiettivo**: $\theta^\star \in \arg\min_\theta d(q_\theta, p_{data})$, usando la **divergenza KL**:
> $$d_{KL}(p, q) = \mathbb{E}_{x \sim p}\left[\log \frac{p(x)}{q(x)}\right]$$
> - misura quanto $q$ si discosta da $p$: vale 0 se $p=q$, cresce quanto più $q$ "sbaglia" dove $p$ ha massa.

## L'obiettivo è intrattabile

Sviluppando la KL tra dati e modello:
$$d_{KL}(p_{data}, q_\theta) = \mathbb{E}_{x \sim p_{data}}\left[\log \frac{p_{data}(x)}{q_\theta(x)}\right] = -\mathbb{E}_{x \sim p_{data}}[\log q_\theta(x)] + \text{const}$$
$$= -\mathbb{E}_{x \sim p_{data}}\Big[\log \underbrace{\mathbb{E}_{\omega \sim p_\omega}[q_\theta(x \mid \omega)]}_{\textbf{intrattabile}}\Big] + \text{const}$$
- Il termine $\log p_{data}(x)$ non dipende da $\theta$ → finisce in `const`. Resta da massimizzare $\mathbb{E}[\log q_\theta(x)]$, ma $q_\theta(x) = \mathbb{E}_{\omega}[q_\theta(x|\omega)]$ è un'**aspettazione su tutto lo spazio latente** → **non calcolabile** in pratica (integrale enorme).

## Il bound variazionale (il trucco chiave)

> [!tip] L'idea ad alto livello (cosa stiamo minimizzando davvero)
> Quello che **vorremmo** minimizzare è la distanza tra la distribuzione vera dei dati $p_{data}$ e quella del nostro modello $q_\theta$ — ma non sappiamo calcolarla (è **intrattabile**: richiederebbe di considerare *tutti* i possibili latenti $\omega$ per ogni dato).
>
> Il **trucco**: invece di minimizzare quella quantità impossibile, minimizziamo un suo **"tetto" (upper bound)** — una quantità che sta sempre **sopra** quella vera ed è invece **calcolabile**. Spingendo giù il tetto, spingiamo giù anche la quantità vera che ci sta sotto. È come non poter misurare l'altezza di una stanza ma poter abbassare il soffitto: se abbasso il soffitto, il pavimento per forza si avvicina.
>
> Questo "tetto" si rivela essere la somma di **due termini con un significato concreto**, ed è esattamente ciò che minimizziamo in pratica:
> 1. **Termine di ricostruzione** — "se codifico un dato $x$ nel latente e poi lo ridecodifico, riottengo $x$?" Misura quanto bene la coppia encoder→decoder **ricostruisce l'input** (è la stessa idea dell'autoencoder normale).
> 2. **Termine di regolarizzazione** — "la distribuzione dei codici latenti prodotti dall'encoder assomiglia al **prior** semplice (la gaussiana $\mathcal{N}(0,I)$)?" Costringe lo spazio latente a essere **ordinato e campionabile**.
>
> **Perché servono entrambi**: con la **sola ricostruzione** otterrei un buon autoencoder, ma il latente sarebbe "bucato" e disordinato → campionando $\omega$ a caso genererei spazzatura (è proprio il problema dell'autoencoder visto prima). Con la **sola regolarizzazione** il latente seguirebbe il prior ma non conterrebbe informazione utile sui dati. È il **bilanciamento** dei due — ricostruire bene *e* tenere il latente ordinato — che rende il VAE capace di **generare** dati nuovi e sensati. In una frase: *minimizziamo l'errore di ricostruzione tenendo al tempo stesso lo spazio latente vicino a una distribuzione semplice da cui sappiamo campionare.*

Si introduce una **distribuzione di encoding** $q_\psi(\omega \mid x) \in \Delta(\Omega)$ (con **altri parametri** $\psi$ — è l'**encoder**). Riscrivendo e applicando la **disuguaglianza di Jensen**:
$$\log \mathbb{E}_{\omega \sim p_\omega}[q_\theta(x \mid \omega)] = \log \mathbb{E}_{\omega \sim q_\psi(\cdot \mid x)}\left[q_\theta(x \mid \omega)\frac{p_\omega(\omega)}{q_\psi(\omega \mid x)}\right]$$
$$\geq \mathbb{E}_{\omega \sim q_\psi(\cdot \mid x)}\left[\log\left(q_\theta(x \mid \omega)\frac{p_\omega(\omega)}{q_\psi(\omega \mid x)}\right)\right] = \underbrace{\mathbb{E}_{\omega \sim q_\psi(\cdot \mid x)}[\log q_\theta(x \mid \omega)]}_{\textbf{Reconstruction}} - \underbrace{d_{KL}(q_\psi(\cdot \mid x), p_\omega)}_{\textbf{Regularizer}}$$

> [!note] Come leggere questo passaggio
> - Il primo trucco è **moltiplicare e dividere** per $q_\psi(\omega|x)$ così da cambiare la distribuzione su cui si fa l'aspettazione (da $p_\omega$ a $q_\psi$): è **importance sampling**, ora campiono $\omega$ dall'encoder (che "sa" quali $\omega$ corrispondono a quel particolare $x$).
> - La **disuguaglianza di Jensen** (il log di una media $\geq$ media dei log, perché $\log$ è concava) trasforma il termine intrattabile in un **lower bound** calcolabile.
> - Il risultato si spezza in due pezzi interpretabili:
> 	- **Reconstruction** $\mathbb{E}_{\omega}[\log q_\theta(x|\omega)]$ → quanto bene il decoder **ricostruisce** $x$ dal latente codificato (come la loss dell'autoencoder);
> 	- **Regularizer** $-d_{KL}(q_\psi(\cdot|x), p_\omega)$ → costringe la distribuzione dell'encoder a **somigliare al prior** $p_\omega$ → è ciò che mancava all'autoencoder normale e rende il latente "campionabile".

> [!important] Variational (lower) Bound
> $$d_{KL}(p_{data}, q_\theta) \leq \mathbb{E}_{x \sim p_{data}}\Big[\underbrace{-\mathbb{E}_{\omega \sim q_\psi(\cdot|x)}[\log q_\theta(x|\omega)]}_{\text{ricostruzione}} + \underbrace{d_{KL}(q_\psi(\cdot|x), p_\omega)}_{\text{regolarizzatore}}\Big] + \text{const}$$
> Minimizzando questo **bound** (invece dell'obiettivo intrattabile) si addestra il VAE:
> - il **termine di ricostruzione** è ancora intrattabile da calcolare esattamente, ma si possono **stimare i gradienti** dei parametri di encoder ($\psi$) e decoder ($\theta$);
> - il **regolarizzatore** può avere una **soluzione in forma chiusa** (es. usando distribuzioni **gaussiane**).

## Training in pratica

> [!example] Flusso
> 1. Campiona $x$ da $p_{data}$.
> 2. L'**encoder** $q_\psi$ produce **media** $\mu_{\omega|x}$ e **covarianza** $\Sigma_{\omega|x}$ → definisce una **gaussiana**.
> 3. **Campiona** $\omega$ da quella gaussiana.
> 4. Il **decoder** $q_\theta$ produce media $\mu_{x|\omega}$ e covarianza $\Sigma_{x|\omega}$ → un'altra gaussiana → si valuta il **termine di ricostruzione**.
> 5. Il **prior** è $p_\omega = \mathcal{N}(0, I)$ (**normale standard**) → si calcola il **termine di regolarizzazione**.
> 6. Si combina tutto nella **Variational Lower Bound loss** e si aggiornano $\theta, \psi$.

> [!note] Effetto dei due termini (esempio MNIST)
> Sullo spazio latente di MNIST:
> - **solo ricostruzione** → il latente è ben separato per classi ma "bucato": campionando si generano dati **senza senso**;
> - **solo regolarizzazione** → il latente segue il prior ma le classi sono mescolate (nessuna struttura utile);
> - **bound variazionale completo** → latente strutturato *e* coperto → **interpolazioni significative** tra i campioni.

## Generare dati con un VAE

> [!example] Generazione
> Si **campiona** $\omega$ dal **prior** $p_\omega = \mathcal{N}(0, I)$, lo si passa nel **decoder** $q_\theta$ che produce media e covarianza, da cui si **campiona** $\hat{x}$ = il **dato generato**. (Niente encoder: a generazione serve solo prior + decoder.)

## Conditional VAE

> [!note] Generazione condizionata
> Se abbiamo **side information** $y \in \mathcal{Y}$ (es. l'etichetta della cifra, attributi del volto) e vogliamo generare dati **condizionati** (es. "genera un 7", "genera un volto con gli occhiali"): si **modificano encoder e decoder** per prendere anche $y$ in input → $q_\psi(\omega \mid x, y)$ e $q_\theta(x \mid \omega, y)$, e si definiscono **prior condizionati** $p_\omega(\omega \mid y)$.

## Problemi del VAE

> [!warning] Limiti
> - **Underfitting**: nelle fasi iniziali il **regolarizzatore è troppo forte** e tende ad **annullare la capacità** del modello.
> - **Campioni sfocati** (blurry): il generatore tende a produrre dati **poco nitidi**.

> [!note] Evoluzione: VQ-VAE
> **VQ-VAE-2** è un modello di sintesi di immagini basato sui VAE che produce immagini di **qualità alta**, paragonabile alle grandi GAN. Usa uno **spazio latente discreto** con un **dizionario** (codebook): il latente è un'immagine a 1 canale che contiene l'**id** di ogni embedding $e$ per ogni pixel (valori **discreti**).

# 5. Generative Adversarial Networks (GAN)

Introdotte da **Goodfellow et al. (2014)**. Permettono di stimare **densità implicite**.

> [!important] Setup
> Si assume di avere un **prior** $p_\omega \in \Delta(\Omega)$ e un **generatore** (decoder) $g_\theta \in \mathcal{X}^\Omega$ che, dato un elemento casuale $\omega$, genera un dato $x \in \mathcal{X}$.
> La densità indotta dal prior e dal generatore è:
> $$q_\theta(x) = \mathbb{E}_{\omega \sim p_\omega}\,\delta[g_\theta(\omega) - x]$$
> - $\delta$ → la **delta di Dirac**: vale "infinito" dove l'argomento è 0 e 0 altrove. In pratica dice "$x$ ha probabilità tutta concentrata dove $g_\theta(\omega) = x$". È una densità **implicita**: so generare campioni ($\omega \to g_\theta(\omega)$) ma **non** ho una formula valutabile per $q_\theta(x)$.

## L'obiettivo originale: JS divergence

> [!important] Obiettivo
> Trovare $\theta^\star$ tale che $q_{\theta^\star}$ fitti $p_{data}$ sotto la **divergenza di Jensen-Shannon**:
> $$\theta^\star \in \arg\min_\theta d_{JS}(p_{data}, q_\theta)$$
> $$d_{JS}(p, q) = \frac{1}{2} d_{KL}\!\left(p, \frac{p+q}{2}\right) + \frac{1}{2} d_{KL}\!\left(q, \frac{p+q}{2}\right)$$
> - la JS è una versione **simmetrica** della KL: confronta sia $p$ che $q$ con la loro **media** $\frac{p+q}{2}$. È **intrattabile** da calcolare (e così lo sono i suoi gradienti), perché $q_\theta$ è una densità implicita.

## Una forma equivalente della JS (l'idea geniale)

> [!tip] L'idea ad alto livello (cosa stiamo minimizzando davvero)
> Anche qui partiamo da un **oggetto intrattabile**. Vorremmo minimizzare la distanza (la divergenza JS) tra i dati veri $p_{data}$ e quelli generati $q_\theta$ — ma non sappiamo calcolarla, perché del generatore sappiamo solo **produrre campioni**, non abbiamo una formula per la sua densità (è *implicita*).
>
> Nel VAE il trucco era sostituire l'oggetto impossibile con un **tetto calcolabile**. Nelle GAN il trucco è diverso e ancora più astuto: si dimostra che **misurare quanto due distribuzioni sono diverse equivale a chiedersi "quanto è facile distinguerle?"**. E "distinguere reale da finto" è semplicemente un problema di **classificazione**, che sappiamo risolvere benissimo con una rete.
>
> Quindi, invece di *calcolare* la divergenza, **addestriamo un classificatore** (il **discriminatore**) a separare i dati veri da quelli generati:
> - se il discriminatore ci riesce **facilmente** → le due distribuzioni sono ancora molto **diverse** (il generatore fa schifo);
> - se il discriminatore **non riesce** a distinguerle (tira a indovinare, 50/50) → le due distribuzioni sono ormai **indistinguibili** → il generatore ha vinto.
>
> Da qui nasce il **gioco a due giocatori** che è il cuore delle GAN, e che è esattamente ciò che minimizziamo/massimizziamo in pratica:
> 1. il **discriminatore** cerca di diventare il **miglior giudice possibile** (massimizza: "becca tutti i falsi");
> 2. il **generatore** cerca di **ingannare quel giudice** (minimizza: "fai sì che i miei falsi vengano scambiati per veri").
>
> I due si **allenano in competizione**, alternandosi: più il giudice diventa bravo, più il falsario è costretto a migliorare, e viceversa. All'equilibrio il generatore produce dati così realistici che il discriminatore non sa più distinguerli → la divergenza intrattabile che volevamo minimizzare è stata **azzerata indirettamente**, senza mai calcolarla. In una frase: *invece di misurare quanto i dati finti somigliano ai veri, mettiamo un falsario contro un detective e li facciamo migliorare a vicenda finché il falsario non è perfetto.*

Manipolando la JS si arriva a:
$$d_{JS}(p, q) = \log(2) + \frac{1}{2} \max_t \Big\{ \mathbb{E}_{x \sim p}[\log t(x)] + \mathbb{E}_{x \sim q}[\log(1 - t(x))] \Big\}$$
- **L'intuizione**: $t(x)$ si comporta come un **classificatore binario** che prevede se $x$ proviene da $p$ (dati reali) o da $q$ (dati generati). Calcolare la JS equivale a trovare il **miglior classificatore** possibile. **Idea chiave: invece di calcolare la divergenza, impariamo $t(x)$!**

## L'obiettivo GAN

Sia $t_\varphi(x)$ un **classificatore (discriminatore)** con parametri $\varphi$. Si ottiene un **lower bound** sull'obiettivo (i termini $\log(2)$ e $\frac12$ si possono trascurare, non cambiano il minimizzatore $\theta^\star$):
$$\theta^\star \in \arg\min_\theta \max_\varphi \Big\{ \mathbb{E}_{x \sim p_{data}}[\log t_\varphi(x)] + \mathbb{E}_{x \sim q_\theta}[\log(1 - t_\varphi(x))] \Big\}$$

Questo dipende ancora dalla densità (implicita) $q_\theta$, ma si può **riscrivere equivalentemente** (dimostrazione saltata) campionando dal generatore:
$$\theta^\star \in \arg\min_\theta \max_\varphi \Big\{ \mathbb{E}_{x \sim p_{data}}[\log t_\varphi(x)] + \mathbb{E}_{\omega \sim p_\omega}[\log(1 - t_\varphi(g_\theta(\omega)))] \Big\}$$

> [!important] Cosa significa il min-max
> - $\mathbb{E}_{x \sim p_{data}}[\log t_\varphi(x)]$ → il discriminatore vuole dare **punteggio alto** ($t \to 1$) ai dati **reali**;
> - $\mathbb{E}_{\omega \sim p_\omega}[\log(1 - t_\varphi(g_\theta(\omega)))]$ → e punteggio **basso** ($t \to 0$) ai dati **generati** $g_\theta(\omega)$;
> - il **$\max_\varphi$**: il discriminatore cerca di **distinguere** reale da finto; il **$\min_\theta$**: il generatore cerca di **ingannarlo** (far sì che i suoi campioni vengano classificati come reali).

> [!important] Un gioco a due giocatori
> - Gioco a **due giocatori, a somma zero, non cooperativo**.
> - **Player 1 — Generatore**: prova a generare dati **indistinguibili** da quelli veri.
> - **Player 2 — Discriminatore**: prova a indovinare se l'input viene dalla distribuzione **vera** o è "**fake**".
> - Si risolve con **gradient descent** e approcci specializzati per il problema **min-max**.

## Training in pratica e test

> [!example] Training
> Si campiona $x$ da $p_{data}$ e $\omega$ da $p_\omega$ (→ generatore $g_\theta$ → $\hat{x}$). Un **random switch** invia al **classificatore** $t_\varphi$ ora un dato reale ora uno finto; il classificatore predice **true (1)** / **fake (0)**. Dalla **GAN loss** si aggiornano $\theta$ (generatore) e $\varphi$ (discriminatore), su **mini-batch** campionati.

> [!example] Test time
> A generazione serve **solo** il generatore: si campiona $\omega$ da $p_\omega$, lo si passa in $g_\theta$ → **dato generato** $\hat{x}$ (il discriminatore si butta via).

## Aritmetica nello spazio latente

> [!note] Interpolazione
> Lo spazio latente delle GAN ha **struttura semantica**: si possono fare **operazioni vettoriali** sui codici $\omega$. Esempio classico:
> $$\omega(\text{donna sorridente}) - \omega(\text{donna neutra}) + \omega(\text{uomo neutro}) \approx \omega(\text{uomo sorridente})$$
> Interpolando tra due codici $\omega_0$ e $\omega_c$ nello spazio latente si ottengono **transizioni graduali e realistiche** nello spazio delle immagini.

## Problemi delle GAN

> [!warning] Limiti
> - **Training stability**: i parametri possono **oscillare** e non convergere mai (è un min-max, non una semplice minimizzazione).
> - **Mode collapse**: il generatore impara a generare **perfettamente solo pochi** esempi del training set, ignorando la varietà dei dati.
> - **Vanishing gradient**: se il discriminatore è **troppo bravo**, lascia al generatore **pochissimo gradiente** da cui imparare (il generatore non sa più come migliorare).

## Varianti e stato dell'arte

> [!note] Altre GAN
> Si possono costruire altri modelli GAN-like cambiando la **divergenza** tra probabilità: le GAN classiche si basano su divergenze di **Bregman**, le **Wasserstein GAN** usano la metrica di **Wasserstein** (aiuta con stabilità e vanishing gradient). GAN e VAE si possono **combinare** (VAE-GAN); esistono **Conditional GAN** (analoghe ai VAE condizionati).
>
> **Modelli generativi oggi**: **Progressive GAN** (cresce la risoluzione durante il training), **StyleGAN** (volti iper-realistici), modelli **multimodali** (testo→immagine), **DragGAN** (editing trascinando punti), **video generation**.

---

# Da padroneggiare

- **Generativo vs discriminativo**: generativo modella $p_X$/$p_{XY}$; discriminativo modella $p_{Y|X}$. Da generativo si ottiene il discriminativo via **Bayes** ($p_{Y|X} = p_{XY}/p_X$), non viceversa.
- **Density estimation**: **esplicita** (ho la densità $f(z)$) vs **implicita** (so solo campionare $f(\omega)$). Obiettivo comune: $q^\star = \arg\min_q d(p_{data}, q)$ con una **divergenza** $d$.
- **VAE** (density esplicita): modello $q_\theta(x) = \mathbb{E}_{\omega \sim p_\omega}[q_\theta(x|\omega)]$; l'obiettivo KL è intrattabile → si usa il **bound variazionale** (Jensen + encoder $q_\psi$):
$$\text{loss} = \underbrace{-\mathbb{E}_{q_\psi}[\log q_\theta(x|\omega)]}_{\text{ricostruzione}} + \underbrace{d_{KL}(q_\psi(\cdot|x), p_\omega)}_{\text{regolarizzatore}}$$
	il regolarizzatore (verso il prior $\mathcal{N}(0,I)$) è ciò che rende il latente campionabile → permette di **generare**. Problemi: underfitting, campioni sfocati. Evoluzione: VQ-VAE (latente discreto).
- **GAN** (density implicita): generatore $g_\theta$ + prior $p_\omega$; densità implicita con la **delta di Dirac**. L'obiettivo è la **JS divergence**, riscritta come **gioco min-max** tra **generatore** e **discriminatore** $t_\varphi$:
$$\theta^\star \in \arg\min_\theta \max_\varphi \big\{ \mathbb{E}_{x \sim p_{data}}[\log t_\varphi(x)] + \mathbb{E}_{\omega \sim p_\omega}[\log(1 - t_\varphi(g_\theta(\omega)))] \big\}$$
	gioco a **due giocatori a somma zero**. Problemi: instabilità, **mode collapse**, **vanishing gradient**. Varianti: Wasserstein GAN, conditional GAN, StyleGAN.
- **Tema comune**: entrambi imparano a trasformare un **prior semplice** ($\mathcal{N}(0,I)$) nella **complessa $p_{data}$** tramite un decoder/generatore; lo **spazio latente** ha struttura semantica (interpolazioni, aritmetica vettoriale).
