---
date: 2024/12/15
tags: 
Materia: "[[Basi di dati]]"
---
## Nested loop join
- algoritmo più semplice e immediato per eseguire un JOIN
![[Pasted image 20241215105714.png|400]]

- dovremo leggere per $R$ volte $1+|S|$ tuple ovvero $|R| + |R|*|S|$

$$
Costo_{NestedLoopJoin}= P_{R}+P_{R}\cdot P_{S}
$$
## Merge JOIN
- le tabelle R e S sono ordinate rispetto ai valore degli attributi su cui facciamo il join
$$
Costo_{MergeJoin}= |R|+|S|
$$
#### external merge sort
- Quando non è possibile caricare in memoria interna tutti i dati da riordinare ci si appoggia a una memoria esterna
- $P_{R}$ pagine di $R$
- $B$ numero di pagine che possono essere caricate in RAM
-  
$$
2\cdot P_{R} \cdot (\lceil log_{B-1}\lceil \frac{P_{R}}{{B}} \rceil +1)
$$
- Se $R$ e $S$ non sono già ordinate il costo del merge JOIN sarà il costo di riordinare $R$ riordinare $S$ e sommato a $P_{R} + P_{S}$

## Hash JOIN
- usa due hash tables per il join
	- divide le tuple in bucket con una funzione di hash
	- poi fa il join tra le tuple nello stesso bucket

> tutte le tuple in un bucket di ${R}$ possono andare in join solo con le tuple che sono nel bucket corrispondente di $S$

$$
Costo_{HashJoin}= (P_{R} +2\cdot|R|) + (P_{S}+2\cdot |S|) +(P_{R} + P_S)
$$

## Index Nested Loops JOIN
- Variante del NLJ dove di assume ci sia un indice sulla inner table
- Leggiamo tutte le pagine della outer table $R$ e poi cerchiamo tramite indice le tuple di $S$ che soddisfano la condizione del JOIN
$$
Costo_{IndexNestedLoopJoin} = P_{R} + |R| \cdot Costo_{EqSearchS}
$$
> Il costo dell'equality search dipende da che tipo di indice abbiamo sull'attributo di $S$ usato per il JOIN

