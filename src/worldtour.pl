worldTourTax :-
    curPlayer(P),
    retract(player(P, Lokasi, Totaluang, Totalnilaiproperti,Totalaset)),
    New is Totaluang-500,
    asserta(player(P, Lokasi, New, Totalnilaiproperti,Totalaset)).

lewatGo:- 
    curPlayer(P),
    retract(player(P, Lokasi, Totaluang, Totalnilaiproperti,Totalaset)),
        New is Totaluang+1000,
    asserta(player(P, Lokasi, New, Totalnilaiproperti,Totalaset)).

uang(Total) :- curPlayer(P), player(P, _, Totaluang, _,_), Total is Totaluang.
worldTour(Tujuan):- 
    uang(All),
    All >= 500,
    getPos(Tujuan,X),
    X \= 8,
    worldTourTax,
    (X > 15;X <8),
    lewatGo,
    ubahLokasi(Tujuan),!.
worldTour(Tujuan):- 
    uang(All),
    All >= 500,
    getPos(Tujuan,X),
    X \= 8,
    worldTourTax,
    ubahLokasi(Tujuan),!.
worldTour(_):- 
    uang(All),
    All < 500,
    print("Uang tidak cukup untuk World Tour"),nl.

isWorldTour :- curPlayer(P),player(P,Lokasi,_,_,_), Lokasi = 'WT', 
            print('Selamat datang di world tour!\nSilahkan masukkan kode lokasi tujuan anda: '), 
            read(Tujuan), 
            worldTour(Tujuan).