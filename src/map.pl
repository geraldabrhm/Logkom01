% Source code program yang minimal berisi:
%     ● Fakta-fakta terkait peta dan pemain
%     ● Implementasi rule-rule kendali dasar start, help ,quit, inventory, dll

/** Map ukuran 10 X 10 **/
/* Initial Map */
/* M: Marketplace, R: Ranch, H: House, Q: Tempat pengambilan quest, o: Tile air, =: Digged tile */
% ############
% #----Q-----#
% #----------#
% #-------R--#
% #----H-----#
% #-----P----#
% #--ooo-----#
% #-ooooo----#
% #--ooo-----#
% #----------#
% #-------M--#
% ############

sizeMap(11,11).

% border kiri
drawMap(X,Y) :- sizeMap(_,T),
                X =:= 0,
                Y =< T+1,
                write('# '),
                NewX is X+1,
                drawMap(NewX,Y).

%border atas
drawMap(X,Y) :- sizeMap(P,_),
                Y =:= 0,
                X < P + 1,
                X > P+1,
                write('# '),
                NewX is X+1,
                drawMap(NewX,Y).

%border kanan
drawMap(X,Y) :- sizeMap(P,T),
                X =:= P,
                Y =< T+1,
                
                write('# '), nl,
                NewY is Y+1,
                drawMap(X,NewY).

%border bawah
drawMap(X,Y) :- sizeMap(P,T),
                X =:= T,
                Y =< T+1,
                
                write('# '), nl,
                NewY is Y+1,
                drawMap(X,NewY).

draw:-drawMap(0,0).



