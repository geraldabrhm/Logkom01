* Farming */
/* Farming actions */
:- dynamic(harvestTile/3).
questFarmRandomizer(A,B) :- 
    crops_list(X),
    random(0,8,Idx),
    select_nth(X,Idx,A),
    random(1,4,B),!.
.
dig :-
    player(X,Y),

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
            asserta(place('j',X,Y));
        PilihBenih == 2 ->
            NewB is B - 1,
            throwItem(8,NewY)
            retract(place('=',X,Y)),
            asserta(place('k',X,Y));
        PilihBenih == 3 ->
            NewC is C - 1
            throwItem(9,NewC),
            retract(place('=',X,Y)),
            asserta(place('t',X,Y)),
    )
