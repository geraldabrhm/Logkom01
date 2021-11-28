:- dynamic(days/1).
:- dynamic(hours/1).

isInHouse :-
    player(X,Y), X =:= 7, Y =:= 6.

sleep :- 
    isInHouse, !,
    addDay(1),
    setHourDawn.


