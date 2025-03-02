---
date: 17/04/2024
tags: 
Materia: "[[Programmazione 2]]"
---
1: Inventario
----------------------------------------------------------

1.1: Interfaccia InventoryBlock
----------------------------------------------------------
Create una interfaccia InventoryBlock per blocchi che 
possono essere messi nell'inventario (lo aggiungiamo dopo).
Block extends InventoryBlock e contiene un metodo 
display_in_inventory, per stampare un blocco dentro all'
inventario.
Implementate il metodo dentro AbstractBlock in modo che 
stampi "[c]" dove c e` il contenuto del blocco.

1.2: UI Inventario
----------------------------------------------------------
Aggiungete un'altra pezzo di UI, la classe Inventory.
Inventory ha una Collection di Block.
Potete usare la classe che preferite, per es. ArrayList.
Create un metodo per stampare l'inventario in modo che 
ogni elemento venga stampato tramite display_in_inventory.
Usate un Iterator per ciclare sulla collection.

Aggiungete i metodi:
- add_block(Block b) per aggiungere un Block all'inventario
- is_smeltable(int index), per dire se il Block di indice
	index e` uno SmeltableBlock o no
- get_smeltable_item(int index) per estrarre lo 
	SmeltableBlock di indice index.
In questi metodi ricordatevi che potete usare i metodi di
ArrayList solo previo cast.

1.3: Inventario nella MainView
----------------------------------------------------------
Aggiungete un campo Inventory alla MainView.
Cambiate il metodo smelt per aggiungere il risultato di
smelt all'inventario.
A questo punto potete testare le funzionalita` di prima,
e dovreste vedere il risultato di smelt venire aggiunto
all'inventario.


2: Prendere Blocchi
----------------------------------------------------------
Aggiungete due metodi, uno per spostare dall'inventario
alla fornace, e uno per spostare dalla fornace all'
inventario.
Adesso cambieremo la logica: i blocchi non vanno presi e
messi in fornace, prima vanno presi e messi nell'inventario,
poi vanno spostati dall'inventario alla fornace.

2.1: Pickable
----------------------------------------------------------
Aggiungete un campo pickable nella classe AbstractBlock.
Aggiungete il metodo is_pickable a Block, implementatelo
dentro AbstractBlock in modo che ritorni pickable.

Create il costruttore di AbstractBlock in modo che setti
pickable a false.
Create il costruttore di AbstractSolidBlock in modo che
setti pickable a true.

Ricordatevi di chiamare sempre il super() nei costruttori
delle sottoclassi!
E, in certi casi, cambiamo il risultato, per esempio,
settate pickable in NullBlock a false, e pickable in
SandBlock a true.

2.2: Cambi a Furnace
----------------------------------------------------------
Aggiungete un metodo get_input a Furnace in modo che si
possa estrarre l'input della Fornace.

2.3: Cambi a Map
----------------------------------------------------------
Aggiungete due metodi a Map:
- is_pickable dice se un elemento a certe coordinate e`
	pickable o meno
- gimme_pickable ritorna il Block a certe coordinate, 
	assumendo che quel block sia pickable

2.4: Testare il Picking
----------------------------------------------------------
Create i seguenti metodi dentro MainView metodi.
Ricordate che MainView funge da wrapper attorno a Map,
Furnace e Inventory. Dovreste poter usare i metodi 
aggiunti in precedenza a queste classi per realizzare i 
metodi qui sotto:
- move_into_furnace_from_inventory
	sposta un blocco SmeltableBlock dall'inventario alla 
	fornace
- move_into_inventory_from_furnace
	sposta il blocco di input della fornace nell'inventario
- pick_up_block
	sposta un blocco a certe coordinate dalla Map 
	all'inventario
- toggle_inventory_comparator: non fa nulla, per ora, lo
	riempirete dopo
- smelt: lo avete gia` modificato prima, non dovete 
	cambiarlo ulteriormente

Di sotto trovate il codice per testare il picking:
```
MainView m = new MainView();
m.display_on_out();
for (int i = 0 ; i < INTERACTIONS ; i++){
    System.out.println("Enter row and then column to pick that block");
    System.out.println("Enter '9' and the item number to move the item to the furnace");
    System.out.println("Enter '99' and then '9' to smelt");
    System.out.println("Enter '99' and then '0' to toggle the inventory sorting");
    System.out.println("Enter '99' and then any number to take from the furnace into the inventory");
    Scanner myObj = new Scanner(System.in);
    int row = myObj.nextInt();
    int col = myObj.nextInt();
    if (row == 9){
        m.move_into_furnace_from_inventory(col);
    }else if( row == 99 ){
        if (col == 9) {
            m.smelt();
        }else if (col == 0){
            m.toggle_inventory_comparator();
        }else {
            m.move_into_inventory_from_furnace();
        }
    } else{
        MapCoordinates c = new MapCoordinates(row,col);
        m.pick_up_block(c);
    }
    m.display_on_out();
}
```


3: Ordinare l'Inventario
----------------------------------------------------------
Create due modi per ordinare l'inventario tramite due
classi che implementano l'interfaccia Comparator<Block>.

3.1: Classi Comparator
----------------------------------------------------------
Create due classi che implementano Comparator<Block>.
La prima, AlphabeticalBlockComparator, compara i due 
blocchi in modo alfabetico, usando per esempio il 
risultato di toString().

La seconda, BlockComparator, compara i due blocchi in modo
assoluto. Per questo create un metodo che assegna ad ogni 
blocco un tipo valore numerico.

3.2: Ordinare
----------------------------------------------------------
Create un metodo che ordina l'inventario e chiamatelo ogni
volta che viene aggiunto un elemento.

Aggiungete un campo all'inventario di tipo 
Comparator<Block> e inizializzatelo a un oggetto delle due
classi create in precedenza.

Create un metodo che cambia il Comparator usato: se quello
in uso e` un AlphabeticalBlockComparator, allora viene
cambiato in un BlockComparator, e vice-versa.

3.3: Testare
----------------------------------------------------------
Esponete questa funzionalita` dentro a MainView.

Suggerimento: potete cambiare il modo in cui l'inventario
viene stampato per avere una indicazione di quale 
Comparator sia in uso.

Testate il codice di picking (sopra) per verificare che
l'ordinamento funzioni.


4: Eccezioni
----------------------------------------------------------
Aggiungete le eccezioni per rendere il codice piu` snello
e facile da mantenere.

4.1: Una Nuova Eccezione
----------------------------------------------------------
Create una eccezione BlockErrorException.

Domanda: in quale package ha senso metterla?

4.2: Eccezioni per Smeltable 
----------------------------------------------------------
Cambiate i metodi is_smeltable di Map e Inventory da
public a private. 
Cambiate la firma dei metodi di Map e Inventory che sono
usati per restituire dei blocchi di tipo SmeltableBlock
in modo che dica throw BlockErrorException.

Nella MainView, dove probabilmente usavate i metodi che 
ora sono private, ora usate un try-catch per gestire le
eccezioni sollevate da questi metodi.

4.3: Eccezioni per Pickable
----------------------------------------------------------
Fate lo stesso lavoro per pickable: cambiate il metodo
is_pickable di Map da public a private e cambiate la 
firma di gimme_pickable in modo che dica throws 
BlockErrorException.
Cambiate la MainView in modo che gestisca l'eccezione.

Domanda: anche qui la MainView non deve a sua volta dire
	throw BlockErrorException. Perche`?


5: Estensioni
----------------------------------------------------------

5.1: Eccezioni per le Coordinate
----------------------------------------------------------
Se avete le Coordinates, sollevate una nuova eccezione
WrongCoordinatesException quando una operazione e` fatta
su Coordinate che sono fuori dalla Map.
Gestite questa eccezione nel main.

5.2: Gravita`
----------------------------------------------------------
Quando viene tolto un elemento, applicate la gravita` a 
tutti gli elementi sopra.

5.3: Nuovi Blocchi: Torce
----------------------------------------------------------
Aggiungete un blocco nuovo: TorchBlock, che e` un 
AbstractSolidBlock.

Nella gestione della gravita`, aggiungete la logica che 
quando un SandBlock si sposta su una TorchBlock, quest'
ultimo non si sposta e il SandBlock viene distrutto e 
rimpiazzato da un AirBlock

Domanda: come potete implementare questa funzionalita` in
	modo generico? Per esempio, se aggiungeste un altro
	blocco GravelBlock, anche quello si dovrebbe 
	distruggere se cadesse su un TorchBlock.
