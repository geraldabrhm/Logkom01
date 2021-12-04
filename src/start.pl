% Source code program yang minimal berisi:
%     ● Fakta-fakta terkait peta dan pemain
%     ● Implementasi rule-rule kendali dasar (start, help ,quit, inventory, dll)
:- dynamic(game_started/1).
:- dynamic(specialty/1).

game_started(false).

start :-
    game_started(false), !,
    retract(game_started(false)),
    asserta(game_started(true)),
	
    ['map.pl'],
    ['move.pl'],
    ['itemAndReconInven.pl'],
    ['help.pl'],
    ['interface.pl'],
    ['quest.pl'],
    ['player.pl'],
    ['marketplace.pl'],
    ['house.pl'],
    ['time.pl'],
    ['farm.pl'],
    ['ranch.pl'],
    ['fish.pl'],

    printHouse,
    printWelcome,
    pickJob,
	
    write('The game already started. Use command \'help.\' for guide'),nl.

start :- write('Game udah dimulai bos!'), nl.

pickJob :-
    write('This is Harvest Star. Choose your job'),nl,
    write('1. Fisherman'),nl,
    write('2. Farmer'),nl,
    write('3. Rancher'),nl,
    read(Job),
    (
    Job =:= 1 -> assertz(specialty(fisherman)), write('Anda memilih fisherman!'), nl;
    Job =:= 2 -> assertz(specialty(farmer)), write('Anda memilih farmer!'), nl;
    Job =:= 3 -> assertz(specialty(rancher)), write('Anda memilih rancher!'), nl;
    pickJob
    ).

quit :- 
    game_started(true),
    write('Are you sure (y/n)?'),nl,
    read(Quit),
    (
    Quit == y -> halt;
    Quit == n -> fail
	).

quitEnd:-
    write('Terimakasih sudah bermain Harvest Star!'), nl,
    write('Do you want to quit (y/n)?'), nl,
    read(Quit),
    (
    Quit == y -> halt;
    Quit == n -> fail
	).