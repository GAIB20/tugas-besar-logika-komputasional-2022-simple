% include properti.pl
:- dynamic(milik/2).
:- dynamic(tingkatProp/2).

/* list kota */
kota(a1).
kota(a2).
kota(a3).
kota(b1).
kota(b2).
kota(b3).
kota(c1).
kota(c2).
kota(c3).
kota(d1).
kota(d2).
kota(d3).
kota(e1).
kota(e2).
kota(e3).
kota(f1).
kota(f2).
kota(f3).
kota(g1).
kota(g2).
kota(g3).
kota(h1).
kota(h2).

/*Nama Lokasi*/
nama(a1,'Jakarta').
nama(a2,'Kuala Lumpur').
nama(a3,'Singapura').
nama(b1,'Phnom Penh').
nama(b2,'Manila').
nama(b3,'Bangkok').
nama(c1,'Dili').
nama(c2,'Vientiane').
nama(c3,'Hanoi').
nama(d1,'Beijing').
nama(d2,'Hongkong').
nama(d3,'Macau').
nama(e1,'Taipei').
nama(e2,'Tokyo').
nama(e3,'Seoul').
nama(f1,'Pyongyang').
nama(f2,'Dhaka').
nama(f3,'New Delhi').
nama(g1,'Kathmandu').
nama(g2,'Islamabad').
nama(g3,'Riyadh').
nama(h1,'Kuwait').
nama(h2,'Doha').
nama(cc,'Change Card').
nama(jl,'Jail').
nama(tx,'Kantor Pajak').
nama(fp,'Free Parking').
nama(wt,'World Tour').


/*Deskripsi*/
deskripsi(a1,'Ibukota Indonesia').
deskripsi(a2,'Ibukota Malaysia').
deskripsi(a3,'Ibukota Singapura').
deskripsi(b1,'Ibukota Kamboja').
deskripsi(b2,'Ibukota Filipina').
deskripsi(b3,'Ibukota Thailand').
deskripsi(c1,'Ibukota Timor Leste').
deskripsi(c2,'Ibukota Laos').
deskripsi(c3,'Ibukota Vietnam').
deskripsi(d1,'Ibukota China').
deskripsi(d2,'Ibukota Hongkong').
deskripsi(d3,'Ibukota Makau').
deskripsi(e1,'Ibukota Taiwan').
deskripsi(e2,'Ibukota Jepang').
deskripsi(e3,'Ibukota Korea Selatan').
deskripsi(f1,'Ibukota Korea Utara').
deskripsi(f2,'Ibukota Bangladesh').
deskripsi(f3,'Ibukota India').
deskripsi(g1,'Ibukota Nepal').
deskripsi(g2,'Ibukota Pakistan').
deskripsi(g3,'Ibukota Arab Saudi').
deskripsi(h1,'Ibukota Kuwait').
deskripsi(h2,'Ibukota Qatar').
deskripsi(cc,'Ujilah keberuntungan anda ditempat ini!\nAnda berhak untuk mendapatkan salah satu dari kartu berikut:\n').
deskripsi(jl,'Tempat para orang ilegal berdiam diri.\nAnda akan dipindahkan ke sini apabila anda mendapatkan kartu masuk penjara atau mendapatkan double 3 kali berturut-turut!').
deskripsi(tx,'Anda harus membayar pajak apabila anda berhenti disini!').
deskripsi(fp,'Parkir bebas, pemain tidak mendapatkan efek apa-apa ketika berhenti di lokasi ini!').
deskripsi(wt,'Anda dapat berpindah ke mana saja! Tentunya dengan membayar uang sebesar X% dari aset Anda.').

initTingkat :- 
    forall( kota(A),(assertz(tingkatProp(A,tanah)))).

checkLocationDetail(Lokasi) :- nama(Lokasi,Nama), deskripsi(Lokasi,Desc),
                                print('Nama Lokasi      : '), print(Nama), nl,
                                print('Deskripsi Lokasi : '), print(Desc), nl,
                                printInfoLokasiTambahan(Lokasi),!.
checkLocationDetail(Lokasi) :- print(Lokasi), print(' bukan merupakan lokasi yang valid! Silahkan masukkan lokasi yang tepat.').

printInfoLokasiTambahan(Lokasi) :- kota(Lokasi), tingkatProp(Lokasi,Tingkat), nl,
                                    print('Kepemilikan         : '), (milik(Lokasi,P) -> print(P);print('-')), nl,
                                    print('Biaya Sewa Saat Ini : '), (milik(Lokasi,P) -> print('duid');print('-')), nl,
                                    print('Biaya Akuisisi      : '), properti(Lokasi,Tingkat,Harga1), print(Harga1), nl,
                                    print('Tingkatan Properti  : ' ), print(Tingkat),!.
printInfoLokasiTambahan(Lokasi) :- !.