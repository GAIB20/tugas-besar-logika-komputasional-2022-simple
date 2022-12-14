:- dynamic(startgame/0).
:- include('chancecard.pl').
:- include('lokasi.pl').
:- include('papan.pl').
:- include('pemain.pl').
:- include('penjara.pl').
:- include('Properti.pl').
:- include('perpajakan.pl').
:- include('worldtour.pl').
:- include('bangkrut.pl').
:- include('minigame.pl').


help :- write('###########################################################################'),nl,
        write('                               MONOPOLY                                    '),nl,
        write('1. startGame           : untuk memulai permainan                            '),nl,
        write('2. map                 : menampilkan peta                                   '),nl,
        write('3. checkPlayerDetail   : menampilkan info dari pemain                       '),nl,
        write('4. checkLocationDetail : menampilkan lokasi                                 '),nl,
        write('5. checkPropertyDetail : menampilkan properti                               '),nl,   
        write('6. throwDice           : Untuk mengocok dadu                                '),nl,
        write('7. help                : Menampilkan bantuan command-command                '),nl,
        write('8. Exit                : Keluar dari game                                   '),nl,
        write('############################################################################'),initPemain.

/*pemain 1 bakal throwDice Awal permainan kan bakal di go itu di nomor 16, nah jadi untuk selanjutnya*/ 

startGame :- write('\33\[38;5;96m##     ##  #######  ##    ##  #######  ########   #######  ##       ##    ##\33\[0m'),nl,
             write('\33\[38;5;96m###   ### ##     ## ###   ## ##     ## ##     ## ##     ## ##        ##  ##\33\[0m'),nl,
             write('\33\[38;5;96m#### #### ##     ## ####  ## ##     ## ##     ## ##     ## ##         ####\33\[0m'),nl,
             write('\33\[38;5;96m## ### ## ##     ## ## ## ## ##     ## ########  ##     ## ##          ##\33\[0m'),nl,
             write('\33\[38;5;96m##     ## ##     ## ##  #### ##     ## ##        ##     ## ##          ##\33\[0m'),nl,
             write('\33\[38;5;96m##     ## ##     ## ##   ### ##     ## ##        ##     ## ##          ##\33\[0m'),nl,
             write('\33\[38;5;96m##     ##  #######  ##    ##  #######  ##         #######  ########    ## \33\[0m'),nl,
             initPemain, initJail, assertz(startgame).

reset :- retract(_).
