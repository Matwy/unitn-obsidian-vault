---
date: 29/02/2024
tags:
  - insiemi
Materia: "[[FMI]]"
---
## Relazione 
**DEF 1.9** Siano $X$ e $Y$ due insiemi
Un sottoinsieme $R$ di $X\times Y$ si dice **relazione** TRA $X$ e $Y$
Tutti $x\in X$ e $y \in Y$ diciamo che $xRy$ (x in relazione con Y) se $(x, y)\subseteq R$

**DEF 1.10** Siano $X$ e $Y$ due insiemi 
E sia $f$ una relazione tra $X$ e $Y$
cioè $f\subset X\times Y$
Diciamo che $f$ è una funzione da $X$ in $Y$ se 

$$\forall x\in X \, , \, \exists !\, y \in Y \,tc\, $$
Se $f$ è una funzione si indica $f \, X\to Y$


## Funzione come legge
Siano $X$ e $Y$ due insiemi non vuoti
Una funzione $f$ come legge da $X$ in $Y$
che indichiamo con $f\, X\to Y$ 
è una legge che ad **ogni** **elemento** $x$ di $X$ **associa un unico elemento** $y$ di $Y$ 
![[Pasted image 20240229092531.png|center|300]]

### Equivalenza tra i concetti di funzione come relazione e come legge nel caso di dominio e codominio non vuoti
Siano $X$ e $Y$ due insiemi non vuoti
# TODO

**DEF** Dati $X \to Y$ due insiemi eventualmente vuoti
indichiamo con $Y^x$ 
l'insieme dai tutte le funzioni di tipo relazione da $X$ in $Y$ 
**OSS** Dato un insieme $A$ 
esiste l'insieme delle parti di $A$ che indichiamo con 
$\mathscr{B}(A)$ oppure $2^A$
i cui elementi sono tutti e soli i sotto insiemi che si possono estrarre da $A$
Ad esempio se $A = \{1,\,2,\,3\}$
allora $2^{A} = \{\varnothing, \{1\}, \, \{2\}, \,\{3\}, \, \{1, 2\},  \, \{2, 3\}, \, A\}$

**OSS2** Siano $X$ e $Y$ due insiemi eventualmente vuoti 
Allora vale :
$$Y^{x}=\{f\in 2^{x\times y} \,|\, \forall x \in X, \, \exists ! \, y \in Y \, tc \, (x, \, y) \in f\} $$

Grazie all'assioma 1.6 di separazione $Y^x$ è un insieme

fai es 1.6 p4 DISPENSE

**ESEMPIO 1.12** Sia $X$ un insieme 
Indichiamo con $$id_{x}:\quad X\to X \quad tc \quad id_{x}(x) = x \quad \quad\forall x \in X$$
### Composizione
**DEF** Siano $X,\,Y$ e $Z$ tre Insiemi e siano $f$ e $g$ due funzioni
$f:\, X\to Y \quad \quad$ e $\quad \quad g:\, Y\to Z$  
Determiniamo la **composizione** di $f$ e $g$ come la seguente 
$$g \circ f : \, X \to Z \,tc\, (g\circ f)(x) = g(f(x)) \quad \forall x\in X$$ 
### Immagine
Sia $f:\, X\to Y$ una funzione
Dato un sottoinsieme $A$ di $X$,
definiamo l'**immagine** di $A$ tramite $f$ come 
$$f(A) = \{f(x)\in Y\,|\, x\in A\}$$
### Controimmagine
Sia B un sottoinsieme di $Y$ 
Definiamo controimmagine di $B$ tramite $f$
$$f^{-1}(B)= \{x\in X \, |\, f(x) \in B\}$$
### Fibra
Se $B = \{y\}$ allora $f^{-1}(\{y\}) = \{x \in X \,|\, f(x) = y\}$
**FIBRA** di $f$ sopra $y$

### Iniettiva
data una funzione $f$ questa è **iniettiva** se
$\forall x_{1}, x_{2}\in x \quad tc \quad x_{1}\neq x_{2}$
allora $f(x_{1}) \neq f(x_2)$
### Surgettiva (suriettiva)
data una funzione $f$ questa è **surgettiva** se
$f(x) = y$ ovvero
$\forall y \in Y \, \exists \, x \in X \quad tc \quad f(x) = y$

### Bigettiva (Biiettiva)
$f$ è **bigettiva** se è sia iniettiva che surgettiva

