isInHouse :-
    player(X,Y), place('H',X,Y).

sleep :- 
    days(X),
    playerMoney(Y),
    X =:= 365,
    Y < 20000, !,
    isInHouse,
    write('You have worked hard, but in the end result is all that matters.'), nl,
    write('May God bless you in the future with kind people!'), nl,
    quitEnd.

sleep :- 
    isInHouse, !,
    addDay(1),
    setHourDawn,
    displayTime,
    write('Selamat pagi bos!'),nl,
    write('Tetap semangat buat kerja ya!'),nl.

sleep :- write('Pulang ke rumah dulu bos!'),nl.