/* Fakta */

% cardlist menyimpan kartu yang disimpan pemain
:- dynamic(cardlist/2).

% currentplayer menyimpan pemain saat ini
:- dynamic(currentplayer/1).
addPlayer1 :- asserta(currentplayer(1)).
removePlayer1 :- retract(currentplayer(1)).
addPlayer2 :- asserta(currentplayer(2)).
removePlayer2 :- retract(currentplayer(2)).

% chancecard(1) adalah Tax Card. Pemain dipindahkan ke petak pajak.
chancecard(1).
% chancecard(2) adalah Gift Card. Pemain mendapatkan hadiah berupa uang dengan jumlah tertentu.
chancecard(2).
% chancecard(3) adalah Get In Jail Card. Pemain dipindahkan ke petak penjara.
chancecard(3).
% chancecard(4) adalah Get Out of Jail Card. Pemain dapat keluar ari petak penjara jika menggunakan kartu ini.
chancecard(4).
% chancecard(5) adalah Angel Card. Pemain dapat menggunakan angel card untuk melindungi dari bayar sewa atau properti dibeli.

% giftamount(10000) adalah total hadiah uang yang akan didapat oleh pemain jika mendapat kartu gift card
giftamount(10000).

/* Rules */

% checkRoll(X,Y), X adalah angka random, Y adalah angka kartu
% checkRoll(X,Y) menentukan angka kartu berdasarkan angka random
checkRoll(X,Y) :- X>0, X=<20, Y=1, print('Anda mendapat Tax Card. Anda dipinidahkan ke petak pajak.').
checkRoll(X,Y) :- X>20, X=<45, Y=2, print('Anda mendapat Gift Card. Anda mendapat uang sebesar 10000').
checkRoll(X,Y) :- X>45, X=<65, Y=3, print('Anda mendapat Get in Jail Card. Anda dipindahkan ke petak penjara.').
checkRoll(X,Y) :- X>65, X=<90, Y=4, print('Anda mendapat Get Out of Jail Card. Simpan kartu untuk digunakan').
checkRoll(X,Y) :- X>90, X=<100, Y=5, print('Anda mendapat Angel Card. Simpan kartu untuk digunakan').

% checkCard(X), X adalah angka kartu
% checkCard(X) menentukan aksi berdasarkan angka kartu
% checkCard(X) :- X =:= 1, pindah ke petak pajak.
% checkCard(X) :- X =:= 2, tambah uang 10000.
% checkCard(X) :- X =:= 3, pindah ke petak penjara.
checkCard(X) :- currentplayer(Y), X =:= 4, assertz(cardlist(Y,4)).
checkCard(X) :- currentplayer(Y), X =:= 5, assertz(cardlist(Y,5)).

% rollCard memanggil fungsi random, checkRoll, dan checkCard
rollCard :- random(1, 100, X), checkRoll(X,Y), checkCard(Y), !.

% checkPrint(X), X adalah angka kartu
% checkPrint(X) menampilkan keterangan kartu berdasarkan angka kartu
checkPrint(X) :- X =:= 4, print('Get Out of Jail Card').
checkPrint(X) :- X =:= 5, print('Angel Card').

% printCard menampilkan semua kartu yang dimiliki pemain
printCard :- currentplayer(X), forall((cardlist(X,Y)), (checkprint(Y), nl)).