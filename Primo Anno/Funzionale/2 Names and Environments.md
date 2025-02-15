---
date: 2024/06/06
tags: 
Materia: "[[Programmazione funzionale]]"
---
## 2 Names and Environments
#### Operations in an environment
- **naming** local declaration in a block or connection of formal and actual parameter
- **referencing** reference to a denoted object via its name
- **Deactivation** Quando in un blocco ha una dichiarazione che maschera una dichiarazione esterna, quest'ultima viene disattivata
- **Reactivation** quando esci dal blocco che maschera un'associazione questa viene riattivata
- **Unnaming** quando esci dal blocco con una dichiarazione locale questa viene distrutta

#### Static Scoping
- Il significato di una variabile si può dedurre senza eseguire il programma 
- Quando non si trova la variabile si risale ad essa andando via via nel blocco genitore fino ad arrivare al blocco globale

#### Dynamic Scoping
- Per dare un significato alla variabile si risale lo stack delle chiamate
- E' quindi meno comprensibile più difficile da implementare e meno efficente

