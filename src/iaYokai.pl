/*Barbeaut Reynald - Bouchard Nicolas
*
* This file contains the IA of a player of Yokai no-mori
* This IA was developped for the MOIA discipline.
*
*
*/

:-use_module(library(clpfd)).
:-use_module(library(plunit)).
:-use_module(library(lists)).

% Flag to display a long list
:-set_prolog_flag(toplevel_print_options,
    [quoted(true), portrayed(true), max_depth(0)]).


/*
*       Initialisation of the board
*/

/*
* Here a pion is defined by its side, its name and its coordinate.
*/

/*
* Initial pieces position for the north player
*/
initial(piece(south,kodama,[2,3])).
initial(piece(south,kodama,[3,3])).
initial(piece(south,kodama,[4,3])).

initial(piece(south,oni,[1,1])).
initial(piece(south,oni,[5,1])).

initial(piece(south,kirin,[2,1])).
initial(piece(south,kirin,[4,1])).

initial(piece(south,koropokkuru,[3,1])).

/*
* Initial pieces position for the south player
*/
initial(piece(north,kodama,[2,4])).
initial(piece(north,kodama,[3,4])).
initial(piece(north,kodama,[4,4])).

initial(piece(north,oni,[1,6])).
initial(piece(north,oni,[5,6])).

initial(piece(north,kirin,[2,6])).
initial(piece(north,kirin,[4,6])).

initial(piece(north,koropokkuru,[3,6])).

/*
* Create the initial board
*/
initialBoard(Board) :-
    findall(Piece, initial(Piece), Board).
/*
* Declare the opponent for each side
*/
opponent(north,south).
opponent(south,north).

/*
* Return the last line of a side
*/
lastLine(south,1).
lastLine(north,6).


/*
* Test if a square is correct
*/
correctSquare([X,Y]) :- X > 0, X < 6, Y > 0, Y < 7.

/*
* Test if a move is correct
*/
correctMove(piece(Player,_,C1),C2,Board) :-
        C1 \= C2,
        \+(member(piece(Player, _, C2), Board)),
        opponent(Player,Player2),
        \+member(piece(Player2,koropokkuru,C2),Board),
        correctSquare(C2).


/*
* Test if there is an ennemy on the square
*/
hasEnnemy(Player, C,Board) :-
    opponent(Player,Player2),
    member(piece(Player2,_,C),Board).

/*
*  Move pieces
*/

/*
* Move on sides (common move for both sides)
*/
movePiece(piece(Player,Name,[X,Y]),piece(Player,Name2,[X2,Y]),Board) :-
    Name \= kodama,
    Name \= oni,
    X2 is X + 1,
    correctMove(piece(Player,Name,[X,Y]),[X2,Y],Board),
    promote(piece(Player,Name,[X2,Y]),piece(_,Name2,_)).

movePiece(piece(Player,Name,[X,Y]),piece(Player,Name2,[X2,Y]),Board) :-
    Name \= kodama,
    Name \= oni,
    X2 is X - 1,
    correctMove(piece(Player,Name,[X,Y]),[X2,Y],Board),
    promote(piece(Player,Name,[X2,Y]),piece(_,Name2,_)).

/*
* Move a south piece
*/

/*
* Move to the front
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name2,[X,Y2]),Board) :-
    Y2 is Y + 1,
    correctMove(piece(south,_,[X,Y]),[X,Y2],Board),
    promote(piece(south,Name,[X,Y2]),piece(_,Name2,_)).

/*
* Move to the front left and front right
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name2,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y + 1,
    X2 is X + 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board),
    promote(piece(south,Name,[X2,Y2]),piece(_,Name2,_)).

movePiece(piece(south,Name,[X,Y]),piece(south,Name2,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y + 1,
    X2 is X - 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board),
    promote(piece(south,Name,[X2,Y2]),piece(_,Name2,_)).

/*
* Move behind
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name2,[X,Y2]),Board) :-
    Name \= kodama,
    Name \= oni,
    Y2 is Y - 1,
    correctMove(piece(south,Name,[X,Y]),[X,Y2],Board),
    promote(piece(south,Name,[X,Y2]),piece(_,Name2,_)).


/*
* Move to the back left and back right
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name2,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y - 1,
    X2 is X + 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board),
    promote(piece(south,Name,[X2,Y2]),piece(_,Name2,_)).

movePiece(piece(south,Name,[X,Y]),piece(south,Name2,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y - 1,
    X2 is X - 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board),
    promote(piece(south,Name,[X2,Y2]),piece(_,Name2,_)).

/*
* Move a north piece
*/

/*
* Move to the front
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name2,[X,Y2]),Board) :-
    Y2 is Y - 1,
    correctMove(piece(north,_,[X,Y]),[X,Y2],Board),
    promote(piece(north,Name,[X,Y2]),piece(_,Name2,_)).

/*
* Move to the front left and front right
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name2,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y - 1,
    X2 is X + 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board),
    promote(piece(north,Name,[X2,Y2]),piece(_,Name2,_)).

movePiece(piece(north,Name,[X,Y]),piece(north,Name2,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y - 1,
    X2 is X - 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board),
    promote(piece(north,Name,[X2,Y2]),piece(_,Name2,_)).

/*
* Move behind
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name2,[X,Y2]),Board) :-
    Name \= kodama,
    Name \= oni,
    Y2 is Y + 1,
    correctMove(piece(north,Name,[X,Y]),[X,Y2],Board),
    promote(piece(north,Name,[X,Y2]),piece(_,Name2,_)).


/*
* Move to the back left and back right
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name2,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y + 1,
    X2 is X + 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board),
    promote(piece(north,Name,[X2,Y2]),piece(_,Name2,_)).

movePiece(piece(north,Name,[X,Y]),piece(north,Name2,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y + 1,
    X2 is X - 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board),
    promote(piece(north,Name,[X2,Y2]),piece(_,Name2,_)).


/*
* Find a piece depending on its team and its coordinate
*/

findAndReturn(Player,Coordinate,[piece(Player,Name,Coordinate)|_],piece(Player,Name,Coordinate)).
findAndReturn(Player,Coordinate,[_|List],P):-
        findAndReturn(Player,Coordinate,List,P).

/*
* Capture an ennemy
*/
capture(Player,C,LPieceTaken,Board,NewLPieceTaken,NewBoard):-
    opponent(Player,Player2),
    findAndReturn(Player2,C,Board,piece(Player2,Name,C2)),
    demote(piece(Player2,Name,C2),Piece),
    NewLPieceTaken = [Piece|LPieceTaken],
    delete(Board,piece(Player2,Name,C2),NewBoard).


/*
* Move and capture if there is an ennemy
*/
movement(piece(Player,Name,C1),Hand,Board,NewHand,NewBoard3,piece(Player,Name2,C2)):-
    movePiece(piece(Player,Name,C1),piece(Player,Name2,C2),Board),
    hasEnnemy(Player, C2,Board),
    capture(Player,C2,Hand,Board,NewHand,NewBoard),
    delete(NewBoard,piece(Player,Name,C1),NewBoard2),
    NewBoard3 = [piece(Player,Name,C2)|NewBoard2].


movement(piece(Player,Name,C1),Hand,Board,Hand,NewBoard2,piece(Player,Name2,C2)):-
    movePiece(piece(Player,Name,C1),piece(Player,Name2,C2),Board),
    \+hasEnnemy(Player, C2,Board),
    delete(Board,piece(Player,Name,C1),NewBoard),
    NewBoard2 = [piece(Player,Name,C2)|NewBoard].
    

/*
* Get all possible moves of a piece
*/
possibleMoves(P,Hand,Board,LMoves) :-
    findall([NewHand,NewBoard,P,P2],movement(P,Hand,Board,NewHand,NewBoard,P2),LMoves).


/*
* Check if a piece is in a promote area
*/
inPromoteArea(north,Y) :- (Y=1;Y=2).

inPromoteArea(south,Y) :- (Y=5;Y=6).

/*
* Promote an oni or a kodama
*/
promote(piece(Player,kodama,[X,Y]),piece(Player,kodamaSamourai,[X,Y])) :-
   inPromoteArea(Player,Y),!. 

promote(piece(Player,oni,[X,Y]),piece(Player,superOni,[X,Y])) :-
   inPromoteArea(Player,Y),!.

promote(Piece,Piece).


/*
* Demote a kodama samourai or a super oni
*/
demote(piece(Player,kodamaSamourai,C),piece(Player2,kodama,C)):-opponent(Player,Player2),!.

demote(piece(Player,superOni,C),piece(Player2,oni,C)):-opponent(Player,Player2),!.

demote(piece(Player,Name,C),piece(Player2,Name,C)):-opponent(Player,Player2).

/*
* Check if a placement of a piece is correct
*/
correctPlacement(piece(Player,Name,_),C2,Board) :-
    Name \= kodama,
    \+(member(piece(Player, _, C2), Board)),
    correctSquare(C2),
    \+hasEnnemy(Player,C2,Board).

%Correct placement for a kodama piece
correctPlacement(piece(Player,kodama,_),[X,Y],Board) :-
    \+(member(piece(Player, _, [X,Y]), Board)),
    correctSquare([X,Y]),
    \+hasEnnemy(Player,[X,Y],Board),
    \+(member(piece(Player, kodama, [X,_]), Board)),
    opponent(Player,Player2),
    lastLine(Player2,LastLine),
    Y \= LastLine.
        
/*
* Place a piece on the board
*/
place(Piece,C,LPieceTaken,Board,NewLPieceTaken,NewBoard) :-
    correctPlacement(Piece,C,Board),
    delete(LPieceTaken,Piece,NewLPieceTaken),
    Piece = piece(Player,Name,_),
    NewBoard = [piece(Player,Name,C) | Board].


/*
* Check if a piece is in a list a C coordinates
*/
compareL(piece(_,_,C2),[C|_]):-
    C2=C,!.
compareL(Piece,[_|L]):-
    compareL(Piece,L).

/*
* Test if a piece is in scope of another opponent piece (to know if the piece will be take in next round)
*/
inScope(Piece, piece(Player,Name,C),Board):-
    findall(C2,
            movePiece(piece(Player,Name,C),piece(_,_,C2),Board),
            LC),
    compareL(Piece,LC).

/*
* Test if piece is in scope of one of an opponent piece
*/
inTake(Piece,Player,Board,[piece(Player2,Name,C)|_]):-
    opponent(Player,Player3),
    Player2 = Player3,
    inScope(Piece,piece(Player2,Name,C),Board),!.
inTake(Piece,Player,Board,[_|L]):-
    inTake(Piece,Player,Board,L).

/*
* Points of a piece
*/
points(kodama,10).
points(kodamaSamourai,20).
points(oni,30).
points(superOni,40).
points(kirin,50).
/*
*Priority is given to the koropokkuru with that even if a piece has a chance to be taken,
* it will still focus to capture the koropokkuru
*/
points(koropokkuru,100).

/*
* Compute distance between two points
*/
distance([X,Y],[X2,Y2],Dist):-
    Dist is sqrt((X2-X)*(X2-X) + (Y2-Y)*(Y2-Y)). 

/*
* Compute the risked cost of a piece (if it is captured)
*/
riskedCost(piece(Player,Name,C),Board,0):-
    \+inTake(piece(Player,Name,C),Player,Board,Board),!.

riskedCost(piece(Player,Name,C),Board,Cost):-
    inTake(piece(Player,Name,C),Player,Board,Board),
    points(Name,Cost),!.

/*
* Return coordinate of a piece
*/
getCoordinate(Player,Name,[piece(Player,Name,Coordinate)|_],Coordinate).
getCoordinate(Player,Name,[_|List],P):-
        getCoordinate(Player,Name,List,P).

/*
* Compute points for a move
*/

computePoints([NewHand,_,_,piece(Player,Name2,C2)],Hand,Board,Cost):-
    NewHand \= Hand,
    NewHand = [piece(Player,Name3,_)|_],
    points(Name3,Point),
    opponent(Player,Player2),
    getCoordinate(Player2,koropokkuru,Board,C3),
    distance(C2,C3,Distance),
    riskedCost(piece(Player,Name2,C2),Board,RiskedCost),
    Cost is Point - Distance - RiskedCost.  


computePoints([NewHand,_,_,piece(Player,Name2,C2)],Hand,Board,Cost):-
    NewHand == Hand,
    opponent(Player,Player2),
    getCoordinate(Player2,koropokkuru,Board,C3),
    distance(C2,C3,Distance),
    riskedCost(piece(Player,Name2,C2),Board,RiskedCost),
    Cost is 0 - Distance - RiskedCost. 

/*
* Go through a list of moves and keep the best one
*/     
bestFromList([],_,_,RecordMove,RecordCost,RecordMove,RecordCost):-!.

bestFromList([Move|LMove],Hand,Board,_,CurrentBestCost,RecordMode,RecordCost):-
    computePoints(Move,Hand,Board,NewCost),
    NewCost > CurrentBestCost,
    bestFromList(LMove,Hand,Board,Move,NewCost,RecordMode,RecordCost).


bestFromList([Move|LMove],Hand,Board,CurrentBestMove,CurrentBestCost,RecordMode,RecordCost):-
    computePoints(Move,Hand,Board,NewCost),
    NewCost =< CurrentBestCost,
    bestFromList(LMove,Hand,Board,CurrentBestMove,CurrentBestCost,RecordMode,RecordCost).

/*
* Compute best move of a piece.
*/
bestMove(P,Hand,Board,BestMove,BestCost):-
    possibleMoves(P,Hand,Board,LMoves),
    LMoves = [FirstMove | _],
    computePoints(FirstMove,Hand,Board,FirstCost),
    bestFromList(LMoves,Hand,Board,FirstMove,FirstCost,BestMove,BestCost).


/*
* Go through a piece's list of a side and compute the best move of each piece to return the best move 
*/
bestSideMoveList(_,_,[],_,BestMove,_,BestMove).

bestSideMoveList(Player,Hand,[piece(Player2,_,_)|LPieces],Board,_,CurrentBestCost,BestMove):-  
    Player \= Player2,
    bestSideMoveList(Player,Hand,LPieces,Board,_,CurrentBestCost,BestMove).

bestSideMoveList(Player,Hand,[piece(Player,Name,C)|LPieces],Board,_,CurrentBestCost,BestMove):-  
    bestMove(piece(Player,Name,C),Hand,Board,NewBestMove,NewBestCost),
    NewBestCost > CurrentBestCost,
    bestSideMoveList(Player,Hand,LPieces,Board,NewBestMove,NewBestCost,BestMove).

bestSideMoveList(Player,Hand,[piece(Player,Name,C)|LPieces],Board,CurrentBestMove,CurrentBestCost,BestMove):-  
    bestMove(piece(Player,Name,C),Hand,Board,_,NewBestCost),
    NewBestCost =< CurrentBestCost,
    bestSideMoveList(Player,Hand,LPieces,Board,CurrentBestMove,CurrentBestCost,BestMove).

/*
*
*/
bestSideMove(Player,Hand,Board,BestMove) :-
    bestSideMoveList(Player,Hand,Board,Board,[],-99,BestMove).   
    



