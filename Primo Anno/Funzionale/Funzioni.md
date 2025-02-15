---
date: 2024/04/17
tags: 
Materia: "[[Programmazione funzionale]]"
---
## Funzioni
Le funzioni in ML possiamo vederle come funzioni matematiche con un **dominio** e **codominio** definito dal tipo dei parametri e il tipo di ritorno.
Una funzione non può avere **effetti** **collaterali**, non può avere effetti che non siano nel **valore** **di** **ritorno**.

### Sintassi
- `fn` è la keyword usata per esprimere un valore di tipo funzione
```
fn <param> => <expression>;
```
- `<param>` è il nome del parametro formale, può essere specificato il tipo
- `<expression>` è un'espressione ML valida

#### Esempio
```
(fn n => n+1) 5;
```
- Questo codice definisce una funzione e poi la applica al valore 5
- Il nome `n` viene quindi associato al valore 5 e poi viene effettuata l'operazione `n+1`
###### Nomi a funzioni
Una valore di tipo funzione può essere legato ad un valore (vedi [[Tipi base SML#Dichiarazione]])
```
val incrementa = fn n => n+1;
```
- il tipo di questa funzione è `fn : int -> int`
	- In matematica equivalente a $f : \mathbb{N} \to \mathbb{N}$

Un altro modo di definire le funzioni è
```
fun incrementa(n) = n+1;
```

## Definizione per casi
Una funzione può anche definire per ogni caso che valore associare
```
fn x => case x of
<pattern1> => <exp1>
| <pattern2> => <exp2>
| <pattern3> => <exp3>;
```
##### Esempio
```
val giorno = fn n => case n of 
1 => ” Lunedi ’ ”
| 2 => ” Martedi ’ ”
| 3 => ” M e r c o l e d i ’ ”
| 4 => ” Giovedi ’ ”
| 5 => ” Venerdi ’ ”
| 6 => ” Sabato ”
| 7 => ” Domenica ”
| _ => ” Giorno non v a l i d o ” ;
```
- `_` cattura tutti i casi non enumerati

## Ricorsione
```
val rec fact = fn n = > if n=0 then 1 else n*fact(n-1);
```
oppure
```
fun fact(n) = > if n=0 then 1 else n*fact(n-1);
```
