:-dynamic(item/6).

kapasitas(100).
/* item(id,nama,jumlah,harga jual,harga beli)
    1. ID
    2. Nama
    3. Jumlah
    4. harga jual
    5. harga beli
    6. level
 */

/*LIST ITEM*/
/*fishing*/
item(1,catfish,0,75,0,0).
item(2,salmon,0,150,0,0).
item(3,tuna,0,250,0,0).

/*harvesting*/
item(4,corn,0,100,0,0).
item(5,potato,5,300,0,0).
item(6,tomato,0,200,0,0).
item(7,cornSeed,0,0,75,0).
item(8,potatoSeed,0,0,150,0).
item(9,tomatoSeed,0,0,100,0).

/*ranching*/
item(10,chicken,0,750,0,0).
item(11,cow,0,1500,0,0).
item(12,sheep,3,2000,0,0).
item(13,egg,0,0,100,0).
item(14,milk,0,0,400,0).
item(15,wool,0,0,750,0).

/*LIST TOOL*/
item(16,shovel,1,0,0,1).
item(17,fishingRod,1,0,0,1).

/* INVENTORY */

/*Cek kapasitas */
banyakItem(Panjang):-
    findall(Value,item(_,_,Value,_,_,_),ListOfValue),
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
rawDisplay:-
    findall(Id,item(Id,_,_,_,_,_),ListOfID),
    displayTas(ListOfID).
displayTas([]).
displayTas([HeadID|TailID]):-
    item(HeadID,Name,X,_,_,Lvl),
    (Lvl =:= 0->
        write(X), write(' '), write(Name), nl,displayTas(TailID);
    Lvl =:= 1->
        write(X), write(' Level '), write(Lvl),write(' '),write(Name),nl,displayTas(TailID)
    ).

addItem(Id,Banyak):-
    item(Id,Name,Amount,HargaJ,HargaB,Level),
    A is Amount+Banyak,
    retract(item(Id,_,_,_,_,_)),
    asserta(item(Id,Name,A,HargaJ,HargaB,Level)).

throwItem(Id,Banyak):-
    item(Id,Name,Amount,HargaJ,HargaB,Level),
    A is Amount-Banyak,
    retract(item(Id,_,_,_,_,_)),
    asserta(item(Id,Name,A,HargaJ,HargaB,Level)).

/*Buat Cek Throw Item */
throw:-
    write('Mau buang apa bos ? '),
    read(NamaBuang),
    item(Id,NamaBuang,Amount,_,_,_),
    write('Kamu punya '),write(Amount),write(' '),write(NamaBuang),write(' Mau Buang Berapa ?'),nl,
    read(JumlahBuang),
    (
        JumlahBuang > Amount ->
            write('Ga cukup, Membatalkan . . .'),nl;
        JumlahBuang =< Amount ->
            throwItem(Id,JumlahBuang),
            write('Kamu telah membuang '),write(JumlahBuang),,write(' '),write(NamaBuang),nl
    ).


/*Buat Cek add Item */
tambahSapi:-addItem(11,2).