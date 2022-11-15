/* Rencana Fakta */
:- dynamic (listcard/1)
chancecard(taxcard).
chancecard(giftcard).
chancecard(injailcard).
chancecard(outjailcard).
giftamount(10000).

/* Rencana Rules */
rollnumber(X) :- random(1, 100, X).
rollcard(X) :- rollnumber(Y), Y>0, Y=<15, X=1.
rollcard(X) :- rollnumber(Y), Y>15, Y=<50, X=2.
rollcard(X) :- rollnumber(Y), Y>50, Y=<65, X=3.
rollcard(X) :- rollnumber(Y), Y>65, Y=<100, X=4.
cardresult(X) :- rollcard(Y), Y =:= 1, X = Y.
cardresult(X) :- rollcard(Y), Y =:= 2, X = Y.
cardresult(X) :- rollcard(Y), Y =:= 3, X = Y.
cardresult(X) :- rollcard(Y), Y =:= 4, X = Y.