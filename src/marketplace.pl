:- include('itemAndReconInven.pl').
:- dynamic(playerMoney/1).

/*sementara, nanti diganti sama yang dari mekanisme player */
playerMoney(5000).


market:-
    write('Mau ngapain ? '),nl,
    write('1. Beli'),nl,
    write('2. Jual'),nl,
    write('Pilih : '),read(Pilihan),nl,
    (
        Pilihan == 1 ->
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
            write('Pilihan : '),read(PilihItem),nl,
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
                            addItem(10,JumlahItem),
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
                            addItem(11,JumlahItem),
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
                            addItem(12,JumlahItem),
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
                    )
            );
        Pilihan == 2->
            playerMoney(Uang),
            write('Item yang dapat anda jual dari Inventory : '),nl,
            item(4,_,A,_,_,_),write('- '),write(A),write(' Corn (100 gold)'),nl,
            item(5,_,B,_,_,_),write('- '),write(B),write(' Potato (300 gold)'),nl,
            item(6,_,C,_,_,_),write('- '),write(C),write(' Tomato (200) gold)'),nl,
            item(13,_,D,_,_,_),write('- '),write(D),write(' Egg (100 gold)'),nl,
            item(14,_,E,_,_,_),write('- '),write(E),write(' Milk (400 gold)'),nl,
            item(15,_,F,_,_,_),write('- '),write(F),write(' Wool (750 gold)'),nl,
            item(1,_,G,_,_,_),write('- '),write(G),write(' Catfish (75 gold)'),nl,
            item(2,_,H,_,_,_),write('- '),write(H),write(' Salmon (150 gold)'),nl,
            item(3,_,I,_,_,_),write('- '),write(I),write(' Tuna (250 gold)'),nl
    ).