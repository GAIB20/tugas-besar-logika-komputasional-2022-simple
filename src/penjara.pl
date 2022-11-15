/* Rencana Fakta */
:- dynamic (turncount/1).
fineamount(5000).

/* Rencana Rules */
bayardenda(X) :- pemain(X), uang(Y), fineamount(Z), Y > Z.
pakaikartu(X) :- pemain(X), cardlist(Y), chancecard(Z), Z =:= outjailcard.
keluarpenjara(X) :- bayardenda(A); pakaikartu(B);
turncount(C), A =:= 3; double(D).