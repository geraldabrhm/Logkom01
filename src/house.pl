:- dynamic(days/1).
:- dynamic(hours/1).

isInHouse :-
    player(X,Y), place('H',X,Y).

sleep :- 
    isInHouse, !,
    addDay(1),
    setHourDawn.


