:- dynamic(player/7).
:- dynamic(curPlayer/1).
:- dynamic(addProperti/3).
:- dynamic(addKartu/2).
:- dynamic(cnt/1).
:- dynamic(cntcard/1).





/*Fungsi-Fungsi yang akan digunakan*/ 

initPemain :- 
            asserta(player('Player 1', 'GO',50,0,50,0,0)), 
            asserta(player('Player 2', 'GO',50,0,50,0,0)),
            asserta(curPlayer('Player 1')).

gantiPemain :- retract(count(_)),curPlayer(P),retract(curPlayer(P)),((P = 'Player 1'-> assertz(curPlayer('Player 2')));assertz(curPlayer('Player 1'))),assertz(count(0)).
infoPemain :- curPlayer(P),player(P, Lokasi, Totaluang, Totalnilaiproperti,Totalaset,Properti,Daftarkartu),
                                    write('your status : '), write(P), nl,
                                    write('lokasi : '), write(Lokasi), nl,
                                    write('total uang: '), write(Totaluang), nl,
                                    write('totalnilaiproperti: '), write(Totalnilaiproperti), nl,
                                    write('totalaset: '), write(Totalaset), nl,
                                    write('Properti yang dimiliki: '), write(Properti), nl,
                                    write('Daftar kartu yang dimiliki: '), write(Daftarkartu),nl.

ubahnilaiproperti(X) :- curPlayer(P), retract(player(P,B,C,D,E,F,G)), Z is D+X,K is F+1, assertz(player(P,B,C,Z,E,K,G)).
beliProperti(X) :- curPlayer(P),retract(player(P,B,C,D,E,F,G)),Z is C-X,assertz(player(P,B,Z,D,E,F,G)),ubahnilaiproperti(X).
ubahLokasi(X) :- curPlayer(P),retract(player(P,_,C,D,E,F,G)),assertz(player(P,X,C,D,E,F,G)).


/*Untuk properti*/

addProperti(X,Y,Z) :- assertz(punyaproperti(X,Y,Z)).

printAll :- assertz(cnt(1)), 
    forall((addProperti(X,Y,Z)), 
        (cnt(Cnt), print(Cnt), print('. '), print(' '), print(Y), print(' '),print(Z),nl,
        retract(cnt(Cnt)), Cnt1 is Cnt+1, assertz(cnt(Cnt1)))).

addKartu(X,Y) :- assertz(cntcard(1)),
    forall((addKartu(X,Y)), 
        (cntcard(Cnt), print(Cnt), print('. '), print(' '), print(Y),nl,
        retract(cntcard(Cnt)), Cnt1 is cntcard+1, assertz(cntcard(Cnt1)))).


