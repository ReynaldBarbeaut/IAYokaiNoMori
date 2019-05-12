:-use_module(library(plunit)).
:-use_module(library(lists)).

:- include(iaYokai).

/*
* Ce prédicat est un plateau alternatif utilisés pour les futurs tests
*/
funBoard([piece(south,koropokkuru,[3,1]),
          piece(south,kirin,[4,1]),
          piece(south,oni,[5,1]),
          piece(south,kirin,[2,4]),
          piece(south,kodama,[3,4]),
          piece(south,kodamaSamourai,[1,6]),
          piece(south,kodamaSamourai,[3,4]),
          piece(north,superOni,[2,2]),
          piece(north,oni,[1,3]),
          piece(north,oni,[4,3]),
          piece(north,kodama,[1,4]),
          piece(north,kirin,[4,5]),
          piece(north,koropokkuru,[4,6])                                      
         ]).


:- begin_tests(iaYokai).

/*
* Tests pour le prédicat opponent
*/
test('opponent_OK',[true(X == south)]):-
    opponent(north,X).

test('opponent_OK',[true(X == north)]):-
    opponent(south,X).

test('opponent_KO',[fail]):-
    opponent(test,_).


/*
* Tests pour le prédicat lastLine
*/
test('lastLine_OK',[true(X == 1)]):-
    lastLine(south,X).

test('lastLine_OK',[true(X == 6)]):-
    lastLine(north,X).

test('lastLine_KO',[fail]):-
    lastLine(test,_).

/*
* Tests pour le prédicats correctSquare
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
* Tests pour le prédicat correctMove
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
* Tests pour le prédicat hasEnnemy
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
* Tests pour le prédicat promote
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
* Tests pour le prédicat correctPlacement
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
* Tests pour le prédicats movePiece
*/
%Tests pour kodama
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


%Tests pour kirin, kodama samourai and super oni since they have the same movement
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

%Tests pour le prédicat koropokkuru
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

%Tests pour le prédicat oni
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


%Tests pour le prédicat correctPlacement
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
* Tests pour le prédicat demote
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
* Tests pour le prédicat compareL
*/
test('compareL_OK',[true]):-
    compareL(piece(north,kodama,[3,3]),[[2,2],[1,3],[3,4],[3,3]]).

test('compareL_OK',[fail]):-
    compareL(piece(north,kodama,[3,3]),[[2,2],[1,3],[3,4]]).

/*
* Tests pour le prédicat inScope
*/
test('inScope_OK',[true]):-
        inScope(piece(north,kodama,[3,3]), piece(south,kodama,[3,2]),[piece(north,kodama,[3,3]), piece(south,kodama,[3,2])]),
        inScope(piece(north,kodama,[3,3]), piece(south,kodama,[3,2]),[piece(north,kodama,[3,3]), piece(south,kodama,[3,2])]),
        initialBoard(Board),
        inScope(piece(north,kodama,[2,4]), piece(south,kodama,[2,3]),Board),
        inScope(piece(south,kodama,[3,3]), piece(north,kodama,[3,4]),Board).

test('inScope_KO',[fail]):-
        inScope(piece(north,kodama,[3,3]), piece(south,kodama,[2,4]),[piece(north,kodama,[3,3]), piece(south,kodama,[2,4])]).

test('inScope_KO',[fail]):-
        initialBoard(Board),
        inScope(piece(north,koropokkuru,[3,6]), piece(south,kodama,[3,3]),Board).

test('inScope_KO',[fail]):-
        initialBoard(Board),
        inScope(piece(south,koropokkuru,[3,1]), piece(north,koropokkuru,[3,6]),Board).

test('inScope_KO',[fail]):-
        initialBoard(Board),
        inScope(piece(south,koropokkuru,[3,1]), piece(north,kodama,[3,4]),Board).

/*
* Tests pour le prédicat inTake
*/
test('inTake_OK',[true]):-
        initialBoard(Board),
        inTake(piece(north,kodama,[2,4]),north,Board,Board),
        inTake(piece(north,kodama,[3,4]),north,Board,Board),
        inTake(piece(north,kodama,[4,4]),north,Board,Board),
        inTake(piece(south,kodama,[2,3]),south,Board,Board),
        inTake(piece(south,kodama,[3,3]),south,Board,Board),
        inTake(piece(south,kodama,[4,3]),south,Board,Board).

test('inTake_KO',[fail]):-
        initialBoard(Board),
        inTake(piece(north,kirin,[2,6]),north,Board,Board).

test('inTake_KO',[fail]):-
        initialBoard(Board),
        inTake(piece(north,koropokkuru,[3,6]),north,Board,Board).

test('inTake_KO',[fail]):-
        initialBoard(Board),
        inTake(piece(north,oni,[5,6]),north,Board,Board).

test('inTake_KO',[fail]):-
        initialBoard(Board),
        inTake(piece(south,kirin,[2,1]),south,Board,Board).

test('inTake_KO',[fail]):-
        initialBoard(Board),
        inTake(piece(south,koropokkuru,[3,1]),south,Board,Board).

test('inTake_KO',[fail]):-
        initialBoard(Board),
        inTake(piece(south,oni,[5,1]),south,Board,Board).

/*
* Tests pour le prédicat distance
*/
test('distance_OK',[true(Dist==1.4142135623730951)]):-
        distance([4,4],[3,3],Dist).

test('distance_OK',[true(Dist==3.605551275463989)]):-
        distance([1,5],[4,3],Dist).

/*
* Tests pour le prédicat riskedCost
*/
test('riskedCost_OK',[true(Cost==40)]):-
        funBoard(Board),
        riskedCost(piece(north,superOni,[2,2]),Board,Cost).

test('riskedCost_OK',[true(Cost==10)]):-
        funBoard(Board),
        riskedCost(piece(north,kodama,[1,4]),Board,Cost).

test('riskedCost_OK',[true(Cost==50)]):-
        funBoard(Board),
        riskedCost(piece(south,kirin,[2,4]),Board,Cost).

test('riskedCost_OK',[true(Cost==150)]):-
        funBoard(Board),
        riskedCost(piece(south,koropokkuru,[3,1]),Board,Cost).

test('riskedCost_OK',[true(Cost==0)]):-
        funBoard(Board),
        riskedCost(piece(south,kodamaSamourai,[1,6]),Board,Cost).

test('riskedCost_OK',[true(Cost==0)]):-
        funBoard(Board),
        riskedCost(piece(north,koropokkuru,[4,6]),Board,Cost).

/*
* Tests pour le prédicat getCoordinate
*/
test('getCoordinate_OK',[true(C==[3,6])]):-
        initialBoard(Board),
        getCoordinate(north,koropokkuru,Board,C).

test('getCoordinate_OK',[true(C==[3,1])]):-
        initialBoard(Board),
        getCoordinate(south,koropokkuru,Board,C).

test('getCoordinate_OK',[true(C==[4,6])]):-
        funBoard(Board),
        getCoordinate(north,koropokkuru,Board,C).

/*
* Tests pour le prédicat bestMove
*/
test('bestMove_OK',[true(BestMove==[[piece(south,kodama,[1,4])],[piece(south,kirin,[1,4]),piece(south,koropokkuru,[3,1]),piece(south,kirin,[4,1]),piece(south,oni,[5,1]),piece(south,kodama,[3,4]),piece(south,kodamaSamourai,[1,6]),piece(south,kodamaSamourai,[3,4]),piece(north,superOni,[2,2]),piece(north,oni,[1,3]),piece(north,oni,[4,3]),piece(north,kirin,[4,5]),piece(north,koropokkuru,[4,6])],piece(south,kirin,[2,4]),piece(south,kirin,[1,4])])]):-
        funBoard(Board),
        bestMove(piece(south,kirin,[2,4]),[],Board,BestMove,_).

test('bestMove_OK',[true(BestMove==[[piece(north,kirin,[2,4])],[piece(north,oni,[2,4]),piece(south,koropokkuru,[3,1]),piece(south,kirin,[4,1]),piece(south,oni,[5,1]),piece(south,kodama,[3,4]),piece(south,kodamaSamourai,[1,6]),piece(south,kodamaSamourai,[3,4]),piece(north,superOni,[2,2]),piece(north,oni,[4,3]),piece(north,kodama,[1,4]),piece(north,kirin,[4,5]),piece(north,koropokkuru,[4,6])],piece(north,oni,[1,3]),piece(north,oni,[2,4])])]):-
        funBoard(Board),
        bestMove(piece(north,oni,[1,3]),[],Board,BestMove,_).

test('bestMove_OK',[true(BestMove==[[piece(north,koropokkuru,[3,1])],[piece(north,oni,[3,1]),piece(south,kirin,[4,1]),piece(south,oni,[5,1]),piece(south,kirin,[2,4]),piece(south,kodama,[3,4]),piece(south,kodamaSamourai,[1,6]),piece(south,kodamaSamourai,[3,4]),piece(north,superOni,[2,2]),piece(north,oni,[1,3]),piece(north,oni,[4,3]),piece(north,kodama,[1,4]),piece(north,kirin,[4,5]),piece(north,koropokkuru,[4,6])],piece(north,oni,[2,2]),piece(north,superOni,[3,1])])]):-
        funBoard(Board),
        bestMove(piece(north,oni,[2,2]),[],Board,BestMove,_).

test('bestMove_OK',[true(BestMove==[])]):-
        funBoard(Board),
        bestMove(piece(north,kodama,[1,4]),[],Board,BestMove,_).

/*
* Tests pour le prédicat bestSideMove
*/
test('bestSideMove_OK',[true(BestMove==[[piece(north,koropokkuru,[3,1])],[piece(north,superOni,[3,1]),piece(south,kirin,[4,1]),piece(south,oni,[5,1]),piece(south,kirin,[2,4]),piece(south,kodama,[3,4]),piece(south,kodamaSamourai,[1,6]),piece(south,kodamaSamourai,[3,4]),piece(north,oni,[1,3]),piece(north,oni,[4,3]),piece(north,kodama,[1,4]),piece(north,kirin,[4,5]),piece(north,koropokkuru,[4,6])],piece(north,superOni,[2,2]),piece(north,superOni,[3,1])])]):-
        funBoard(Board),
        bestSideMove(north,[],Board,BestMove,_). 


test('bestSideMove_OK',[true(BestMove==[[piece(north,kodama,[3,3])],[piece(north,kodama,[3,3]),piece(south,kodama,[2,3]),piece(south,kodama,[4,3]),piece(south,oni,[1,1]),piece(south,oni,[5,1]),piece(south,kirin,[2,1]),piece(south,kirin,[4,1]),piece(south,koropokkuru,[3,1]),piece(north,kodama,[2,4]),piece(north,kodama,[4,4]),piece(north,oni,[1,6]),piece(north,oni,[5,6]),piece(north,kirin,[2,6]),piece(north,kirin,[4,6]),piece(north,koropokkuru,[3,6])],piece(north,kodama,[3,4]),piece(north,kodama,[3,3])])]):-
        initialBoard(Board),
        bestSideMove(north,[],Board,BestMove,_).

test('bestSideMove_OK',[true(BestMove==[[piece(south,kodama,[3,4])],[piece(south,kodama,[3,4]),piece(south,kodama,[2,3]),piece(south,kodama,[4,3]),piece(south,oni,[1,1]),piece(south,oni,[5,1]),piece(south,kirin,[2,1]),piece(south,kirin,[4,1]),piece(south,koropokkuru,[3,1]),piece(north,kodama,[2,4]),piece(north,kodama,[4,4]),piece(north,oni,[1,6]),piece(north,oni,[5,6]),piece(north,kirin,[2,6]),piece(north,kirin,[4,6]),piece(north,koropokkuru,[3,6])],piece(south,kodama,[3,3]),piece(south,kodama,[3,4])])]):-
        initialBoard(Board),
        bestSideMove(south,[],Board,BestMove,_).

/*
* Tests pour le prédicat freeSquare
*/
test('freeSquare_OK',[true(LSquare==[[1,2],[1,3],[1,4],[1,5],[2,2],[2,5],[3,2],[3,5],[4,2],[4,5],[5,2],[5,3],[5,4],[5,5]])]):-
        initialBoard(Board),
        freeSquare(Board,LSquare).

test('freeSquare_OK',[true(LSquare==[[1,1],[1,2],[1,5],[2,1],[2,3],[2,5],[2,6],[3,2],[3,3],[3,5],[3,6],[4,2],[4,4],[5,2],[5,3],[5,4],[5,5],[5,6]])]):-
        funBoard(Board),
        freeSquare(Board,LSquare).


/*
* Tests pour le prédicat bestPiece
*/
test('bestPiece_OK',[true(BestPiece==piece(north,kirin,C))]):-
        bestPiece([piece(north,kodama,_),piece(north,kirin,C)],_,0,BestPiece).

test('bestPiece_OK',[true(BestPiece==piece(north,kirin,C))]):-
        bestPiece([piece(north,kirin,C),piece(north,kirin,_)],_,0,BestPiece).

test('bestPiece_OK',[true(BestPiece==piece(south,kirin,C))]):-
        bestPiece([piece(south,oni,_),piece(south,kirin,C)],_,0,BestPiece).

test('bestPiece_OK',[true(BestPiece==piece(south,kodama,C))]):-
        bestPiece([piece(south,kodama,C),piece(south,kodama,_)],_,0,BestPiece).

test('bestPiece_OK',[true(BestPiece==piece(south,oni,C))]):-
        bestPiece([piece(south,kodama,_),piece(south,oni,C)],_,0,BestPiece).

/*
* Tests pour le prédicats computePlacementPoint
*/
test('computePlacementPoint_OK',[true(Cost== -51.0)]):-
        funBoard(Board),
        computePlacementPoint(piece(north,kirin,[2,1]),Board,Cost).

test('computePlacementPoint_OK',[true(Cost== -13.16227766016838)]):-
        funBoard(Board),
        computePlacementPoint(piece(north,kodama,[4,4]),Board,Cost).

/*
* Tests pour le prédicat bestPlacement
*/
test('bestPlacement_OK',[true(BestPlacement== piece(north,kirin,[1,1]))]):-
        funBoard(Board),
        bestPlacement([piece(north,kodama,_),piece(north,kirin,_)],Board,_,BestPlacement,_).

test('bestPlacement_OK',[true(BestPlacement== piece(north,kirin,[1,1]))]):-
        funBoard(Board),
        bestPlacement([piece(north,oni,_),piece(north,kirin,_)],Board,_,BestPlacement,_).

test('bestPlacement_OK',[true(BestPlacement== piece(north,oni,[1,1]))]):-
        funBoard(Board),
        bestPlacement([piece(north,kodama,_),piece(north,oni,_)],Board,_,BestPlacement,_).



/*
* Tests pour le prédicat bestAction
*/
test('bestAction_Stop_Check_OK',[true(Type==capture), true(P1==piece(south,kirin,[2,2])), true(P2 == piece(south,kirin,[3,2]))]):-
    bestAction(south,[piece(south,koropokkuru,[3,1]),piece(north,kodama,[3,2]),piece(north,kodama,[3,3]),piece(south,kirin,[2,2]),piece(north,koropokkuru,[5,5])],[],Type,P1,P2).

test('bestAction_Round1_South',[true(Type==capture), true(P1==piece(south,kodama,[3,3])), true(P2 == piece(south,kodama,[3,4]))]):-
    initialBoard(Board),
    bestAction(south,Board,[],Type,P1,P2).

test('bestAction_Round1_North',[true(Type==capture), true(P1==piece(north,kodama,[3,4])), true(P2 == piece(north,kodama,[3,3]))]):-
    initialBoard(Board),
    bestAction(north,Board,[],Type,P1,P2).

test('bestAction_North',[true(Type==capture), true(P1==piece(north,superOni,[2,2])), true(P2 == piece(north,superOni,[3,1]))]):-
    funBoard(Board),
    bestAction(north,Board,[],Type,P1,P2).


:- end_tests(iaYokai).