/* belum handle moving object (dig tile, player) */
:- dynamic(player/2).

player(7,6).

place('H',7,6).
place('Q',7,3).
place('F',11,4).
place('R',10,5).
place('M',10,12).
tile_water(5,8).
tile_water(6,8).
tile_water(7,8).
tile_water(4,9).
tile_water(5,9).
tile_water(6,9).
tile_water(7,9).
tile_water(8,9).
tile_water(5,10).
tile_water(6,10).
tile_water(7,10).
map_size(14,17).

% MAP
% RIGHT BORDER
draw_point(X, Y) :- map_size(W, H),
					X =:= W + 1,
					Y =< H + 1,
					write('# '), nl,
					NewY is Y+1,
					draw_point(0, NewY).
% LEFT BORDER	
draw_point(X, Y) :- map_size(_, H),
					X =:= 0,
					Y =< H+1,
					write('# '),
					NewX is X+1,
					draw_point(NewX, Y).
% TOP BORDER			
draw_point(X, Y) :- map_size(W, _),
					X < W + 1,
					X > 0,
					Y =:= 0,
					write('# '),
					NewX is X+1,
					draw_point(NewX, Y).
% BOTTOM BORDER								
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y =:= H + 1,
					write('# '),
					NewX is X+1,
					draw_point(NewX, Y).					
% MAP INSIDE
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					player(X,Y), !,
					write('P'),
					write(' '),
					NewX is X+1,
					draw_point(NewX, Y).					
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					place(Obj, X, Y), !,
					write(Obj),
					write(' '),
					NewX is X+1,
					draw_point(NewX, Y).
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					tile_water(X,Y), !,
					write('o '),
					NewX is X+1,
					draw_point(NewX, Y).
% EMPTY TILE					
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					(\+ player(X, Y)),
					(\+ place(_, X, Y)),
					(\+ tile_water(X, Y)),
					write('- '),
					NewX is X+1,
					draw_point(NewX, Y).

map :- draw_point(0, 0).

% MOVE
% Baru handle pager, belum tile_water.
w :- player(X,Y), W is Y-1, W > 0, !, retract(player(X,Y)), assertz(player(X,W)); write('Move gagal!').
s :- player(X,Y), map_size(_,B), S is Y+1, S =< B, !, retract(player(X,Y)), assertz(player(X,S)); write('Move gagal!').
a :- player(X,Y), A is X-1, A > 0, !, retract(player(X,Y)), assertz(player(A,Y)); write('Move gagal!').
d :- player(X,Y), map_size(A,_), D is X+1, D =< A, !, retract(player(X,Y)), assertz(player(D,Y)); write('Move gagal!').