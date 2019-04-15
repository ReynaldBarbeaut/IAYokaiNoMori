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
initial_board(Board) :-
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
correctSquare([X,Y]) :- X > 0, X < 7, Y > 0, Y < 7.

/*
* Test if a move is correct
*/
correctMove(piece(Player,_,C1),C2,Board) :-
        C1 \= C2,
        \+(member(piece(Player, _, C2), Board)),
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
    findall([NewHand,NewBoard,P2],movement(P,Hand,Board,NewHand,NewBoard,P2),LMoves).


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
demote(piece(Player,kodamaSamourai,C),piece(Player,kodama,C)):-!.

demote(piece(Player,superOni,C),piece(Player,oni,C)):-!.

demote(Piece,Piece).

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
* Check is an element to a list is in the second
*/
compareL(Player,[C|_], Board):-
    member(piece(Player,koropokkuru,C), Board),!.
compareL(Player,[_|L], Board):-
    compareL(Player,L, Board).

/*
* Test if a piece is in scope of opponent koropokkuru
*/
inScope(piece(Player,Name,C),Board):-
    findall(C2,
            movePiece(piece(Player,Name,C),piece(_,_,C2),Board),
            LC),
    opponent(Player,Player2),
    compareL(Player2,LC,Board).

/*
* Test if opponent korpokkuru is check
*/
check(Player,Board,[piece(Player,Name,C)|_]):-
    inScope(piece(Player,Name,C),Board),!.
check(Player,Board,[_|L]):-
    check(Player,Board,L).
        




    


