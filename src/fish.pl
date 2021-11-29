% Cek posisi player
isCanFish :- 
	player(X,Y), W is Y-1, tile_water(X,W), !;
	player(X,Y), S is Y+1, tile_water(X,S), !;
	player(X,Y), A is X-1, tile_water(A,Y), !;
	player(X,Y), D is X+1, tile_water(D,Y).

% Belum add EXP
addCatfish :-
	addItem(1,1).
addSalmon :-
	addItem(2,1).
addTuna :-
	addItem(3,1).

% Kondisi Fishing tiap level
fish1 :- 
	random(1,101,N),
	(	N > 0, N =< 50 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 10 xp bos!'), nl;
		N > 50, N =< 100 -> write('Selamat bos! dapet lele'), nl, write('Dapet 20 xp bos!'), nl, addCatfish
	).
fish2 :-
	random(1,101,N),
	(	N > 0, N =< 45 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 10 xp bos!'), nl;
		N > 45, N =< 85 -> write('Selamat bos! dapet lele'), nl, write('Dapet 20 xp bos!'), nl, addCatfish;
		N > 85, N =< 100 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 35 xp bos!'), nl, addSalmon
	).
fish3 :-
	random(1,101,N),
	(	N > 0, N =< 40 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 10 xp bos!'), nl;
		N > 40, N =< 80 -> write('Selamat bos! dapet lele'), nl, write('Dapet 20 xp bos!'), nl, addCatfish;
		N > 80, N =< 100 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 35 xp bos!'), nl, addSalmon
	).
fish4 :-
	random(1,101,N),
	(	N > 0, N =< 30 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 10 xp bos!'), nl;
		N > 30, N =< 70 -> write('Selamat bos! dapet lele'), nl, write('Dapet 20 xp bos!'), nl, addCatfish;
		N > 70, N =< 95 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 35 xp bos!'), nl, addSalmon;
		N > 95, N =< 100 -> write('Selamat bos! dapet tuna'), nl, write('Dapet 50 xp bos!'), nl, addTuna
	).
fish5 :-
	random(1,101,N),
	(	N > 0, N =< 25 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 10 xp bos!'), nl;
		N > 25, N =< 65 -> write('Selamat bos! dapet lele'), nl, write('Dapet 20 xp bos!'), nl, addCatfish;
		N > 65, N =< 90 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 35 xp bos!'), nl, addSalmon;
		N > 90, N =< 100 -> write('Selamat bos! dapet tuna'), nl, write('Dapet 50 xp bos!'), nl, addTuna
	).

% Main fish (belum add waktu)
fish :-
	isCanFish, !,
	NotLateNight, !,
	level(X),
	(	X == 1 -> fish1;
		X == 2 -> fish2;
		X == 3 -> fish3;
		X == 4 -> fish4;
		X == 5 -> fish5
	).

fish :- write('Nggak ada air bos!'), nl.