bangkrut(X) :- curPlayer(P), getasetpemain(P,Aset), Aset < X,
                    write('Uang yang dipegang        : '), getmoneypemain(P,Totaluang), print(Totaluang), nl,
                    write('Total Nilai Properti      : '), getpropertipemain(P, Totalnilaiproperti), print(Totalnilaiproperti), nl,
                    write('Total kekayaan            : '), getasetpemain(P, Totalkekayaan),print(Totalkekayaan), nl,nl, 
                    hargaSewa(Lokasi, X),
                    write('Harga yang harus dibayar  : '), write(X),nl,
                    write('Sayang sekali, uangmu sudah tidak cukup. Selamat tinggal :)'),!.
bangkrut(X) :- curPlayer(P), getmoneypemain(P,Uang), Uang < X,
                    write('Uang yang dipegang        : '), getmoneypemain(P,Totaluang), print(Totaluang), nl,
                    write('Total Nilai Properti      : '), getpropertipemain(P, Totalnilaiproperti), print(Totalnilaiproperti), nl,
                    write('Total kekayaan            : '), getasetpemain(P, Totalkekayaan),print(Totalkekayaan), nl,nl, 
                    hargaSewa(Lokasi, X),
                    write('Harga yang harus dibayar  : '), write(X),nl,
                    repeat,
                    write('Wah, uangmu kurang! Apakah kamu ingin tetap meneruskan permainan?'),
                    read(Y), 
                    (Y = yes -> 
                        write('Properti mana yang ingin dijual?\n'),nl, 
                        printAllProperti,
                        read(A),
                        jualLokasi(A), getmoneypemain(P,Uang1),
                        (Uang1 < X -> 
                            (write('Pembayaran kamu masih kurang!\n'), 
                            bangkrut(X))
                            ;
                            (write('Hore uang kamu mencukupi!\n'))
                            )
                        ;
                        write('Sayang cepat sekali menyerah, selamat tinggal :)\n')).
                        

bangkrut(_).


