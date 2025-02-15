---
date: 2024/04/17
tags: 
Materia: "[[Programmazione funzionale]]"
---

## Tipi base SML
### Unit
- `unit`
- Unico valore `()`
### Bool
- `bool`
##### Valori
- `true` o `false`
### Interi
- `int`
##### Valori
- Interi positivi e negativi
#####  Operatori
- `~` nega il segno
- `*`
- `+`
- `-`
- `div` divisione intera
### Reali
- `real`
##### Valori
- Insieme di approssimazioni di numeri reali
- `3.14` o `314e~2`
##### Operatori
- `~`
- `NaN` Indica un valore non rappresentabile come la radice quadrata di un numero negativo
- `inf` valori infiniti come la divisione per 0
- possono essere valutati con `<`, `>`, `<=`, `>=` valutandoli così a valori `bool`
- non possono venir fatti test di uguaglianza su questi

### Char
- `char`
##### Valori
- vengono rappresentati con il prefisso `#` e le virgolette esempio: `#"a"`

### String
- `string`
##### Valori
- insieme delle stringe esempio : `"ciao"`

##### Operatori
- `^` concatenazione

## Dichiarazione
- in ML possiamo associare un **identificatore** ad un **valore**
```
val <name>:<type> = <value >;
val <name> = <expression>;
```
- al posto del valore possiamo mettere anche un'espressione
esempio `val pi = 3.14`

Da notare che ad ogni dichiarazione viene creato un nuovo identificatore associato ad un valore

Quindi se andiamo a ridefinire `val pi = 3.1415` non stiamo modificando il valore precedente ma stiamo mascherando la `pi` precedente con una nuova dichiarazione.
- ML usa sempre l'**ultimo** **valore** associato ad un nome