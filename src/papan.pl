pos(0,'FP').
pos(1,'E1').
pos(2,'E2').
pos(3,'E3').
pos(4,'CC').
pos(5,'F1').
pos(6,'F2').
pos(7,'F3').
pos(8,'WT').
pos(9,'G1').
pos(10,'G2').
pos(11,'G3').
pos(12,'TX').
pos(13,'CC').
pos(14,'H1').
pos(15,'H2').
pos(16,'GO').
pos(17,'A1').
pos(18,'A2').
pos(19,'A3').
pos(20,'CC').
pos(21,'B1').
pos(22,'B2').
pos(23,'B3').
pos(24,'JL').
pos(25,'C1').
pos(26,'C2').
pos(27,'C3').
pos(28,'TX').
pos(29,'D1').
pos(30,'D2').
pos(31,'D3').
heightMap(9).
widthMap(9).

totalLoc(X) :- heightMap(H),widthMap(W), X is H*2+W*2-4.
nextLoc(A,Dist,B) :- pos(X,A), totalLoc(Len), X1 is (X+Dist) mod (Len), pos(X1,B). 

printEmptyCell :- print('    ').

printInfoCell(Kota) :- tingkatProp(Kota,X1), print(' '), print(X1), print(' '),!.
printInfoCell(Kota) :- \+ tingkatProp(Kota,_), printEmptyCell.

printKodeCell(Kode) :- print(' '), print(Kode), print(' ').

printSymCnt(_,0) :- !.
printSymCnt(Sym,Cnt) :- print(Sym), Cnt1 is Cnt-1, printSymCnt(Sym,Cnt1).

map :- upperRow, midRows, bottomRow,nl.

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
    heightMap(H),
    widthMap(W),
    IDX is (W*2+H-2-1)-I,
    pos(IDX,Kode),
    print(' '),
    printInfoCell(Kode).

printBottomCellke(-1) :- !.
printBottomCellke(I) :-
    I1 is I-1,
    printBottomCellke(I1),
    heightMap(H),
    widthMap(W),
    IDX is (W*2+H-2-1)-I,
    pos(IDX,Kode),
    print('|'),
    printKodeCell(Kode).
