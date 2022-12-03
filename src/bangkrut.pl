bangkrut(X) :- curPlayer(P), getmoneypemain(P,Uang), Uang < X,
                    write('Uang yang dipegang        :'), getmoneypemain(P,Totaluang),
                    write('Total Nilai Properti      :'), getpropertipemain(P, Totalnilaiproperti),
                    write('Total kekayaan            :'), getasetpemain(P, Totalkekayaan),nl,nl,
                    hargaSewa(Lokasi, X),
                    write(X),
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
                            (write('Hore sewa kamu sudah bisa dibayar!\n'), 
                            format('Uang setelah membayar sewa: ~w', [Uang1]))
                            )
                        ;
                        write('Sayang cepat sekali menyerah, selamat tinggal :)\n')).
                        
bangkrut(X) :- curPlayer(P), getasetpemain(P,Aset), Aset < X,
                    write('Uang yang dipegang        :'), getmoneypemain(P,Totaluang),
                    write('Total Nilai Properti      :'), getpropertipemain(P, Totalnilaiproperti),
                    write('Total kekayaan            :'), getasetpemain(P, Totalkekayaan),nl,nl,
                    hargaSewa(Lokasi, X),
                    write(X),nl,
                    write('Sayang sekali, uangmu sudah tidak cukup. Selamat tinggal :)').
bangkrut(_).


