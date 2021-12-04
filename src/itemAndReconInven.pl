:-dynamic(item/6).
:-dynamic(inven/6).


kapasitas(100).
/* inven(id,nama,jumlah,harga jual,harga beli,level)
    1. ID
    2. Nama
    3. Jumlah
    4. harga jual
    5. harga beli
    6. level
 */

 /* READ THIS
     - buat dynamic item itu cuman buat list aja kalo butuh
    untuk inventory yang bner bner invetory, itu di dynamic inven
    - parameter kalau mau nambah item ke tas itu (Id,Jumlah itemnya)
    - parameter hapus/throw item sama kayak nambah item
    - yang ada comment "cek" di atas rules nya, itu cmn buat ngecek bner apa engga
    rules yang udah di buat
    - Selain hewan, semua pake fakta inven, hewan pake fakta item aja
*/

 /*starter Pack*/
inven(16,shove,1,0,0,1).
inven(17,fishingRod,1,0,0,1).
inven(4,corn,10,100,0,0).

/*LIST ITEM*/
/*fishing*/
item(1,catfish,0,75,0,0).
item(2,salmon,0,150,0,0).
item(3,tuna,0,250,0,0).

/*harvesting*/
item(4,corn,0,100,0,0).
item(5,potato,0,300,0,0).
item(6,tomato,0,200,0,0).
item(7,cornSeed,0,0,75,0).
item(8,potatoSeed,0,0,150,0).
item(9,tomatoSeed,0,0,100,0).

/*ranching*/
item(10,chicken,0,0,750,0).
item(11,cow,0,0,1500,0).
item(12,sheep,0,0,2000,0).
item(13,egg,0,100,0,0).
item(14,milk,0,400,0,0).
item(15,wool,0,750,0,0).

/*LIST TOOL*/
item(16,shove,1,0,0,1).
item(17,fishingRod,1,0,0,1).

/* INVENTORY */

/*Cek kapasitas */
banyakItem(Panjang):-
    findall(Value,inven(_,_,Value,_,_,_),ListOfValue),
    totList(ListOfValue,Panjang).
totList([],0).
totList([Head|Tail],Tot):-
    totList(Tail,TotRaw),
    Tot is Head + TotRaw.

/*Cek*/
displayPanjang:- 
    banyakItem(A),
    write('Banyak isi tas sekarang adalah '),write(A),nl,!.

/* Display Inventory */
inventory:-
    banyakItem(A),
    write('Isi tas kamu ada ('),write(A),write(' / 100)'),nl,
    findall(Id,inven(Id,_,_,_,_,_),ListOfID),
    displayTas(ListOfID).
displayTas([]).
displayTas([HeadID|TailID]):-
    inven(HeadID,Name,Amount,_,_,Lvl),
    (Lvl > 0 ->
        write(Amount), write(' Level '), write(Lvl),write(' '),write(Name),nl,displayTas(TailID);
    Lvl =:= 0 ->
        write(Amount), write(' '), write(Name), nl,displayTas(TailID)
    ).

rawDisplayMarket:-
    findall(Id,inven(Id,_,_,_,_,_),IdListForSell),
    displayMarket(IdListForSell).
displayMarket([]).
displayMarket([HiD|TiD]):-
    inven(HiD,Name,Amount,SellPrice,_,_),
    (
        SellPrice > 0 ->
            write('- '),write(Amount),write(' '),write(Name),nl;
        SellPrice < 1 ->
            write('')
    ),displayMarket(TiD).
    

addItem(Id,Banyak):-
    banyakItem(Caps),
    (\+inven(Id,_,_,_,_,_) -> item(Id,Nama,Amount,HargaJ,HargaB,Level);
	inven(Id,Nama,X,HargaJ,HargaB,Level) -> Amount is X
    ),
	A is Amount+Banyak,
    NewCaps is A + Caps,
    (NewCaps =< 100 ->
        (\+inven(Id,_,_,_,_,_) -> 
            asserta(inven(Id,Nama,A,HargaJ,HargaB,Level));
        inven(Id,_,_,_,_,_) ->
            retract(inven(Id,_,_,_,_,_)),
            asserta(inven(Id,Nama,A,HargaJ,HargaB,Level))
        );
    NewCaps > 100 ->
        write('Kapasitas sudah penuh !'),nl
    ).

upgradeTool(Id,Lvl):-
    inven(Id,Nama,Amount,HargaJ,HargaB,_),
    A is Lvl,
    retract(inven(Id,_,_,_,_,_)),
    asserta(inven(Id,Nama,Amount,HargaJ,HargaB,A)).

throwItem(Id,Banyak):-
    inven(Id,Nama,Amount,HargaJ,HargaB,Level),
    A is Amount-Banyak,
    (A == 0 ->
        retract(inven(Id,_,_,_,_,_));
    A > 0 ->
        retract(inven(Id,_,_,_,_,_)),
        asserta(inven(Id,Nama,A,HargaJ,HargaB,Level))
    ).

/*Buat Cek Throw Item */
throw:-
    write('Mau buang apa bos ? '),nl,
    read(NamaBuang),
    inven(Id,NamaBuang,Amount,_,_,_),
    write('Kamu punya '),write(Amount),write(' '),write(NamaBuang),nl,write('Mau Buang Berapa ?'),nl,
    read(JumlahBuang),
    (
        JumlahBuang > Amount ->
            write('Ga cukup, Membatalkan . . .'),nl;
        JumlahBuang =< Amount ->
            throwItem(Id,JumlahBuang),
            write('Kamu telah membuang '),write(JumlahBuang),write(' '),write(NamaBuang),nl
    ).