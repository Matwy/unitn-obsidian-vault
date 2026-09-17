---
date: 2025/03/28
tags: 
Materia: "[[Fisica]]"
---
## Piano inclinato

In un **piano inclinato**, un corpo di massa $m$ è soggetto a diverse forze, tra cui:
1. **Forza peso** $\vec{P}$, diretta verticalmente verso il basso, di modulo $P = mg$.
2. **Reazione normale** $\vec{N}$, perpendicolare al piano.
3. **Forza di attrito** $\vec{A}$, parallela al piano e opposta al moto (o alla tendenza al moto).

---

## Scomposizione del peso

Se il piano è inclinato di un angolo $\theta$ rispetto all’orizzontale, la forza peso $mg$ si scompone in:
- **Componente parallela** al piano: 
  $$
  mg \sin \theta
  $$
- **Componente perpendicolare** al piano: 
  $$
  mg \cos \theta
  $$

La reazione normale $N$ risulta, in condizioni standard (senza altre forze verticali), pari a:
$$
N = mg \cos \theta.
$$

---

## Casi tipici di studio

### 1. Corpo fermo sul piano (condizione di equilibrio)

- Il blocco rimane fermo se la componente parallela al piano $mg \sin \theta$ non supera la massima forza di attrito statico:
$$
mg \sin \theta \le A_{s,\text{max}} = \mu_s \, N = \mu_s \, mg \cos \theta.
$$
- Da cui segue la condizione:
$$
\tan \theta \le \mu_s.
$$
- Se questa condizione è verificata, l’attrito statico $A_s$ assume il valore necessario (da $0$ a $\mu_s \, mg \cos \theta$) per mantenere il blocco in equilibrio. 

---

### 2. Discesa frenata (corpo in moto con attrito dinamico)

- Se la componente $mg \sin \theta$ supera la massima forza di attrito statico, il blocco inizia a muoversi. A questo punto l’attrito diventa **dinamico**, di valore:
$$
A_d = \mu_d \, N = \mu_d \, mg \cos \theta,
$$
- dove $\mu_d$ è il coefficiente di attrito dinamico. 

- La **forza risultante** lungo il piano sarà:
  $$
  F_{\text{res}} = mg \sin \theta - A_d = mg \sin \theta - \mu_d \, mg \cos \theta.
  $$
- L’**accelerazione** del blocco lungo il piano risulta quindi:
  $$
  a = \frac{F_{\text{res}}}{m} = g (\sin \theta - \mu_d \cos \theta).
  $$

Se $\sin \theta > \mu_d \cos \theta$, il blocco **scivola verso il basso** con un’accelerazione positiva lungo il piano.  
Se $\sin \theta = \mu_d \cos \theta$, il blocco **scende a velocità costante** (accelerazione nulla).  
Se $\sin \theta < \mu_d \cos \theta$, teoricamente il blocco **non scivola** oppure rallenta fino a fermarsi (se era già in moto e l’attrito è abbastanza grande).

---

## Approfondimenti e note aggiuntive

1. **Attrito statico vs. dinamico**  
   - L’attrito **statico** $\vec{A}_s$ si adatta al valore della forza tangenziale (fino a un massimo di $\mu_s N$).  
   - L’attrito **dinamico** $\vec{A}_d$ assume un valore costante pari a $\mu_d N$ (a parità di condizioni di velocità e superficie).

2. **Forze parallele e perpendicolari**  
   - Parallelamente al piano: $mg \sin \theta$ (peso) e $\vec{A}$ (attrito).  
   - Perpendicolarmente al piano: $mg \cos \theta$ (peso) e $\vec{N}$ (normale). 

3. **Quando considerare altri effetti**  
   - Se l’angolo $\theta$ è molto grande, la formula per l’attrito può subire variazioni se si verificano slittamenti molto rapidi, vibrazioni o altri fenomeni non ideali.  
   - In presenza di lubrificanti o superfici particolarmente lisce/rugose, i coefficienti $\mu_s$ e $\mu_d$ cambiano.

4. **Discesa frenata**  
   - Il termine “frenata” indica che l’attrito dinamico agisce da “freno” rispetto alla componente del peso lungo il piano.  
   - Se la somma delle forze è diretta verso il basso, ma minore del peso parallelo al piano, si avrà un’accelerazione minore di $g \sin \theta$.  
   - In certi casi (ad esempio se si esercita anche una forza esterna contraria alla discesa) si può avere moto uniformemente ritardato o addirittura moto verso l’alto se la forza di attrito più la forza esterna superano $mg \sin \theta$.

---

## Riepilogo formule principali

- **Reazione normale**:
  $$
  N = mg \cos \theta
  $$
- **Forza di attrito statico (max)**:
  $$
  A_{s,\text{max}} = \mu_s \, mg \cos \theta
  $$
- **Forza di attrito dinamico**:
  $$
  A_d = \mu_d \, mg \cos \theta
  $$
- **Accelerazione in caso di moto sul piano con attrito dinamico**:
  $$
  a = g \bigl(\sin \theta - \mu_d \cos \theta \bigr)
  $$