:-dynamic(haveQuest/1).
:-dynamic(listQuest/2).


haveQuest(no).
listQuest(ranching,0).
listQuest(fishing,0).
listQuest(harvesting,0).


takeQuest:- 
    write('Mau bantuin gaaakkk :( ? '),nl,
    retract(listQuest(ranching,_)),
    retract(listQuest(fishing,_)),
    retract(listQuest(harvesting,_)),
    random(1,11,A),
    random(1,11,B),
    random(1,11,C),
    asserta(listQuest(ranching,A)),
    asserta(listQuest(fishing,B)),
    asserta(listQuest(harvesting,C)),
    retract(haveQuest(no)),
    asserta(haveQuest(yes)).

ranchingQ :- listQuest(ranching,RanchValue),
                (RanchValue > 0 ->
                    write(RanchValue),
                    write(' ranch item'),nl;
                RanchValue < 1 ->
                    write('0 ranch item'),nl
                ).
fishingQ :- listQuest(fishing,FishValue),
                (FishValue > 0 ->
                    write(FishValue),
                    write(' fish'),nl;
                FishValue < 1 ->
                    write('0 fish'),nl
                ).
harvestingQ :- listQuest(harvesting,HarvestValue),
                (HarvestValue > 0 ->
                    write(HarvestValue),
                    write(' harvest item'),nl;
                HarvestValue < 1 ->
                    write('0 harvest item'),nl
                ).

inPlace :- player(X,Y), place('Q',X,Y).

quest :- lateNight, !, write('Udah malem bos, waktunya tidur!'), nl.

quest:-
    inPlace, !,
    haveQuest(Bool),
        (Bool = no -> 
            takeQuest,
            ranchingQ,
            fishingQ,
            harvestingQ;
        Bool = yes ->
            write('Misi yang lain di selesain dulu yaaa SEMANGAT!!!'),nl,
            ranchingQ,
            fishingQ,
            harvestingQ
        ).

quest:- write('Pergi ke tempat Quest dulu bos!'), nl.

onGoing:-
    haveQuest(yes), !,
    ranchingQ,
    fishingQ,
    harvestingQ.

onGoing :- write('Belum ada quest bos!'),nl.

updateQuestRanch(Jumlah):-
    listQuest(ranching,ValueOfRanch),
	ValueOfRanch > 0,
    NewValue is ValueOfRanch - Jumlah,
    (
        NewValue > 0 ->
            write('Quest ranching tersisa '),write(NewValue),write(' Item'),nl,
            retract(listQuest(ranching,_)),asserta(listQuest(ranching,NewValue));
        NewValue =:= 0 ->
            write('Selamat!, quest ranching telah selesai'),nl,
            retract(listQuest(ranching,_)),asserta(listQuest(ranching,0))
    ),
    updateWholeQuest.

updateQuestFish(Jumlah):-
    listQuest(fishing,ValueOfFishing),
	ValueOfFishing > 0,
    NewValue is ValueOfFishing - Jumlah,
    (
        NewValue > 0 ->
            write('Quest Fishing tersisa '),write(NewValue),write(' Item'),nl,
                retract(listQuest(fishing,_)),asserta(listQuest(fishing,NewValue));
        NewValue =:= 0 ->
            write('Selamat!, quest Fishing telah selesai'),nl,
            retract(listQuest(fishing,_)),asserta(listQuest(fishing,0))
    ),
    updateWholeQuest.


updateQuestFarming(Jumlah):-
    listQuest(ranching,ValueOfFarm),
	ValueOfFarm > 0,
    NewValue is ValueOfFarm - Jumlah,
    (
        NewValue > 0 ->
            write('Quest farming tersisa '),write(NewValue),write(' Item'),nl,
            retract(listQuest(harvesting,_)),asserta(listQuest(ranching,NewValue));
        NewValue =:= 0 ->
            write('Selamat!, quest farming telah selesai'),nl,
            retract(listQuest(harvesting,_)),asserta(listQuest(ranching,0))
    ),
    updateWholeQuest.

/* buat testing doang bang
testUpdateQuest:-
    write('Masukkan jumlah : '),read(X),nl,updateQuestFishing(X).
*/

updateWholeQuest:-
    listQuest(ranching,0),listQuest(fishing,0),listQuest(harvesting,0),
    write('Selamat Anda telah berhasil menyelesaikan semua quest dan mendapatkan 100 exp'),
    addExpGeneral(100),
    retract(haveQuest(_)),asserta(haveQuest(no)).