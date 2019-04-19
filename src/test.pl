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
    lastLine(south,X).

test('lastLine_OK',[true(X == 6)]):-
    lastLine(north,X).

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
    correctSquare([0,2]).

test('correctSquare_KO',[fail]):-
    correctSquare([8,4]).

test('correctSquare_KO',[fail]):-
    correctSquare([-1,3]).

test('correctSquare_KO',[fail]):-
    correctSquare([3,0]).

test('correctSquare_KO',[fail]):-
    correctSquare([2,7]).

/*
* Tests for the correctMove predicate
*/
test('correctMove_OK',[true]):-
    correctMove(piece(south,kodama,[4,4]),[4,5],[]),
    correctMove(piece(south,kodama,[4,4]),[4,5],[piece(north,kodama,[4,5])]),
    correctMove(piece(south,kodama,[4,4]),[2,5],[]),
    correctMove(piece(south,kodama,[4,4]),[4,5],[]),
    correctMove(piece(south,kodama,[4,4]),[3,5],[piece(north,kodama,[3,5])]).
    
test('correctMove_KO',[fail]):-
    correctMove(piece(south,kodama,[4,4]),[4,4],[]).

test('correctMove_KO',[fail]):-
    correctMove(piece(south,kodama,[4,4]),[4,5],[piece(south,kodama,[4,5])]).

test('correctMove_KO',[fail]):-
    correctMove(piece(south,kodama,[4,4]),[0,5],[]).

test('correctMove_KO',[fail]):-
    correctMove(piece(south,kodama,[4,6]),[4,7],[]).

test('correctMove_KO',[fail]):-
    correctMove(piece(south,kodama,[4,4]),[3,5],[piece(south,kodama,[3,5])]).

/*
* Tests for the hasEnnemy predicate
*/
test('hasEnnemy_OK',[true]):-
    hasEnnemy(south, [1,3],[piece(north,kodama,[1,3])]),
    hasEnnemy(north, [1,3],[piece(south,kirin,[1,3])]),
    hasEnnemy(south, [2,4],[piece(north,oni,[2,4])]),
    hasEnnemy(north, [1,3],[piece(south,superOni,[1,3])]),
    hasEnnemy(south, [1,3],[piece(north,koropokkuru,[4,3]),piece(north,kodama,[2,3]),piece(north,kodama,[1,3]),piece(north,kirin,[1,5])]),
    hasEnnemy(north, [1,3],[piece(north,koropokkuru,[4,3]),piece(north,kodama,[2,3]),piece(south,kodama,[1,3]),piece(north,kirin,[1,5])]).
       
test('hasEnnemy_KO',[fail]):-
    hasEnnemy(south, [1,3],[piece(south,kodama,[1,3])]).

test('hasEnnemy_KO',[fail]):-
    hasEnnemy(north, [1,3],[piece(north,kirin,[1,3])]).

test('hasEnnemy_KO',[fail]):-
    hasEnnemy(south, [2,4],[piece(south,oni,[2,4])]).

test('hasEnnemy_KO',[fail]):-
    hasEnnemy(north, [1,3],[piece(north,superOni,[1,3])]).

test('hasEnnemy_KO',[fail]):-
    hasEnnemy(south, [1,3],[piece(north,koropokkuru,[4,3]),piece(north,kodama,[2,3]),piece(south,kodama,[1,3]),piece(north,kirin,[1,5])]).

test('hasEnnemy_KO',[fail]):-
    hasEnnemy(north, [1,3],[piece(north,koropokkuru,[4,3]),piece(north,kodama,[2,3]),piece(north,kodama,[1,3]),piece(north,kirin,[1,5])]).

/*
* Tests for the promote predicate
*/
test('promote_OK',[true(X == piece(south,kodamaSamourai,[1,5]))]):-
    promote(piece(south,kodama,[1,5]),X).

test('promote_OK',[true(X == piece(south,superOni,[1,6]))]):-
    promote(piece(south,oni,[1,6]),X).

test('promote_OK',[true(X == piece(north,kodamaSamourai,[3,1]))]):-
    promote(piece(north,kodama,[3,1]),X).

test('promote_OK',[true(X == piece(north,superOni,[3,2]))]):-
    promote(piece(north,oni,[3,2]),X).


test('promote_OK',[true(X == piece(south,kodama,[1,3]))]):-
    promote(piece(south,kodama,[1,3]),X).

test('promote_OK',[true(X == piece(south,oni,[1,4]))]):-
    promote(piece(south,oni,[1,4]),X).

test('promote_OK',[true(X == piece(south,kirin,[1,3]))]):-
    promote(piece(south,kirin,[1,3]),X).

test('promote_OK',[true(X == piece(south,koropokkuru,[1,3]))]):-
    promote(piece(south,koropokkuru,[1,3]),X).

test('promote_OK',[true(X == piece(north,kirin,[1,3]))]):-
    promote(piece(north,kirin,[1,3]),X).

test('promote_OK',[true(X == piece(north,koropokkuru,[1,3]))]):-
    promote(piece(north,koropokkuru,[1,3]),X).


/*
* Tests for the correctPlacement predicate
*/
test('correctPlacement_OK',[true]):-
    correctPlacement(piece(south,kirin,[3,3]),[3,4],[piece(south,kirin,[3,3])]),
    correctPlacement(piece(south,kodama,[3,3]),[3,4],[piece(south,kodama,[4,3])]).

test('correctPlacement_KO',[fail]):-
    correctPlacement(piece(south,kodama,[3,3]),[3,4],[piece(south,kodama,[3,5])]).

test('correctPlacement_KO',[fail]):-
    correctPlacement(piece(north,kodama,[3,3]),[3,4],[piece(north,kodama,[3,1])]).

test('correctPlacement_KO',[fail]):-
    correctPlacement(piece(north,kodama,[3,3]),[3,7],[piece(north,kodama,[4,1])]).

test('correctPlacement_KO',[fail]):-
    correctPlacement(piece(north,kodama,[3,3]),[3,4],[piece(north,kodama,[3,3])]).

test('correctPlacement_KO',[fail]):-
    correctPlacement(piece(north,kodama,[3,3]),[3,1],[piece(south,kodama,[3,1])]).

/*
* Test for the movePiece predicate
*/
%Test for kodama
test('movePiece_kodama_OK',[all(C2==[[3,3]])]):-
    movePiece(piece(north,kodama,[3,4]),piece(north,kodama,C2),[]).

test('movePiece_kodama_OK',[all(C2==[[3,5]])]):-
    movePiece(piece(south,kodama,[3,4]),piece(south,kodama,C2),[]).

test('movePiece_kodama_OK',[all(C2==[[3,3]])]):-
    movePiece(piece(north,kodama,[3,4]),piece(north,kodama,C2),[piece(south,kodama,[3,3])]).

test('movePiece_kodama_OK',[all(C2==[[3,5]])]):-
    movePiece(piece(south,kodama,[3,4]),piece(south,kodama,C2),[piece(north,kodama,[3,5])]).

test('movePiece_kodama_KO',[all(C2==[])]):-
    movePiece(piece(north,kodama,[3,4]),piece(north,kodama,C2),[piece(north,kodama,[3,3])]).

test('movePiece_kodama_KO',[all(C2==[])]):-
    movePiece(piece(south,kodama,[3,4]),piece(south,kodama,C2),[piece(south,kodama,[3,5])]).


%Test for kirin, kodama samourai and super oni since they have the same movement
test('movePiece_several_pieces_OK',[all(C2==[[4,4],[2,4],[3,3],[4,3],[2,3],[3,5]])]):-
    movePiece(piece(north,kodamaSamourai,[3,4]),piece(north,kodamaSamourai,C2),[]).

test('movePiece_several_pieces_OK',[all(C2==[[3,3],[4,3],[2,3],[3,5]])]):-
    movePiece(piece(north,kodamaSamourai,[3,4]),piece(north,kodamaSamourai,C2),[piece(north,kodama,[4,4]),piece(north,kodama,[2,4])]).


test('movePiece_oni_OK',[all(P==[piece(north,superOni,[3,2]),piece(north,superOni,[4,2]),piece(north,superOni,[2,2]),piece(north,oni,[4,4]),piece(north,oni,[2,4]) ])]):-
    movePiece(piece(north,oni,[3,3]),P,[]).


test('movePiece_several_pieces_OK',[all(C2==[[4,3]])]):-
    movePiece(piece(north,kodamaSamourai,[3,4]),piece(north,kodamaSamourai,C2),[piece(north,kodama,[4,4]),
                                                                                piece(north,kodama,[2,4]),
                                                                                piece(north,kodama,[3,3]),
                                                                                piece(south,kodama,[4,3]),
                                                                                piece(north,kodama,[2,3]),
                                                                                piece(north,kodama,[3,5])]).


test('movePiece_several_pieces_KO',[all(C2==[])]):-
    movePiece(piece(north,kodamaSamourai,[3,4]),piece(north,kodamaSamourai,C2),[piece(north,kodama,[4,4]),
                                                                                piece(north,kodama,[2,4]),
                                                                                piece(north,kodama,[3,3]),
                                                                                piece(north,kodama,[4,3]),
                                                                                piece(north,kodama,[2,3]),
                                                                                piece(north,kodama,[3,5])]).

%Tests for koropokkuru
test('movePiece_koropokkuru_OK',[all(C2==[[4,4],[2,4],[3,3],[4,3],[2,3],[3,5],[4,5],[2,5]])]):-
    movePiece(piece(north,koropokkuru,[3,4]),piece(north,koropokkuru,C2),[]).

test('movePiece_koropokkuru_OK',[all(C2==[[4,3],[4,5],[2,5]])]):-
    movePiece(piece(north,koropokkuru,[3,4]),piece(north,koropokkuru,C2),[piece(north,kodama,[4,4]),
                                                                                piece(north,kodama,[2,4]),
                                                                                piece(north,kodama,[3,3]),
                                                                                piece(south,kodama,[4,3]),
                                                                                piece(north,kodama,[2,3]),
                                                                                piece(north,kodama,[3,5])]).


test('movePiece_koropokkuru_KO',[all(C2==[])]):-
    movePiece(piece(north,koropokkuru,[3,4]),piece(north,koropokkuru,C2),[piece(north,kodama,[4,4]),
                                                                                piece(north,kodama,[2,4]),
                                                                                piece(north,kodama,[3,3]),
                                                                                piece(north,kodama,[4,3]),
                                                                                piece(north,kodama,[2,3]),
                                                                                piece(north,kodama,[3,5]),
                                                                                piece(north,kodama,[4,5]),
                                                                                piece(north,kodama,[2,5])]).

%Tests for oni
test('movePiece_oni_OK',[all(C2==[[3,3],[4,3],[2,3],[4,5],[2,5]])]):-
    movePiece(piece(north,oni,[3,4]),piece(north,oni,C2),[]).

test('movePiece_oni_OK',[all(C2==[[4,3],[4,5],[2,5]])]):-
    movePiece(piece(north,oni,[3,4]),piece(north,oni,C2),[piece(north,kodama,[3,3]),
                                                                                piece(south,kodama,[4,3]),
                                                                                piece(north,kodama,[2,3])]).


test('movePiece_oni_KO',[all(C2==[])]):-
    movePiece(piece(north,oni,[3,4]),piece(north,oni,C2),[piece(north,kodama,[3,3]),
                                                                                piece(north,kodama,[4,3]),
                                                                                piece(north,kodama,[2,3]),
                                                                                piece(north,kodama,[4,5]),
                                                                                piece(north,kodama,[2,5])]).


%Tests for correctPlacement predicate
test('correctPlacement_OK',[true]):-
    correctPlacement(piece(south,oni,[1,4]),[2,3],[piece(south,oni,[2,4]),piece(south,oni,[4,3])]),
    correctPlacement(piece(south,kodama,[3,2]),[2,3],[piece(south,oni,[2,4]),piece(south,oni,[4,3])]),
    correctPlacement(piece(south,kirin,[1,4]),[2,3],[piece(south,oni,[2,4]),piece(south,oni,[2,6])]),
    correctPlacement(piece(south,oni,[1,4]),[2,3],[piece(south,oni,[2,4]),piece(south,oni,[1,1])]).

test('correctPlacement_Kodama_OK',[true]):-
    correctPlacement(piece(south,kodama,[1,4]),[2,3],[piece(north,kodama,[2,4]),piece(south,oni,[4,5])]),
    correctPlacement(piece(north,kodama,[1,4]),[2,3],[piece(south,kodama,[2,4]),piece(south,oni,[4,5])]),
    correctPlacement(piece(south,kodama,[1,4]),[2,1],[piece(south,oni,[2,4]),piece(south,oni,[4,5])]),
    correctPlacement(piece(north,kodama,[1,4]),[2,6],[piece(south,oni,[2,4]),piece(south,oni,[4,5])]).

test('correctPlacement_KO',[fail]):-
    correctPlacement(piece(south,oni,[1,4]),[2,3],[piece(south,oni,[2,3]),piece(south,oni,[4,3])]).

test('correctPlacement_KO',[fail]):-
    correctPlacement(piece(south,oni,[3,2]),[2,3],[piece(north,oni,[2,3]),piece(south,oni,[4,3])]).

test('correctPlacement_KO',[fail]):-
    correctPlacement(piece(north,oni,[1,4]),[2,3],[piece(south,oni,[2,3]),piece(south,oni,[4,3])]).

test('correctPlacement_KO',[fail]):-
    correctPlacement(piece(north,oni,[3,2]),[2,3],[piece(north,oni,[2,3]),piece(south,oni,[4,3])]).

test('correctPlacement_Kodama_KO',[fail]):-
    correctPlacement(piece(south,kodama,[1,4]),[1,3],[piece(south,kodama,[1,3]),piece(south,oni,[4,5])]).

test('correctPlacement_Kodama_KO',[fail]):-
    correctPlacement(piece(north,kodama,[1,4]),[5,3],[piece(north,kodama,[5,3]),piece(south,oni,[4,5])]).

test('correctPlacement_Kodama_KO',[fail]):-
    correctPlacement(piece(south,kodama,[1,4]),[2,7],[piece(south,oni,[2,4]),piece(south,oni,[4,5])]).

test('correctPlacement_Kodama_KO',[fail]):-
    correctPlacement(piece(north,kodama,[1,4]),[2,1],[piece(south,oni,[2,4]),piece(south,oni,[4,5])]).

/*
* Tests for place predicate
*/

test('place_OK',[true(NewLPieceTaken==[]), true(NewBoard==[piece(south,oni,[4,4])])]):-
    place(piece(south,oni,[_,_]),[4,4],[piece(south,oni,[_,_])],[],NewLPieceTaken,NewBoard).

test('place_OK',[true(NewLPieceTaken==[]), true(NewBoard==[piece(south,kodama,[4,4])])]):-
    place(piece(south,kodama,[_,_]),[4,4],[piece(south,kodama,[_,_])],[],NewLPieceTaken,NewBoard).

test('place_OK',[true(NewLPieceTaken==[]), true(NewBoard==[piece(south,kodama,[5,3])])]):-
    place(piece(south,kodama,[_,_]),[5,3],[piece(south,kodama,[_,_])],[],NewLPieceTaken,NewBoard).


test('place_south_KO',[fail]):-
    place(piece(south,kodama,[_,_]),[4,4],[piece(south,kodama,[_,_])],[piece(south,kodama,[4,2])],[],[]).

test('place_south_KO',[fail]):-
    place(piece(south,kodama,[_,_]),[6,4],[piece(south,kodama,[_,_])],[piece(south,kodama,[4,2])],[],[]).

test('place_north_KO',[fail]):-
    place(piece(north,kodama,[_,_]),[4,4],[piece(north,kodama,[_,_])],[piece(north,kodama,[4,2])],[],[]).

test('place_north_KO',[fail]):-
    place(piece(north,kodama,[_,_]),[1,4],[piece(north,kodama,[_,_])],[piece(north,kodama,[4,2])],[],[]).

test('place_north_KO',[fail]):-
    place(piece(north,oni,[_,_]),[4,4],[piece(north,oni,[_,_])],[piece(north,kodama,[4,4])],[],[]).

test('place_north_KO',[fail]):-
    place(piece(north,oni,[_,_]),[4,4],[piece(north,oni,[_,_])],[piece(south,kodama,[4,4])],[],[]).


test('place_north_KO',[fail]):-
    place(piece(north,oni,[_,_]),[0,4],[piece(north,oni,[_,_])],[piece(south,kodama,[4,4])],[],[]).

test('place_north_KO',[fail]):-
    place(piece(north,oni,[_,_]),[8,4],[piece(north,oni,[_,_])],[piece(south,kodama,[4,4])],[],[]).


test('place_north_KO',[fail]):-
    place(piece(north,oni,[_,_]),[-1,2],[piece(north,oni,[_,_])],[piece(south,kodama,[4,4])],[],[]).


/*
* Tests for demote predicate
*/
test('demote_OK',[true(X == piece(north,kodama,[1,3]))]):-
    demote(piece(south,kodamaSamourai,[1,3]),X).

test('demote_OK',[true(X == piece(north,oni,[1,3]))]):-
    demote(piece(south,superOni,[1,3]),X).

test('demote_OK',[true(X == piece(south,kodama,[1,3]))]):-
    demote(piece(north,kodamaSamourai,[1,3]),X).

test('demote_OK',[true(X == piece(south,oni,[1,3]))]):-
    demote(piece(north,superOni,[1,3]),X).


test('demote_OK',[true(X == piece(north,kirin,[1,3]))]):-
    demote(piece(south,kirin,[1,3]),X).

test('demote_OK',[true(X == piece(north,koropokkuru,[1,3]))]):-
    demote(piece(south,koropokkuru,[1,3]),X).

test('demote_OK',[true(X == piece(south,kirin,[1,3]))]):-
    demote(piece(north,kirin,[1,3]),X).

test('demote_OK',[true(X == piece(south,koropokkuru,[1,3]))]):-
    demote(piece(north,koropokkuru,[1,3]),X).


/*
* Tests for find and return predicate
*/


:- end_tests(iaYokai).