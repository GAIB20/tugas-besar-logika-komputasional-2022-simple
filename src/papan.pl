pos(0,fp).
pos(1,e1).
pos(2,e2).
pos(3,e3).
pos(4,cc).
pos(5,f1).
pos(6,f2).
pos(7,f3).
pos(8,wt).
pos(9,g1).
pos(10,g2).
pos(11,g3).
pos(12,tx).
pos(13,cc).
pos(14,h1).
pos(15,h2).
pos(16,go).
pos(17,a1).
pos(18,a2).
pos(19,a3).
pos(20,cc).
pos(21,b1).
pos(22,b2).
pos(23,b3).
pos(24,jl).
pos(25,c1).
pos(26,c2).
pos(27,c3).
pos(28,tx).
pos(29,d1).
pos(30,d2).
pos(31,d3).
heigthMap(9).
widthMap(9).

printEmptyCell :- print('    ').

printInfoCell(Kota) :- bangunan(Kota,X1), print(' '), print(X1), print(' '),!.
printInfoCell(Kota) :- \+ bangunan(Kota,_), printEmptyCell.

printKodeCell(Kode) :- print(' '), print(Kode), print(' ').

printSymCnt(_,0) :- !.
printSymCnt(Sym,Cnt) :- print(Sym), Cnt1 is Cnt-1, printSymCnt(Sym,Cnt1).

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
    
    heigthMap(H),
    widthMap(W),
    IdxLeft is (2*W+2*H-4)-1 - I,
    IdxRight is W+I,
    pos(IdxLeft,KodeLeft),
    pos(IdxRight,KodeRight),
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
    
    IDX is I,
    pos(IDX,Kode),
    print(' '),
    printInfoCell(Kode).

printUpperCellke(-1) :- !.
printUpperCellke(I) :-
    I1 is I-1,
    printUpperCellke(I1),
    IDX is I,
    pos(IDX,Kode),
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
    heigthMap(H),
    widthMap(W),
    IDX is (W*2+H-2-1)-I,
    pos(IDX,Kode),
    print(' '),
    printInfoCell(Kode).

printBottomCellke(-1) :- !.
printBottomCellke(I) :-
    I1 is I-1,
    printBottomCellke(I1),
    heigthMap(H),
    widthMap(W),
    IDX is (W*2+H-2-1)-I,
    pos(IDX,Kode),
    print('|'),
    printKodeCell(Kode).
