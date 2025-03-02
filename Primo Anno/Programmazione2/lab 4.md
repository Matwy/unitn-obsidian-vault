---
date: 2024-05-07
Materia: "[[Programmazione 2]]"
---

1: GUI con JavaFX 
----------------------------------------------------------
In questo lab aggiungerete una GUI al progetto sviluppato
in precedenza. 

Domanda: dove mettete le classi della GUI? Usate la 
    struttura di package per fare ordine.

1.1: BlockPane
----------------------------------------------------------
Create una classe BlockPane che estende StackPane.
BlockPane ha un campo privato di tipo Block che viene
passato e inizializzato dal costruttore.

BlockPane e` il responsabile di stampare il Block che
contiene. Ogni blocco viene stampato come un quadrato 
colorato di 50x50 px, e sopra il nome identificativo del
blocco.
Usate la classe Rectangle per creare il quadrato 
colorato, e Test per il testo.

Potete usare queste costanti per giocare con i parametri
della visualizzazione:
```
public static final int DIM_SQUARE = 50;
private static final String FONT_NAME = "Verdana";
private static final int FONT_SIZE = 18;
private static final FontWeight FONT_WEIGHT = FontWeight.BOLD;
private static final Color BLOCK_BORDER = Color.BLACK;
private static final Color FONT_FILL = Color.BLACK;
private static final Color FONT_BORDER = Color.BLACK;
```

Il colore del BlockPane varia in base al blocco stesso,
create un metodo (statico?) che prende un blocco e in
base al suo tipo, ritorna un Color.

Isolate i comandi responsabili di inizializzare i valori
del Rectangle e del Text in un metodo initialise, che
viene chiamato alla fine del costruttore di BlockPane.
Rendete questo metodo private.
Domanda: perche` farlo private?

Create un metodo changeBlock che prende un Block e cambia
il Block del BlockPane al blocco preso in input e richiama
initialise per aggiornare la visualizzazione.

Testate.
Create un BlockPane, visualizzatelo, cambiatene il Block 
all'interno e verificate che funzioni l'aggiornamento
della visualizzazione.

1.2: InventoryPane
----------------------------------------------------------
Create una classe InventoryPane che estende HBox.
InventoryPane ha un campo Text e un campo HBox, il primo
serve per stampare Inventory:, il secondo serve per 
contenere tutti gli oggetti da stampare.
Entrambi sono aggiunti come children di un InventoryPane
dal costruttore.

Testate.
Create un InventoryPane, visualizzatelo, create una 
Collection di Blocks, e per ogni elemento nella
collection, aggiungete all'InventoryPane un BlockPane 
inizializzato con l'elemento Block.

1.3: MapPane
----------------------------------------------------------
Create una classe MapPane che estende GridPane.
Create un metodono initialise_air che inizializza la 
griglia di MapPane con dei BlockPane i cui Blocks sono
degli AirBlock

Attenzione! in Gridpane, le row e col sono invertite.
    Se in una matrice come in Map avete l'elemento [i][j],
    in un GridPane, lo stesso elemento e` in [j][i].

Aggiungete il seguente metodo, cortesia del prof Ronchetti
```
public static Node getElementAt(GridPane gp, int i, int j) {
    for (Node x :gp. getChildren()) {
        if ((GridPane.getRowIndex(x) == i) && (GridPane.getColumnIndex(x) == j)) {
            return x;
        }
    }
    return null;
}
```

Create un metodo get_block_at_coord che prende delle 
coordinate riga-colonna e restituisce il BlockPane a quelle
coordinate. Usate getElementAt e cast dove necessario.

Domanda: e se le coordinate sono out-of-bound?

Create un metodo setCell che prende delle coordinate 
riga-colonna e un Block. Questo metodo sostituisce il 
blocco all'interno del BlockPane delle coordinate.
Se il blocco e` null, invece, viene aggiunto un BlockPane
con il blocco desiderato all'interno.

Occhio, se aggiungeste sempre un BlockPane a delle 
coordinate, quelli vecchi non verrebbero eliminati, ma
rimarrebbero li`, coperti dai BlockPane nuovi. 

Testate che la mappa funzioni.
Create una matrice di Blocks casuale e inizializzate 
il MapPane con i blocchi della matrice.

1.4: FurnacePane
----------------------------------------------------------
Create FurnacePane che estende VBox, con due campi:
input e output che sono BlockPane. 
Aggiungete del testo che dica "Furnace", poi l'input,
poi del testo che dica "-->", poi l'output.

Testate che visualizzi correttamente i blocchi.

1.5: ButtonListPane
----------------------------------------------------------
Create ButtonListPane, che estende VBox.
Aggiungete un Bottone singolo, con un EventHandler anonimo
che in caso di pressione non fa nulla.

1.6: MainGui
----------------------------------------------------------
Create MainGui che estende BorderPane.
Settate al centro un MapPane, a sinistra il 
ButtonListPane, a destra un FurnacePane.


2: Interazioni Aggiuntive
----------------------------------------------------------

2.1: Visualizzare l'Aggiunta di Sabbia
----------------------------------------------------------
Modificate l'handler del bottone in modo che aggiunga un 
blocco di sabbia alle coordinate 0-0 della mappa.

2.1: Aggiungere un Blocco Casuale
----------------------------------------------------------
Modificate l'handler del bottone in modo che generi un
Block casuale e che questo venga aggiunto all'interno del
MapPane a coordinate casuali.

2.3: ButtonListPane Layout
----------------------------------------------------------
Create il ButtonListPane in modo che abbia:
- su una riga due TextField e un Button che dice "Pick"
- su una riga un TextField e un Button che dice 
    "Move to Furnace"
- su una riga un Button che dice "Smelt"
- su una riga un Button che dice "Move back"
- su una riga un Button che dice "Toggle Inventory Sorting"

2.3: Layout Options
----------------------------------------------------------
Giocate con le opzioni di layout per rendere la GUI 
piacevole.


3: Estensioni
----------------------------------------------------------

3.1: Preparazione al Prossimo Lab
----------------------------------------------------------
Nel tempo rimanente, fatevi una copia del progetto e fate
quanto scritto qui sotto su quella copia.
L'obiettivo e` farvi realizzare che per quanto le cose 
funzionino, il nostro codice sta diventando tanto e di 
difficile gestione.

In preparazione al prossimo lab, aggiungete dei getters
a map, furnace, e inventory per gli oggetti che devono 
essere visibili da fuori, tipo:
    un blocco a certe coordinate, 
    gli input-output della fornace
    un iteratore sugli elementi dell'inventory

Attenzione a non fare overriding con i getters gia` 
esistenti, tipo quelli di Furnace che hanno una logica piu`
complessa del semplice Getter.

Provate a connettere le parti di 'business logic' gia fatte
all'interno di Map, Furnace e Inventory alle loro controparti
grafiche tramite i getters e l'aggiunta di parametri o di 
campi (privati).

3.2: Limitazioni dell'OOP
----------------------------------------------------------
Fermatevi a ragionare sulla struttura delle classi e sul
rapporto tra i campi e le classi.
Concettualmente, possiamo categorizzare i blocchi in base
alle loro proprieta`: 
 - se seguono la gravita`
 - se gli si cade attraverso
 - se sono prendibili
 - se sono smeltabili
Idealmente, potremmo avere una classe astratta per ognuna
di queste proprieta`, ma dato il sistema di ereditarieta`
singola di Java, come facciamo per creare tutte le 
combinazioni di questi booleani? Dovremmo codificare a 
mano il prodotto cartesiano di tutte quelle classi ... 

La cosa viene risolta dai linguaggi che hanno i Traits,
che per certi versi sono una generalizzazione del 
paradigma OOP. 
Per farlo in Java dobbiamo seguire le linee guida di 
Java che sono 
"prediligere la composizione all'ereditarieta`"
che pero` cozza con tanti benefici dell'analisi dei tipi 
che ci permette di fare l'ereditarieta`.

Domanda: come si potrebbe ristrutturare la classe astratta
    Block per favorire la composizione e supportare tutti
    questi tipi di proprieta` in modo piu` modulare?

