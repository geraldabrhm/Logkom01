:- dynamic(playerMoney/1).

/*sementara, nanti diganti sama yang dari mekanisme player */
playerMoney(5000).

inMarket :- player(X,Y), place('M',X,Y).

market:-
    inMarket, !,
    write('Mau ngapain ? '),nl,
    write('1. buy'),nl,
    write('2. sell'),nl,
    write('Pilih (buy/sell): '),read(Pilihan),nl,
    (
        Pilihan == buy ->
            write('Item yang tersedia : '),nl,
            write('1. Corn seed (75 gold)'),nl,
            write('2. Potato seed (150 gold)'),nl,
            write('3. Tomato seed (100 gold)'),nl,
            write('4. Chicken (750 gold)'),nl,
            write('5. Cow (1500 gold)'),nl,
            write('6. Sheep (2000 gold)'),nl,
            write('7. Level 2 Shove (750 gold)'),nl,
            write('8. Level 2 Fishing Rod(750 gold'),nl,
            write('9. Level 3 Shovel(2000 gold)'),nl,
            write('10. Level 3 Fishing Rod (2000 gold)'),nl,
            write('Pilih berdasarkan nomor : '),read(PilihItem),nl,
            playerMoney(Uang),
            (
                PilihItem == 1 ->
                    (
                        write('Mau beli berapa ?'),read(JumlahItem),nl,
                        Tot is 75*JumlahItem,
                        Uang >= Tot ->
                            addItem(7,JumlahItem),
                            NewUang is Uang-Tot,
                            retract(playerMoney(_)),
                            asserta(playerMoney(NewUang)),
                            write('anda berhasil membeli corn seed dengan harga '),write(Tot),nl;
                        write('Uang mu tidak mencukupi untuk membeli corn seed'),nl
                    );
                PilihItem == 2 ->
                    (
                        write('Mau beli berapa ?'),read(JumlahItem),nl,
                        Tot is 150*JumlahItem,
                        Uang >= Tot ->
                            addItem(8,JumlahItem),
                            NewUang is Uang-Tot,
                            retract(playerMoney(_)),
                            asserta(playerMoney(NewUang)),
                            write('anda berhasil membeli potato seed dengan harga '),write(Tot),nl;
                        write('Uang mu tidak mencukupi untuk membeli potato seed'),nl                        
                    );
                PilihItem == 3 ->
                    (
                        write('Mau beli berapa ?'),read(JumlahItem),nl,
                        Tot is 100*JumlahItem,
                        Uang >= Tot ->
                            addItem(9,JumlahItem),
                            NewUang is Uang-Tot,
                            retract(playerMoney(_)),
                            asserta(playerMoney(NewUang)),
                            write('anda berhasil membeli tomato seed dengan harga '),write(Tot),nl;
                        write('Uang mu tidak mencukupi untuk membeli tomato seed'),nl                        
                    );
                PilihItem == 4 ->
                    (
                        write('Mau beli berapa ?'),read(JumlahItem),nl,
                        Tot is 750*JumlahItem,
                        Uang >= Tot ->
                            addChicken(JumlahItem),
                            NewUang is Uang-Tot,
                            retract(playerMoney(_)),
                            asserta(playerMoney(NewUang)),
                            write('anda berhasil membeli chicken dengan harga '),write(Tot),nl;
                        write('Uang mu tidak mencukupi untuk membeli chicken'),nl                        
                    );
                PilihItem == 5 ->
                    (
                        write('Mau beli berapa ?'),read(JumlahItem),nl,
                        Tot is 1500*JumlahItem,
                        Uang >= Tot ->
                            addCow(JumlahItem),
                            NewUang is Uang-Tot,
                            retract(playerMoney(_)),
                            asserta(playerMoney(NewUang)),
                            write('anda berhasil membeli cow dengan harga '),write(Tot),nl;
                        write('Uang mu tidak mencukupi untuk membeli cow'),nl                   
                    );
                PilihItem == 6 ->
                    (
                        write('Mau beli berapa ?'),read(JumlahItem),nl,
                        Tot is 2000*JumlahItem,
                        Uang >= Tot ->
                            addSheep(JumlahItem),
                            NewUang is Uang-Tot,
                            retract(playerMoney(_)),
                            asserta(playerMoney(NewUang)),
                            write('anda berhasil membeli sheep dengan harga '),write(Tot),nl;
                        write('Uang mu tidak mencukupi untuk membeli sheep'),nl                        
                    );
                PilihItem == 7 ->
                    (
                        Uang >= 750 ->
                            upgradeTool(16,2),
                            NewUang is Uang-750,
                            retract(playerMoney(_)),
                            asserta(playerMoney(NewUang)),
                            write('anda berhasil upgrade shove ke level 2 dengan harga 750 gold');
                        write('Uang mu tidak mencukupi untuk upgrade shove'),nl                       
                    );
                PilihItem == 8 ->
                    (
                        Uang >= 750 ->
                            upgradeTool(17,2),
                            NewUang is Uang-750,
                            retract(playerMoney(_)),
                            asserta(playerMoney(NewUang)),
                            write('anda berhasil upgrade fishing rod ke level 2 dengan harga 750 gold');
                        write('Uang mu tidak mencukupi untuk membeli corn seed'),nl                        
                    );
                PilihItem == 9 ->
                    (
                        Uang >= 2000 ->
                            upgradeTool(16,3),
                            NewUang is Uang-2000,
                            retract(playerMoney(_)),
                            asserta(playerMoney(NewUang)),
                            write('anda berhasil upgrade shove ke level 3 dengan harga 2000 gold');
                        write('Uang mu tidak mencukupi untuk upgrade shove'),nl                       
                    );
                PilihItem == 10 ->
                    (
                        Uang >= 2000 ->
                            upgradeTool(17,3),
                            NewUang is Uang-2000,
                            retract(playerMoney(_)),
                            asserta(playerMoney(NewUang)),
                            write('anda berhasil upgrade fishing rod ke level 3 dengan harga 2000 gold');
                        write('Uang mu tidak mencukupi untuk membeli corn seed'),nl                        
                    );
                write('List barang tidak tersedia !'),nl
            );
        Pilihan == sell ->
            write('Item yang dapat anda jual dari Inventory : '),nl,
            rawDisplayMarket,
            write('Pilih Nama item : '),nl,read(PilihJual),nl,
            playerMoney(Uang),
            write('Mau jual berapa bang ?'),nl,read(JumlahJual),nl,
            inven(Id,PilihJual,Amount,SellPrice,_,_),
            A is Amount,
            ( A >= JumlahJual ->  
                throwItem(Id,JumlahJual),
                write('Anda telah berhasil menjual '),write(JumlahJual),write(' '),write(PilihJual),nl,
                NewUang is Uang + SellPrice,
                retract(playerMoney(_)),asserta(playerMoney(NewUang));
            write('Jumlah terlalu banyak !'),nl
            )
    ).

market :- write('Pergi ke market dulu bos!'),nl.