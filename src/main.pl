:- include('chancecard.pl').
:- include('lokasi.pl').
:- include('papan.pl').
:- include('pemain.pl').
%:- include('penjara.pl').
:- include('Properti.pl').
:- include('perpajakan.pl').

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

startGame :- write('##     ##  #######  ##    ##  #######  ########   #######  ##       ##    ## '),nl,
             write('###   ### ##     ## ###   ## ##     ## ##     ## ##     ## ##        ##  ##'),nl,
             write('#### #### ##     ## ####  ## ##     ## ##     ## ##     ## ##         ####'),nl,
             write('## ### ## ##     ## ## ## ## ##     ## ########  ##     ## ##          ##'),nl,
             write('##     ## ##     ## ##  #### ##     ## ##        ##     ## ##          ##'),nl,
             write('##     ## ##     ## ##   ### ##     ## ##        ##     ## ##          ##'),nl,
             write('##     ##  #######  ##    ##  #######  ##         #######  ########    ## '),nl,
             initPemain.

    
