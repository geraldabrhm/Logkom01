isInHouse :-
    player(X,Y), place('H',X,Y).

sleep :- 
    isInHouse, !,
    addDay(1),
    setHourDawn,
    displayTime,
    write('Selamat pagi bos!'),nl,
    write('Tetap semangat buat kerja ya!'),nl.

sleep :- write('Pulang ke rumah dulu bos!'),nl.