listLokasi(['FP','E1','E2','E3','CC','F1','F2','F3','MG','WT','G1','G2','G3','TX','CC','H1','H2','GO','A1','A2','A3','CC','B1','B2','B3','MG','JL','C1','C2','C3','TX','D1','D2','D3']).
heightMap(9).
widthMap(10).

getPos(Lokasi,KeI,IDX) :- listLokasi(List), getIdx(List,Lokasi,KeI,IDX).
getLoc(IDX,Lokasi) :- listLokasi(List), getVal(List,IDX,Lokasi).


getVal([A|_],0,A) :- !.
getVal([_|C],IDX,RES) :- IDX1 is IDX-1, getVal(C,IDX1,RES).
getIdx([Val|_],Val,1,0):- !.
getIdx([Val|C],Val,KeI,IDX) :- KeI1 is KeI-1, getIdx(C,Val,KeI1,IDX1), IDX is IDX1+1.
getIdx([A|C],Val,KeI,IDX) :- \+ A = Val, getIdx(C,Val,KeI,IDX1), IDX is IDX1+1.

totalLoc(X) :- heightMap(H),widthMap(W), X is H*2+W*2-4.
nextLoc(A,Dist,B) :- totalLoc(Len), B is (A+Dist) mod (Len). 

printEmptyCell :- print('    ').

printInfoCell(Kota) :- punyaLokasi(P,Kota), tingkatProp(Kota,Tingkat), print(' '), print(P),print(Tingkat), print(' '),!.
printInfoCell(Kota) :- \+ tingkatProp(Kota,_), printEmptyCell.

printKodeCell(Kode) :- print(' '), print(Kode), print(' ').

printSymCnt(_,0) :- !.
printSymCnt(Sym,Cnt) :- print(Sym), Cnt1 is Cnt-1, printSymCnt(Sym,Cnt1).

map :- upperRow, midRows, bottomRow, 
        getlokasipemain('P',Lokasi1),getlokasipemain('Q',Lokasi2),
        print('Lokasi sekarang:\n'),
        print('P: '), print(Lokasi1),nl,
        print('Q: '), print(Lokasi2),nl.

midRows :- 
    heightMap(H),
    H > 2,  
    I is H-2-1,
    printMidRow(I).

printMidRow(-1) :- !.
printMidRow(I) :-
    I1 is I-1,
    printMidRow(I1),

    totalLoc(LocCnt),
    widthMap(W),
    IdxLeft is LocCnt-1 - I,
    IdxRight is W+I,
    getLoc(IdxLeft,KodeLeft),
    getLoc(IdxRight,KodeRight),
    printInfoCell(KodeLeft), print('|'), printKodeCell(KodeLeft), print('|'),
    printTengah(I),
    print('|'), printKodeCell(KodeRight), print('|'), printInfoCell(KodeRight),
    nl.

printTengah(I) :-
    I =:= 0,
    widthMap(W), 
    Len is (W-2)*5-1,
    printSymCnt('-',Len),!.
printTengah(I) :-
    heightMap(H),
    I =:= H-2-1,
    widthMap(W),
    Len is (W-2)*5-1,
    printSymCnt('-',Len),!.
printTengah(I) :-
    heightMap(H),
    I =:= (H-2-1) div 2,
    widthMap(W),
    Len is (W-2)*5-1,
    BlankKiri is (Len-15) div 2,
    BlankKanan is (Len-15+1) div 2,
    printSymCnt(' ',BlankKiri),
    print('M O N O P O L Y'),
    printSymCnt(' ',BlankKanan),!.
printTengah(_) :-
    widthMap(W), 
    Len is (W-2)*5-1,
    printSymCnt(' ',Len).

upperRow :-
    widthMap(W),
    I is W-1,
    printEmptyCell,
    printInfoUpperCellke(I), nl,
    printEmptyCell,
    Len is W*5+1,
    printSymCnt('-',Len), nl,
    printEmptyCell,
    printUpperCellke(I), print('|'), nl.

printInfoUpperCellke(-1) :- !.
printInfoUpperCellke(I) :-
    I1 is I-1,
    printInfoUpperCellke(I1),
    
    IDX is I,
    getLoc(IDX,Kode),
    print(' '),
    printInfoCell(Kode).

printUpperCellke(-1) :- !.
printUpperCellke(I) :-
    I1 is I-1,
    printUpperCellke(I1),
    IDX is I,
    getLoc(IDX,Kode),
    print('|'),
    printKodeCell(Kode).

bottomRow :-
    widthMap(W),
    I is W-1,
    printEmptyCell,
    printBottomCellke(I), print('|'), nl,
    printEmptyCell,
    Len is W*5+1,
    printSymCnt('-',Len), nl,
    printEmptyCell,
    printInfoBottomCellke(I), nl.

printInfoBottomCellke(-1) :- !.
printInfoBottomCellke(I) :-
    I1 is I-1,
    printInfoBottomCellke(I1),
    heightMap(H),
    widthMap(W),
    IDX is (W*2+H-2-1)-I,
    getLoc(IDX,Kode),
    print(' '),
    printInfoCell(Kode).

printBottomCellke(-1) :- !.
printBottomCellke(I) :-
    I1 is I-1,
    printBottomCellke(I1),
    heightMap(H),
    widthMap(W),
    IDX is (W*2+H-2-1)-I,
    getLoc(IDX,Kode),
    print('|'),
    printKodeCell(Kode).
