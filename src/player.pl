:- dynamic(lvlRanching/1).
:- dynamic(lvlFishing/1).
:- dynamic(lvlFarming/1).
:- dynamic(expRanching/1).
:- dynamic(expFishing/1).
:- dynamic(expFarming/1).

% inisiasi level
lvlRanching(1).
lvlFishing(1).
lvlFarming(1).

% inisiasi exp
expRanching(0).
expFishing(0).
expFarming(0).

% Level up Ranching
lvlRanching(2) :-
    lvlRanching(1),
    expRanching(X),
    X >= 300,
    resetExpRanching.

lvlRanching(3) :-
    lvlRanching(2),
    expRanching(X),
    X >= 500,
    resetExpRanching.  

lvlRanching(4) :-
    lvlRanching(3),
    expRanching(X),
    X >= 1000,
    resetExpRanching.  

lvlRanching(5) :-
    lvlRanching(4),
    expRanching(X),
    X >= 1500,
    resetExpRanching. 

% Level up Fishing
lvlFishing(2) :-
    lvlFishing(1),
    expFishing(X),
    X >= 300,
    resetExpFishing.

lvlFishing(3) :-
    lvlFishing(2),
    expFishing(X),
    X >= 500,
    resetExpFishing.  

lvlFishing(4) :-
    lvlFishing(3),
    expFishing(X),
    X >= 1000,
    resetExpFishing.  

lvlFishing(5) :-
    lvlFishing(4),
    expFishing(X),
    X >= 1500,
    resetExpFishing.  

% Level up Farming
lvlFarming(2) :-
    lvlFarming(1),
    expFarming(X),
    X >= 300,
    resetExpFarming.

lvlFarming(3) :-
    lvlFarming(2),
    expFarming(X),
    X >= 500,
    resetExpFarming.  

lvlFarming(4) :-
    lvlFarming(3),
    expFarming(X),
    X >= 1000,
    resetExpFarming.  

lvlFarming(5) :-
    lvlFarming(4),
    expFarming(X),
    X >= 1500,
    resetExpFarming.

% reset exp
expRanching(0) :-
    resetExpRanching.

expFishing(0) :-
    resetExpFishing.

expFarming(0) :-
    resetExpFarming.

% add exp
expRanching(X) :-
    addExpRanching(Y),
    expRanching(X1)
    X is X1 + Y.

expFishing(X) :-
    addExpFishing(Y),
    expFishing(X1)
    X is X1 + Y.

expFarming(0) :-
    addExpFarming(Y),
    expFarming(X1)
    X is X1 + Y.

addExpRanching(Y) :-
addExpFishing(Y) :-
addExpFarming(Y) :-

status :- 
    lvlFarming(A),
    lvlFishing(B),
    lvlRanching(C),
    expFarming(D),
    expFishing(E),
    expRanching(F),
    playerMoney(G),
    specialty(H),
    write('Your status : '), nl
    write('Job : '), write(H), nl
    write('Level Farming : '), write(A), nl
    write('Exp Farming : '), write(D), nl
    write('Level Fishing : '), write(B), nl
    write('Exp Fishing : '), write(E), nl
    write('Level Ranching : '), write(C), nl
    write('Exp Ranching : '), write(F), nl
    write('Gold : '), write(G), nl

