:-use_module(library(plunit)).
:-use_module(library(lists)).
/*Barbeaut Reynald - Bouchard Nicolas
*
* This file contains the IA of a player of Yokai no-mori
* This IA was developped for the MOIA discipline.
*
*
*/

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
correctMove(piece(south,_,_),C2,Board) :-
        \+(member(piece(south, _, C2), Board)),
        correctSquare(C2).

correctMove(piece(north,_,_),C2,Board) :-
        \+(member(piece(north, _, C2), Board)),
        correctSquare(C2).



