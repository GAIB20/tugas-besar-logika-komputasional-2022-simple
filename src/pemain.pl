:- dynamic(player/7).
:- dynamic(curPlayer/1).
:- dynamic(punyaproperti/3).
:- dynamic(punyakartu/2).
:- dynamic(cnt/1).
:- dynamic(cntcard/1).
:- dynamic(dadu1/1).
:- dynamic(dadu2/1).
:- dynamic(count/1).


/*Fungsi init pemain adalah menginitkan semua nilai-nilai awal dan menset curPlayer  yang akan pertama kali bermain adalah pemain 1*/

initPemain :- 
            asserta(player('Player 1', 'GO',50,0,50)), 
            asserta(player('Player 2', 'GO',50,0,50)),
            asserta(curPlayer('Player 1')),assertz(count(0)).

/*Fungsi ganti pemain untuk mengganti pemain jika awalnya pemain 1 maka akan menjadi pemain 2 dan sebalikna */
gantiPemain :- retract(count(_)),assertz(count(0)),curPlayer(P),retract(curPlayer(P)),((P = 'Player 1'-> assertz(curPlayer('Player 2')));assertz(curPlayer('Player 1'))).
/*Untuk mengecek detail kepemilikan suatu pemain*/
checkPlayerDetail:- curPlayer(P),player(P, Lokasi, Totaluang, Totalnilaiproperti,Totalaset),write('Informasi Player '), write('('),write(P),write(')'),nl,nl,
                                write('Lokasi                    :'), write(Lokasi),nl,
                                write('Total Uang                :'), write(Totaluang),nl,
                                write('Total Nilai Properti      :'), write(Totalnilaiproperti),nl,
                                write('Total Aset                :'), write(Totalaset),nl,nl,
                                printAllProperti,nl,nl,printAllCard.

/*Membeli sebuah properti X sebagai info player 1 atau 2 eg. 'Player 1' kemudian Y adalah Properti yang akan dibeli Z adalah jenis properti dan K harga properti*/
beliProperti(X,Y,Z,K) :- curPlayer(P),retract(player(P,B,C,D,E)),L is C-K,H is D+K,addProperti(X,Y,Z),T is L+H,assertz(player(P,B,L,H,T)).
ubahLokasi(X) :- curPlayer(P),retract(player(P,B,C,D,E)),assertz(player(P,X,C,D,E)).

/*Fungsi untuk menambah properti X : info player 1 atau 2 'Player 1', Y adalah nama properti dan Z jenis properti kayak 'Bangunan'*/
addProperti(X,Y,Z) :- assertz(punyaproperti(X,Y,Z)).
/*Menambah kartu X info pemain dan Y nama kartu nya*/
addKartu(X,Y) :- assertz(punyakartu(X,Y)).

/*Print properti yang dimiliki*/
printAllProperti :- write('Daftar Kepemilikan Properti :'),nl,assertz(cnt(1)), 
    forall((punyaproperti(X,Y,Z)), 
        (cnt(Cnt), write(Cnt), write('. '), write(' '), write(Y), write(' '),write('-'),write(' '),write(Z),nl,
        retract(cnt(Cnt)), Cnt1 is Cnt+1, assertz(cnt(Cnt1)))).
/*print kartu yang dimiliki*/
printAllCard :- write('Daftar Kepemilikan Card :'),nl,assertz(cntcard(1)),
    forall((punyakartu(X,Y)), 
        (cntcard(Cnt), print(Cnt), print('. '), print(' '), print(Y),nl,
        retract(cntcard(Cnt)), Cnt1 is cntcard+1, assertz(cntcard(Cnt1)))).

/*throw dice*/
throwDice :- curPlayer(P), write('Sekarang Giliran '),write(P),random(1,7,X), random(1,7,Y),nl,nl,write('dadu 1 : '),write(X),write('.'),nl,
write('dadu 2 : '),write(Y),write('.'),nl, Z is X+Y, write('Anda maju sejauh '), write(Z), write(' langkah'),nl,
(Y =:= X -> (write('double '),nl, retract(count(A)), D is A+1, assertz(count(D)),(D =:= 3 -> (write('Anda masuk penjara'), gantiPemain);throwDice));gantiPemain).