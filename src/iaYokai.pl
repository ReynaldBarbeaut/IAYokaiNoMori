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
movePiece(piece(Player,Name,[X,Y]),piece(Player,Name,[X2,Y]),Board) :-
    Name \= kodama,
    Name \= oni,
    X2 is X + 1,
    correctMove(piece(Player,Name,[X,Y]),[X2,Y],Board).

movePiece(piece(Player,Name,[X,Y]),piece(Player,Name,[X2,Y]),Board) :-
    Name \= kodama,
    Name \= oni,
    X2 is X - 1,
    correctMove(piece(Player,Name,[X,Y]),[X2,Y],Board).

/*
* Move a south piece
*/

/*
* Move to the front
*/
movePiece(piece(south,_,[X,Y]),piece(south,_,[X,Y2]),Board) :-
    Y2 is Y + 1,
    correctMove(piece(south,_,[X,Y]),[X,Y2],Board).

/*
* Move to the front left and front right
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y + 1,
    X2 is X + 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board).

movePiece(piece(south,Name,[X,Y]),piece(south,Name,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y + 1,
    X2 is X - 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board).

/*
* Move behind
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name,[X,Y2]),Board) :-
    Name \= kodama,
    Name \= oni,
    Y2 is Y - 1,
    correctMove(piece(south,Name,[X,Y]),[X,Y2],Board).


/*
* Move to the back left and back right
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y - 1,
    X2 is X + 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board).

movePiece(piece(south,Name,[X,Y]),piece(south,Name,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y - 1,
    X2 is X - 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board).

/*
* Move a north piece
*/

/*
* Move to the front
*/
movePiece(piece(north,_,[X,Y]),piece(north,_,[X,Y2]),Board) :-
    Y2 is Y - 1,
    correctMove(piece(north,_,[X,Y]),[X,Y2],Board).

/*
* Move to the front left and front right
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y - 1,
    X2 is X + 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board).

movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y - 1,
    X2 is X - 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board).

/*
* Move behind
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X,Y2]),Board) :-
    Name \= kodama,
    Name \= oni,
    Y2 is Y + 1,
    correctMove(piece(north,Name,[X,Y]),[X,Y2],Board).


/*
* Move to the back left and back right
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y + 1,
    X2 is X + 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board).

movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y + 1,
    X2 is X - 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board).

/*
* Promote an oni or a kodama
*/
promote(piece(Player,kodama,C),piece(Player,kodamaSamourai,C)).

promote(piece(Player,oni,C),piece(Player,superOni,C)).

/*
* Check is a placement of a piece is correct
*/
correctPlacement(piece(Player,Name,C1),C2,Board) :-
    Name \= kodama,
    correctMove(piece(Player,Name,C1),C2,Board),
    \+hasEnnemy(Player,C2,Board).

%Correct placement for a kodama piece
correctPlacement(piece(Player,kodama,C1),[X,Y],Board) :-
    correctMove(piece(Player,kodama,C1),[X,Y],Board),
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
* Find a piece depending on its team and its coordinate
*/

findAndReturn(Player,Coordinate,[piece(Player,Name,Coordinate)|_],piece(Player,Name,Coordinate)).
findAndReturn(Player,Coordinate,[_|List],P):-
        findAndReturn(Player,Coordinate,List,P).
/*
* Capture an ennemy
*/
capture(Player,C,LPieceTaken,Board,NewLPieceTaken,NewBoard):-
    findAndReturn(Player,C,Board,piece(Player2,Name,C2)),
    Name \= koropokkuru,
    NewLPieceTaken = [piece(Player2,Name,C2)|LPieceTaken],
    delete(piece(piece(Player2,Name,C2),Name,C2),Board,NewBoard).

