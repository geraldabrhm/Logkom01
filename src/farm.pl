/* Farming */

:- dynamic(item/6).
:- dynamic(inven//6).
:- dynamic(tool/7).

/* Farming actions */
% list ID item seed
seed_list([e10,e11,e12,e13,e14,e15,e16,e17,e18]).
planted_list([]).

% mengecek apakah kooordinat X,Y adalah tile soid/seed/plant
% soilTile(X, Y)
% seedTile(X, Y, IDSeed,  Time remaining to harvest)
% plantTile(X, Y, IDSeed)

isSoilTile(X,Y) :- soilTile(X,Y).
isSeedTile(X,Y) :- seedTile(X,Y,_,_).
isPlantTile(X,Y) :- plantTile(X,Y,_).

% print semua seed yang ada di inventory

is_in_seed(X, [X|_],0):- !.
is_in_seed(X, [_|T],Index) :- is_in_seed(X,T,Index1), Index is Index1 + 1.

is_not_in_inventory :- inventory(CurrentInventory),
    traverse_search(CurrentInventory),!.

traverse_search([]) :- !.
traverse_search([[A,B]|T]) :-
    seed_list(Seed),
    is_in_seed(A,Seed,_),!,fail.

traverse_search([[A,B]|T]) :-
    seed_list(Seed),
    \+is_in_seed(A,Seed,_),
    traverse_search(T).

search_seed([]) :-!.
search_seed([Head|Tail]) :- inventory(CurrentInventory), 
    \+is_member(Head,CurrentInventory,Index),
    search_seed(Tail).

search_seed([Head|Tail]) :- inventory(CurrentInventory), 
    is_member(Head,CurrentInventory,Index),
    seed(ID,_,Nama,_,_,_),
    select_nth(CurrentInventory,Index,[ID,Amount]),
    write(ID),write('. '), write(Nama), write(' : '), write(Amount), write(' X'),nl,
    search_seed(Tail).

print_Seed :- seed_list(X),search_seed(X),!.

plant :- runProgram(_),
    posisi(X,Y),
    \+isSoilTile(X,Y),
    write('-------------- \33\[38;5;76mTanah ini belum di gali! kamu harus menggalinya dulu dengan command dig\33\[0m -------------- '),nl,!.

plant :- runProgram(_),
    posisi(X,Y),
    isSoilTile(X,Y),
    is_not_in_inventory,
    write('-------------- \33\[38;5;202mKamu tidak punya bibit di inventory !\33\[0m -------------- '),nl,!.

plant :- runProgram(_),
    posisi(X,Y),
    isSoilTile(X,Y),
    inventory(CurrentInventory),
    write('\33\[38;5;220mDi Inventory Kamu punya :\33\[0m'),nl,
    print_Seed,nl,
    write('Apa yang ingin kamu tanam ? ( masukan id )'),nl,
    read(Input),
    (
        (
            is_member(Input,CurrentInventory,Index),
            seed(Input,U,Nama,W,H,M),
            time(_,_,Season,Musim,_),
            (
                (
                    Season =:= M,
                    select_nth(CurrentInventory,Index,[ID,N]),
                    N1 is N - 1,
                    set_nth(CurrentInventory,Index,[ID,N1],NewInventory),
                    write('-------------- \33\[38;5;76mKamu telah menanam : \33\[0m'),write(Nama),write(' --------------'),nl,
                    w, 
                    planted_list(PL),
                    insert_last([X,Y],PL,NewPL),
                    updateStat,
                    retract(planted_list(PL)),
                    retract(soilTile(X,Y)),
                    retract(inventory(CurrentInventory)),
                    asserta(planted_list(NewPL)),
                    assertz(inventory(NewInventory)),
                    assertz(seedTile(X,Y,Input,W))
                );
                (
                    Season =\= M,
                    write('-------------- \33\[38;5;202mKamu tidak bisa menanam '),write(Nama),write(' di Musim '),write(Musim),write(' \33\[0m--------------'),nl
                )
            )
        );
        (
            \+is_member(Input,CurrentInventory,Index),
            seed(Input,U,Nama,W,H,M),
            \+is_in_seed(Input,CurrentInventory,_),
            write('-------------- \33\[38;5;202mBibit tersebut tidak ada di inventory  : \33\[0m'),write(Nama),write(' --------------'),nl
        )
    ),
    !.
    


dig :- runProgram(_),
    inventory(CurrentInventory),
    is_member(i1,CurrentInventory,Index),
    posisi(X,Y),
    cekArea(X,Y),
    asserta(soilTile(X,Y)),
    updateStat,
    write('-------------- \33\[38;5;76mKamu menggali tanah ini !\33\[0m --------------'),nl, 
    w,!.

dig :- runProgram(_),
    inventory(CurrentInventory),
    \+is_member(i1,CurrentInventory,Index),
    write('-------------- \33\[38;5;202mKamu belum punya item Pick di inventory untuk menggali, kamu bisa membelinya di Market !\33\[0m --------------'),nl,!.

harvest :- runProgram(_),
    posisi(X,Y),
    plantTile(X,Y,ID),
    crops(ID,_,U,Nama,_,_),
    inventory(CurrentInventory),
    (
        (
            \+is_member(i2,CurrentInventory,Index),
            insert_item(ID,1),
            getHarvestExpGold(ID,EXP,GOLD),
            kegiatan(K), K1 is K + 1,
            energi(E), E1 is E-1, 
            player(A,B,C,D,E2,F,G,H,I,J,K2,L,M),
            D1 is D + EXP,
            L1 is L + EXP,
            write('-------------- \33\[38;5;76mKamu memanen : '), write(Nama), write(' '), write(U), write(' 1 X'),write('\33\[0m --------------'),nl,
            write('-------------- \33\[38;5;111m+\33\[0m '), write(EXP), write(' \33\[38;5;111mExp\33\[0m --------------'),nl,
            asserta(player(A,B,C,D1,E2,F,G,H,I,J,K2,L1,M)),
            asserta(kegiatan(K1)),
            asserta(energi(E1)),
            retract(kegiatan(K)),
            retract(energi(E)),
            retract(player(_,_,_,D,_,_,_,_,_,_,_,L,_)),
            retract(plantTile(X,Y,ID)),!,
            levelUp,updateStat
        );
        (
            is_member(i2,CurrentInventory,Index),
            tool(i2,T1,T2,T3,LV,EHarvest,T4),
            N is 1 + LV,
            insert_item(ID,N),
            getHarvestExpGold(ID,EXP,GOLD),
            kegiatan(K), K1 is K + 1,
            energi(E), E1 is E-1, 
            player(A,B,C,D,E2,F,G,H,I,J,K2,L,M),
            D1 is D + (EXP * N),
            L1 is L + (EXP * N),
            EHarvest1 is EHarvest + 50,
            levelUpHarvester,
            NEXP is EXP * N,
            write('-------------- \33\[38;5;76mKamu memanen : '), write(Nama), write(' '), write(U),write(' '),write(N), write(' X'),write('\33\[0m --------------'),nl,
            write('-------------- \33\[38;5;111m+\33\[0m '), write(NEXP), write(' \33\[38;5;111mExp\33\[0m --------------'),nl,
            asserta(player(A,B,C,D1,E2,F,G,H,I,J,K2,L1,M)),
            asserta(kegiatan(K1)),
            asserta(energi(E1)),
            asserta(tool(i2,T1,T2,T3,LV,EHarvest1,T4)),
            asserta(tool(i2,_,_,_,LV,EHarvest,_)),
            retract(kegiatan(K)),
            retract(energi(E)),
            retract(player(_,_,_,D,_,_,_,_,_,_,_,L,_)),
            retract(plantTile(X,Y,ID)),!,
            levelUp,updateStat
        )
    ).

harvest :-
    posisi(X,Y),
    seedTile(X,Y,ID,T),
    seed(ID,U,N,_,_,_),
    write('-------------- \33\[38;5;202m'),write(N),write(' '),write(U),write(' belum dapat dipanen !\33\[0m'),
    write(' -------------- '),nl,
    write('-------------- \33\[38;5;202m'),write('Sisa hari sampai dapat dipanen : \33\[0m'),write(T),write(' -------------- '),nl,!.

harvest :-
    posisi(X,Y),
    \+seedTile(X,Y,_,_),
    \+plantTile(X,Y,_),
    write('-------------- \33\[38;5;202mTidak ada crops di lokasi ini \33\[0m'),nl,!.

/* Update waktu sisa seed sampai siap panen */
/* dipake di ganti time */

update_seed_tile([]).

update_seed_tile([[X,Y]|Tail]) :- 
    \+seedTile(X,Y,Head,W),
    update_seed_tile(Tail).

update_seed_tile([[X,Y]|Tail]) :- 
    seedTile(X,Y,Head,W),
    W > 1,
    W1 is W - 1,
    asserta(seedTile(X,Y,Head,W1)),
    retract(seedTile(X,Y,Head,W)),
    update_seed_tile(Tail).

update_seed_tile([[X,Y]|Tail]) :- 
    seedTile(X,Y,Head,W),
    W = 1,
    crops(ID,Head,_,_,_,_),
    planted_list(PL),
    is_member_XY([X,Y],PL,Idx),
    delete_at_n(Idx,PL,NPL),
    asserta(planted_list(NPL)),
    asserta(plantTile(X,Y,ID)),
    retract(seedTile(X,Y,Head,W)),
    retract(planted_list(PL)),
    update_seed_tile(Tail).

updateSeed :-
    planted_list(X),
    update_seed_tile(X), !.

levelUpHarvester :- 
    tool(i2,_,_,_,LV,Exp,Base),
    Exp >= Base,
    LV1 is LV + 1,
    BaseNew is Base + 100,
    ExpNew is Exp mod Base,
    retract(tool(i2,_,_,_,LV,Exp,Base)),
    asserta(tool(i2,_,_,_,LV1,ExpNew,Base)), !.

levelUpHarvester :- 
    tool(i2,_,_,_,LV,Exp,Base),
    Exp < Base,!.

crops_list([e1,e2,e3,e4,e5,e6,e7,e8,e9]).

questFarmRandomizer(A,B) :- 
    crops_list(X),
    random(0,8,Idx),
    select_nth(X,Idx,A),
    random(1,4,B),!.
