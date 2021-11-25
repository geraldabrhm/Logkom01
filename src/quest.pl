:-dynamic(haveQuest/1).
:-dynamic(listQuest/2).
:-dynamic(takeQuest/0).


haveQuest(no).
listQuest(ranching,0).
listQuest(fishing,0).
listQuest(harvesting,0).


takeQuest:- 
    write("Mau bantuin gaaakkk :( ? "),nl,
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

ranchingQ :- listQuest(ranching,ranchValue),
                ranchValue > 0 ->
                    write(ranchValue),
                    write(' ranch item');
                ranchValue < 1 ->
                    write('0 ranch item').
fishingQ :- listQuest(fishing,fishValue),
                fishValue > 0 ->
                    write(fishValue),
                    write(' fish');
                fishValue < 1 ->
                    write('0 fish').
harvestingQ :- listQuest(harvesting,harvestValue),
                harvestValue > 0 ->
                    write(harvestValue),
                    write(' harvest item');
                harvestValue < 1 ->
                    write('0 harvest item').

mainQuest:-
    haveQuest(bool),
        bool == no -> 
            takeQuest;
        bool == yes ->
            write("Misi yang lain di selesain dulu yaaa SEMANGAT!!!"),
            ranchingQ,
            fishingQ,
            harvestingQ.
