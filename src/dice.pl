:- dynamic(dadu1/1).
:- dynamic(dadu2/1).
:- dynamic(count/1).


throwDice :- random(1,7,X), random(1,7,Y), write('dadu 1 :'),nl,write(X),nl,
write('dadu 2 : '),nl,write(Y),nl, Z is X+Y,assertz(dadu1(Y)),assertz(dadu2(X)),
write('total langkah : '),nl,write(Z),nl,(X =:= Y, -> write('double'),nl,(count =:= 3 -> write('Anda masuk penjara.');throwDice)).






