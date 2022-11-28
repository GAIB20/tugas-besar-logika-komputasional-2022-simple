:- dynamic(player/5).
:- dynamic(curPlayer/1).
:- dynamic(punyaLokasi/2).
:- dynamic(punyakartu/2).
:- dynamic(cnt/1).
:- dynamic(count/1).





/*Fungsi init pemain adalah menginitkan semua nilai-nilai awal dan menset curPlayer  yang akan pertama kali bermain adalah pemain 1*/

initPemain :- 
            asserta(player('P', 'GO',5000,0,5000)), 
            asserta(player('Q', 'GO',5000,0,5000)),
            asserta(curPlayer('P')),assertz(count(0)).

/*Fungsi ganti pemain untuk mengganti pemain jika awalnya pemain 1 maka akan menjadi pemain 2 dan sebalikna */
gantiPemain :- retract(count(_)),assertz(count(0)),curPlayer(P),retract(curPlayer(P)),((P = 'P'-> assertz(curPlayer('Q')));assertz(curPlayer('P'))).
/*Untuk mengecek detail kepemilikan suatu pemain*/

checkPlayerDetail:- \+ startgame,!,fail, print("Belum menjalankan startGame!").
checkPlayerDetail:- curPlayer(P),player(P, Lokasi, Totaluang, Totalnilaiproperti,Totalaset),write('Informasi Player '), write('('),write(P),write(')'),nl,nl,
                                write('Lokasi                    :'), write(Lokasi),nl,
                                write('Total Uang                :'), write(Totaluang),nl,
                                write('Total Nilai Properti      :'), write(Totalnilaiproperti),nl,
                                write('Total Aset                :'), write(Totalaset),nl,nl,
                                printAllProperti,nl,nl,printAllCard.

/*Mengakuisisi sebuah lokasi A menjadi tingkat yang lebih tinggi, e.g : tanah -> b1 -> b2 -> b3 -> landmark, sebagai info player saat ini */
akuisisiLokasi(A) :- curPlayer(P),\+ punyaLokasi(P,A), assertz(punyaLokasi(P,A)), hargaAkuisisi(A,Harga), naikTingkatProperti(A),
                    retract(player(P,B,C,D,E)),L is C-Harga,H is D+Harga,assertz(player(P,B,L,H,E)),!.
akuisisiLokasi(A) :- curPlayer(P),punyaLokasi(P,A), hargaAkuisisi(A,Harga), naikTingkatProperti(A), 
                    retract(player(P,B,C,D,E)),L is C-Harga,H is D+Harga,assertz(player(P,B,L,H,E)).

/*Menjual sebuah lokasi A yang dimiliki player saat ini */
jualLokasi(A) :- curPlayer(P), punyaLokasi(P,A), hargaTotalLokasi(A,Harga), HargaJual is 8*Harga/10,
                retract(player(P,B,C,D,_)),L is C+HargaJual,H is D-Harga,T is L+H,assertz(player(P,B,L,H,T)),
                retract(punyaLokasi(P,A)).
ubahLokasi(X) :- curPlayer(P),retract(player(P,_,C,D,E)),assertz(player(P,X,C,D,E)).
ubahMoney(X) :- curPlayer(P),retract(player(P,B,_,C,D)),assertz(player(P,B,X,C,D)).

/*Menambah kartu X info pemain dan Y nama kartu nya*/
addKartu(X,Y) :- assertz(punyakartu(X,Y)).

/*Print properti yang dimiliki*/
printAllProperti :- write('Daftar Kepemilikan Properti :'),nl,assertz(cnt(1)), curPlayer(P),
    forall((punyaLokasi(P,A)), 
        ( nama(A,NamaKota), tingkatProp(A,T), namaProperti(T,NamaProp),
        cnt(Cnt), write(Cnt), write('.  '), write(' '), write(NamaKota), write(' '),write('-'),write(' '),write(NamaProp),nl,
        retract(cnt(Cnt)), Cnt1 is Cnt+1, assertz(cnt(Cnt1))
        )), retract(cnt(_)).
/*print kartu yang dimiliki*/
printAllCard :- write('Daftar Kepemilikan Card :'),nl,assertz(cntcard(1)), curPlayer(P),
    forall((punyakartu(P,B)), 
        (cntcard(Cntcar), write(Cntcar), write('. '), namakartu(X,Y), write(Y), nl,
        retract(cntcard(Cntcar)), Cntcard1 is Cntcar+1, assertz(cntcard(Cntcard1)))).

/*throw dice*/
throwDice :- curPlayer(P), write('Sekarang Giliran '),write(P),random(1,7,X), random(1,7,Y),nl,nl,write('dadu 1 : '),write(X),write('.'),nl,
write('dadu 2 : '),write(Y),write('.'),nl, Z is X+Y, write('Anda maju sejauh '), write(Z), write(' langkah'),nl,
(Y =:= X -> (write('double '),nl, retract(count(A)), D is A+1, assertz(count(D)),(D =:= 3 -> (write('Anda masuk penjara'), gantiPemain);throwDice));gantiPemain).

getmoneypemain(P,X) :- player(P,_,X,_,_).  
getasetpemain(P,X) :- player(P,_,_,_,X).
getpropertipemain(P,X) :- player(P,_,_,X,_).
getlokasipemain(P,X) :- player(P,X,_,_,_).