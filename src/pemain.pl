:- dynamic(player/7).
:- dynamic(properti/1).


/*Fungsi-Fungsi yang akan digunakan*/
insert_last(X, [], [X]) :- !.
insert_last(X, [H|T1], [H|T2]):- insert_last(X,T1, T2).

head([H|_], H).



initPemain :- 
            write('1. Player 1.'),nl,
            write('2. Player 2.'),nl,
            write('Masukkan angka : '), read(X),nl,
            (X =:= 1 ->asserta(player('Player 1', 'GO',50,0,50,0,0));
            X =:= 2 ->asserta(player('Player 2', 'GO',50,0,50,0,0))).
infoPemain :- player(_info, _lokasi, _totaluang, _totalnilaiproperti,_totalaset,_properti,_daftarkartu),
                                    write('your status : '), write(_info), nl,
                                    write('lokasi : '), write(_lokasi), nl,
                                    write('total uang: '), write(_totaluang), nl,
                                    write('totalnilaiproperti: '), write(_totalnilaiproperti), nl,
                                    write('totalaset: '), write(_totalaset), nl,
                                    write('Properti yang dimiliki: '), write(_properti), nl,
                                    write('Daftar kartu yang dimiliki: '), write(_daftarkartu).

ubahnilaiproperti(X) :- retract(player(A,B,C,D,E,F,G)), Z is D+X,K is F+1, assertz(player(A,B,C,Z,E,K,G)).
beliProperti(X) :- retract(player(A,B,C,D,E,F,G)),Z is C-X,assertz(player(A,B,Z,D,E,F,G)),ubahnilaiproperti(X).



/*ubahLokasi('X') :- retract(player(A,B,C,D,E,F,G)),Z is 'X',assertz(player(A,Z,C,D,E,F,G)).*/
















































































































































