:- include('pemain.pl').

pajak :- curPlayer(P),player(P,B,C,D,E),B = 'TX',write('Hallo '),write(P),nl,write('Anda harus membayar sebanyak :'),H is E*0.1,write(H).