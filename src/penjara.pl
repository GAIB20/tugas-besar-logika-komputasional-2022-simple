/* Fakta */

% currentplayer menyimpan pemain saat ini
:- dynamic(currentplayer/1).
addPlayer1 :- asserta(currentplayer(1)).
removePlayer1 :- retract(currentplayer(1)).
addPlayer2 :- asserta(currentplayer(2)).
removePlayer2 :- retract(currentplayer(2)).

% jailstatus(0) adalah keadaan pemain tidak berada di penjara
jailstatus(0).
% jailstatus(1) adalah keadaan pemain berada di penjara
jailstatus(1).

% jail menyimpan keadaan pemain, apakah berada di penjara atau tidak
:- dynamic(jail/2).
initJail :- currentplayer(X), asserta(jail(X,0)).

% turncount menyimpan jumlah turn pemain berada di penjara
:- dynamic(turncount/2).

% fineamount(5000) adalah total uang denda yang harus dibayar jika pemain ingin keluar dair penjara
fineamount(5000).

/* Rules */

% checkJail mengecek keadaan pemain saat ini
checkJail(X) :- X =:= 0, print('Anda tidak berada di penjara.').
checkJail(X) :- X =:= 1, print('Anda berada di penjara.').

% inJail memasukkan pemain ke dalam penjara
inJail :- currentplayer(X), retract(jail(X,0)), assertz(jail(X,1)),
assertz(turncount(X,0)).

% outJail mengeluarkan pemain dari dalam penjara
outJail :- currentplayer(X), retract(jail(X,1)), assertz(jail(X,0)),
retract(turncount(X,Z)).

% printJail menampilkan keadaan pemain saat ini
printJail :- currentplayer(X), jail(X,Y), checkJail(Y), !.

% checkUse mengecek apakah pemain memiliki Get Out of Jail Card
checkUse :- currentplayer(X), cardlist(X,Y), Y =:= 4,
print('Anda memiliki Get Out of Jail Card.'), nl.

% useCard menggunakan Get Out of Jail Card pemain
useCard :- \+checkUse,
print('Anda tidak memiliki Get Out of Jail Card'), !.
useCard :- currentplayer(X), checkUse, retract(cardlist(X,Y)), outJail,
print('Get Out of Jail Card digunakan. Anda dapat keluar dari penjara.'), !.

% checkPay mengecek apakah pemain memiliki uang lebih banyak daripada denda
checkPay :- currentplayer(X), moneyamount(X,Y), Y >= 5000,
print('Anda memiliki jumlah uang yang cukup untuk membayar denda'), nl.

% payFine membayar denda untuk keluar dari penjara
payFine :- \+checkPay,
print('Anda tidak memiliki jumlah uang yang cukup untuk membayar denda'), !.
payFine :- currentplayer(X), checkPay, retract(moneyamount(X,Y)),
Z is Y-5000, assert(moneyamount(X,Z)), outJail,
print('Membayar denda. Anda dapat keluar dari penjara.'), !.

% checkTurn mengecek jumlah Turn pemain berada di penjara
checkTurn :- currentplayer(X), turncount(X,Y), Y =< 3.

% jailAct menampilkan aksi yang dapat dilakukan pemain
jailAct :- \+checkTurn, outJail,
print('Sudah 3 Turn di penjara, Anda dapat keluar dari penjara'), !.
jailAct :- currentplayer(X), jail(X,1), checkTurn, turncount(X,Y),
print('Jumlah Turn Anda berada di dalam penjara: '), print(Y), nl,
print('Anda berada di penjara. Berikut aksi yang dapat dilakukan.'), nl,
print('1. useCard : menggunakan Get Out of Jail Card untuk keluar dari penjara'), nl,
print('2. payFine : membayar denda untuk keluar dari penjara.'), nl,
print('3. throwDice : melempar dadu dan menambah turncount.'), !.

% plusJailturn menambah satu pada turncount
plusJailTurn :- currentplayer(X), retract(turncount(X,Y)), Z is Y+1,
assert(turncount(X,Z)).