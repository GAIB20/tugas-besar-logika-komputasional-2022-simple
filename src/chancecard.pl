/* Fakta */

% CC(1), Tax Card, pemain dipindahkan ke petak pajak.
% CC(2), Gift Card, pemain mendapatkan hadiah uang sejumlah 10000.
% CC(3), Go To Jail Card, pemain dipindahkan ke petak penjara.
% CC(4), Get Out Of Jail Card, pemain dapat keluar dari petak penjara jika menggunakan kartu ini.
% CC(5), Angel Card, pemain dapat menggunakan angel card untuk melindungi dari bayar sewa atau properti dibeli.

namakartu(1,'Tax Card').
namakartu(2,'Gift Card').
namakartu(3,'Go To Jail Card').
namakartu(4,'Get Out Of Jail Card').
namakartu(5,'Angel Card').

/* Rules */

% checkRoll(X,Y) menentukan angka kartu berdasarkan angka random
checkRoll(X,Y) :- X > 0, X =< 20, Y = 1, print('Anda mendapat Tax Card. Anda dipinidahkan ke petak pajak.').
checkRoll(X,Y) :- X > 20, X =< 45, Y = 2, print('Anda mendapat Gift Card. Anda mendapat hadiah uang sejumlah 10000.').
checkRoll(X,Y) :- X > 45, X =< 65, Y = 3, print('Anda mendapat Go To Jail Card. Anda dipindahkan ke petak penjara.').
checkRoll(X,Y) :- X > 65, X =< 90, Y = 4, print('Anda mendapat Get Out Of Jail Card. Simpan kartu untuk digunakan.').
checkRoll(X,Y) :- X > 90, X =< 100, Y = 5, print('Anda mendapat Angel Card. Simpan kartu untuk digunakan.').

% checkCard(X) menentukan aksi berdasarkan angka kartu
% checkCard(X) :- X =:= 1, pindah ke petak pajak.
% checkCard(X) :- X =:= 2, tambah uang 10000.
% checkCard(X) :- X =:= 3, pindah ke petak penjara.
checkCard(X) :- curPlayer(Y), X =:= 4, assertz(punyakartu(Y,4)).
checkCard(X) :- curPlayer(Y), X =:= 5, assertz(punyakartu(Y,5)).

% rollCard memanggil fungsi random, checkRoll, dan checkCard
rollCard :- random(1, 100, X), checkRoll(X,Y), checkCard(Y), !.