:- dynamic(lvlRanching/1).
:- dynamic(expRanching/1).
:- dynamic(item/6).
:- dynamic(timeToExploit/1).
%:- dynamic(hours/1).


% exp(A, B): exp yang didapat dari A adalah B ketika di-collect
exp(egg, 20). % chicken
exp(milk, 30). % cow
exp(wool, 35). % sheep

% Initial
lvlRanching(1). % Lvl ranching
expRanching(0). % exp ranching
timeToExploit(5). % waktu yg dibutuhkan untuk chicken, cow, dan sheep bisa di exploit
collOfRanchItem(0, 0, 0). % koleksi yang bisa dieksploitasi (belum di eksploitasi dan bisa dimasukan ke inventory), arg menunjukan 0 egg, 0 milk, 0 wool

expRanching(Exp) :-
    (Exp >= 0, Exp < 300) -> (retract(lvlRanching(_)), asserta(lvlRanching(1)));
    (Exp >= 300, Exp < 500) -> (retract(lvlRanching(_)), asserta(lvlRanching(2)));
    (Exp >= 500, Exp < 1000) -> (retract(lvlRanching(_)), asserta(lvlRanching(3)));
    (Exp >= 1000, Exp < 1500) -> (retract(lvlRanching(_)), asserta(lvlRanching(4)));
    (Exp >= 1500) -> (retract(lvlRanching(_)), asserta(lvlRanching(5))).

updateTime :-
    (lvlRanching(1)) -> (retract(timeToExploit(_)), asserta(timeToExploit(5)));
    (lvlRanching(2)) -> (retract(timeToExploit(_)), asserta(timeToExploit(4)));
    (lvlRanching(3)) -> (retract(timeToExploit(_)), asserta(timeToExploit(3)));
    (lvlRanching(4)) -> (retract(timeToExploit(_)), asserta(timeToExploit(2)));
    (lvlRanching(5)) -> (retract(timeToExploit(_)), asserta(timeToExploit(1))).

% [Nunggu mekanisme hours]
% updateColl :-
%     collOfRanchItem(Awal1, Awal2, Awal3),

% addSomething(N): Menambahkan Something sejumlah N ke inventory dan mengurangi collOfRanchItem
addChicken(N) :-
	retract(item(10,chicken,X,0,750,0)), NewX is X+N, asserta(item(10,chicken,NewX,0,750,0)).
addCow(N) :-
	retract(item(11,cow,X,0,1500,0)), NewX is X+N, asserta(item(11,cow,0,0,1500,0)).
addSheep(N) :-
	retract(item(12,sheep,X,0,2000,0)), NewX is X+N, asserta(item(12,sheep,NewX,0,2000,0)).
addEgg(N) :-
    collOfRanchItem(Amount1, Amount2, Amount3),
    N is Amount1,
    retract(collOfRanchItem(_,_,_)), asserta(collOfRanchItem(0, Amount2, Amount3)),
	retract(item(13,egg,X,100,0,0)), NewX is X+N, asserta(item(13,egg,NewX,100,0,0)),
    exp(egg, Val),
    expRanching(Before),
    retract(expRanching(_)), asserta(expRanching(Before + (Val * N))).
    % [Nanti nambah exp player juga di sini]
addMilk(N) :-
    collOfRanchItem(Amount1, Amount2, Amount3),
    N is Amount2,
    retract(collOfRanchItem(_,_,_)), asserta(collOfRanchItem(Amount1, 0, Amount3)),
	retract(item(14,milk,X,400,0,0)), NewX is X+N, asserta(item(14,milk,NewX,400,0,0)),
    exp(milk, Val),
    expRanching(Before),
    retract(expRanching(_)), asserta(expRanching(Before + (Val * N))).
    % [Nanti nambah exp player juga di sini]
addWool(N) :-
    collOfRanchItem(Amount1, Amount2, Amount3),
    N is Amount3,
    retract(collOfRanchItem(_,_,_)), asserta(collOfRanchItem(Amount1, Amount2, 0)),
	retract(item(15,wool,0,750,0,0)), NewX is X+N, asserta(item(15,wool,NewX,750,0,0)),
    exp(wool, Val),
    expRanching(Before),
    retract(expRanching(_)), asserta(expRanching(Before + (Val * N))).
    % [Nanti nambah exp player juga di sini]