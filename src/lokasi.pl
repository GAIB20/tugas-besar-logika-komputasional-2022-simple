% include properti.pl
:- dynamic(milik/2).
:- dynamic(tingkatProp/2).

/* list kota */
kota('A1').
kota('A2').
kota('A3').
kota('B1').
kota('B2').
kota('B3').
kota('C1').
kota('C2').
kota('C3').
kota('D1').
kota('D2').
kota('D3').
kota('E1').
kota('E2').
kota('E3').
kota('F1').
kota('F2').
kota('F3').
kota('G1').
kota('G2').
kota('G3').
kota('H1').
kota('H2').

/*Nama Lokasi*/
nama('A1','Jakarta').
nama('A2','Kuala Lumpur').
nama('A3','Singapura').
nama('B1','Phnom Penh').
nama('B2','Manila').
nama('B3','Bangkok').
nama('C1','Dili').
nama('C2','Vientiane').
nama('C3','Hanoi').
nama('D1','Beijing').
nama('D2','Hongkong').
nama('D3','Macau').
nama('E1','Taipei').
nama('E2','Tokyo').
nama('E3','Seoul').
nama('F1','Pyongyang').
nama('F2','Dhaka').
nama('F3','New Delhi').
nama('G1','Kathmandu').
nama('G2','Islamabad').
nama('G3','Riyadh').
nama('H1','Kuwait').
nama('H2','Doha').
nama('CC','Change Card').
nama('JL','Jail').
nama('TX','Kantor Pajak').
nama('FP','Free Parking').
nama('WT','World Tour').


/*Deskripsi*/
deskripsi('A1','Ibukota Indonesia').
deskripsi('A2','Ibukota Malaysia').
deskripsi('A3','Ibukota Singapura').
deskripsi('B1','Ibukota Kamboja').
deskripsi('B2','Ibukota Filipina').
deskripsi('B3','Ibukota Thailand').
deskripsi('C1','Ibukota Timor Leste').
deskripsi('C2','Ibukota Laos').
deskripsi('C3','Ibukota Vietnam').
deskripsi('D1','Ibukota China').
deskripsi('D2','Ibukota Hongkong').
deskripsi('D3','Ibukota Makau').
deskripsi('E1','Ibukota Taiwan').
deskripsi('E2','Ibukota Jepang').
deskripsi('E3','Ibukota Korea Selatan').
deskripsi('F1','Ibukota Korea Utara').
deskripsi('F2','Ibukota Bangladesh').
deskripsi('F3','Ibukota India').
deskripsi('G1','Ibukota Nepal').
deskripsi('G2','Ibukota Pakistan').
deskripsi('G3','Ibukota Arab Saudi').
deskripsi('H1','Ibukota Kuwait').
deskripsi('H2','Ibukota Qatar').
deskripsi('CC','Ujilah keberuntungan anda ditempat ini!\nAnda berhak untuk mendapatkan salah satu dari kartu berikut:\n').
deskripsi('JL','Tempat para orang ilegal berdiam diri.\nAnda akan dipindahkan ke sini apabila anda mendapatkan kartu masuk penjara atau mendapatkan double 3 kali berturut-turut!').
deskripsi('TX','Anda harus membayar pajak apabila anda berhenti disini!').
deskripsi('FP','Parkir bebas, pemain tidak mendapatkan efek apa-apa ketika berhenti di lokasi ini!').
deskripsi('WT','Anda dapat berpindah ke mana saja! Tentunya dengan membayar uang sebesar X% dari aset Anda.').


nextTingkat(0,1).
nextTingkat(1,2).
nextTingkat(2,3).
nextTingkat(3,'L').
naikTingkatProperti(A) :- \+ tingkatProp(A,_), assertz(tingkatProp(A,0)).
naikTingkatProperti(A) :- retract(tingkatProp(A,B)), nextTingkat(B,B1), assertz(tingkatProp(A,B1)).
namaProperti(0,'Tanah').
namaProperti(1,'Bangunan 1').
namaProperti(2,'Bangunan 2').
namaProperti(3,'Bangunan 3').
namaProperti('L','Landmark').

checkLocationDetail(Lokasi) :- nama(Lokasi,Nama), deskripsi(Lokasi,Desc),
                                print('Nama Lokasi      : '), print(Nama), nl,
                                print('Deskripsi Lokasi : '), print(Desc), nl,
                                printInfoLokasiTambahan(Lokasi),!.
checkLocationDetail(Lokasi) :- print(Lokasi), print(' bukan merupakan lokasi yang valid! Silahkan masukkan lokasi yang tepat.').

printInfoLokasiTambahan(Lokasi) :- kota(Lokasi), nl,
                                    print('Kepemilikan         : '), (milik(Lokasi,P) -> print(P);print('-')), nl,
                                    print('Biaya Sewa Saat Ini : '), (milik(Lokasi,P) -> print('duid');print('-')), nl,
                                    print('Biaya Akuisisi      : '), (tingkatProp(Lokasi,Prop) -> (nextTingkat(Prop,Prop1) -> beli(Lokasi,Prop1,Harga), print(Harga); print('-')); beli(Lokasi,0,Harga),print(Harga) ), nl,
                                    print('Tingkatan Properti  : ' ),(tingkatProp(Lokasi,Prop) -> namaProperti(Prop,Nama), print(Nama);print('-')),!.
printInfoLokasiTambahan(Lokasi) :- \+ kota(Lokasi).