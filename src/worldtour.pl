WorldTourTax(player) :-
    retractall(player(P, Lokasi, Totaluang, Totalnilaiproperti,Totalaset)),
    asserta(player(P, Lokasi, Totaluang-500, Totalnilaiproperti,Totalaset)).

LewatGo(player) :- 
    retractall(player(P, Lokasi, Totaluang, Totalnilaiproperti,Totalaset)),
    asserta(player(P, Lokasi, Totaluang+1000, Totalnilaiproperti,Totalaset)).

uang(player,total) :- player(P, Lokasi, Totaluang, Totalnilaiproperti,Totalaset),total is Totaluang.
worldTour(Player,Tujuan):- 
    uang(Player,All),
    All >= 500,
    pos(X,Tujuan),
    X \= 8,
    WorldTourTax(Player),
    (X =:= 15;X=:=14;X=:=13;X=:=12;X=:=11;X=:=10;X=:=9),
    LewatGo(player),
    ubahLokasi(Tujuan).
worldTour(Player,Tujuan):- 
    uang(Player,All),
    All >= 500,
    pos(X,Tujuan),
    X \= 8,
    WorldTourTax(Player),
    ubahLokasi(Tujuan).
worldTour(Player,Tujuan):- 
    uang(Player,All),
    All < 500,
    print("Uang tidak cukup untuk World Tour")print('\n').


