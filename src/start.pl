% Source code program yang minimal berisi:
%     ● Fakta-fakta terkait peta dan pemain
%     ● Implementasi rule-rule kendali dasar (start, help ,quit, inventory, dll)
:- dynamic(game_started/1).
:- dynamic(specialty/1).

game_started(false).

start :-
    ['map.pl'],
    ['move.pl'],
    ['itemAndReconInven.pl'],
    ['help.pl'],
    ['interface.pl'],
    ['quest.pl'],
    %['player.pl'],
    ['marketplace.pl'],
    %['house.pl'],
    %['farm.pl'],
    ['ranch.pl'],
    ['fish.pl'],

    retract(game_started(false)), !,
    asserta(game_started(true)),

    printHouse,
    printWelcome,
    write('This is Harvest Star. Choose your job'),nl,
    write('1. Fisherman'),nl,
    write('2. Farmer'),nl,
    write('3. Rancher'),nl,

    read(Job),
    (
    Job =:= 1 -> assertz(specialty(fisherman));
    Job =:= 2 -> assertz(specialty(farmer));
    Job =:= 3 -> assertz(specialty(rancher))
    ),
    write('The game already started. Use command \'help.\' for guide'),nl.

quit :- 
    game_started(true),
    write('Are you sure (y/n)?'),nl,
    read(Quit),
    (
    Quit == y -> halt;
    Quit == n -> fail
	).