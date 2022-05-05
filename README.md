# progettoProlog
Progetto Prolog per IA Lab 2022

## Prolog

Caricare il puzzle dell'8 con l'euristica voluta.

8 (Euristica Misplaced Tiles):
```
['puzzle15/ricerca.pl'].
```
8 (Euristica Manhattan):
```
['puzzle15/ricerca_manhattan.pl'].
```

Utilizzare il codice per eseguirlo e vedere la tempistica:
```
statistics(cputime, TStart), prova(L), write(L), statistics(cputime, TEnd), T is TEnd-TStart.
```
