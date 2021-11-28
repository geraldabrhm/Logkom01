:- dynamic(hours/1).
:- dynamic(days/1).

days(1).
hours(6).

NotLateNight :-
    hours(X),
    Y < 22.

DisplayTime :-
    days(X),
    hours(Y),
    Y < 22, !,
    write('Day : '),
    write(X), nl,
    write('Hour :'),
    write(Y), nl.

DisplayTime :-
    days(X),
    write('Day : '),
    write(X), nl,
    write('It\'s late night. Time to sleep'), nl.

days(X) :-
    addDay(Y),
    days(X1),
    X is X1 + Y.

hours(6) :- 
    setHourDawn.

hours(X) :-
    hours(X1),
    X1 <= 22, !,
    addHour(Y),
    X is X1 + Y,
    X <= 22.

hours(22) :-

addHour(X) :-
addDay(X) :-

