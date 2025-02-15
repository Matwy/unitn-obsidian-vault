---
date: 2024-02-27
Materia: "[[Calcolatori]]"
tags:
  - binario
---
# Binario
Il computer usa solo 1 e 0 (acceso e spento)
Il sistema binario uguale
Una cifra binaria si chiama **bit**
Una sequenza di **8 bit** si chiama **byte**
Un **byte** può assumere $2^8$ valori da $0$ a $255$ $(=11111111_{2})$
# Conversioni

## Conversione da decimale ad una base $B$

Per convertire $x_{10}$ in base $B$
1) Divisione intera fra $x$ e $B$
2) Il resto è la cifra da inserire a sinistra nel numero convertito
3) Il quoziente viene assegnato ad $x$
4) Si riparte al punto 2
**ESEMPIO**
![[Pasted image 20240227135937.png]]


## Conversione da una base $B$ a decimale
$$= \sum_{k=0}^{i}c_{k}B^k $$
**ESEMPIO** $170_{8} = 1\cdot 8^{2}+ 7\cdot 8^{1}+ 0 \cdot 8^{0}= 120_{10}$

## Somma tra numeri binari
![[Pasted image 20240227142145.png]]

## Sottrazione tra numeri binari
![[Pasted image 20240227142427.png]]

## Moltiplicazione per potenze di 2
![[Pasted image 20240227144855.png]]

#### Codifica numeri interi
- [[Codifica numeri interi]]