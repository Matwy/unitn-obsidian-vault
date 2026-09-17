---
date: 2026-06-14
tags:
Materia: "[[Machine Learning]]"
pdf: "[[Lec16 - Diffusion Models.pdf]]"
---

## 16 Diffusion Models

> [!abstract] Idea in una riga
> Un **diffusion model** impara a **invertire un processo di rumore**: partiamo da un'immagine reale, le aggiungiamo rumore gaussiano un po' alla volta fino a distruggerla completamente (→ rumore puro), e alleniamo una rete a fare il percorso inverso, **togliendo rumore passo dopo passo** finché da rumore casuale non emerge un'immagine nuova e realistica.
>
> È la famiglia di modelli generativi dietro Stable Diffusion, DALL·E 2, Imagen, Midjourney.

Collegamento al resto del corso: questo è il terzo grande paradigma generativo dopo le [[15 Modelli Generativi|VAE e le GAN]]. Come le VAE userà un **bound variazionale**, ma supera entrambe in qualità di generazione.

---

# 1. Dove si collocano i diffusion model

I modelli generativi visti finora:

- **VAE**: encoder + decoder, ottimizzano un *lower bound* della likelihood (ELBO). Generazione veloce ma immagini un po' sfocate (*blurry*).
- **GAN**: generatore vs discriminatore, gioco min-max. Immagini nitide ma training instabile e *mode collapse*.
- **Diffusion**: qualità altissima e training **stabile**, al prezzo di una **generazione lenta** (serve iterare molti passi).

> [!important] Il Trilemma Generativo (Generative Trilemma)
> Un modello generativo "ideale" vorrebbe **tre** cose contemporaneamente, ma in pratica se ne ottengono solo due:
> 1. **High Quality Samples** — campioni di alta qualità
> 2. **Mode Coverage / Diversity** — coprire tutte le modalità dei dati (varietà)
> 3. **Fast Sampling** — generazione veloce
>
> | Modello | Qualità | Diversità | Velocità |
> |---|---|---|---|
> | GAN | ✅ | ❌ (mode collapse) | ✅ |
> | VAE / Flow | ⚠️ | ✅ | ✅ |
> | **Diffusion** | ✅ | ✅ | ❌ (lento) |
>
> I diffusion model "pagano" sul terzo punto: gran parte della ricerca recente (distillation, latent diffusion, diffusion-GAN) serve proprio a recuperare **velocità** senza perdere qualità.

---

# 2. Formulazione di base: due processi

L'idea è costruire una **catena di Markov** con due direzioni:

- **Forward process (diffusione)**: aggiunge rumore. È **fisso**, non si impara. Va da $x_0$ (immagine reale) a $x_T$ (rumore gaussiano puro).
- **Reverse process (denoising)**: toglie rumore. È **imparato** da una rete neurale. Va da $x_T$ a $x_0$.

```
x_0  →  x_1  →  x_2  →  ...  →  x_T      (forward: aggiunge rumore, fisso)
immagine                       rumore N(0,I)

x_0  ←  x_1  ←  x_2  ←  ...  ←  x_T      (reverse: toglie rumore, imparato)
```

> [!note] Ripasso: Catena di Markov
> Una sequenza di variabili dove **ogni stato dipende solo dal precedente**:
> $$q(x_t \mid x_{t-1}, x_{t-2}, \dots, x_0) = q(x_t \mid x_{t-1})$$
> Questo è ciò che rende tutto trattabile: per passare da un passo al successivo basta guardare un solo stato.

---

# 3. Forward process (aggiunta di rumore)

Definiamo un **singolo passo** di rumore come una gaussiana:

$$q(x_t \mid x_{t-1}) = \mathcal{N}\big(x_t; \ \sqrt{1-\beta_t}\, x_{t-1}, \ \beta_t I\big)$$

Cosa significa termine per termine:
- $x_{t-1}$ → immagine al passo precedente (meno rumorosa).
- $x_t$ → immagine al passo corrente (più rumorosa).
- $\beta_t \in (0,1)$ → **noise schedule**: quanto rumore aggiungiamo al passo $t$. È un valore piccolo (es. cresce da $10^{-4}$ a $0.02$).
- **media** $\sqrt{1-\beta_t}\,x_{t-1}$ → restringiamo (scaliamo verso 0) l'immagine precedente di un fattore $\sqrt{1-\beta_t}$. Questo serve a **non far esplodere la varianza**: senza lo "shrink" l'immagine crescerebbe di energia a ogni passo.
- **varianza** $\beta_t I$ → iniettiamo rumore gaussiano isotropo (uguale in ogni dimensione/pixel).

Per l'intera traiettoria, grazie alla proprietà di Markov, la distribuzione congiunta è il prodotto dei singoli passi:

$$q(x_{1:T} \mid x_0) = \prod_{t=1}^{T} q(x_t \mid x_{t-1})$$

## 3.1 Il trucco chiave: saltare direttamente al passo $t$

Applicare $T$ passi uno alla volta sarebbe lentissimo in training. Per fortuna, componendo gaussiane si ottiene una formula **chiusa** che permette di campionare $x_t$ **direttamente da $x_0$** senza passare per gli stati intermedi.

Definiamo:
$$\alpha_t = 1 - \beta_t \qquad\qquad \bar{\alpha}_t = \prod_{s=1}^{t} \alpha_s = \prod_{s=1}^{t} (1-\beta_s)$$

- $\alpha_t$ → "quanta immagine sopravvive" al passo $t$.
- $\bar{\alpha}_t$ ("alpha bar") → **prodotto cumulato**: quanta immagine originale sopravvive dopo $t$ passi totali. Parte da ~1 (t piccolo) e tende a 0 (t grande, tutto rumore).

Allora vale:

$$\boxed{\ q(x_t \mid x_0) = \mathcal{N}\big(x_t; \ \sqrt{\bar{\alpha}_t}\, x_0, \ (1-\bar{\alpha}_t) I\big)\ }$$

E in forma di **campionamento diretto** (reparameterization trick):

$$x_t = \sqrt{\bar{\alpha}_t}\, x_0 + \sqrt{1-\bar{\alpha}_t}\, \varepsilon, \qquad \varepsilon \sim \mathcal{N}(0, I)$$

Lettura intuitiva:
- $\sqrt{\bar{\alpha}_t}\, x_0$ → frazione di **segnale** (immagine originale) rimasta.
- $\sqrt{1-\bar{\alpha}_t}\, \varepsilon$ → frazione di **rumore** aggiunto.
- Le due frazioni si "scambiano peso": a $t$ piccolo domina il segnale, a $t = T$ domina il rumore ($\bar{\alpha}_T \approx 0 \Rightarrow x_T \approx \varepsilon \sim \mathcal{N}(0,I)$).

> [!tip] Perché è importante
> Questa formula ci dà, per qualsiasi $t$, una versione rumorosa di $x_0$ **in un colpo solo** e ci dice **esattamente quale rumore $\varepsilon$** abbiamo aggiunto. Quel $\varepsilon$ sarà il **target** che la rete deve imparare a predire (vedi [[#6. Training: dal bound variazionale alla loss semplice|sezione 6]]).

---

# 4. Reverse process (denoising) — la parte imparata

Vogliamo invertire la catena. Partiamo da rumore puro:

$$p(x_T) = \mathcal{N}(x_T; \ 0, I)$$

e impariamo i passi di denoising. Il vero $q(x_{t-1}\mid x_t)$ è intrattabile (richiederebbe l'intera distribuzione dei dati), quindi lo **approssimiamo con una gaussiana** parametrizzata da una rete neurale $\theta$:

$$p_\theta(x_{t-1} \mid x_t) = \mathcal{N}\big(x_{t-1}; \ \mu_\theta(x_t, t), \ \sigma_t^2 I\big)$$

- $\mu_\theta(x_t, t)$ → **media predetta dalla rete**: dato lo stato rumoroso $x_t$ e il **timestep $t$**, la rete dice "dove" si trova l'immagine un po' meno rumorosa.
- $\sigma_t^2$ → varianza del passo; spesso **fissata** (non imparata), tipicamente $\sigma_t^2 = \beta_t$ o una sua variante.
- $t$ in input → la rete deve sapere "a che livello di rumore" sta lavorando (lo stesso peso fa cose diverse a $t=10$ e $t=900$).

L'intera generazione è il prodotto della catena inversa:

$$p_\theta(x_{0:T}) = p(x_T) \prod_{t=1}^{T} p_\theta(x_{t-1} \mid x_t)$$

> [!note] Perché una gaussiana funziona come approssimazione?
> Si dimostra che se i passi $\beta_t$ sono **abbastanza piccoli**, anche il vero passo inverso $q(x_{t-1}\mid x_t)$ è (approssimativamente) **gaussiano**. Quindi modellarlo con una gaussiana è una scelta teoricamente giustificata — non un'approssimazione grossolana.

---

# 5. Connessione con VAE e GAN

> [!example] Diffusion = VAE "profonda" con encoder fisso
> - Il **forward process** è come l'**encoder** di una VAE… ma **fisso** (nessun parametro da imparare) e con tante "latenti" $x_1,\dots,x_T$ delle stesse dimensioni dell'immagine.
> - Il **reverse process** è come il **decoder**, ed è la parte imparata.
> - Come la VAE, si ottimizza un **upper bound variazionale** della negative log-likelihood (vedi [[#6. Training: dal bound variazionale alla loss semplice|sezione 6]]).
>
> Differenze con la GAN: niente discriminatore, niente gioco avversariale → training molto più **stabile**, nessun mode collapse.

---

# 6. Training: dal bound variazionale alla loss semplice

## 6.1 Il bound variazionale

Come per le VAE non possiamo massimizzare direttamente $\log p_\theta(x_0)$, quindi minimizziamo un **upper bound** della negative log-likelihood. Sviluppandolo si ottiene una somma di termini, uno per ogni passo:

$$L = \underbrace{D_{KL}\big(q(x_T\mid x_0)\,\|\,p(x_T)\big)}_{L_T:\ \text{prior matching}} + \sum_{t>1} \underbrace{D_{KL}\big(q(x_{t-1}\mid x_t, x_0)\,\|\,p_\theta(x_{t-1}\mid x_t)\big)}_{L_{t-1}:\ \text{denoising matching}} - \underbrace{\log p_\theta(x_0\mid x_1)}_{L_0:\ \text{reconstruction}}$$

Cosa sono i tre tipi di termine:
- $L_T$ (**prior matching**) → misura quanto $x_T$ (fine del forward) somiglia al prior $\mathcal{N}(0,I)$. Non contiene parametri $\theta$ → praticamente **costante**, si ignora.
- $L_{t-1}$ (**denoising matching**) → il cuore: per ogni passo confronta il **vero** passo inverso $q(x_{t-1}\mid x_t, x_0)$ (calcolabile in forma chiusa, perché condizionato su $x_0$) con quello **predetto** dalla rete $p_\theta$. È un confronto fra due gaussiane → KL in forma chiusa.
- $L_0$ (**reconstruction**) → termine finale di ricostruzione dell'immagine pulita.

> [!tip] L'idea ad alto livello (cosa stiamo minimizzando davvero)
> Tutta questa somma di KL si riduce a una richiesta semplice: **per ogni livello di rumore, la rete deve indovinare il passo di denoising "giusto"** — quello che il processo forward (di cui conosciamo tutto) avrebbe fatto al contrario.
>
> Il bello è che, condizionando su $x_0$, il "passo giusto" $q(x_{t-1}\mid x_t, x_0)$ è **calcolabile esattamente**: abbiamo un bersaglio preciso a cui far aderire la rete. Non c'è nulla di avversariale o instabile: è una serie di problemi di regressione gaussiana.

## 6.2 La loss semplificata $L_{\text{simple}}$

Ho et al. (DDPM, 2020) mostrano che, riparametrizzando la media $\mu_\theta$ in modo che la rete **predica il rumore $\varepsilon$** invece dell'immagine, tutta quella somma di KL si riduce a un banalissimo **errore quadratico medio sul rumore**:

$$\ L_{\text{simple}} = \mathbb{E}_{x_0,\ \varepsilon,\ t}\Big[\ \big\|\ \varepsilon - \varepsilon_\theta\big(\sqrt{\bar{\alpha}_t}\, x_0 + \sqrt{1-\bar{\alpha}_t}\,\varepsilon,\ t\big)\ \big\|^2\ \Big]\ $$

Termine per termine:
- $\varepsilon \sim \mathcal{N}(0,I)$ → il rumore vero che abbiamo aggiunto a $x_0$ per fabbricare $x_t$.
- $\sqrt{\bar{\alpha}_t}\, x_0 + \sqrt{1-\bar{\alpha}_t}\,\varepsilon$ → è semplicemente $x_t$ (campionamento diretto della [[#3.1 Il trucco chiave: saltare direttamente al passo $t$|sezione 3.1]]).
- $\varepsilon_\theta(x_t, t)$ → il rumore **predetto** dalla rete, guardando l'immagine rumorosa e il timestep.
- $\|\varepsilon - \varepsilon_\theta(\cdot)\|^2$ → quanto la rete sbaglia nel predire il rumore.

> [!success] Il messaggio chiave del training
> Allenare un diffusion model = **insegnare a una rete a predire il rumore presente in un'immagine rumorosa**. Tutto qui. Una loss MSE, stabile e semplice, equivalente al complicato bound variazionale.

## 6.3 Algoritmo di Training

> [!example] Algorithm 1 — Training
> **repeat**
> 1. $x_0 \sim q(x_0)$ — prendi un'immagine reale dal dataset
> 2. $t \sim \text{Uniform}(\{1, \dots, T\})$ — scegli un timestep a caso
> 3. $\varepsilon \sim \mathcal{N}(0, I)$ — campiona del rumore
> 4. Gradient descent su: $\nabla_\theta \big\| \varepsilon - \varepsilon_\theta(\sqrt{\bar{\alpha}_t}x_0 + \sqrt{1-\bar{\alpha}_t}\varepsilon,\ t) \big\|^2$
>
> **until** convergenza
>
> Nota: a ogni iterazione si addestra su **un solo $t$ a caso** — non serve simulare tutta la catena, rendendo il training efficiente.

---

# 7. Sampling (generazione)

Per generare una nuova immagine partiamo da rumore puro e applichiamo $T$ passi di denoising imparati.

> [!example] Algorithm 2 — Sampling
> 1. $x_T \sim \mathcal{N}(0, I)$ — parti da rumore puro
> 2. **for** $t = T, \dots, 1$ **do**
> 3. &nbsp;&nbsp;&nbsp;&nbsp; $z \sim \mathcal{N}(0,I)$ se $t>1$, altrimenti $z = 0$
> 4. &nbsp;&nbsp;&nbsp;&nbsp; $x_{t-1} = \dfrac{1}{\sqrt{\alpha_t}}\Big(x_t - \dfrac{1-\alpha_t}{\sqrt{1-\bar{\alpha}_t}}\, \varepsilon_\theta(x_t, t)\Big) + \sigma_t\, z$
> 5. **end for**
> 6. **return** $x_0$

Lettura della formula del passo (riga 4):
- $\varepsilon_\theta(x_t, t)$ → la rete stima il rumore presente in $x_t$.
- $x_t - \frac{1-\alpha_t}{\sqrt{1-\bar{\alpha}_t}}\varepsilon_\theta$ → **sottraiamo** una frazione del rumore stimato: ecco il "denoising".
- $\frac{1}{\sqrt{\alpha_t}}(\cdots)$ → riscaliamo (annulliamo lo shrink fatto nel forward).
- $+\,\sigma_t z$ → **ri-aggiungiamo un po' di rumore** (tranne all'ultimo passo). Sembra controintuitivo, ma è ciò che rende il processo **stocastico**: senza questo termine il sampling collasserebbe e perderebbe diversità.

> [!warning] Perché la generazione è lenta
> Il ciclo gira da $t=T$ a $t=1$: con $T=1000$ servono **1000 forward pass della rete** per una singola immagine. Questo è il "prezzo" del Trilemma → tutta la [[#9. Advanced Tricks — recuperare velocità e controllo|sezione 9]] è dedicata a velocizzare questo passaggio.

---

# 8. La rete: U-Net + condizionamento sul tempo

La rete $\varepsilon_\theta(x_t, t)$ deve prendere un'immagine rumorosa e produrre un'immagine (il rumore stimato), **stessa dimensione in input e output**. L'architettura naturale è la **U-Net**.

> [!note] U-Net
> Architettura encoder–decoder a forma di "U":
> - **Encoder (contracting path)**: convoluzioni + downsampling → riduce la risoluzione, estrae feature astratte.
> - **Decoder (expanding path)**: upsampling → ricostruisce alla risoluzione originale.
> - **Skip connections**: collegano i livelli encoder ai corrispondenti livelli decoder alla stessa risoluzione. Servono a **non perdere i dettagli fini** (texture, bordi) che il downsampling cancellerebbe.
> - Spesso include blocchi di **self-attention** alle risoluzioni più basse.

## 8.1 Come si dice alla rete "a che timestep siamo"

Il timestep $t$ è uno scalare, ma deve influenzare tutta la rete. Si codifica con un **embedding sinusoidale** (le stesse *positional encoding* dei Transformer / *Fourier features*):

$$\text{PE}(t)_{2i} = \sin\!\Big(\frac{t}{10000^{2i/d}}\Big), \qquad \text{PE}(t)_{2i+1} = \cos\!\Big(\frac{t}{10000^{2i/d}}\Big)$$

- $t$ → il timestep.
- $i$ → indice della dimensione dell'embedding, $d$ → dimensione totale.
- Frequenze diverse ($10000^{2i/d}$) → ogni dimensione "oscilla" a un ritmo diverso, dando una firma unica a ogni $t$.

Questo vettore viene poi proiettato (MLP) e **iniettato nei blocchi della U-Net**, così che la rete sappia adattare il denoising al livello di rumore corrente.

---

# 9. Advanced Tricks — recuperare velocità e controllo

Tutto il filone di ricerca recente attacca il punto debole del Trilemma (velocità) e aggiunge **controllo** (testo, classi).

## 9.1 Diffusion-GAN

> [!warning] L'assunzione nascosta che vogliamo rompere
> Nel reverse process (sezione 4) abbiamo modellato il passo di denoising $p_\theta(x_{t-1}\mid x_t)$ come una **gaussiana**. Questa scelta è valida **solo se il passo è piccolo** (togliamo pochissimo rumore per volta) — ed è *esattamente* il motivo per cui servono **migliaia di passi** ("Often requires 1000s of network evaluations").
>
> Se proviamo a fare **passi grandi** (per andare veloci, es. 4 passi invece di 1000), il vero passo inverso $q(x_{t-1}\mid x_t)$ **smette di essere gaussiano** e diventa **multimodale**.

**Perché diventa multimodale?** Se $x_t$ è molto rumoroso e vuoi saltare lontano indietro in un colpo solo, ci sono **tante immagini pulite diverse** compatibili con quel rumore (un gatto, un cane, un volto…). La distribuzione di $x_{t-1}$ ha quindi **più picchi** (più modi). Una **gaussiana ha un solo picco** → non può rappresentarli.

**L'idea (Xiao et al. 2021):** sostituiamo la gaussiana con una **GAN condizionale**, che *sa* modellare distribuzioni multimodali e complesse. Ogni passo di denoising diventa un piccolo GAN che, dato $x_t$, genera $x_{t-1}$.

$$\underbrace{p_\theta(x_{t-1}\mid x_t) = \mathcal{N}(\mu_\theta, \sigma_t^2 I)}_{\text{diffusion classico: gaussiana} \to \text{passi piccoli} \to 1000\ \text{passi}} \qquad\Longrightarrow\qquad \underbrace{p_\theta(x_{t-1}\mid x_t) = \text{GAN}(x_t, t)}_{\text{diffusion-GAN: multimodale} \to \text{passi grandi} \to \sim 4\ \text{passi}}$$

**Come si allena** (non è una GAN "one-shot" che genera l'immagine dal nulla):
- Il **generatore** $G(x_t, z, t)$ guarda l'immagine rumorosa $x_t$ (e un rumore latente $z$) e produce una stima dell'immagine pulita $x'_0$; da questa, tramite il *posterior sampling* $q(x_{t-1}\mid x_t, x'_0)$, si ottiene il passo indietro $x'_{t-1}$.
- Il **discriminatore** $D(x_{t-1}, x_t, t)$ riceve una **coppia** (passo precedente, passo attuale) e deve dire se è **reale** (presa dal vero forward diffusion) o **falsa** (prodotta dal generatore).

In pratica: invece di "incollare" una gaussiana al passo di denoising, usiamo un **gioco avversariale** per far combaciare la distribuzione predetta con quella vera (anche se multimodale), passo per passo.

> [!success] Perché funziona meglio di una GAN normale
> - Generatore e discriminatore risolvono un problema **molto più semplice** (togliere un po' di rumore è più facile che generare un'immagine intera dal rumore puro).
> - **Mode coverage più forte** → niente *mode collapse* tipico delle GAN one-shot, perché ogni passo è piccolo e condizionato su $x_t$.
> - Training più **stabile**.
> - Risultato: **~40× più veloce** del DDPM a parità di qualità (FID).
>
> In una riga: **usa una GAN al posto della gaussiana in ogni passo di denoising, così puoi fare pochi passi grandi invece di mille piccoli.**

## 9.2 Distillation
Si **distilla** un modello "insegnante" lento (molti passi) in uno "studente" veloce che fa lo stesso percorso in **pochi passi** (anche 1–4). Tecnica chiave per il sampling rapido in produzione.

## 9.3 Latent-space diffusion (Stable Diffusion)
> [!important] L'idea che ha reso i diffusion model pratici
> Invece di diffondere nello spazio dei **pixel** (es. 512×512×3, costosissimo), si lavora in uno **spazio latente compresso**:
> 1. Un **autoencoder** ($\mathcal{E}$ encoder, $\mathcal{D}$ decoder) comprime l'immagine in una latente piccola: $z = \mathcal{E}(x)$.
> 2. Il **diffusion process avviene su $z$** (molto più piccola → molto più veloce).
> 3. Il decoder $\mathcal{D}$ riporta la latente generata in pixel: $\hat{x} = \mathcal{D}(z)$.
>
> Questo è il cuore di **Stable Diffusion** (Rombach et al., 2022) e il motivo del **fast sampling**.

## 9.4 Text-to-image: condizionamento

Per generare da testo, il reverse process viene **condizionato** su un prompt:

$$p_\theta(x_{t-1} \mid x_t, \, c)$$

dove $c$ è l'embedding del testo. In Stable Diffusion il testo entra nella U-Net tramite **cross-attention** (le query vengono dalle feature dell'immagine, key/value dall'embedding testuale).

### CLIP
> [!note] CLIP (Contrastive Language–Image Pre-training)
> Modello che impara a mettere **immagini e testo nello stesso spazio di embedding**. Allenato con una loss **contrastiva** su milioni di coppie (immagine, didascalia): avvicina gli embedding delle coppie corrette, allontana quelli sbagliati.
> Fornisce gli **embedding di testo** $c$ usati per condizionare la generazione (es. addestrato su LAION-5B, ~5 miliardi di coppie testo-immagine).

### GLIDE / Classifier-Free Guidance
Per rendere l'immagine **più aderente al prompt**, si usa la **classifier-free guidance**: si allena la rete sia in modalità condizionata $\varepsilon_\theta(x_t, t, c)$ sia non condizionata $\varepsilon_\theta(x_t, t)$ (a volte si "spegne" $c$), e in sampling si **estrapola**:

$$\hat{\varepsilon}_\theta(x_t, t, c) = \varepsilon_\theta(x_t, t) + s \cdot \big(\varepsilon_\theta(x_t, t, c) - \varepsilon_\theta(x_t, t)\big)$$

- $s \geq 1$ → **guidance scale**: quanto "spingere" verso il prompt.
- $s = 1$ → condizionamento normale; $s$ grande → immagini più fedeli al testo ma meno diverse (trade-off fedeltà/varietà).
- Il termine $(\varepsilon_{\text{cond}} - \varepsilon_{\text{uncond}})$ → "direzione" che porta verso il testo, amplificata da $s$.

---

# 10. Diffusion Zoo — cosa si può fare

I diffusion model non servono solo a generare immagini da testo:

- **Super Resolution** — da immagine 64×64 a 1024×1024 (SR3, raffinamento iterativo).
- **Image-to-Image** — colorazione, traduzione di stile, inpainting (Palette).
- **Semantic Segmentation** — si usa il DDPM pre-addestrato come *feature extractor*: si aggiunge rumore a un'immagine reale, si estraggono le rappresentazioni a livello di pixel dalla U-Net e un ensemble di MLP predice la classe di ogni pixel.
- **Image Editing** (SDEdit) — si perturba un disegno/stroke con rumore e si simula la reverse SDE: il processo "proietta" il disegno grezzo sulla *manifold* delle immagini naturali.
- **Video Generation** — diffusion esteso al tempo (video diffusion models).
- **3D Shape Generation** — es. DreamFusion: text-to-3D usando un diffusion 2D come prior.

> [!tip] Forward vs Reverse SDE
> A livello continuo (Song et al.) il forward e il reverse process sono descritti da **equazioni differenziali stocastiche (SDE)**. La generazione = risolvere numericamente la **reverse SDE** partendo da rumore. Questa visione unifica DDPM, score-matching e i vari sampler veloci.

---

# 11. Riepilogo

| Elemento | Formula chiave | A cosa serve |
|---|---|---|
| Forward (1 passo) | $q(x_t\mid x_{t-1}) = \mathcal{N}(\sqrt{1-\beta_t}x_{t-1}, \beta_t I)$ | aggiunge rumore (fisso) |
| Forward (diretto) | $x_t = \sqrt{\bar\alpha_t}x_0 + \sqrt{1-\bar\alpha_t}\,\varepsilon$ | salta direttamente al passo $t$ |
| Reverse (imparato) | $p_\theta(x_{t-1}\mid x_t)=\mathcal{N}(\mu_\theta(x_t,t),\sigma_t^2 I)$ | toglie rumore |
| Loss | $L_{\text{simple}}=\mathbb{E}\big[\|\varepsilon - \varepsilon_\theta(x_t,t)\|^2\big]$ | predire il rumore (MSE) |
| Sampling | $x_{t-1}=\frac{1}{\sqrt{\alpha_t}}\big(x_t - \frac{1-\alpha_t}{\sqrt{1-\bar\alpha_t}}\varepsilon_\theta\big)+\sigma_t z$ | un passo di denoising |
| Rete | U-Net + time embedding sinusoidale | stima $\varepsilon_\theta(x_t,t)$ |
| Velocità | latent diffusion, distillation | risolve il Trilemma |

---

> [!done] Da padroneggiare
> - **I due processi**: forward (aggiunge rumore, **fisso**, gaussiano) vs reverse (toglie rumore, **imparato**). Saper scrivere $q(x_t\mid x_{t-1})$ e $p_\theta(x_{t-1}\mid x_t)$.
> - Significato di $\beta_t$ (noise schedule), $\alpha_t = 1-\beta_t$, $\bar\alpha_t = \prod \alpha_s$ (segnale residuo cumulato).
> - La formula di **campionamento diretto** $x_t = \sqrt{\bar\alpha_t}x_0 + \sqrt{1-\bar\alpha_t}\,\varepsilon$ e perché elimina la necessità di iterare in training.
> - Il **bound variazionale** ha 3 tipi di termine (prior matching, denoising matching, reconstruction) e si riduce alla **loss semplice MSE sul rumore** $L_{\text{simple}}$.
> - L'**idea di fondo**: allenare = predire il rumore; generare = togliere rumore passo dopo passo da $\mathcal{N}(0,I)$.
> - Perché il sampling è **lento** (T forward pass) e quali trick lo velocizzano (**latent diffusion** = Stable Diffusion, **distillation**).
> - Il **Trilemma Generativo** e dove cadono GAN / VAE / Diffusion.
> - Ruolo di **U-Net** (con skip connections) e del **time embedding sinusoidale**.
> - Condizionamento **text-to-image**: CLIP per gli embedding di testo, cross-attention, **classifier-free guidance** con guidance scale $s$.
> - Connessione concettuale con [[15 Modelli Generativi|VAE]] (bound variazionale, encoder/decoder) e differenze con le [[15 Modelli Generativi|GAN]] (stabilità, no mode collapse).
