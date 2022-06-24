:- load_files('dominio.pl').
:- load_files('regole.pl').

prova(ListaAzioni):-
    puzzle_iniziale(SIniziale),
    ricerca(SIniziale, 1, [], [], [], ListaAzioni).

ricerca(S,_,Visitati,_, _, ListaAzioni) :- 
    puzzle_finale(S),
    !,
    calcolaAzioni(S, Visitati, ListaAzioniInv),
    !,
    inverti(ListaAzioniInv, ListaAzioni).

ricerca(S, NumeroPassi, Visitati, ListaFrontiere, VisitatiPulito, ListaAzioni) :-
    controlloMosse(S, [destra, sinistra, sotto, sopra], ListaAzioniPossibili),
    !,
    calcolaCostiPassi(S, ListaAzioniPossibili, NumeroPassi, Visitati, ListaFrontierePrec, VisitatiPulito),
    !,
    append(ListaFrontierePrec, ListaFrontiere, NewListaFrontiere),
    calcolaMin(NewListaFrontiere, Min),
    !,
    nth0(1, Min, NuovoS),
    nth0(2, Min, PrecS),
    nth0(3, Min, NumeroPassiPrec),
    NumeroPassiIncr is NumeroPassiPrec+1,
    delete(NewListaFrontiere, Min, NewListaFrontiere2),
    ricerca(NuovoS, NumeroPassiIncr, [[NuovoS | [PrecS]] | Visitati], NewListaFrontiere2, [S | VisitatiPulito], ListaAzioni),
    !.

controlloMosse(_, [], _).

controlloMosse(S, [Head | Tail], ListaPossMosse) :-
    \+applicabile(Head, S),
    controlloMosse(S, Tail, ListaPossMosse).

controlloMosse(S, [Head | Tail], ListaPossMosse) :-
    controlloMosse(S, Tail, Res),
    append(Res, [Head], ListaPossMosse).

calcolaCostiPassi(_, [], _, _, _, _).

calcolaCostiPassi(S, [Head | Tail], NumeroPassi, Visitati, ListaFrontiere, VisitatiPulito) :-
    trasforma(Head,S,SNuovo),
    member(SNuovo, VisitatiPulito),
    calcolaCostiPassi(S, Tail, NumeroPassi, Visitati, ListaFrontiere, VisitatiPulito).

calcolaCostiPassi(S, [Head | Tail], NumeroPassi, Visitati, ListaFrontiere, VisitatiPulito) :-
    trasforma(Head,S,SNuovo),
    puzzle_finale(SFinale),
    contaDifferenze(SNuovo, SFinale, Ris),
    !,
    calcolaCostiPassi(S, Tail, NumeroPassi, Visitati, Res, VisitatiPulito),
    RisTotale is Ris+NumeroPassi,
    append([RisTotale], [SNuovo], DaInserire),
    append(DaInserire, [S | [NumeroPassi]], Vecchio),
    append([Vecchio], Res, ListaFrontiere).

contaDifferenze(S, SNuovo, Diff) :-
    contaDifferenze_(S, SNuovo, Diff, 0).

contaDifferenze_([], [], Diff, Diff).

contaDifferenze_([Head|Tail], [Head|Tail2], Diff, Acc) :-
    contaDifferenze_(Tail, Tail2, Diff, Acc).

contaDifferenze_([Head|Tail], [Head2|Tail2], Diff, Acc) :-
    Head =\= Head2,
    Diff1 is Acc + 1,
    contaDifferenze_(Tail, Tail2, Diff, Diff1).

calcolaMin([Min], Min).

calcolaMin([Head, Head2 | Tail], M) :-
    nth0(0, Head, Costo),
    nth0(0, Head2, Costo2),
    Costo =< Costo2,
    calcolaMin([Head | Tail], M).

calcolaMin([Head, Head2 | Tail], M) :-
    nth0(0, Head, Costo),
    nth0(0, Head2, Costo2),
    Costo > Costo2,
    calcolaMin([Head2 | Tail], M).

calcolaAzioni(S, Visitati, []) :-
    ricercaStatoVecchio(S, Visitati, SVecchio),
    SVecchio = 0.

calcolaAzioni(S, Visitati, [Mossa | ListaAzioni]) :-
    ricercaStatoVecchio(S, Visitati, SVecchio),
    calcolaMossa(S, SVecchio, Mossa),
    calcolaAzioni(SVecchio, Visitati, ListaAzioni).

calcolaMossa(S, SVecchio, sopra) :-
    nth0(Indice, S, 0),
    nth0(IndiceV, SVecchio, 0),
    Diff is IndiceV - Indice,
    Diff = 3.

calcolaMossa(S, SVecchio, sinistra) :-
    nth0(Indice, S, 0),
    nth0(IndiceV, SVecchio, 0),
    Diff is IndiceV - Indice,
    Diff = 1.

calcolaMossa(S, SVecchio, destra) :-
    nth0(Indice, S, 0),
    nth0(IndiceV, SVecchio, 0),
    Diff is IndiceV - Indice,
    Diff = -1.

calcolaMossa(S, SVecchio, sotto) :-
    nth0(Indice, S, 0),
    nth0(IndiceV, SVecchio, 0),
    Diff is IndiceV - Indice,
    Diff = -3.

ricercaStatoVecchio(S, _, 0) :-
    puzzle_iniziale(SIniziale),
    S = SIniziale.

ricercaStatoVecchio(S, [Head | Tail], SVecchio) :-
    nth0(0, Head, Stato),
    S \= Stato,
    ricercaStatoVecchio(S, Tail, SVecchio).

ricercaStatoVecchio(_, [Head | _], SVecchio) :-
    nth0(1, Head, SVecchio).

inverti([],[]).
inverti([Head|Tail],Res):-
    inverti(Tail,InvT),
    append(InvT,[Head],Res).