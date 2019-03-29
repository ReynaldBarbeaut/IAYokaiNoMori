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
initial(piece(north,kodama,[2,3])).
initial(piece(north,kodama,[3,3])).
initial(piece(north,kodama,[4,3])).

initial(piece(north,oni,[1,1])).
initial(piece(north,oni,[5,1])).

initial(piece(north,kirin,[2,1])).
initial(piece(north,kirin,[4,1])).

initial(piece(north,koropokkuru,[3,1])).



/*
* Initial pieces position for the south player
*/
initial(piece(south,kodama,[2,4])).
initial(piece(south,kodama,[3,4])).
initial(piece(south,kodama,[4,4])).

initial(piece(south,oni,[1,6])).
initial(piece(south,oni,[5,6])).

initial(piece(south,kirin,[2,6])).
initial(piece(south,kirin,[4,6])).

initial(piece(south,koropokkuru,[3,6])).

/*
* Create the initial board
*/
initial_board(Board) :-
    findall(Piece, initial(Piece), Board).


/*
* Test if a square is correct
*/
correctSquare([X,Y]) :- X > 0, X < 6, Y > 0, Y < 6.

/*
* Test if a move is correct
*/
correctMove(piece(south,_,C1),C2,Board) :-
        C1 \= C2,
        \+(member(piece(south, _, C2), Board)),
        correctSquare(C2).

correctMove(piece(north,_,C1),C2,Board) :-
        C1 \= C2,
        \+(member(piece(north, _, C2), Board)),
        correctSquare(C2).

/*
*  Move pieces
*/

/*
* Move on sides (common move for both sides)
*/
movePiece(piece(_,Name,[X,Y]),piece(north,Name,[X2,Y]),Board) :-
    Name \= kodama,
    Name \= oni,
    X2 is X + 1,
    correctMove(piece(_,Name,[X,Y]),[X2,Y],Board).

movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X2,Y]),Board) :-
    Name \= kodama,
    Name \= oni,
    X2 is X - 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y],Board).

/*
* Move a north piece
*/

/*
* Move to the front
*/
movePiece(piece(north,_,[X,Y]),piece(north,_,[X,Y2]),Board) :-
    Y2 is Y + 1,
    correctMove(piece(north,_,[X,Y]),[X,Y2],Board).

/*
* Move to the front left and front right
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y + 1,
    X2 is X + 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board).

movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y + 1,
    X2 is X - 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board).

/*
* Move behind
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X,Y2]),Board) :-
    Name \= kodama,
    Name \= oni,
    Y2 is Y - 1,
    correctMove(piece(north,Name,[X,Y]),[X,Y2],Board).


/*
* Move to the back left and back right
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y - 1,
    X2 is X + 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board).

movePiece(piece(north,Name,[X,Y]),piece(north,Name,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y - 1,
    X2 is X - 1,
    correctMove(piece(north,Name,[X,Y]),[X2,Y2],Board).

/*
* Move a south piece
*/

/*
* Move to the front
*/
movePiece(piece(south,_,[X,Y]),piece(south,_,[X,Y2]),Board) :-
    Y2 is Y - 1,
    correctMove(piece(south,_,[X,Y]),[X,Y2],Board).

/*
* Move to the front left and front right
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y - 1,
    X2 is X + 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board).

movePiece(piece(south,Name,[X,Y]),piece(south,Name,[X2,Y2]),Board) :-
    Name \= kodama,
    Y2 is Y - 1,
    X2 is X - 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board).

/*
* Move behind
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name,[X,Y2]),Board) :-
    Name \= kodama,
    Name \= oni,
    Y2 is Y + 1,
    correctMove(piece(south,Name,[X,Y]),[X,Y2],Board).


/*
* Move to the back left and back right
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y + 1,
    X2 is X + 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board).

movePiece(piece(south,Name,[X,Y]),piece(south,Name,[X2,Y2]),Board) :-
    (Name=oni;Name=koropokkuru),
    Y2 is Y + 1,
    X2 is X - 1,
    correctMove(piece(south,Name,[X,Y]),[X2,Y2],Board).
                                                                         
                                               

