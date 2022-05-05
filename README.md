# progettoProlog
Progetto Prolog per IA Lab 2022

## Run

Caricare il puzzle dell'8 o del 15, con l'euristica voluta.

8 (Euristica Misplaced Tiles):
```
['ricerca.pl'].
```
8 (Euristica Manhattan):
```
['ricerca_manhattan.pl'].
```

Utilizzare il codice:
```
statistics(cputime, TStart), prova(L), write(L), statistics(cputime, TEnd), T is TEnd-TStart.
```
