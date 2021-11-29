:- dynamic(lvlRanching/1).
:- dynamic(lvlFishing/1).
:- dynamic(lvlFarming/1).
:- dynamic(expRanching/1).
:- dynamic(expFishing/1).
:- dynamic(expFarming/1).
:- dynamic(lvlGeneral/1).
:- dynamic(expGeneral/1).

% inisiasi level
lvlGeneral(1).
lvlRanching(1).
lvlFishing(1).
lvlFarming(1).

% inisiasi exp
expGeneral(0).
expRanching(0).
expFishing(0).
expFarming(0).

% add exp
addExpRanching(Y) :-
    lvlRanching(A),
    expRanching(X1),
    X is X1 + Y,
    addExpGeneral(Y),
    retract(expRanching(X1)),
    asserta(expRanching(X)),
    (   X >= 300, A =:= 1 -> retract(lvlRanching(1)), asserta(lvlRanching(2)), resetExpRanching;
        X >= 500, A =:= 2 -> retract(lvlRanching(2)), asserta(lvlRanching(3)), resetExpRanching;
        X >= 1000, A =:= 3 -> retract(lvlRanching(3)), asserta(lvlRanching(4)), resetExpRanching;
        X >= 1500, A =:= 4 -> retract(lvlRanching(4)), asserta(lvlRanching(5)), resetExpRanching;).

addExpFishing(Y) :-
    lvlFishing(A),
    expFishing(X1),
    X is X1 + Y,
    addExpGeneral(Y),
    retract(expFishing(X1)),
    asserta(expFishing(X)),
    (   X >= 300, A =:= 1 -> retract(lvlFishing(1)), asserta(lvlFishing(2)), resetExpFishing;
        X >= 500, A =:= 2 -> retract(lvlFishing(2)), asserta(lvlFishing(3)), resetExpFishing;
        X >= 1000, A =:= 3 -> retract(lvlFishing(3)), asserta(lvlFishing(4)), resetExpFishing;
        X >= 1500, A =:= 4 -> retract(lvlFishing(4)), asserta(lvlFishing(5)), resetExpFishing;).

addExpFarming(Y) :-
    lvlFarming(A),
    expFarming(X1),
    X is X1 + Y,
    addExpGeneral(Y),
    retract(expFishing(X1)),
    asserta(expFishing(X)),
    (   X >= 300, A =:= 1 -> retract(lvlFarming(1)), asserta(lvlFarming(2)), resetExpFarming;
        X >= 500, A =:= 2 -> retract(lvlFarming(2)), asserta(lvlFarming(3)), resetExpFarming;
        X >= 1000, A =:= 3 -> retract(lvlFarming(3)), asserta(lvlFarming(4)), resetExpFarming;
        X >= 1500, A =:= 4 -> retract(lvlFarming(4)), asserta(lvlFarming(5)), resetExpFarming;).

addExpGeneral(Y):-
    lvlGeneral(B1),
    expGeneral(C1),
    C is C1 + Y,
    retract(expGeneral(C1)),
    asserta(expGeneral(C)),
    (C >= 1000 -> retract(lvlGeneral(_)),B is B1 + 1, asserta(lvlGeneral(B)), resetExpGeneral).

% reset exp
resetExpRanching :-
    retract(expRanching(_)),
    asserta(expRanching(0)).

resetExpFishing :-
    retract(expFishing(_)),
    asserta(expFishing(0)).

resetExpFarming :-
    retract(expFarming(_)),
    asserta(expFarming(0)).

resetExpGeneral :-
    retract(expGeneral(_)),
    asserta(expGeneral(0)).    

status :- 
    lvlFarming(A),
    lvlFishing(B),
    lvlRanching(C),
    expFarming(D),
    expFishing(E),
    expRanching(F),
    playerMoney(G),
    specialty(H),
    lvlGeneral(X),
    expGeneral(Y),
    write('Your status : '), nl

    write('Job : '), write(H), nl
    write('Level : '),write(X), nl
    write('Level Farming : '), write(A), nl
    write('Exp Farming : '), write(D), nl
    write('Level Fishing : '), write(B), nl
    write('Exp Fishing : '), write(E), nl
    write('Level Ranching : '), write(C), nl
    write('Exp Ranching : '), write(F), nl
    write('Gold : '), write(G), nl
    write('Exp : '), write(Y), write('/1000'), nl.

