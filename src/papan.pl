cellList([fp,e1,e2,e3,cc,f1,f2,f3,wt,g1,g2,g3,tx,cc,h1,h2,go,a1,a2,a3,cc,b1,b2,b3,jl,c1,c2,c3,tx,d1,d2,d3]).
heigthMap(9).
widthMap(9).

printEmptyCell :- print('    ').

printInfoCell(Kota) :- bangunan(Kota,X1), print(' '), print(X1), print(' '),!.
printInfoCell(Kota) :- \+ bangunan(Kota,_), printEmptyCell.

printKodeCell(Kode) :- print(' '), print(Kode), print(' ').

printSymCnt(_,0) :- !.
printSymCnt(Sym,Cnt) :- print(Sym), Cnt1 is Cnt-1, printSymCnt(Sym,Cnt1).

getIdxVal([A|_],0,A) :- !.
getIdxVal([_|C],IDX,RES) :- IDX1 is IDX-1, getIdxVal(C,IDX1,RES).


map :- upperRow, midRows, bottomRow,nl.

midRows :- 
    heigthMap(H),
    H > 2,  
    I is H-2-1,
    printMidRow(I).

printMidRow(-1) :- !.
printMidRow(I) :-
    I1 is I-1,
    printMidRow(I1),
    cellList(List),
    heigthMap(H),
    widthMap(W),
    IdxLeft is (2*W+2*H-4)-1 - I,
    IdxRight is W+I,
    getIdxVal(List,IdxLeft,KodeLeft),
    getIdxVal(List,IdxRight,KodeRight),
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
    heigthMap(H),
    I =:= H-2-1,
    widthMap(W),
    Len is (W-2)*5-1,
    printSymCnt('-',Len),!.
printTengah(I) :-
    heigthMap(H),
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
    cellList(List),
    IDX is I,
    getIdxVal(List,IDX,Kode),
    print(' '),
    printInfoCell(Kode).

printUpperCellke(-1) :- !.
printUpperCellke(I) :-
    I1 is I-1,
    printUpperCellke(I1),
    cellList(List),
    IDX is I,
    getIdxVal(List,IDX,Kode),
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
    cellList(List),
    heigthMap(H),
    widthMap(W),
    IDX is (W*2+H-2-1)-I,
    getIdxVal(List,IDX,Kode),
    print(' '),
    printInfoCell(Kode).

printBottomCellke(-1) :- !.
printBottomke(I) :-
    I1 is I-1,
    printBottomke(I1),
    cellList(List),
    heigthMap(H),
    widthMap(W),
    IDX is (W*2+H-2-1)-I,
    getIdxVal(List,IDX,Kode),
    print('|'),
    printKodeCell(Kode).

ujiLoop :-
    I is 1,
    repeat,
    I1 is I+1,
    I1 = 8.

ujiLoop2 :-
    repeat,
    read(X),
    X = stop.
