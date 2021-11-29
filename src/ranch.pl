:- dynamic(timeToExploit/1).
:- dynamic(collOfRanchItem/3).
:- dynamic(beenExploit/1).
% :- dynamic(lvlRanching/1).
% :- dynamic(expRanching/1).
% :- dynamic(timeRanch/1).
% :- dynamic(hoursTaken/1).


% exp(A, B): exp yang didapat dari A adalah B ketika di-collect
exp(egg, 20). % chicken
exp(milk, 30). % cow
exp(wool, 35). % sheep

% Initial
timeToExploit(5). % waktu yg dibutuhkan untuk chicken, cow, dan sheep bisa di exploit
collOfRanchItem(0, 0, 0). % koleksi yang bisa dieksploitasi (belum di eksploitasi dan bisa dimasukan ke inventory), arg menunjukan 0 egg, 0 milk, 0 wool
beenExploit(0).
% timeRanch(0).
% hoursTaken(0).

updateLevel :-
    (expRanching(A), Exp is A),
    ((Exp >= 0, Exp < 300) -> (retract(lvlRanching(_)), asserta(lvlRanching(1)));
    (Exp >= 300, Exp < 500) -> (retract(lvlRanching(_)), asserta(lvlRanching(2)));
    (Exp >= 500, Exp < 1000) -> (retract(lvlRanching(_)), asserta(lvlRanching(3)));
    (Exp >= 1000, Exp < 1500) -> (retract(lvlRanching(_)), asserta(lvlRanching(4)));
    (Exp >= 1500) -> (retract(lvlRanching(_)), asserta(lvlRanching(5)))).

updateTime :-
    (lvlRanching(1)) -> (retract(timeToExploit(_)), asserta(timeToExploit(5)));
    (lvlRanching(2)) -> (retract(timeToExploit(_)), asserta(timeToExploit(4)));
    (lvlRanching(3)) -> (retract(timeToExploit(_)), asserta(timeToExploit(3)));
    (lvlRanching(4)) -> (retract(timeToExploit(_)), asserta(timeToExploit(2)));
    (lvlRanching(5)) -> (retract(timeToExploit(_)), asserta(timeToExploit(1))).

updateColl :-
    timeToExploit(WEks),
    hours(Jamnya),
    days(Harinya),
    beenExploit(Pliss),
    HariAsli is Harinya - 1,
    Nilai is ((HariAsli * 24) + Jamnya - 6),
    NowVal is Nilai // WEks, % csplfo ej tjoj
    NowValUpdate is NowVal - Pliss,
    increaseColl(NowValUpdate).

    % hoursTaken(Ada),
    % timeRanch(Bingung),
    % Totalnya is ((24 * HariAsli) + Jamnya - 6),
    % Totaluntukdipake is Totalnya - Ada,
    % Val1 is Totaluntukdipake // WEks,
    % Val2 is Totaluntukdipake mod WEks),
    % retract(timeRanch(_)), asserta(timeRanch(Val2)),
    % (((Val1 =:= WEks) -> (increaseColl(Val1)));
    % ((WRan =\= WEks) -> (retract(timeRanch(_)), asserta(timeRanch(Incr))))).
    
% menambah elemen-elemen collOfRanchItem sebanyak X
increaseColl(X) :-
    collOfRanchItem(Awal1, Awal2, Awal3),
    Inc1 is Awal1 + X, Inc2 is Awal2 + X, Inc3 is Awal3 + X,
    retract(collOfRanchItem(_,_,_)), asserta(collOfRanchItem(Inc1, Inc2, Inc3)).
    

% addSomething(N): Menambah banyak ayam, sapi, atau domba sebanyak N
addChicken(N) :-
	retract(item(10,chicken,X,0,750,0)), NewX is X+N, asserta(item(10,chicken,NewX,0,750,0)).
addCow(N) :-
	retract(item(11,cow,X,0,1500,0)), NewX is X+N, asserta(item(11,cow,NewX,0,1500,0)).
addSheep(N) :-
	retract(item(12,sheep,X,0,2000,0)), NewX is X+N, asserta(item(12,sheep,NewX,0,2000,0)).

% addSomething: Menambahkan Something sejumlah N ke inventory dan mengurangi collOfRanchItem
addEgg :-
    (collOfRanchItem(Amount1, Amount2, Amount3),
    N is Amount1, 
    item(10,_,X,_,_,_)),
    (((N =\= 0) -> (retract(collOfRanchItem(_,_,_)), asserta(collOfRanchItem(0, Amount2, Amount3)),
	% retract(item(13,egg,X,100,0,0)), NewX is X+N, asserta(item(13,egg,NewX,100,0,0)), % ekivalen sama addItem(13, N)
    addItem(13, N),
    % timeToExploit(II),
    exp(egg, Val),
    expRanching(Before),
    To is Val * N * X,
    ExpAfter is Before + To,
    retract(expRanching(_)), asserta(expRanching(ExpAfter)),
    write('Baru aja ngambil telur ayam nih bos, dapet'), write(N), write(' telur, di inventory udah nambah'),
    beenExploit(Brp), Suatu is Brp + 1, retract(beenExploit(_)), asserta(beenExploit(Suatu)))); 
    % hoursTaken(Sblm), P is II * N + Sblm, retract(hoursTaken(_)), asserta(hoursTaken(P))
    ((N =:= 0) -> write('Telurnya lagi kosong bos, no pain no gain, tunggu waktunya'), nl)),
    addExpGeneral(To).
addMilk :-
    (collOfRanchItem(Amount1, Amount2, Amount3),
    N is Amount2, 
    item(11,_,X,_,_,_)),
    (((N =\= 0) -> (retract(collOfRanchItem(_,_,_)), asserta(collOfRanchItem(Amount1, 0, Amount3)),
	% retract(item(14,milk,X,400,0,0)), NewX is X+N, asserta(item(14,milk,NewX,400,0,0)), % ekivalen sama addItem(14, N)
    addItem(14, N),
    % timeToExploit(II),
    exp(milk, Val),
    expRanching(Before),
    To is Val * N * X,
    ExpAfter is Before + To,
    retract(expRanching(_)), asserta(expRanching(ExpAfter)),
    write('Mantep, dapet '), write(N), write(' susu nih bos, di inventory udah ditambah'), nl,
    beenExploit(Brp), Suatu is Brp + 1, retract(beenExploit(_)), asserta(beenExploit(Suatu)))); 
    % hoursTaken(Sblm), P is II * N + Sblm, retract(hoursTaken(_)), asserta(hoursTaken(P))
    ((N =:= 0) -> write('Milk yang dihasilin sapinya lagi abis nih bos, no pain no gain, tunggu waktunya'), nl)),
    addExpGeneral(To).
addWool :-
    (collOfRanchItem(Amount1, Amount2, Amount3),
    N is Amount3,
    item(12,_,X,_,_,_)),
    (((N =\= 0) -> (retract(collOfRanchItem(_,_,_)), asserta(collOfRanchItem(Amount1, Amount2, 0)),
	% retract(item(15,wool,X,750,0,0)), NewX is X+N, asserta(item(15,wool,NewX,750,0,0)), % ekivalen sama addItem(15, N)
    addItem(15, N),
    % timeToExploit(II),
    exp(wool, Val),
    expRanching(Before),
    To is Val * N * X,
    ExpAfter is Before + To,
    retract(expRanching(_)), asserta(expRanching(ExpAfter)),
    write('Dapet juga wolnya, dah tuh jual atau dipake jait, dapet '), write(N), write(' wol, udah ditaro di inventory ya'), nl,
    beenExploit(Brp), Suatu is Brp + 1, retract(beenExploit(_)), asserta(beenExploit(Suatu)))); 
    % hoursTaken(Sblm), P is II * N + Sblm, retract(hoursTaken(_)), asserta(hoursTaken(P))
    ((N =:= 0) -> (write('Wolnya udah abis nih bos, lain kali ambilnya'), nl))),
    addExpGeneral(To).
    % [Nanti nambah exp player juga di sini]

inRanch :- player(X,Y), place('R',X,Y).

ranch :-
    inRanch, !,
    updateLevel,
    updateTime,
    updateColl,
    write('What animal you want to exploit (You can type chicken., cow., or sheep.): '), nl,
    read(PickedAnimal),
    (((PickedAnimal = 'chicken') -> (addEgg));
    ((PickedAnimal = 'cow') -> (addMilk));
    ((PickedAnimal = 'sheep') -> (addWool));
    ((\+(PickedAnimal = 'chicken'), \+(PickedAnimal = 'cow'), \+(PickedAnimal = 'sheep')) -> (write('Gak ada hewan yang lu sebutin bos, cuma ada chicken, cow, sama sheep aja')))).

ranch :- write('Pergi ke peternakan dulu bos!'), nl.