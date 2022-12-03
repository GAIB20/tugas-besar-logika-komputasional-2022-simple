/* Fakta */

% punyakartu(X,Y), pemain X memiliki kartu Y.
namakartu(1,'Tax Card').
namakartu(2,'Gift Card').
namakartu(3,'Go To Jail Card').
namakartu(4,'Get Out Of Jail Card').
namakartu(5,'Angel Card').

/* Rules */

% checkRoll(X,Y) menentukan angka kartu berdasarkan angka random yang didapat
checkRoll(X,Y) :- X > 0, X =< 20, Y = 1, print('Anda mendapat Tax Card. Anda dipinidahkan ke petak pajak.\n').
checkRoll(X,Y) :- X > 20, X =< 45, Y = 2, print('Anda mendapat Gift Card. Anda mendapat hadiah uang sejumlah 10000.\n').
checkRoll(X,Y) :- X > 45, X =< 65, Y = 3, print('Anda mendapat Go To Jail Card. Anda dipindahkan ke petak penjara.\n').
checkRoll(X,Y) :- X > 65, X =< 90, Y = 4, print('Anda mendapat Get Out Of Jail Card. Simpan kartu untuk digunakan.\n').
checkRoll(X,Y) :- X > 90, X =< 100, Y = 5, print('Anda mendapat Angel Card. Simpan kartu untuk digunakan.\n').

% checkCard(X) menentukan aksi berdasarkan angka kartu yang didapat
checkCard(X) :- X =:= 1, getPos('TX',2,IDX), majuKeLokasi(IDX).
checkCard(X) :- curPlayer(Y), X =:= 2, getmoneypemain(Y,Z), Z1 is Z+10000, ubahMoney(Z1).
checkCard(X) :- X =:= 3, toJail.
checkCard(X) :- curPlayer(Y), X =:= 4, addKartu(Y,X).
checkCard(X) :- curPlayer(Y), X =:= 5, addKartu(Y,X).

% rollCard memanggil fungsi random, checkRoll, checkCard
rollCard :- random(1, 101, X), checkRoll(X,Y), checkCard(Y), !.

% checkChanceCard mengecek apakah pemain berada di petak chance card
checkChanceCard :- curPlayer(P),getlokasipemain(P,Lokasi), Lokasi = 'CC', 
print('\nSelamat datang di Chance Card! Anda akan mengambil satu kartu secara acak. Berikut hasil kartu anda.\n'),
rollCard, !.
checkChanceCard.