---
date: 2024/06/09
tags: 
Materia: "[[Programmazione funzionale]]"
---
## Lambda calculus
- E' un modo per scrivere funzioni
- `fn x => e` in ML
- $\lambda x.e$ in $\lambda$- calculus
## Due operazioni
- **Abstraction** di un term con la rispettiva variabile $x$
	- $\lambda x.e$ è una funzione che quando applicata ad un valore $v$ produce $e$ dove viene rimpiazzata $v$ al posto di $x$ 
- **Application** di una funzione a un parametro $e_{1} e_{2}$ che è l'applicazione della funzione $e_{1}$ alla funzione $e_{2}$

## Terminologia
$$
\underbrace{\lambda x}_{binder}\overbrace{e}^{\text{lo scope di x}}
$$
- Il set di **free variables** di un espressione  è composto dalle variabili non legate ad un binder
	- $F_{v}(\lambda x.xy) = {y}$

- Il set di **bound variables** di un espressione  è composto dalle variabili legate ad un binder
	- $B_{v}(\lambda x.xy) = {x}$

## Curried function
- In ML le funzioni prendono un solo argomento 
	- per simularne molteplici usiamo le tuple

- Un altro modo sarebbe quello di usare delle **curried function**
	- divide i suo argomenti facendo più funzioni da un solo argomento
---
## Encodings
#### Booleans
- **true** $= \lambda x. \lambda y. x$
- **false** $= \lambda x. \lambda y. y$
- if a then b else c = a b c

- **Example**
	- If **true** then b else c $= (\lambda x. \lambda y. x)b\, c = b$
	- If **false** then b else c $= (\lambda x. \lambda y. y)b\, c = c$

##### not
- **not** $= \lambda x.x\, false\, true$
- not x = if x then false else true
##### and
- **and** $= \lambda x. \lambda y .x\, y\, false$
- and x y = if x then y else false

##### or
- **or** $= \lambda x.\lambda y.x\, true\, y$
- or x y = if x then true else y

##### xor
- $xor \, x\,y = \lambda x. x (not(y))y$
- xor x y = if x then (if y then false else true) else (if y then true else false)
---
#### Pairs
- $(a,b) = \lambda x. \text{if x then a else b}$
- $first = \lambda f . \text{ true}$
- $second = \lambda f . \text{ false}$

---
#### Naturali
- Peano
	- 0 è un numero naturale
	- se n è naturale lo è anche $succ(n)$

- Church's
	- 0 è $\lambda f. \lambda x. x$
	- intuitivamente f applicata 0 volte a x
	- $succ(n):$ applica f a x n volte

##### Successor
- Scriviamo $nf$ con significato "applico f $n$ volte"
- allora $n$ è $\lambda . \lambda x . n f x$
- definiamo $succ(n) = \lambda n . \lambda f . \lambda x . f(n f x)$
![[Pasted image 20240609153234.png]]
##### Is zero
$iszero = \lambda z.z(\lambda y.false)true$
##### Addition
$add\,n\,m = \lambda n. \lambda m. \lambda f. \lambda x. mf(nf(x))$
---
## Recursion

### Y-combinator
- $Y=\lambda f. (\lambda x. f(xx))(\lambda x. f(xx))$
