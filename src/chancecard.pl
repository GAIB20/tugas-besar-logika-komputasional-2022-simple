/* Fakta */

% card1 adalah kartu yang saat ini dibaca dari listcard1
:- dynamic(card1/1).
% card2 adalah kartu yang saat ini dibaca dari listcard2
:- dynamic(card2/1).

% chancecard(1) adalah tax card. Pemain dipindahkan ke petak pajak.
chancecard(1).
% chancecard(2) adalah gift card. Pemain mendapatkan hadiah berupa uang dengan jumlah tertentu.
chancecard(2).
% chancecard(3) adalah get in jail card. Pemain dipindahkan ke petak penjara.
chancecard(3).
% chancecard(4) adalah get out of out jail card. Pemain dapat keluar ari petak penjara jika menggunakan kartu ini.
chancecard(4).
% chancecard(5) adalah angel card. Pemain dapat menggunakan angel card untuk melindungi dari bayar sewa atau properti dibeli.

% giftamount(10000) adalah total hadiah uang yang akan didapat oleh pemain jika mendapat kartu gift card
giftamount(10000).

/* Rules */

% rollnumber(X) bernilai true dengan X adalah angka hasil fungsi random
rollnumber(X) :- random(1, 100, X).

% rollcard(X) bernilai true dengan X adalah 1, 2, 3, 4, atau 5 berdasarkan hasil rollnumber(Y)
rollcard(X) :- rollnumber(Y), Y>0, Y=<20, X=1.
rollcard(X) :- rollnumber(Y), Y>20, Y=<45, X=2.
rollcard(X) :- rollnumber(Y), Y>45, Y=<65, X=3.
rollcard(X) :- rollnumber(Y), Y>65, Y=<90, X=4.
rollcard(X) :- rollnumber(Y), Y>90, Y=<100, X=5.

% cardresult(X) bernilai true jika rollcard(Y), maka X adalah Y.
cardresult(X) :- rollcard(Y), Y =:= 1, X = Y.
cardresult(X) :- rollcard(Y), Y =:= 2, X = Y.
cardresult(X) :- rollcard(Y), Y =:= 3, X = Y.
cardresult(X) :- rollcard(Y), Y =:= 4, X = Y.
cardresult(X) :- rollcard(Y), Y =:= 5, X = Y.

% printcard(Y) menampilkan keterangan kartu apa yang didapat oleh pemain
printcard(Y) :- cardresult(Y), Y =:= 1,
write('Anda mendapat kartu tax card. Anda akan dipinidahkan ke petak pajak.').
printcard(Y) :- cardresult(Y), Y =:= 2,
write('Anda mendapat kartu gift card. Anda akan mendapatkan uang sebesar 10000.').
printcard(Y) :- cardresult(Y), Y =:= 3,
write('Anda mendapat kartu get in jail card. Anda akan dipindahkan ke petak penjara.').
printcard(Y) :- cardresult(Y), Y =:= 4,
write('Anda mendapat kartu get out of jail card. Simpan kartu ini agar bisa digunakan.').
printcard(Y) :- cardresult(Y), Y =:= 5,
write('Anda mendapat kartu angel card. Simpan kartu ini agar bisa digunakan.')

% addcard(X) menambahkan kartu X ke dalam listcard
addcard1(X) :- printcard(Y), card1(Y), assertz(listcard1(Y)).
addcard2(X) :- printcard(Y), card2(Y), assertz(listcard2(Y)).

% removecard(X) mengambil kartu X dari dalam listcard
removecard1(X) :- card1(X), retract(listcard1(X)).
removecard2(X) :- card2(X), retract(listcard2(X)).