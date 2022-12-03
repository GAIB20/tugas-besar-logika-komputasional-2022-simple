/* Fakta */

% jail(X,0) adalah pemain X tidak berada di penjara
% jail(X,1) adalah pemain X berada di penjara
% Jumlah denda yang dibayarkan untuk keluar dari penjara adalah 5000

% jail(X,Y) menyimpan keadaan pemain X, apakah berada di penjara atau tidak
:- dynamic(jail/2).
initJail :- assertz(jail('P',0)), assertz(jail('Q',0)).

% jailturn menyimpan jumlah turn pemain berada di penjara
:- dynamic(jailturn/2).

/* Rules */

% checkJail mengecek status pemain apakah berada di dalam penjara
checkJail :- curPlayer(X), jail(X,1), jailAct, !.
checkJail.

% toJail memasukkan pemain ke dalam penjara
toJail :- curPlayer(X), majuKeLokasi('JL'), print('\nAnda Masuk Penjara.\n'),
retract(jail(X,0)), assertz(jail(X,1)), assertz(jailturn(X,0)).

% outOfJail mengeluarkan pemain dari dalam penjara
outOfJail :- curPlayer(X), retract(jail(X,1)), assertz(jail(X,0)),
retract(jailturn(X,_)).

% checkUse mengecek apakah pemain memiliki Get Out Of Jail Card
checkUse :- curPlayer(X), punyakartu(X,Y), Y =:= 4.

% useCard menggunakan Get Out of Jail Card pemain
useCard :- \+checkUse,
print('\nAnda tidak memiliki Get Out Of Jail Card. Silakan pilih aksi lain.\n'), !.
useCard :- curPlayer(X), checkUse, retract(punyakartu(X,4)), outOfJail,
print('\nGet Out of Jail Card digunakan. Anda keluar dari penjara.\n'), !.

% checkPay mengecek apakah pemain memiliki uang lebih banyak daripada denda
checkPay :- curPlayer(X), getmoneypemain(X,Y), Y >= 5000.

% payFine membayar denda untuk keluar dari penjara
payFine :- \+checkPay,
print('\nAnda tidak memiliki jumlah uang yang cukup untuk membayar denda. Silakan pilih aksi lain.\n'), !.
payFine :- curPlayer(X), checkPay, getmoneypemain(X,Y), Y1 is Y-5000, ubahMoney(Y1),
outOfJail, print('\nAnda membayar denda (sebesar 5000) dan keluar dari penjara.\n'),  !.

% checkTurn mengecek jumlah Turn pemain berada di penjara
checkTurn :- curPlayer(X), jailturn(X,Y), Y < 3.

% jailAct menampilkan aksi yang dapat dilakukan pemain
jailAct :- \+checkTurn, outOfJail,
print('\nSudah 3 Turn di penjara. Anda keluar dari penjara.\n'), !.
jailAct :- curPlayer(X), checkTurn, jailturn(X,Y),
print('\nJumlah Turn pemain '), print(X), print(' berada di dalam penjara: '), print(Y), print(' Turn.\n'),
print('Berikut aksi yang dapat dilakukan.\n'),
print('1. useCard : menggunakan Get Out of Jail Card untuk keluar dari penjara.\n'),
print('2. payFine : membayar denda (sebesar 5000) untuk keluar dari penjara.\n'),
print('3. throwDice : melempar dadu dan menambah jailturn.\n'), !.

% plusJailTurn menambah satu jailturn
plusJailTurn :- curPlayer(X), retract(jailturn(X,Y)), Y1 is Y+1,
assertz(jailturn(X,Y1)).