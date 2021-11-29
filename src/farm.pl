/* Farming */
/* Farming actions */
/* fakta buat list udah nge plant apa aja ('J',durasi,x,y) durasi dalam jam*/
:- dynamic(plantTile/4).

dig :-
    player(X,Y),
    isRawTile(X,Y), !,
    asserta(place('=',X,Y)),
    write('Anda berhasil menggali pada petak ini'),nl.
dig :-
    write('Salah tempat buat gali Bos'),nl.

plant:-
    player(X,Y),
    place('=',X,Y),!,
    inven(_,cornSeed,A,_,_,_),inven(_,potatoSeed,B,_,_,_),inven(_,tomatoSeed,C,_,_,_),
    write('Anda memiliki benih : '),nl,
    write('1. '),write(A),write(' corn seed'),nl,
    write('2. '),write(B),write(' potato seed'),nl,
    write('3. '),write(C),write(' tomato seed'),nl,
    write('Pilihan berdasarkan angka : '),write(PilihBenih),nl,
    (
        PilihBenih == 1 -> 
            NewA is A - 1,
            throwItem(7,NewA),
            retract(place('=',X,Y)),
            asserta(place('j',X,Y)),
            asserta(plantTile('J',3,X,Y));
        PilihBenih == 2 ->
            NewB is B - 1,
            throwItem(8,NewY)
            retract(place('=',X,Y)),
            asserta(place('k',X,Y)),
            asserta(plantTile('K',4,X,Y));
        PilihBenih == 3 ->
            NewC is C - 1,
            throwItem(9,NewC),
            retract(place('=',X,Y)),
            asserta(place('t',X,Y)),
            asserta(plantTile('T',2,X,Y))
    ).
plant:-
    write('Kalau mau nanem gali dulu ya!'),nl.

harvest :-
    player(X,Y),
    plantTile(H,N,X,Y), N =< 0, !,
    lvlFarming(L),
    (   L == 1 -> random(1,11,)
        (   H == 'J' -> addItem(4,1), updateQuestFarming(1), retract(planTile(H,N,X,Y)), retract(place(_,X,Y));
            H == 'K' -> addItem(5,1), updateQuestFarming(1), retract(planTile(H,N,X,Y)), retract(place(_,X,Y));
            H == 'T' -> addItem(6,1), updateQuestFarming(1), retract(planTile(H,N,X,Y)), retract(place(_,X,Y))
        )
    ).
    
harvest :-
    write('Ga ada yang bisa dipanen bos!'),nl.

mapHarvest(X,Y) :- map_size(W,H),
    X < W + 1,
    X > 0,
    Y < H + 1,
    Y > 0,
    plantTile(Nama,Durasi,X,Y),!,
    NewDurasi is Durasi - 1,
    retract(Nama,Durasi,X,Y),
    asserta(Nama,NewDurasi,X,Y).
    NewX is X+1,
    mapHarvest(NewX, Y).
mapHarvest(X,Y) :- map_size(W, H),
     X =:= W + 1,
     Y =< H + 1,
     NewY is Y+1,
     mapHarvest(0, NewY).