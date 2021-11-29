:- dynamic(player/2).

player(7,6).

%toGetWalk buat ngelarang pemain ke tile tertentu
toGetWalk(X,Y):- \+tile_water(X,Y),\+isWallTile(X,Y),\+place('Q',X,Y), \+place('R',X,Y), \+place('H',X,Y), \+place('M',X,Y).

%handling masuk air

w :- player(X,Y),W is Y-1,
	(
		toGetWalk(X,W) ->
			retract(player(X,Y)),assertz(player(X,W));
		tile_water(X,W) -> 
			write('Hati Hati Bos ada air!'),nl;
		isWallTile(X,W) ->
			write('Ada Tembok Bos!'),nl;
		place('Q',X,W) ->
			retract(player(X,Y)),assertz(player(X,W)),
			write('Ketik "quest" untuk Mendapatkan quest baru'),nl;
		place('R',X,W) ->
			retract(player(X,Y)),assertz(player(X,W)),
			write('Ketik "ranch" untuk masuk ke dalam peternakan'),nl;
		place('H',X,W) ->
			retract(player(X,Y)),assertz(player(X,W)),
			write('Ketik "sleep" untuk beristirahat'),nl;
		place('M',X,W) ->
			retract(player(X,Y)),assertz(player(X,W)),
			write('Ketik "market" untuk melakukan jual beli'),nl
	),addHour(1),map.
s :- player(X,Y),S is Y+1,
	(
		toGetWalk(X,S) ->
			retract(player(X,Y)),assertz(player(X,S));
		tile_water(X,S) -> 
			write('Hati Hati Bos ada air!'),nl;
		isWallTile(X,S) ->
			write('Ada Tembok Bos!'),nl;
		place('Q',X,S) ->
			retract(player(X,Y)),assertz(player(X,S)),
			write('Ketik "quest" untuk Mendapatkan quest baru'),nl;
		place('R',X,S) ->
			retract(player(X,Y)),assertz(player(X,S)),
			write('Ketik "ranch" untuk masuk ke dalam peternakan'),nl;
		place('H',X,S) ->
			retract(player(X,Y)),assertz(player(X,S)),
			write('Ketik "sleep" untuk beristirahat'),nl;
		place('M',X,S) ->
			retract(player(X,Y)),assertz(player(X,S)),
			write('Ketik "market" untuk melakukan jual beli'),nl
	),addHour(1),map.
a :- player(X,Y),A is X-1,
	(
		toGetWalk(A,Y) ->
			retract(player(X,Y)),assertz(player(A,Y));
		tile_water(A,Y) -> 
			write('Hati Hati Bos ada air!'),nl;
		isWallTile(A,Y) ->
			write('Ada Tembok Bos!'),nl;
		place('Q',A,Y) ->
			retract(player(X,Y)),assertz(player(A,Y)),
			write('Ketik "quest" untuk Mendapatkan quest baru'),nl;
		place('R',A,Y) ->
			retract(player(X,Y)),assertz(player(A,Y)),
			write('Ketik "ranch" untuk masuk ke dalam peternakan'),nl;
		place('H',A,Y) ->
			retract(player(X,Y)),assertz(player(A,Y)),
			write('Ketik "sleep" untuk beristirahat'),nl;
		place('M',A,Y) ->
			retract(player(X,Y)),assertz(player(A,Y)),
			write('Ketik "market" untuk melakukan jual beli'),nl
	),addHour(1),map.
d :- player(X,Y),D is X+1,
	(
		toGetWalk(D,Y) ->
			retract(player(X,Y)),assertz(player(D,Y));
		tile_water(D,Y) -> 
			write('Hati Hati Bos ada air!'),nl;
		isWallTile(D,Y) ->
			write('Ada Tembok Bos!'),nl;
		place('Q',D,Y) ->
			retract(player(X,Y)),assertz(player(D,Y)),
			write('Ketik "quest" untuk Mendapatkan quest baru'),nl;
		place('R',D,Y) ->
			retract(player(X,Y)),assertz(player(D,Y)),
			write('Ketik "ranch" untuk masuk ke dalam peternakan'),nl;
		place('H',D,Y) ->
			retract(player(X,Y)),assertz(player(D,Y)),
			write('Ketik "sleep" untuk beristirahat'),nl;
		place('M',D,Y) ->
			retract(player(X,Y)),assertz(player(D,Y)),
			write('Ketik "market" untuk melakukan jual beli'),nl
	),addHour(1),map.
