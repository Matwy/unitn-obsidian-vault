---
date: 07/03/2024
tags:
  - "#probabilità"
Materia: "[[Probabilità e Statistica]]"
---
$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}\newcommand{\P}{\mathbb{P}}$
## Probabilità condizionata
Sappiamo che un certo evento $F$ si è verificato
vogliamo valutare la probabilità di un altro evento $E$ sulla base di questa conoscenza.

**DEF** $(\Omega, \mathscr{F}, P)$ spazio di probabilità  $P(F) \neq 0$,
Definiamo la probabilità di $E$ **condizionata** ad $F$ come
$$P(E|F) = \frac{P(E\cap F)}{P(F)}$$
![[Pasted image 20240307161354.png|center|400]] 

Quindi ora abbiamo solo esiti compatibili con $F$ e normalizziamo sapendo che ora il nostro "universo" è $F$
**OSS** $P(F|F) = \frac{P(F\bigcap F)}{P(F)} = \frac{P(F)}{P(F)} = 1$

**DEF** $E,F \in \mathcal{F}$ si dicono **indipendenti** se 
$$P(E\cap F) = P(E)P(F)$$

**Teorema** Sia $(E_{i})_{i\in I}$ una partizione di $\Omega$
($I$ finito o numerabile) $\forall F\in \mathcal{F}$
$$P(F) = \sum_{i\in I} P(F\cap E_{i}) = \sum_{i\in I} P(F|E_i)P(E_i)$$
	Dividiamo il problema in sottoproblemi più semplici

**DEF** $(\Omega, \Fcal, \mathbb{P})$ $F \in \Fcal$  $\mathbb{P}(F) \neq 0$
Due eventi $E_1,E_{2}\in \Fcal$ si dicono **indipendenti** **condizionatamente**  ad $F$
$$
\mathbb{P} (E_{1}\cap E_{2}|F) = \mathbb{P} (E_{1}|F)\mathbb{P}(E_{2}|F)
$$
#### Studio di un fenomeno 
1) facciamo un'ipotesi $H, \P(H)$
2) pianifichiamo un esperimento $E$
3) Valutiamo i possibili risultati e la loro plausibilità rispetto a $H, H^{c}, \P(E|H), \P(E|C)$
4) aggiorniamo la nostra convinzione che $H$ sia vera $\P(H|E)$
#### Esempio
Pierino ha studiato?
$H=$"P non ha studiato" $\P(H) =70\%$
$E=$ "P non risponde correttamente"
$P(E|H) = 90\%$     
$\P(E|H^{c})=1-\P(E^c|H^c)$

Si verifica $E$
$$P(H|E) = \frac{\P(E|H)\P(H)}{\P(E)}$$
$$
=\frac{\P(E|H)\P(H)}{\P(E|H)\P(H)+\P(E|H^{c})\P(H^c)}
$$

