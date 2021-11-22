/* belum handle moving object (dig tile, player) */
:- dynamic(player/2).

player(1,2).

place('H',1,2).
place('R',3,6).
place('M',8,8).
mapSizeX(8).
mapSizeY(8).

contentMap(X,Y) :- player(X,Y), write('P'), !; place(A,X,Y), write(A), !; write('-').
drawContent(1,0) :- !.
drawContent(X,0) :- mapSizeY(B), nl, P is X-1, drawContent(P,B), !.
drawContent(X,Y) :- mapSizeX(A), mapSizeY(B), P is (A-X+1), Q is (B-Y+1), contentMap(P,Q), Z is Y-1, drawContent(X,Z).
map :- mapSizeX(A), mapSizeY(B), drawContent(A,B).

w :- player(X,Y), W is X-1, W > 0, !, retract(player(X,Y)), assertz(player(W,Y)); write('Move gagal!').
s :- player(X,Y), mapSizeX(A), S is X+1, S =< A, !, retract(player(X,Y)), assertz(player(S,Y)); write('Move gagal!').
a :- player(X,Y), A is Y-1, A > 0, !, retract(player(X,Y)), assertz(player(X,A)); write('Move gagal!').
d :- player(X,Y), mapSizeY(B), D is Y+1, D =< B, !, retract(player(X,Y)), assertz(player(X,D)); write('Move gagal!').