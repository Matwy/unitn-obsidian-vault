---
date: 2024-05-07
Materia: "[[Programmazione 2]]"
---

1: Unificare il Main Controller
----------------------------------------------------------
Prima di fare la terza 'View', estraete l'interfaccia del
MainController. A questo punto dovreste avere due 
MainController, che espongono gli stessi metodi a chi li
utilizza: estraeteli in una interfaccia 
MainControllerInterface.

Nel resto del codice (per es. nella MainGUI), usate il
tipo della nuova interfaccia dove possibile, invece di 
quello della classe.


2: Fine-Grained GUI
----------------------------------------------------------
Create un nuovo package per i controller fine-grained.

2.1: Fine-Grained Interface
----------------------------------------------------------
Create una interfaccia FGController con questi metodi:
	void efficient_redraw();
    void not_efficient_redraw();
    void add_efficiency_enabler(Object o);
    Collection<Object> get_efficiency_enabler();

2.2: Fine-Grained Abstract Class
----------------------------------------------------------
Create una classe astratta AbstractFGController che 
implementa l'interfaccia FGController. 
Aggiungete un campo 
	protected Collection<Object> efficiency_enablers;
che inizializzate nel costuttore, e definite il quarto
metodo dell'interfaccia in modo che vengano aggiunti gli
objects alla Collection.

Il primo metodo, redraw, deve controllare che 
efficiency_enablers contenga qualcosa. In caso affermativo,
chiama efficient_redraw e cancella la collection,
altrimenti, chiama la not_efficient_redraw.

I rimanenti metodi ereditati dell'interfaccia dichiarateli 
abstract.

2.3: Fine-Grained Classes
----------------------------------------------------------
Implementate le classi controller per Map, Inventory e 
Furnace, che estendono AbstractFGController.
Definite i metodi abstract, e nel costruttore non 
dimenticate la chiamata a super();

Dentro al FGMapController potete ora definire la 
not_efficient_redraw in modo che stampi tutta la griglia,
(tramite la setCell sulla MapGUI in base alla m.getCell 
sulla Map), mentre la efficient_redraw chiama gli stessi
metodi ma solo sulle Coordinate che sono aggiunte dentro 
alla collection efficiency_enablers.

Nota: avere una classe Coordinate semplifica di molto
	la gestione degli efficiency_enablers. 
	Inoltre, potete fare override del metodo 
	add_efficiency_enabler in modo che aggiunga solo 
	oggetti di tipo Coordinate

Nota: per essere sicuri che vengano stampati, alla fine
	del costruttore ricordatevi di chiamare redraw.

Impementate, oltre alla FGMapController, anche le classi
per FGInventoryController e FGFurnaceController.
Scegliete voi come e se implementare i metodi in modo
diverso.
Se scegliete di far fare la stessa cosa sia a 
not_efficient_redraw che ad efficient_redraw, potete
fare override di add_efficiency_enabler in modo che non
aggiunga nulla alla collection ereditata da 
AbstractFGController.

2.4: Fine-Grained Main
----------------------------------------------------------
Definite il FGMainController. Nei metodi che ereditate
dall'interfaccia MainControllerInterface, ricordatevi di
aggiungere agli efficiency_enablers dei sotto-componenti
del main controller, e di chiamare redraw su quei 
sotto-componenti.

Usate gli efficiency_enablers che il FGMainController 
eredita da AbstractFGController per aggiungere solo i
controllers che sono da ridisegnare, per esempio se 
viene chiamato pick_block, aggiungete solo i controller
per la mappa e per l'inventario.


3: Estensioni
----------------------------------------------------------
Il progetto di laboratorio, a questo punto, puo` essere
esteso in diverse direzioni. Scegliete quella che piu` vi
aggrada.

3.1: Funzionalita` Extra
----------------------------------------------------------
Aggiungete blocchi e funzionalita` extra.
Fatelo seguendo il design MVC: i nuovi blocchi vengono
aggiunti nel model, come anche la classe che gestisce la 
funzionalita` extra. Serve poi un nuovo pezzo di GUI che
visualizza la funzionalita` nuova, che va inserito all'
interno della MainGUI. Infine serve un controller che 
faccia parlare GUI e la classe che definisce la nuova
funzionalita`.

Esempi di funzionalita` includono:
- Enchanting.
	In un Tavolo da Incantamento si possono aggiungere due
	oggetti: uno e` di tipo 'Enchantable' (per es. i 
	blocchi IronSword), e uno e` di tipo 'Enchanting 
	Material' (un blocco nuovo, LapislazuliBlock).
	Una volta inseriti entrambi, si consumano i 
	Lapislazuli e si ottiene un EnchantedSwordBlock

	Pensate a come spostare da Inventario sia alla fornace
	che al tavolo da incantamento. Per esempio se uno
	clicka va da una parte, ma se shift-clicka va da un'
	altra. Ci sono diversi metodi che si possono 
	chiamare su un event, tipo mouseEvent.isShiftDown()
	per realizzare queste funzionalita`.

- Tooling
	In una Working Bench si possono mettere due Blocks 
	dello stesso tipo che vengono consumati per creare un
	altro blocco. Per esempio due WoodBlock possono essere
	usati e viene creato un WoodStick, due GlassBlocks 
	creano un GlassPaneBlock, e via discorrendo.

	Anche qui, pensate a come spostare dall'inventario al
	tavolo, oppure alla fornace, etc.

3.2: Enums
----------------------------------------------------------
Aggiungendo blocchi, alcune funzionalita` diventano piu`
difficili da gestire, come la selezione del colore di un
BlockPane.

Eliminate le classi di blocchi e create un Enum che estende
l'AbstractBlock e che al suo interno ridefinisce tutti i
blocchi di cui avete bisogno come varianti della Enum.

3.3: Abstract Main Controller
----------------------------------------------------------
Avete oramai tre Main Controllers, verosimilmente con del
codice che viene duplicato. 
Aggiungete una classe astratta AbstractMainController
che implementa MainControllerInterface.
Questa classe ha, al suo interno tre campi di tipo
MyController (l'interfaccia piu` generale che implementano
i controller), uno per la mappa, uno per l'inventario, e 
uno per la fornace.
Inoltre ha un campo MainFunctionalities.

Create i setter per tutti i Controller.

Nota: se volete procedere per passi, prima fate il 
	refactoring spiegato di sotto solo per i metodi, poi 
	estraete anche i campi dentro all'
	AbstractMainController.

Cominciate da un main controller (consigliato quello FG 
che avete appena fatto) e fategli estendere l'
AbstractMainController invece che l'AbstractFGController.
Inoltre, fategli implementare l'interfaccia 
FGControllerInterface. 
In questo modo, dovrete implementare le funzionalita` 
abstract che sono ereditate da AbstractFGController, e
anche quelle richieste per essere usate come un 
FGController.

Controllate il metodo che ereditate da FGController:
add_efficiency_enabler. Siccome il MainFGController ora 
non estende AbstractFGController, non ha la collection
efficiency_enablers.

Domanda: Come implementare il metodo, quindi?
 - se aggiungete il codice di AbstractFGController dentro a
 	MainFGController, fate duplicazione di codice
 - se provate a estendere anche AbstractFGController da 
 	MainFGController non potete: Java permette 
 	ereditarieta` singola
 - dovrete seguire le linee guida di Java: 
 	'preferite la composizione alla ereditarieta`'

All'atto pratico, questo significa che per risolvere questo
problema in un modo 'da Java', dovrete
- creare una classe MainFGControllerHelper che estende
	AbstractFGController
- aggiungere un campo di tipo MainFGControllerHelper dentro
	al MainFGController
- tutti i metodi che MainFGController implementa da 
	FGControllerInterface vengono richiamati sul campo di
	tipo MainFGControllerHelper.

Una volta fatto questo per il controller fine-grained, 
fatelo anche per quello simple e per quello testuale.