% Source code program yang minimal berisi:
%     ● Fakta-fakta terkait peta dan pemain
%     ● Implementasi rule-rule kendali dasar start, help ,quit, inventory, dll

:- dynamic(isWallTile/2).

/* Initial Map */
/* M: Marketplace, R: Ranch, H: House, Q: Tempat pengambilan quest, o: Tile air, =: Digged tile */
% ############
% #----Q-----#
% #----------#
% #-------R--#
% #----H-----#
% #-----P----#
% #--ooo-----#
% #-ooooo----#
% #--ooo-----#
% #----------#
% #-------M--#
% ############

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

isWallTile(X,Y):- X=:=0;Y=:=0;X=:=15;Y=:=18. 

% MAP
% RIGHT BORDER
draw_point(X, Y) :- map_size(W, H),
					X =:= W + 1,
					Y =< H + 1,
					write('#'), nl,
					NewY is Y+1,
					draw_point(0, NewY).
% LEFT BORDER	
draw_point(X, Y) :- map_size(_, H),
					X =:= 0,
					Y =< H+1,
					write('#'),
					NewX is X+1,
					draw_point(NewX, Y).
% TOP BORDER			
draw_point(X, Y) :- map_size(W, _),
					X < W + 1,
					X > 0,
					Y =:= 0,
					write('#'),
					NewX is X+1,
					draw_point(NewX, Y).
% BOTTOM BORDER								
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y =:= H + 1,
					write('#'),
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
					NewX is X+1,
					draw_point(NewX, Y).					
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					place(Obj, X, Y), !,
					write(Obj),
					NewX is X+1,
					draw_point(NewX, Y).
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					tile_water(X,Y), !,
					write('o'),
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
					write('-'),
					NewX is X+1,
					draw_point(NewX, Y).

map :- draw_point(0,0).