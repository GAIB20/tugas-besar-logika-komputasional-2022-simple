bangkrut :- 
                player(P, Lokasi, Totaluang, Totalnilaiproperti,Totakekayaan), nl,
                    write('Uang yang dipegang        :'), write(Totaluang),nl,
                    write('Total Nilai Properti      :'), write(Totalnilaiproperti),nl,
                    write('Total kekayaan            :'), write(Totaluang), write(Totalnilaiproperti), write('='), write(Totaluang + Totalnilaiproperti),nl,nl,
                    hargaSewa(Lokasi, X),
                    write(X),nl,nl,
                    write('Wah, uangmu kurang! Apakah kamu ingin tetap meneruskan permainan?'),nl.

