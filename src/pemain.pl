:- dynamic(player/5).
% pemain(Namapemain, Lokasi, Uang, Aset, Totalaset)
:- dynamic(curPlayer/1).
% nama pemain saat ini
:- dynamic(punyaLokasi/2).
% punyaLokasi(X,A) : player X punya lokasi A
:- dynamic(punyakartu/2).
% punyaKart()
:- dynamic(cnt/1).
:- dynamic(count/1).
:- dynamic(totalLangkah/1).




/*Fungsi init pemain adalah menginitkan semua nilai-nilai awal dan menset curPlayer  yang akan pertama kali bermain adalah pemain 1*/

initPemain :- 
            getPos('GO',1,IDXSTART),
            asserta(player('P', IDXSTART,5000,0,5000)), 
            asserta(player('Q', IDXSTART,5000,0,5000)),
            asserta(curPlayer('P')),assertz(count(0)),
            asserta(totalLangkah(0)).

/*Fungsi ganti pemain untuk mengganti pemain jika awalnya pemain 1 maka akan menjadi pemain 2 dan sebalikna */
gantiPemain :- retract(totalLangkah(_)), assertz(totalLangkah(0)), retract(count(_)),assertz(count(0)),curPlayer(P),retract(curPlayer(P)),((P = 'P'-> assertz(curPlayer('Q')));assertz(curPlayer('P'))), 
curPlayer(P1), write('\n### Giliran Pemain '), write(P1), write(' ###\n'), checkJail.
/*Untuk mengecek detail kepemilikan suatu pemain*/

checkPlayerDetail:- \+ startgame,!,fail, print("Belum menjalankan startGame!").
checkPlayerDetail:- curPlayer(P),player(P,_, Totaluang, Totalnilaiproperti,Totalaset),write('Informasi Player '), write('('),write(P),write(')'),nl,nl,
                                write('Lokasi                    :'), getlokasipemain(P, Lokasi), write(Lokasi),nl,
                                write('Total Uang                :'), write(Totaluang),nl,
                                write('Total Nilai Properti      :'), write(Totalnilaiproperti),nl,
                                write('Total Aset                :'), write(Totalaset),nl,nl,
                                printAllProperti,nl,nl,printAllCard.

/*Membeli properti pada sebuah lokasi A menjadi tingkat yang lebih tinggi, e.g : tanah -> b1 -> b2 -> b3 -> landmark, sebagai info player saat ini */
beliProperti(A) :- curPlayer(P),\+ punyaLokasi(P,A), assertz(punyaLokasi(P,A)), hargaAkuisisi(A,Harga), naikTingkatProperti(A),
                    retract(player(P,B,C,D,E)),L is C-Harga,H is D+Harga,assertz(player(P,B,L,H,E)),!.
beliProperti(A) :- curPlayer(P),punyaLokasi(P,A), hargaAkuisisi(A,Harga), naikTingkatProperti(A), 
                    retract(player(P,B,C,D,E)),L is C-Harga,H is D+Harga,assertz(player(P,B,L,H,E)).

/*Menjual sebuah lokasi A yang dimiliki player saat ini */
jualLokasi(A) :- curPlayer(P), punyaLokasi(P,A), hargaTotalLokasi(A,Harga), HargaJual is Harga*0.8,
                retract(player(P,B,C,D,_)),L is C+HargaJual,H is D-Harga,T is L+H,assertz(player(P,B,L,H,T)),
                retract(punyaLokasi(P,A)).
majuKeLokasi(X) :- curPlayer(P),retract(player(P,A,C,D,E)),assertz(player(P,X,C,D,E)), checkGo(A,X), checkBayarSewa, checkPajak, checkChanceCard, 
 checkWorldTour, checkMiniGame.
pindahLokasi(Lokasi,KeI) :- getPos(Lokasi,KeI,IDX), curPlayer(P),retract(player(P,_,C,D,E)),assertz(player(P,IDX,C,D,E)), checkBayarSewa, checkPajak, checkChanceCard, 
 checkWorldTour, checkMiniGame.
ubahMoney(X) :- curPlayer(P),retract(player(P,B,A,C,D)),T is X+C,assertz(player(P,B,X,C,T)).
checkGo(Old,New) :- getPos('GO',1,IDXGO), Old < IDXGO, New >= IDXGO, curPlayer(P), getmoneypemain(P,M),  NewM is M + 5000, ubahMoney(NewM),!.
checkGo(Old,New) :- getPos('GO',1,IDXGO), Old < IDXGO, New =< Old, curPlayer(P), getmoneypemain(P,M),  NewM is M + 5000, ubahMoney(NewM),!.
checkGo(Old,New) :- getPos('GO',1,IDXGO), Old > IDXGO, New > IDXGO, curPlayer(P), getmoneypemain(P,M),  NewM is M + 5000, ubahMoney(NewM),!.
checkGo(_,_).

/*Menambah kartu X info pemain dan Y nama kartu nya*/
addKartu(X,Y) :- assertz(punyakartu(X,Y)).

/*Print properti yang dimiliki*/
printAllProperti :- write('Daftar Kepemilikan Properti :'),nl,assertz(cnt(1)), curPlayer(P),
    forall((punyaLokasi(P,A)), 
        (  tingkatProp(A,T), namaProperti(T,NamaProp),
        cnt(Cnt), write(Cnt), write('.  '), write(' '), write(A), write(' '),write('-'),write(' '),write(NamaProp),nl,
        retract(cnt(Cnt)), Cnt1 is Cnt+1, assertz(cnt(Cnt1))
        )), retract(cnt(_)).
/*print kartu yang dimiliki*/
printAllCard :- write('Daftar Kepemilikan Card :'),nl,assertz(cntcard(1)), curPlayer(P),
    forall((punyakartu(P,B)), 
        (cntcard(Cntcar), write(Cntcar), write('. '), namakartu(B,Y), write(Y), nl,
        retract(cntcard(Cntcar)), Cntcard1 is Cntcar+1, assertz(cntcard(Cntcard1)))).

throwDice :- curPlayer(P),jail(P,0),nl,random(1,7,X),random(1,7,Y),write('dadu 1 : '),write(X),write('.'),nl,
write('dadu 2 : '),write(Y),write('.'),nl, Z is X+Y, write('Anda maju sejauh '), retract(totalLangkah(L)), L1 is L + Z, 
assertz(totalLangkah(L1)), write(Z), write(' langkah'),nl,
(Y =:= X -> (write('double '),nl, retract(count(A)), D is A+1, 
assertz(count(D)),getlokasipemainIDX(P,Now), nextLoc(Now,L1,Next), majuKeLokasi(Next),retract(totalLangkah(_)),assertz(totalLangkah(0)),
(D =:= 3 -> (write('Anda masuk penjara'), toJail, gantiPemain);write('')));(retract(count(_)),
assertz(count(0)),getlokasipemainIDX(P,Now),nextLoc(Now,L1,Next),majuKeLokasi(Next),gantiPemain)),!.

throwDice :- curPlayer(P), jail(P,1), random(1,7,X), random(1,7,Y), write('\ndadu 1 : '), write(X), write('.\n'),
write('dadu 2 : '), write(Y), write('.\n'), Z is X+Y,
(Y =:= X -> (Z is X+Y, write('Double! Anda keluar penjara dan maju sejauh '), write(Z), write(' langkah.\n'), retract(totalLangkah(L)), L1 is L + Z, assertz(totalLangkah(L1)), totalLangkah(Total), getlokasipemainIDX(P,Now), nextLoc(Now,Total,Next), majuKeLokasi(Next), outOfJail, gantiPemain); 
write('Anda tetap berada di dalam penjara. Jail Turn bertambah satu.\n'), plusJailTurn, gantiPemain), !.

getmoneypemain(P,X) :- player(P,_,X,_,_).  
getasetpemain(P,X) :- player(P,_,_,_,X).
getpropertipemain(P,X) :- player(P,_,_,X,_).
getlokasipemain(P,X) :- player(P,IDX,_,_,_), getLoc(IDX,X).
getlokasipemainIDX(P,IDX) :- player(P,IDX,_,_,_).