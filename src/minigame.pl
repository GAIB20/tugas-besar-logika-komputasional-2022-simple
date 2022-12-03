:- dynamic(countguess/1).
:- dynamic(youget/1).
/*Untuk menginisiasi setiap akan melakukan minigame*/
initAwal :- assertz(countguess(0)),assertz(youget(0)).

salah :- nl,write('Nice try again'),nl,minigame.


minigame :- retract(countguess(A)),C is A+1,assertz(countguess(C)),
random(1,11,X),nl,write('You guess :  '),read(Z),
(X =:= Z -> (write('You right'),retract(youget(D)),F is D+X,assertz(youget(F)),(C =:= 3 -> (nl,write('GG'),nl,
writehasilminigame);salah));(write('Wrong ANswer'),nl,writehasilminigame)).


writehasilminigame :- curPlayer(P),youget(A),write('You get '),write(A),write(' koin'),getmoneypemain(P,S),X is S+A,ubahMoney(X).
checkMiniGame :- initAwal,curPlayer(P),getlokasipemain(P,Lokasi),Lokasi = 'MG',minigame.