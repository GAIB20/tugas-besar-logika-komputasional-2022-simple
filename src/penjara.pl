/* Fakta */

% jail(X,0) adalah pemain X tidak berada di penjara
% jail(X,1) adalah pemain X berada di penjara
% Jumlah denda yang dibayarkan untuk keluar dari penjara adalah 5000

% jail menyimpan keadaan pemain, apakah berada di penjara atau tidak
:- dynamic(jail/2).
initJail :- assertz(jail('P',0)), assertz(jail('Q',0)).

% turncount menyimpan jumlah turn pemain berada di penjara
:- dynamic(turncount/2).

/* Rules */

% toJail memasukkan pemain ke dalam penjara
toJail :- curPlayer(X), retract(jail(X,0)), assertz(jail(X,1)),
assertz(turncount(X,0)).

% outOfJail mengeluarkan pemain dari dalam penjara
outOfJail :- curPlayer(X), retract(jail(X,1)), assertz(jail(X,0)),
retract(turncount(X,_)).

% checkUse mengecek apakah pemain memiliki Get Out Of Jail Card
checkUse :- curPlayer(X), punyakartu(X,Y), Y =:= 4.

% useCard menggunakan Get Out of Jail Card pemain
useCard :- \+checkUse,
print('Anda tidak memiliki Get Out Of Jail Card.'), !.
useCard :- curPlayer(X), checkUse, retract(punyakartu(X,4)), outOfJail,
print('Get Out of Jail Card digunakan. Anda dapat keluar dari penjara.'), !.

% checkPay mengecek apakah pemain memiliki uang lebih banyak daripada denda
checkPay :- curPlayer(X), getmoneypemain(X,Y), Y >= 5000.

% payFine membayar denda untuk keluar dari penjara
payFine :- \+checkPay,
print('Anda tidak memiliki jumlah uang yang cukup untuk membayar denda'), !.
payFine :- curPlayer(X), checkPay, getmoneypemain(X,Y), Y1 is Y-5000, ubahMoney(Y1),
outOfJail, print('Membayar denda. Anda dapat keluar dari penjara.'), !.

% checkTurn mengecek jumlah Turn pemain berada di penjara
checkTurn :- curPlayer(X), turncount(X,Y), Y < 3.

% jailAct menampilkan aksi yang dapat dilakukan pemain
jailAct :- \+checkTurn, outOfJail,
print('Sudah 3 Turn di penjara. Anda dapat keluar dari penjara'), !.
jailAct :- curPlayer(X), checkTurn, turncount(X,Y),
print('Jumlah Turn Anda berada di dalam penjara: '), print(Y), print(' Turn'), nl,
print('Anda berada di penjara. Berikut aksi yang dapat dilakukan.'), nl,
print('1. useCard : menggunakan Get Out of Jail Card untuk keluar dari penjara'), nl,
print('2. payFine : membayar denda untuk keluar dari penjara.'), nl,
print('3. throwDice : melempar dadu dan menambah turncount.'), !.

% plusJailTurn menambah satu turncount
plusJailTurn :- curPlayer(X), retract(turncount(X,Y)), Y1 is Y+1,
assertz(turncount(X,Y1)).