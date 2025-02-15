---
date: 2024-05-07
Materia: "[[Programmazione 2]]"
---


In questo lab aggiungerete un design pattern chiamato
Model-View-Controller alla vostra applicazione.
Anzi, ne farete due. 
Il primo, molto semplice, connette la logica alla GUI in
maniera inefficiente (ma funzionante).
Il secondo invece e` un refactoring della logica scritta
in precedenza, per stampare a schermo (senza GUI).
Non introdurrete nuove funzionalita`, ma organizzerete
quelle esistenti secondo i principi di Object-Oriented
Programming per facilitare le future estensioni del codice.

https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller


1: Un MVC Inefficiente
----------------------------------------------------------
In questo MVC vogliamo evitare di toccare la business 
logic dentro Map, Inventory e Furnace. 
L'idea e` di creare dei controllers che 
- ricevono gli input dell'utente dalla GUI
- chiamano i relativi metodi all'interno delle classi
    della business logic esistente
- ri-disegnano il loro pezzo di GUI da capo
Servono quindi quattro controller, uno per Map, uno per 
Inventory, uno per Furnace e uno per MainView.

1.1: Controller Interface
----------------------------------------------------------
Create una interfaccia SimpleController con un solo metodo
redraw.

1.2: Controller Classes: Overview
----------------------------------------------------------
I Controller seguono tutti la stessa struttura, hanno due
campi: uno che e` business logic, e uno che e` il Pane
che devono disegnare.

I costruttori dei Controller prendono i valori iniziali
per entrambi i campi in input (eccetto quello del Main,
per semplicita`).

1.3: Controller Classes: FurnaceSimpleController
----------------------------------------------------------
I due campi sono di tipo Furnace e FurnacePane.
Per essere sicuri che venga mostrato, chiamate redraw alla
fine del costruttore.

Il metodo redraw rimuove tutti i figli del FurnacePane,
poi lo ri-popula, aggiungendo il testo in cima, aggiungendo
l'input della Furnace, aggiungendo il testo con la freccia,
e infine aggiungendo l'output della Furnace.

Per fare questa cosa in modo modulare, potete modificare
FurnacePane in modo che abbia dei metodi per aggiungere 
il testo e la freccia, e chiamare questi metodi sia all'
interno del costruttore di FurnacePane, che dal controller.

Testate che funzioni creando un controller, chiamando i 
metodi della Furnace e chiamando redraw sul controller.

1.3: Controller Classes: InventorySimpleController
----------------------------------------------------------
I due campi sono di tipo Inventory e InventoryPane.
Come prima, chiamate redraw alla fine del costruttore.

Anche qui, il metodo redraw rimuove tutti i figli dell'
InventoryPane, aggiunge il testo, e poi aggiunge tutti
i blocchi che Inventory ha nella sua collection.

Per comunicare questi blocchi, non serve fare un getter
che ritorni la collection, potete ritornare l'iteratore
di quella collection e usarlo per ottenere i Blocks con
cui creare i BlockPane da aggiungere ai Children dell'
InventoryPane.

Testate!

1.4: Controller Classes: MapSimpleController
----------------------------------------------------------
I due campi sono di tipo Map e MapPane.
Come prima, chiamate redraw alla fine del costruttore.

Il metodo redraw ha i soliti due cicli per passare tutte
le celle della Map, e chiamera` set_cell di MapPane con
il risultato di get_cell su Map, usando le stesse 
coordinate.

Testate che non ci siano problemi di comunicazione tra
i due oggetti Map e MapPane, che usano coordinate 
invertite!

1.5: Controller Classes: MainSimpleController
----------------------------------------------------------
I due campi sono di tipo MainView e MainGUI.
Questo controller ha anche un altro campo controllerslist
di tipo Collection<SimpleController>.
Infine ha anche un campo per ognuno dei Controller 
sopracitati.

Questo costruttore prende solo il valore per il campo di
tipo MainView in input, e crea lui un nuovo MainGUI al
suo interno. Il motivo e` spiegato nella prossima sezione.

Il costruttore poi crea 
- un MapSimpleController con la Map della MainView e con
    il MapPane della MainGUI
- un FurnaceSimpleController con la Furnace della MainView
    e il FurnacePane della MainGUI
- un InventorySimpleController con l'Inventory della
    MainView e l' InventoryPane della MainGUI
e aggiunge questi controller alla sua collection e ne 
inizializza i campi relativi.

Il metodo redraw di questa collection chiama redraw su
tutti gli elementi di controllerslist.

Aggiungete poi questi metodi dentro al MainSimpleController
 -smelt, move_into_inventory_from_furnace, 
    move_into_furnace_from_inventory, pick_up_block,
    toggle_inventory_comparator
questi metodi chiamano i metodi omonimi sul campo MainView.
Dopo averlo fatto, i metodi chiamano redraw sui controller
che sono coinvolti. Per esempio, nel caso di pick_up_block
viene chiamato redraw sul MapSimpleController e sull' 
InventorySimpleController.

1.6: Cambi nella MainGUI
----------------------------------------------------------
Per collegare l'input utente al controller, aggiungete un
parametro a MainGUI di tipo MainSimpleController.

Aggiungete quel parametro anche a ButtonView, e passatelo
da MainGUI a ButtonView quando viene creato.

All'interno di ButtonView, scrivete gli handler dei 
bottoni creati durante il lab 4.

- il bottone in prima riga legge gli interi dai due 
    TextField e chiama 'pick_up_block' di 
    MainSimpleController con le coordinate lette
- il bottone in seconda riga legge l'intero dal
    TextField e chiama move_into_furnace_from_inventory
- il bottone in terza riga chiama smelt
- il bottone in quarta riga chiama
    move_into_furnace_from_inventory
- il bottone in quinta riga chiama 
    toggle_inventory_comparator

1.7: Unire il Tutto
----------------------------------------------------------
All'interno del metodo start della vostra MainFX 
application, usate questo codice per testare il tutto.

```
mc = new MainSimpleController(new MainView());
MainGUI layout = mc.getMainGUI();
Scene scene = new Scene(layout);
stage.setScene(scene);
stage.show();
```


2: MVC per la Stampa Senza GUI
----------------------------------------------------------
L'MVC che avete creato ora funziona, a un certo livello
tiene divisa interfaccia e logica.
Pero` non e` efficiente. Se cambia un solo blocco della
mappa, posso dire solo al controller di quell'elemento di 
cambiare? 
Si, ma richiede una architettura piu` precisa del progetto.

Prima di arrivare a quel punto, notiamo una cosa.
Il progetto che stampa ad output non e` sviluppato come 
MVC. Le classi Map, Furnace, Inventory e MainView sono sia
controller, che view (tramite il metodo display_to_out),
che model.

In questa parte del lab farete un lavoro di refactoring,
estraendo prima le funzionalita` di View e poi quelle di
Model da quelle classi.

Anche qui, usate il package system per creare ordine.
Per spostare e rinominare cose all'interno del progetto, 
usate la funzione 'Refactor' di IntelliJ.

2.1: La View Tramite TextPrinter
----------------------------------------------------------
Definite una interfaccia TextPrinter con un metodo 
display_on_out.

Create le classi: FurnacePrinter, InventoryPrinter, 
MapPrinter e MainPrinter.

Spostate i metodi display_on_out dalle classi non-printer
alle relative classi Printer.
Notate come IntelliJ si lamenta, alcune informazioni di
cui hanno bisogno questi metodi non sono presenti!

Aggiungete tali informazioni come campi nella relative 
classe Printer, per esempio:
- private SmeltableBlock e private Block out; 
    per FurnacePrinter
- private Collection<Block> il e 
    private Comparator<Block> cb; per InventoryPrinter
- private Block[][] content; per MapPrinter
- MapPrinter m, FurnacePrinter f, e InventoryPrinter i 
    per MainPrinter

Aggiungete ad ogni classe Printer un metodo update che
prende i parametri utili per inizializzare i campi;

Domanda: Come potete uniformare i separatori laterali? 
    Hint: usate una classe astratta.

2.2: Un Abstract Controller 
----------------------------------------------------------
Create una classe astratta AbstractTextController con:
- un campo tp di tipo TextPrinter
- un getter per questo campo
- un metodo abstract updatePrinter()
- questo metodo
```
public void update_and_display(){
    this.updatePrinter();
    tp.display_on_out();
}
```

Per ognuna delle classe Map, Furnace, Inventory e MainView, 
create una classe Controller che estende 
AbstractTextController.
Aggiungete nei costruttori delle nuove classi un parametro, 
la classe di Model e inizializzate il campo tp con il 
TextPrinter corretto in ogni classe.

Per esempio, il costruttore di MapController prende in
input un Map, e lo salva in un campo privato e crea un
nuovo MapPrinter per tp.

Ora dovrete implementare updatePrinter in ogni classe,
chiamando il metodo update su tp, e passando i parametri
necessari. 
Notate la necessita` di cast per fare funzionare questa
cosa: perche`?
Questo metodo dentro a MainView deve anche chiamare 
updatePrinter sugli AbstractTextController che sono 
contenuti dentro a MainView.

Notate un'altra cosa: 
 - potete chiamare update_and_display su un oggetto di tipo
    MapController, FurnaceController, InventoryController 
    o MainViewController? Perche`?
 - cosa succede quando lo fate? Quale updatePrinter viene
    chiamato?

2.3: Testate
----------------------------------------------------------
Non avendo aggiunto funzionalita` nuove, il codice, se 
compila, dovrebbe andare direttamente. 
Se questo succede, fatecelo sapere. 

In base all'ordine in cui fate questo refactoring, potreste
avere delle classi con dei metodi che non vengono chiamati.
IntelliJ ce li segnala, eliminateli solo dopo aver testato.

2.4: E la GUI?
----------------------------------------------------------
Notate come il controller della GUI utilizzi lo stesso 
model del controller testuale: entrambi i controller hanno
la stessa sostanziale struttura.

