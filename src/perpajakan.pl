pajak :- curPlayer(P), 
        getmoneypemain(P,C), getasetpemain(P,E),
        write('Anda harus membayar sebanyak : '),H is E*0.1,write(H),nl,
        bangkrut(H),
        CurUang is C-(E*0.1), ubahMoney(CurUang),
        write('Setelah membayar pajak memiliki uang sebesar : '), write(CurUang), nl.

checkPajak:- curPlayer(P), getlokasipemain(P,Lokasi), Lokasi = 'TX', 
        write('Selamat datang dikantor pajak!!!'),nl,pajak,!.
checkPajak.