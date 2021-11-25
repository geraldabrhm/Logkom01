% Source code program yang minimal berisi:
%     ● Fakta-fakta terkait peta dan pemain
%     ● Implementasi rule-rule kendali dasar (start, help ,quit, inventory, dll)
:- dynamic(game_started/1).

game_started(false).

start :-
    ['map.pl'],
    ['inventory.pl'],
    ['help.pl'],
    ['interface.pl'],

    retract(game_started(false)), !,
    asserta(game_started(true)),

    printHouse.
    write('Welcome to Harvest Star. Choose your job'),nl,
    write('1. Fisherman'),nl,
    write('2. Farmer'),nl,
    write('3. Rancher'),nl.

    read(Job),
    ((Job =:= 1 -> Fisherman(true));
    (Job =:= 2 -> Farmer(true));
    (Job =:= 3 -> Rancher(true))).

start :-
    write('The game already started. Use command \'help.\' for guide'),nl.

quit :- 
    game_started(true),
    write('Are you sure (y/n)?'),nl,
    read(Quit),
    (Quit == y -> halt;
    (Quit == n -> fail)).
    

