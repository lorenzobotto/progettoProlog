# progettoProlog
Progetto Prolog per il corso di Intelligenza Artificiale e Laboratorio - Unito 2022.

## Descrizione progetto

E' stato implementato un sistema intelligente in grado di risolvere il gioco
"Sliding Puzzle 8" utilizzando come strategia di ricerca nello spazio degli stati l'algoritmo A* (A Star),
utilizzando due euristiche:
- euristica delle caselle fuori posto: conta le caselle fuori posto dello stato considerato rispetto allo stato goal;
- euristica della distanza di Manhattan: calcola il numero di azioni necessarie per portare una casella nel posto corretto, per ogni casella, e infine somma tutti i valori.

Il file 'ricerca.pl' utilizza l'euristica delle caselle fuori posto, mentre il file 'ricerca_manhattan.pl' utilizza l'euristica della distanza di Manhattan.

Il sistema è composto da tre file:
- un file 'regole.pl' che contiene le definizioni dei predicati trasforma/3 e applicabile/2;
- un file 'dominio.pl' che contiene i fatti che descrivono il dominio, lo stato iniziale e i
goal;
- un file 'ricerca.pl' (o 'ricerca_manhattan.pl') che contiene l’implementazione della strategia di ricerca con un
predicato prova/1 il cui argomento corrisponde ad un termine di output con il
risultato, nel formato prova(+ListaAzioni). 

## Come eseguire

Installare SWI-Prolog da https://www.swi-prolog.org/. Una volta installato si può proseguire con le esecuzioni.

Aprire Prolog da linea di comando (se le variabili di sistema sono impostate) digitando:
```
swipl
```

Caricare il puzzle dell'8 con l'euristica voluta.

Sliding Puzzle 8 (Euristica caselle fuori posto):
```
['ricerca.pl'].
```
Sliding Puzzle 8 (Euristica distanza di Manhattan):
```
['ricerca_manhattan.pl'].
```

Utilizzare il codice seguente per eseguirlo e vedere la tempistica:
```
statistics(cputime, TStart), prova(L), statistics(cputime, TEnd), T is TEnd-TStart, write(L), length(L, NumeroAzioni).
```