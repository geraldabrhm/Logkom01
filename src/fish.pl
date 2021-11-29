% Cek posisi player
isCanFish :- 
	player(X,Y), W is Y-1, tile_water(X,W), !;
	player(X,Y), S is Y+1, tile_water(X,S), !;
	player(X,Y), A is X-1, tile_water(A,Y), !;
	player(X,Y), D is X+1, tile_water(D,Y).

addCatfish :-
	addItem(1,1).
addSalmon :-
	addItem(2,1).
addTuna :-
	addItem(3,1).

% Kondisi Fishing tiap level
fish1 :-
	specialty(fisherman), !,
	random(1,101,N),
	(	N > 0, N =< 50 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 20 xp bos!'), nl, addExpFishing(20);
		N > 50, N =< 100 -> write('Selamat bos! dapet lele'), nl, write('Dapet 40 xp bos!'), nl, addCatfish, addExpFishing(40), updateQuestFish(1)
	).
fish1 :-
	random(1,101,N),
	(	N > 0, N =< 50 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 10 xp bos!'), nl, addExpFishing(10);
		N > 50, N =< 100 -> write('Selamat bos! dapet lele'), nl, write('Dapet 20 xp bos!'), nl, addCatfish, addExpFishing(20), updateQuestFish(1)
	).

fish2 :-
	specialty(fisherman), !,
	random(1,101,N),
	(	N > 0, N =< 45 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 20 xp bos!'), nl, addExpFishing(20);
		N > 45, N =< 85 -> write('Selamat bos! dapet lele'), nl, write('Dapet 40 xp bos!'), nl, addCatfish, addExpFishing(40), updateQuestFish(1);
		N > 85, N =< 100 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 70 xp bos!'), nl, addSalmon, addExpFishing(70), updateQuestFish(1)
	).
fish2 :-
	random(1,101,N),
	(	N > 0, N =< 45 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 10 xp bos!'), nl, addExpFishing(10);
		N > 45, N =< 85 -> write('Selamat bos! dapet lele'), nl, write('Dapet 20 xp bos!'), nl, addCatfish, addExpFishing(20), updateQuestFish(1);
		N > 85, N =< 100 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 35 xp bos!'), nl, addSalmon, addExpFishing(35), updateQuestFish(1)
	).

fish3 :-
	specialty(fisherman), !,
	random(1,101,N),
	(	N > 0, N =< 40 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 20 xp bos!'), nl, addExpFishing(20);
		N > 40, N =< 80 -> write('Selamat bos! dapet lele'), nl, write('Dapet 40 xp bos!'), nl, addCatfish, addExpFishing(40), updateQuestFish(1);
		N > 80, N =< 100 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 70 xp bos!'), nl, addSalmon, addExpFishing(70), updateQuestFish(1)
	).
fish3 :-
	random(1,101,N),
	(	N > 0, N =< 40 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 10 xp bos!'), nl, addExpFishing(10);
		N > 40, N =< 80 -> write('Selamat bos! dapet lele'), nl, write('Dapet 20 xp bos!'), nl, addCatfish, addExpFishing(20), updateQuestFish(1);
		N > 80, N =< 100 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 35 xp bos!'), nl, addSalmon, addExpFishing(35), updateQuestFish(1)
	).

fish4 :-
	specialty(fisherman), !,
	random(1,101,N),
	(	N > 0, N =< 30 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 20 xp bos!'), nl, addExpFishing(20);
		N > 30, N =< 70 -> write('Selamat bos! dapet lele'), nl, write('Dapet 40 xp bos!'), nl, addCatfish, addExpFishing(40), updateQuestFish(1);
		N > 70, N =< 95 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 70 xp bos!'), nl, addSalmon, addExpFishing(70), updateQuestFish(1);
		N > 95, N =< 100 -> write('Selamat bos! dapet tuna'), nl, write('Dapet 100 xp bos!'), nl, addTuna, addExpFishing(100), updateQuestFish(1)
	).
fish4 :-
	random(1,101,N),
	(	N > 0, N =< 30 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 10 xp bos!'), nl, addExpFishing(10);
		N > 30, N =< 70 -> write('Selamat bos! dapet lele'), nl, write('Dapet 20 xp bos!'), nl, addCatfish, addExpFishing(20), updateQuestFish(1);
		N > 70, N =< 95 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 35 xp bos!'), nl, addSalmon, addExpFishing(35), updateQuestFish(1);
		N > 95, N =< 100 -> write('Selamat bos! dapet tuna'), nl, write('Dapet 50 xp bos!'), nl, addTuna, addExpFishing(50), updateQuestFish(1)
	).

fish5 :-
	specialty(fisherman), !,
	random(1,101,N),
	(	N > 0, N =< 25 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 20 xp bos!'), nl, addExpFishing(20);
		N > 25, N =< 65 -> write('Selamat bos! dapet lele'), nl, write('Dapet 40 xp bos!'), nl, addCatfish, addExpFishing(40), updateQuestFish(1);
		N > 65, N =< 90 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 70 xp bos!'), nl, addSalmon, addExpFishing(70), updateQuestFish(1);
		N > 90, N =< 100 -> write('Selamat bos! dapet tuna'), nl, write('Dapet 100 xp bos!'), nl, addTuna, addExpFishing(100), updateQuestFish(1)
	).
fish5 :-
	random(1,101,N),
	(	N > 0, N =< 25 -> write('Gadapet apa-apa bos!'), nl, write('Dapet 10 xp bos!'), nl, addExpFishing(10);
		N > 25, N =< 65 -> write('Selamat bos! dapet lele'), nl, write('Dapet 20 xp bos!'), nl, addCatfish, addExpFishing(20), updateQuestFish(1);
		N > 65, N =< 90 -> write('Selamat bos! dapet salmon'), nl, write('Dapet 35 xp bos!'), nl, addSalmon, addExpFishing(35), updateQuestFish(1);
		N > 90, N =< 100 -> write('Selamat bos! dapet tuna'), nl, write('Dapet 50 xp bos!'), nl, addTuna, addExpFishing(50), updateQuestFish(1)
	).

fish :- lateNight, !, write('Udah malem bos, waktunya tidur!'), nl.

fish :-
	isCanFish, !,
	lvlFishing(X),
	(	X == 1 -> fish1;
		X == 2 -> fish2;
		X == 3 -> fish3;
		X == 4 -> fish4;
		X == 5 -> fish5
	),inven(17,_,_,_,_,Y),
	(	Y == 1 -> addHour(3);
		Y == 2 -> addHour(2);
		Y == 3 -> addHour(1)
	).

fish :- write('Nggak ada air bos!'), nl.