mekanismeBangkrut :- condition(Uang, hargaSewa), player(P, Lokasi, Totaluang, Totalnilaiproperti,Totakekayaan), nl,
                    write('Uang yang dipegang        :'), write(Totaluang),nl,
                    write('Total Nilai Properti      :'), write(Totalnilaiproperti),nl,
                    write('Total kekayaan            :'), write(Totaluang), write(Totalnilaiproperti), write('='), write(Totaluang + Totalnilaiproperti),nl,nl,
                    write(hargaSewa(lokasi, X)),nl,nl,
                    write('Wah, uangmu kurang! Apakah kamu ingin tetap meneruskan permainan?'),nl.
                    
                    
condition(Uang,hargaSewa) :- Uang < hargaSewa.


isBangkrut:- 