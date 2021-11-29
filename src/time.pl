:- dynamic(hours/1).
:- dynamic(days/1).

days(1).
hours(6).

lateNight :-
    hours(X),
    X >= 22.

displayTime :-
    days(X),
    hours(Y),
    Y < 22, !,
    write('Hari : '),
    write(X), nl,
    write('Jam : '),
    write(Y), nl.

displayTime :-
    days(X),
    write('Day : '),
    write(X), nl,
    write('Udah malem bos, waktunya tidur!'), nl.

addDay(Y) :-
    days(X1),
    X is X1 + Y,
    retract(days(X1)),
    asserta(days(X)),
    mapHarvest(0,0).

setHourDawn :- 
    retract(hours(_)),
    asserta(hours(6)).

addHour(Y) :-
    hours(X1),
    X is X1 + Y,
    X =< 22, !,
    retract(hours(X1)),
    asserta(hours(X)).

addHour(_) :-
    retract(hours(_)),
    asserta(hours(22)),
    write('Udah malem bos, waktunya tidur!'), nl.
