applicabile(destra,State):-
    nth0(X, State, 0),
    X \= 3,
    X \= 7,
    X \= 11,
    X \= 15.

applicabile(sinistra,State):-
    nth0(X, State, 0),
    X \= 0,
    X \= 4,
    X \= 8,
    X \= 12.

applicabile(sopra,State):-
    nth0(X, State, 0),
    X > 3.

applicabile(sotto,State):-
    nth0(X, State, 0),
    X < 12.

trasforma(destra, State, NuovoStato) :-
    nth0(X, State, 0),
    PosSuc is X+1,
    nth0(PosSuc, State, Elem),
    nth0(X, Result, Elem, State),
    list_to_set(Result, NuovoStato).

trasforma(sinistra, State, NuovoStato) :-
    nth0(X, State, 0),
    PosPrec is X-1,
    nth0(PosPrec, Result, 0, State),
    list_to_set(Result, NuovoStato).

trasforma(sopra, State, NuovoStato) :-
    nth0(X, State, 0),
    PosPrec is X-4,
    nth0(PosPrec, Result, 0, State),
    list_to_set(Result, RisultatoPrimoCambio),
    PosPrec2 is PosPrec + 1,
    nth0(PosPrec2, RisultatoPrimoCambio, ElementoEliminato, RisultatoEliminazione),
    nth0(X, NuovoStato, ElementoEliminato, RisultatoEliminazione).

trasforma(sotto, State, NuovoStato) :-
    nth0(X, State, 0),
    PosPrec is X+4,
    nth0(PosPrec, Result, 0, State),
    nth0(X, Result, _, RisultatoEliminazione),
    nth0(PosPrec, RisultatoEliminazione, ElementoEliminato, RisultatoSecondaEliminazione),
    nth0(X, StatoFinale, ElementoEliminato, RisultatoSecondaEliminazione),
    list_to_set(StatoFinale, NuovoStato).