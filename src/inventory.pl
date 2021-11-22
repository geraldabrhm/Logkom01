:- dynamic(inventory/4).

/* Deklarasi Fakta */
/* invCapacity(Capacity)*/
invCapacity(100).

/* item(ID, Category, Name) */
item(1, 1, 'Carrot').
item(2, 1, 'Potato').
item(3, 1, 'Strawberry').

/* Category */
% 1 -> plants
% 2 -> tools
% 3 -> misc

/* inventory(ID, Category, Name, Amount) */
invTotal([], 0).
invTotal([HeadID|TailID], Total) :-
  inventory(HeadID, _, _, Amount),
  invTotal(TailID, NewAmount),
  Total is Amount + NewAmount.

isInventoryFull :-
  findall(ID, inventory(ID, _, _, _), IDs),
  invCapacity(Capacity),
  invTotal(IDs, Total),
  Total =:= Capacity.

isInventoryPartiallyFull(Amount) :-
  findall(ID, inventory(ID, _, _, _), IDs),
  invCapacity(Capacity),
  invTotal(IDs, Total),
  Amount + Total >= Capacity.

add(ID, ID_Amount) :-

throw(ID, ID_Amount) :-
  inventory(ID, Category, Name, Amount),
  NewAmount is Amount - ID_Amount,
  retract(inventory(ID, _, _, _)), (
    NewAmount > 0 -> asserta(inventory(ID, Category, Name, NewAmount))
  ).
displayInventory([]).
displayInventory([HeadID|TailID]) :-
  inventory(HeadID, _, Name, Amount),
  write(Amount), write(' '), write(Name), nl,
  displayInventory(TailID).

inventory :-
