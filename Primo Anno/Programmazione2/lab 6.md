---
date: 2024-05-07
Materia: "[[Programmazione 2]]"
---

1: Blocchi Clickabili
----------------------------------------------------------
Create tre classi che estendono BlockPane, una per ogni
tipo di event listener che adrete ad aggiungerci
- esterno (che riceve un oggetto di una classe che dovete
    definire voi per gestire gli eventi)
- interno (che inizializza la gestione degli eventi con
    un oggetto di una classe interna)
- anonimo

Usate i blocchi con listener esterni per i blocchi della 
mappa, quelli interni per i blocchi della fornace e 
quelli anonimi per i blocchi dell'inventario.

Attenzione a quale EventHandler importate, a volte 
IntelliJ importa quello di awt, non di javafx.

1.1: Test
----------------------------------------------------------
Prima ancora di riempire i metodi handle, testate che vada
il tutto, magari con delle semplici printouts.

1.2: Handle
----------------------------------------------------------
Riempite i metodi handle dei vari listeners.
Ricordatevi di mettere le chiamate a redraw del controller
per aggiornare la GUI.

Notate quali handler hanno bisogno di quali parametri per
funzionare: alcuni necessitano del controller, altri no.


2: Listener da Tastiera
----------------------------------------------------------
Aggiungete un listener da tastiera al MainGUI che ascolta
la pressione di questi tasti:
- S per cambiare l'ordinamento dell'inventario
- N per aggiungere un nuovo blocco casualmente
- R per aggiungere 10 blocchi casuali

Quando lo testate, occhio che se i TextFields sono in 
focus, scriverete i tasti al loro interno e non arrivera`
l'evento al key listener.


3: Eccezioni GUI
----------------------------------------------------------
Gestite le eccezioni generando dei messaggi appropriati su
finestre di tipo Alert.


4: Estensioni
----------------------------------------------------------
Rendete i blocchi minabili con piu click.
Ogni blocco puo` avere un valore di durezza, e un click
toglie un certo valore (Arbitrario, scegliete voi), e 
quando  questo diventa 0 o negativo, il blocco viene preso.
In base al valore del blocco, se ne cambi la 
rappresenzazione.
Per esempio potete usare  opacityProperty()  per settare
l'opacita` in base a quanto un blocco sia stato minato.
Attenzione a cambiarne la rappresentazione solo in mappa,
una volta che il blocco e` in inventario o in fornace,
si deve vedere come prima di essere stato minato.

Aggiungete una checkbox per usare un piccone per fare il
pick up dei blocchi, il piccone aumenta il valore che viene
sottratto da ogni blocco quando si clicka.
