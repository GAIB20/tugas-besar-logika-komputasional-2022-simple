:- include(chancecard.pl).

/* Fakta */

% turncount1 menyimpan jumlah turn pemain1 ada di penjara
:- dynamic(turncount1/1).
$ turncount2 menyimpan jumlah turn pemain2 ada di penjara
:- dynamic(turncount2/1).

% fineamount(5000) adalah total uang denda yang harus dibayar jika pemain ingin keluar dair penjara
fineamount(5000).

% penjara1(0) adalah keadaan pemain1 tidak berada di dalam penjara
penjara1(0).
% penjara1(1) adalah keadaan pemain1 berada di dalam penjara
penjara1(1).
% penjara2(0) adalah keadaan pemain2 tidak berada di dalam penjara
penjara2(0)
% penjara2(1) adalah kondisi pemain2 berada di dalam penjara
penjara2(1).

/* Rules */

% checkpenjara(X) bernilai trua jika pemain berada di dalam penjara
checkpenjara1(X) :- penjara1(X), X =:= 1.
checkpenjara2(X) :- penjara2(X), X =:= 1.

% checkkartu(X) bernilai true jika pemain memiliki kartu get out of jail
checkkartu1(X) :- checkpenjara1(Y), Y =:= 1, retract(listcard1), card1(X), X =:= 4.
checkkartu2(X) :- checkpenjara2(Y), Y =:= 1, retract(listcard2), card2(X), X =:= 4.

% pakaikartu(X) bernilai true jika pemain memilih untuk menggunakan kartu get out of jail
pakaikartu1(X) :- checkkartu1(Y), removecard1(Y).
pakaikartu2(X) :- checkkartu2(Y), removecard2(Y).

% checkuang(X) bernilai true jika pemain memiliki uang lebih besar dari denda
checkuang1(x) :- checkpenjara1(Y), Y =:= 1, retract(uangpemain1), uangpemain1 > fineamount, asserta(uangpemain1), X=uangpemain1.
checkuang2(x) :- checkpenjara2(Y), Y =:= 1, retract(uangpemain2), uangpemain2 > fineamount, asserta(uangpemain2), X=uangpemain2.

% bayardenda(X) bernilai true jika pemain memilih untuk membayar denda
bayardenda1(X) :- checkuang1(Y), retract(uangpemain1), uangpemain1 is Y-fineamount, asserta(uangpemain1).
bayardenda2(X) :- checkuang2(Y), retract(uangpemain2), uangpemain1 is Y-fineamount, asserta(uangpemain2).


% checkdice(X) bernilai true jika hasil lemparan dadu double
checkdice1(X) :- checkpenjara1(Y), Y =:= 1, retract(dice1pemain1), retract(dice2pemain1), dice1pemain1 =:= 6, dice2pemain1 =:= 6,
assertz(dice1pemain1), assertz(dice2pemain1).
checkdice2(X) :- checkpenjara1(Y), Y =:= 1, retract(dice1pemain2), retract(dice2pemain2), dice1pemain2 =:= 6, dice2pemain2 =:= 6,
assertz(dice1pemain2), assertz(dice2pemain2).

% checckturn(X) bernilai true jika turn pemain berada di dalam penjara kurang dari 3
checkturn1(X) :- checkpenjara1(Y), Y =:= 1, retract(turncount1), turncount1=<3, assertz(turncount1).
checkturn2(X) :- checkpenjara1(Y), Y =:= 1, retract(turncount2), turncount2=<3, assertz(turncount2).

% turnplus(X) bernilai true jika pemain tidak memilih pakaikartu, bayardenda, tidak mendapat double, dan checkturn bernilai true
turnplus1(X) :- checkturn1(Y) , \+pakaikartu1(A), \+bayardenda1(B), \+ checkdice1(C),
retract(turncount1), turncount1 is turncount1+1, assertz(turncount1).
turnplus2(X) :- checkturn2(Y) , \+pakaikartu2(A), \+bayardenda2(B), \+ checkdice2(C),
retract(turncount2), turncount2 is turncount2+1, assertz(turncount2).

% keluarpenjara(X) bernilai true jika melakukan aksi pakaikartu, bayardenda, mendapat double, atau telah menunggu 3 kali giliran.
keluarpenjara1(X) :- pakaikartu1(Y), penjara1(Z), Z=0.
keluarpenjara1(X) :- bayardenda1(Y), penjara1(Z), Z=0.
keluarpenjara1(X) :- checkdice1(Y), penjara1(Z), Z=0.
keluarpenjara1(X) :- \+checkturn1(Y), penjara1(Z), Z=0.
keluarpenjara2(X) :- pakaikartu2(Y), penjara2(Z), Z=0.
keluarpenjara2(X) :- bayardenda2(Y), penjara2(Z), Z=0.
keluarpenjara2(X) :- checkdice2(Y), penjara2(Z), Z=0.
keluarpenjara2(X) :- \+checkturn2(Y), penjara2(Z), Z=0.