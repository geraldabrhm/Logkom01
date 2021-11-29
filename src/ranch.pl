
:- dynamic(lvlRanching/1).
:- dynamic(expRanching/1).
:- dynamic(timeToExploit/1).
:- dynamic(collOfRanchItem/3).
:- dynamic(timeRanch/1).


% exp(A, B): exp yang didapat dari A adalah B ketika di-collect
exp(egg, 20). % chicken
exp(milk, 30). % cow
exp(wool, 35). % sheep

% Initial
lvlRanching(1). % Lvl ranching
expRanching(0). % exp ranching
timeToExploit(5). % waktu yg dibutuhkan untuk chicken, cow, dan sheep bisa di exploit
collOfRanchItem(0, 0, 0). % koleksi yang bisa dieksploitasi (belum di eksploitasi dan bisa dimasukan ke inventory), arg menunjukan 0 egg, 0 milk, 0 wool
timeRanch(0). % mekanisme waktu khusus ranch

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

% [Nunggu mekanisme hours]
updateTimeRanch :-
    % if <Hours> tambah 1 <timeRanch> tambah 1
    (timeToExploit(WEks),
    timeRanch(WRan),
    Incr is WRan + 1),
    (((WRan =:= WEks) -> (increaseColl, retract(timeRanch(_)), asserta(timeRanch(0))));
    ((WRan =\= WEks) -> (retract(timeRanch(_)), asserta(timeRanch(Incr))))).
    
% menambah elemen-elemen collOfRanchItem sebanyak 1
increaseColl :-
    collOfRanchItem(Awal1, Awal2, Awal3),
    Inc1 is Awal1 + 1, Inc2 is Awal2 + 1, Inc3 is Awal3 + 1,
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
    collOfRanchItem(Amount1, Amount2, Amount3),
    N is Amount1,
    retract(collOfRanchItem(_,_,_)), asserta(collOfRanchItem(0, Amount2, Amount3)),
	% retract(item(13,egg,X,100,0,0)), NewX is X+N, asserta(item(13,egg,NewX,100,0,0)), % ekuivalen sama addItem(13, N)
    addItem(13, N),
    exp(egg, Val),
    expRanching(Before),
    retract(expRanching(_)), asserta(expRanching(Before + (Val * N))).
    % [Nanti nambah exp player juga di sini]
addMilk :-
    collOfRanchItem(Amount1, Amount2, Amount3),
    N is Amount2,
    retract(collOfRanchItem(_,_,_)), asserta(collOfRanchItem(Amount1, 0, Amount3)),
	% retract(item(14,milk,X,400,0,0)), NewX is X+N, asserta(item(14,milk,NewX,400,0,0)), % ekuivalen sama addItem(14, N)
    addItem(14, N),
    exp(milk, Val),
    expRanching(Before),
    retract(expRanching(_)), asserta(expRanching(Before + (Val * N))).
    % [Nanti nambah exp player juga di sini]
addWool :-
    collOfRanchItem(Amount1, Amount2, Amount3),
    N is Amount3,
    retract(collOfRanchItem(_,_,_)), asserta(collOfRanchItem(Amount1, Amount2, 0)),
	% retract(item(15,wool,0,750,0,0)), NewX is X+N, asserta(item(15,wool,NewX,750,0,0)), % ekuivalen sama addItem(15, N)
    addItem(15, N),
    exp(wool, Val),
    expRanching(Before),
    retract(expRanching(_)), asserta(expRanching(Before + (Val * N))).
    % [Nanti nambah exp player juga di sini]