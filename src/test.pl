:-use_module(library(plunit)).
:-use_module(library(lists)).

:- include(iaYokai).

:- begin_tests(iaYokai).

/*
* Tests for the opponent predicate
*/
test('opponent_OK',[true(X == south)]):-
    opponent(north,X).

test('opponent_OK',[true(X == north)]):-
    opponent(south,X).

test('opponent_KO',[fail]):-
    opponent(test,_).


/*
* Tests for the lastLine predicate
*/
test('lastLine_OK',[true(X == 1)]):-
    lastLine(north,X).

test('lastLine_OK',[true(X == 6)]):-
    lastLine(south,X).

test('lastLine_KO',[fail]):-
    lastLine(test,_).

/*
* Test for correctSquare predicate
*/
test('correctSquare_OK',[true]):-
    correctSquare([1,5]),
    correctSquare([5,5]),
    correctSquare([3,3]),
    correctSquare([3,4]),
    correctSquare([2,5]).


test('correctSquare_KO',[fail]):-
    correctSquare([0,2]),
    correctSquare([6,4]),
    correctSquare([-1,3]),
    correctSquare([3,0]),
    correctSquare([2,6]).

/*
* Tests for the correctMove predicate
*/
test('correctMove_OK',[true]):-
    correctMove(piece(north,kodama,[4,4]),[4,5],[]),
    correctMove(piece(north,kodama,[4,4]),[4,5],[piece(south,kodama,[4,5])]),
    correctMove(piece(north,kodama,[4,4]),[2,5],[]),
    correctMove(piece(north,kodama,[4,4]),[4,5],[]),
    correctMove(piece(north,kodama,[4,4]),[3,5],[piece(south,kodama,[3,5])]).
    
test('correctMove_KO',[fail]):-
    correctMove(piece(north,kodama,[4,4]),[4,4],[]),
    correctMove(piece(north,kodama,[4,4]),[4,5],[piece(north,kodama,[4,5])]),
    correctMove(piece(north,kodama,[4,4]),[0,5],[]),
    correctMove(piece(north,kodama,[4,4]),[4,6],[]),
    correctMove(piece(north,kodama,[4,4]),[3,5],[piece(north,kodama,[3,5])]).

/*
* Tests for the hasEnnemy predicate
*/
test('hasEnnemy_OK',[true]):-
    hasEnnemy(north, [1,3],[piece(south,kodama,[1,3])]),
    hasEnnemy(south, [1,3],[piece(north,kirin,[1,3])]),
    hasEnnemy(north, [2,4],[piece(south,oni,[2,4])]),
    hasEnnemy(south, [1,3],[piece(north,superOni,[1,3])]),
    hasEnnemy(north, [1,3],[piece(south,koropokkuru,[4,3]),piece(south,kodama,[2,3]),piece(south,kodama,[1,3]),piece(south,kirin,[1,5])]),
    hasEnnemy(south, [1,3],[piece(south,koropokkuru,[4,3]),piece(south,kodama,[2,3]),piece(north,kodama,[1,3]),piece(south,kirin,[1,5])]).
       
test('hasEnnemy_KO',[fail]):-
    hasEnnemy(north, [1,3],[piece(north,kodama,[1,3])]),
    hasEnnemy(south, [1,3],[piece(south,kirin,[1,3])]),
    hasEnnemy(north, [2,4],[piece(north,oni,[2,4])]),
    hasEnnemy(south, [1,3],[piece(south,superOni,[1,3])]),
    hasEnnemy(north, [1,3],[piece(south,koropokkuru,[4,3]),piece(south,kodama,[2,3]),piece(north,kodama,[1,3]),piece(south,kirin,[1,5])]),
    hasEnnemy(south, [1,3],[piece(south,koropokkuru,[4,3]),piece(south,kodama,[2,3]),piece(south,kodama,[1,3]),piece(south,kirin,[1,5])]).

/*
* Tests for the promote predicate
*/
test('promote_OK',[true(X == piece(north,kodamaSamourai,[1,3]))]):-
    promote(piece(north,kodama,[1,3]),X).

test('promote_OK',[true(X == piece(north,superOni,[1,3]))]):-
    promote(piece(north,oni,[1,3]),X).

test('promote_OK',[true(X == piece(south,kodamaSamourai,[1,3]))]):-
    promote(piece(south,kodama,[1,3]),X).

test('promote_OK',[true(X == piece(south,superOni,[1,3]))]):-
    promote(piece(south,oni,[1,3]),X).


test('promote_KO',[fail]):-
    promote(piece(north,kirin,[1,3]),_).

test('promote_KO',[fail]):-
    promote(piece(north,koropokkuru,[1,3]),_).

test('promote_KO',[fail]):-
    promote(piece(south,kirin,[1,3]),_).

test('promote_KO',[fail]):-
    promote(piece(south,koropokkuru,[1,3]),_).


/*
* Tests for the correctPlacement predicate
*/
test('correctPlacement_OK',[true]):-
    correctPlacement(piece(north,kirin,[3,3]),[3,4],[piece(north,kirin,[3,3])]),
    correctPlacement(piece(north,kodama,[3,3]),[3,4],[piece(north,kodama,[4,3])]).

test('correctPlacement_KO',[fail]):-
    correctPlacement(piece(north,koropokkuru,[3,3]),[3,4],[piece(north,kirin,[3,3])]),
    correctPlacement(piece(north,kodama,[3,3]),[3,4],[piece(north,kodama,[3,5])]),
    correctPlacement(piece(south,kodama,[3,3]),[3,4],[piece(south,kodama,[3,1])]),
    correctPlacement(piece(south,kodama,[3,3]),[3,6],[piece(south,kodama,[4,1])]),
    correctPlacement(piece(south,kodama,[3,3]),[3,4],[piece(south,kodama,[3,3])]),
    correctPlacement(piece(south,kodama,[3,3]),[3,4],[piece(north,kodama,[3,1])]).

/*
* Test for the movePiece predicate
*/
%Test for kodama
test('movePiece_kodama_OK',[all(C2==[[3,3]])]):-
    movePiece(piece(south,kodama,[3,4]),piece(south,kodama,C2),[]).

test('movePiece_kodama_OK',[all(C2==[[3,5]])]):-
    movePiece(piece(north,kodama,[3,4]),piece(north,kodama,C2),[]).

test('movePiece_kodama_OK',[all(C2==[[3,3]])]):-
    movePiece(piece(south,kodama,[3,4]),piece(south,kodama,C2),[piece(north,kodama,[3,3])]).

test('movePiece_kodama_OK',[all(C2==[[3,5]])]):-
    movePiece(piece(north,kodama,[3,4]),piece(north,kodama,C2),[piece(south,kodama,[3,5])]).

test('movePiece_kodama_KO',[all(C2==[])]):-
    movePiece(piece(south,kodama,[3,4]),piece(south,kodama,C2),[piece(south,kodama,[3,3])]).

test('movePiece_kodama_KO',[all(C2==[])]):-
    movePiece(piece(north,kodama,[3,4]),piece(north,kodama,C2),[piece(north,kodama,[3,5])]).


%Test for kirin, kodama samourai and super oni since they have the same movement
test('movePiece_several_pieces_OK',[all(C2==[[4,4],[2,4],[3,3],[4,3],[2,3],[3,5]])]):-
    movePiece(piece(south,kodamaSamourai,[3,4]),piece(south,kodamaSamourai,C2),[]).

test('movePiece_several_pieces_OK',[all(C2==[[3,3],[4,3],[2,3],[3,5]])]):-
    movePiece(piece(south,kodamaSamourai,[3,4]),piece(south,kodamaSamourai,C2),[piece(south,kodama,[4,4]),piece(south,kodama,[2,4])]).

test('movePiece_several_pieces_OK',[all(C2==[[4,3]])]):-
    movePiece(piece(south,kodamaSamourai,[3,4]),piece(south,kodamaSamourai,C2),[piece(south,kodama,[4,4]),
                                                                                piece(south,kodama,[2,4]),
                                                                                piece(south,kodama,[3,3]),
                                                                                piece(north,kodama,[4,3]),
                                                                                piece(south,kodama,[2,3]),
                                                                                piece(south,kodama,[3,5])]).


test('movePiece_several_pieces_KO',[all(C2==[])]):-
    movePiece(piece(south,kodamaSamourai,[3,4]),piece(south,kodamaSamourai,C2),[piece(south,kodama,[4,4]),
                                                                                piece(south,kodama,[2,4]),
                                                                                piece(south,kodama,[3,3]),
                                                                                piece(south,kodama,[4,3]),
                                                                                piece(south,kodama,[2,3]),
                                                                                piece(south,kodama,[3,5])]).

%Tests for koropokkuru
test('movePiece_koropokkuru_OK',[all(C2==[[4,4],[2,4],[3,3],[4,3],[2,3],[3,5],[4,5],[2,5]])]):-
    movePiece(piece(south,koropokkuru,[3,4]),piece(south,koropokkuru,C2),[]).

test('movePiece_koropokkuru_OK',[all(C2==[[4,3],[4,5],[2,5]])]):-
    movePiece(piece(south,koropokkuru,[3,4]),piece(south,koropokkuru,C2),[piece(south,kodama,[4,4]),
                                                                                piece(south,kodama,[2,4]),
                                                                                piece(south,kodama,[3,3]),
                                                                                piece(north,kodama,[4,3]),
                                                                                piece(south,kodama,[2,3]),
                                                                                piece(south,kodama,[3,5])]).


test('movePiece_koropokkuru_KO',[all(C2==[])]):-
    movePiece(piece(south,koropokkuru,[3,4]),piece(south,koropokkuru,C2),[piece(south,kodama,[4,4]),
                                                                                piece(south,kodama,[2,4]),
                                                                                piece(south,kodama,[3,3]),
                                                                                piece(south,kodama,[4,3]),
                                                                                piece(south,kodama,[2,3]),
                                                                                piece(south,kodama,[3,5]),
                                                                                piece(south,kodama,[4,5]),
                                                                                piece(south,kodama,[2,5])]).

%Tests for oni
test('movePiece_oni_OK',[all(C2==[[3,3],[4,3],[2,3],[4,5],[2,5]])]):-
    movePiece(piece(south,oni,[3,4]),piece(south,oni,C2),[]).

test('movePiece_oni_OK',[all(C2==[[4,3],[4,5],[2,5]])]):-
    movePiece(piece(south,oni,[3,4]),piece(south,oni,C2),[piece(south,kodama,[3,3]),
                                                                                piece(north,kodama,[4,3]),
                                                                                piece(south,kodama,[2,3])]).


test('movePiece_oni_KO',[all(C2==[])]):-
    movePiece(piece(south,oni,[3,4]),piece(south,oni,C2),[piece(south,kodama,[3,3]),
                                                                                piece(south,kodama,[4,3]),
                                                                                piece(south,kodama,[2,3]),
                                                                                piece(south,kodama,[4,5]),
                                                                                piece(south,kodama,[2,5])]).


:- end_tests(iaYokai).