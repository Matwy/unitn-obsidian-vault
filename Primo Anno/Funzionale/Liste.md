---
date: 2024/05/15
tags: 
Materia: "[[Programmazione funzionale]]"
---
# Appunti sulle Liste in SML

## Introduzione

Le liste in SML (Standard ML) sono strutture dati fondamentali usate per rappresentare sequenze ordinate di elementi. Sono **immutabili**, il che significa che una volta create, non possono essere modificate. È possibile però crearne di nuove basate su quelle esistenti.

## Costruzione delle Liste

- **Lista vuota**: `[]`
- **Lista di un elemento**: `[1]`
- **Lista di più elementi**: `[1, 2, 3, 4]`

## Operatori sulle Liste

### Operatore `::`

L'operatore `::` (cons) è usato per aggiungere un elemento all'inizio di una lista.

Esempi:
```
val list1 = 1 :: [];          (* [1] *)
val list2 = 1 :: 2 :: [];     (* [1, 2] *)
val list3 = 1 :: [2, 3, 4];   (* [1, 2, 3, 4] *)
```

### Operatore `@`

L'operatore `@` è usato per concatenare due liste.

**Esempi**:

```
val list1 = [1, 2, 3];
val list2 = [4, 5];
val concatenatedList = list1 @ list2;  (* [1, 2, 3, 4, 5] *)
```
---
### Funzioni sulle Liste
#### Head `hd`
- Restituisce il primo elemento della lista. Solleva un'eccezione se la lista è vuota.

**Esempio**:
```
val firstElement = hd [1, 2, 3];  (* 1 *)
```
---
#### Tail `tl`
- Restituisce la lista senza il primo elemento. Solleva un'eccezione se la lista è vuota.
**Esempio**:
```

val restOfList = tl [1, 2, 3];  (* [2, 3] *)
```
---
#### null
- Verifica se la lista è vuota.
**Esempio**:
```
val isEmpty = null [];  (* true *)
val isNotEmpty = null [1, 2, 3];  (* false *)
```
---
#### length
- Restituisce la lunghezza della lista.
**Esempio**:
```
val listLength = length [1, 2, 3];  (* 3 *)
```
---
#### nth
- Restituisce l'elemento all'indice specificato (zero-based). Solleva un'eccezione se l'indice è fuori dal range.

**Esempio**:
```
val secondElement = nth ([1, 2, 3], 1);  (* 2 *)
```
---
## Pattern Matching sulle Liste
- Il pattern matching è una potente caratteristica di SML per de-strutturare le liste.

**Esempio**:
```

val list = [1, 2, 3];

val (first :: second :: rest) = list;
(* first = 1, second = 2, rest = [3] *)
	
(* Pattern matching per liste con un numero variabile di elementi *)
fun processList lst =
    case lst of
        [] => "Lista vuota"
      | [x] => "Un solo elemento: " ^ Int.toString(x)
      | [x, y] => "Due elementi: " ^ Int.toString(x) ^ " e " ^ Int.toString(y)
      | x :: y :: _ => "Almeno due elementi: " ^ Int.toString(x) ^ " e " ^ Int.toString(y);

val result1 = processList [];           (* "Lista vuota" *)
val result2 = processList [1];          (* "Un solo elemento: 1" *)
val result3 = processList [1, 2];       (* "Due elementi: 1 e 2" *)
val result4 = processList [1, 2, 3];    (* "Almeno due elementi: 1 e 2" *)
```
---