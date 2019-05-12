/*Barbeaut Reynald - Bouchard Nicolas
*
* Ce fichier contient les sources de notre IA,
* cette dernière a été développé dans le cadre
* d'un projet d'IA de l'UE MOIA
*
*
*/

:-use_module(library(clpfd)).
:-use_module(library(plunit)).
:-use_module(library(lists)).
:-use_module(library(between)).

% Flag pour afficher les listes longues
:-set_prolog_flag(toplevel_print_options,
    [quoted(true), portrayed(true), max_depth(0)]).


/*
*       Initialisation du plateau
*/

/*
* Une pièce est définie par son
* équipe son nom et ses coordonnées
*/

/*
* Positions initiales pour le joueur sud
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
* Positions initiales pour le joueur sud
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
* Création du plateau initial
*/
initialBoard(Board) :-
    findall(Piece, initial(Piece), Board).
/*
* Declare the opponent for each side
*/
opponent(north,south).
opponent(south,north).

/*
* Retourne la dernière ligne d'un côté
*/
lastLine(south,1).
lastLine(north,6).


/*
* Regarde si une case est dans le plateau
*/
correctSquare([X,Y]) :- X > 0, X < 6, Y > 0, Y < 7.

/*
* Test si un mouvement est correcte
*/
correctMove(piece(Player,_,C1),C2,Board) :-
        C1 \= C2,
        \+(member(piece(Player, _, C2), Board)),
        correctSquare(C2).


/*
* Test s'il y a un ennemi sur la case C
*/
hasEnnemy(Player, C,Board) :-
    opponent(Player,Player2),
    member(piece(Player2,_,C),Board).

/*
*  Prédicats pour déplacer une pièce
*/

/*
* Déplacement sur les côtés (commun aux 2 camps)
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
* Déplacement pour une pièce qui regarde le sud
*/

/*
* Déplacement avant
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name2,[X,Y2]),Board) :-
    Y2 is Y + 1,
    correctMove(piece(south,_,[X,Y]),[X,Y2],Board),
    promote(piece(south,Name,[X,Y2]),piece(_,Name2,_)).

/*
* Déplacement avant-gauche et avant-droite
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
* Déplacement arrière
*/
movePiece(piece(south,Name,[X,Y]),piece(south,Name2,[X,Y2]),Board) :-
    Name \= kodama,
    Name \= oni,
    Y2 is Y - 1,
    correctMove(piece(south,Name,[X,Y]),[X,Y2],Board),
    promote(piece(south,Name,[X,Y2]),piece(_,Name2,_)).


/*
* Déplacement arrière-gauche et arrière-droite
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
* Déplacement pour une pièce qui regarde le nord
*/

/*
* Déplacement avant
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name2,[X,Y2]),Board) :-
    Y2 is Y - 1,
    correctMove(piece(north,_,[X,Y]),[X,Y2],Board),
    promote(piece(north,Name,[X,Y2]),piece(_,Name2,_)).

/*
* Déplacement avant-gauche et avant-droite
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
* Déplacement arrière
*/
movePiece(piece(north,Name,[X,Y]),piece(north,Name2,[X,Y2]),Board) :-
    Name \= kodama,
    Name \= oni,
    Y2 is Y + 1,
    correctMove(piece(north,Name,[X,Y]),[X,Y2],Board),
    promote(piece(north,Name,[X,Y2]),piece(_,Name2,_)).


/*
* Déplacement arrière-gauche et arrière-droite
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
* Trouve un pièce en fonction de son équipe et de ses coordonnées
*/

findAndReturn(Player,Coordinate,[piece(Player,Name,Coordinate)|_],piece(Player,Name,Coordinate)).
findAndReturn(Player,Coordinate,[_|List],P):-
        findAndReturn(Player,Coordinate,List,P).

/*
* Capture un ennemi
*/
capture(Player,C,Hand,Board,NewHand,NewBoard):-
    opponent(Player,Player2),
    findAndReturn(Player2,C,Board,piece(Player2,Name,C2)),
    demote(piece(Player2,Name,C2),Piece),
    NewHand = [Piece|Hand],
    delete(Board,piece(Player2,Name,C2),NewBoard).


/*
* Déplace et capture s'il y a un ennemi
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
* Regarde si une pièce est dans la zone de promotion
*/
inPromoteArea(north,Y) :- (Y=1;Y=2).

inPromoteArea(south,Y) :- (Y=5;Y=6).

/*
* Passe une pièce au niveau supérieur
*/
promote(piece(Player,kodama,[X,Y]),piece(Player,kodamaSamourai,[X,Y])) :-
   inPromoteArea(Player,Y),!. 

promote(piece(Player,oni,[X,Y]),piece(Player,superOni,[X,Y])) :-
   inPromoteArea(Player,Y),!.

promote(Piece,Piece).


/*
* Rétrograde une pièce
*/
demote(piece(Player,kodamaSamourai,C),piece(Player2,kodama,C)):-opponent(Player,Player2),!.

demote(piece(Player,superOni,C),piece(Player2,oni,C)):-opponent(Player,Player2),!.

demote(piece(Player,Name,C),piece(Player2,Name,C)):-opponent(Player,Player2).


/*
* Regarde si les coordonnées d'une pièce sont présentes dans une liste de coordonnées
*/
compareL(piece(_,_,C2),[C|_]):-
    C2=C,!.
compareL(Piece,[_|L]):-
    compareL(Piece,L).

/*
* Regarde si une pièce est juste à  côté d'une autre pièce
*/
inScope(Piece, piece(Player,Name,C),Board):-
    findall(C2,
            movePiece(piece(Player,Name,C),piece(_,_,C2),Board),
            LC),
    compareL(Piece,LC).

/*
* Regarde si une pièce est à  côté d'une des pièces de l'ennemi
*/
inTake(Piece,Player,Board,[piece(Player2,Name,C)|_]):-
    opponent(Player,Player3),
    Player2 = Player3,
    inScope(Piece,piece(Player2,Name,C),Board),!.
inTake(Piece,Player,Board,[_|L]):-
    inTake(Piece,Player,Board,L).

/*
* Points pour chaque pièce
*/
points(kodama,10).
points(kodamaSamourai,20).
points(oni,30).
points(superOni,40).
points(kirin,50).
points(koropokkuru,150).

/*
* Calcul la distance entre 2 points
*/
distance([X,Y],[X2,Y2],Dist):-
    Dist is sqrt((X2-X)*(X2-X) + (Y2-Y)*(Y2-Y)). 

/*
* Calcul le coût risqué d'une pièce
*/
riskedCost(piece(Player,Name,C),Board,0):-
    \+inTake(piece(Player,Name,C),Player,Board,Board),!.

riskedCost(piece(Player,Name,C),Board,Cost):-
    inTake(piece(Player,Name,C),Player,Board,Board),
    points(Name,Cost),!.

/*
* Retourne les coordonnées d'une pièce (utilisé dans cette IA uniquement pour le koropokkuru
*   c'est pour cela que les doublons ne sont pas vérifiés)
*/
getCoordinate(Player,Name,[piece(Player,Name,Coordinate)|_],Coordinate).
getCoordinate(Player,Name,[_|List],P):-
        getCoordinate(Player,Name,List,P).

/*
* Trouve tous les mouvements possibles pour une pièce
*/
possibleMoves(P,Hand,Board,LMoves) :-
    findall([NewHand,NewBoard,P,P2],movement(P,Hand,Board,NewHand,NewBoard,P2),LMoves).

/*
* Calcul les points d'un mouvement
*/
computePoints([NewHand,NewBoard,_,piece(Player,Name2,C2)],Hand,Board,Cost):-
    getCoordinate(Player,koropokkuru,Board,C),
    getCoordinate(Player,koropokkuru,NewBoard,C1),
    inTake(piece(Player,koropokkuru,C),Player,Board,Board),
    \+inTake(piece(Player,koropokkuru,C1),Player,NewBoard,NewBoard),
    NewHand \= Hand,
    NewHand = [piece(Player,Name3,_)|_],
    points(Name3,Point),
    opponent(Player,Player2),
    getCoordinate(Player2,koropokkuru,Board,C3),
    distance(C2,C3,Distance),
    riskedCost(piece(Player,Name2,C2),Board,RiskedCost),
    Cost is 1000 + Point - Distance - RiskedCost,!.  

computePoints([NewHand,NewBoard,_,piece(Player,Name2,C2)],Hand,Board,Cost):-
    getCoordinate(Player,koropokkuru,Board,C),
    getCoordinate(Player,koropokkuru,NewBoard,C1),
    inTake(piece(Player,koropokkuru,C),Player,Board,Board),
    \+inTake(piece(Player,koropokkuru,C1),Player,NewBoard,NewBoard),
    NewHand = Hand,
    opponent(Player,Player2),
    getCoordinate(Player2,koropokkuru,Board,C3),
    distance(C2,C3,Distance),
    riskedCost(piece(Player,Name2,C2),Board,RiskedCost),
    Cost is 1000 - Distance - RiskedCost,!. 

computePoints([NewHand,_,_,piece(Player,Name2,C2)],Hand,Board,Cost):-
    NewHand \= Hand,
    NewHand = [piece(Player,Name3,_)|_],
    points(Name3,Point),
    opponent(Player,Player2),
    getCoordinate(Player2,koropokkuru,Board,C3),
    distance(C2,C3,Distance),
    riskedCost(piece(Player,Name2,C2),Board,RiskedCost),
    Cost is Point - Distance - RiskedCost,!.  


computePoints([NewHand,_,_,piece(Player,Name2,C2)],Hand,Board,Cost):-
    NewHand = Hand,
    opponent(Player,Player2),
    getCoordinate(Player2,koropokkuru,Board,C3),
    distance(C2,C3,Distance),
    riskedCost(piece(Player,Name2,C2),Board,RiskedCost),
    Cost is 0 - Distance - RiskedCost,!.

/*
* Traverse une liste de coups et garde le meilleur
*/     
bestFromList([],_,_,RecordMove,RecordCost,RecordMove,RecordCost).

bestFromList([Move|LMove],Hand,Board,_,CurrentBestCost,RecordMode,RecordCost):-
    computePoints(Move,Hand,Board,NewCost),
    NewCost > CurrentBestCost,
    bestFromList(LMove,Hand,Board,Move,NewCost,RecordMode,RecordCost).


bestFromList([Move|LMove],Hand,Board,CurrentBestMove,CurrentBestCost,RecordMode,RecordCost):-
    computePoints(Move,Hand,Board,NewCost),
    NewCost =< CurrentBestCost,
    bestFromList(LMove,Hand,Board,CurrentBestMove,CurrentBestCost,RecordMode,RecordCost).


/*
* Calcul le meilleur coup d'une liste
*/
bestMove(P,Hand,Board,[],-10000):-
    possibleMoves(P,Hand,Board,LMoves),
    LMoves = [].



bestMove(P,Hand,Board,BestMove,BestCost):-
    possibleMoves(P,Hand,Board,LMoves),
    LMoves \= [],
    LMoves = [FirstMove | _],
    computePoints(FirstMove,Hand,Board,FirstCost),
    bestFromList(LMoves,Hand,Board,FirstMove,FirstCost,BestMove,BestCost).


/*
* Traverse une liste de pièce pour un côté et retourne le meilleur coup de chacune d'entre elle
*/
bestSideMoveList(_,_,[],_,BestMove,BestCost,BestMove,BestCost):-!.

bestSideMoveList(Player,Hand,[piece(Player2,_,_)|LPieces],Board,CurrentBestMove,CurrentBestCost,BestMove,BestCost):-  
    Player \= Player2,
    bestSideMoveList(Player,Hand,LPieces,Board,CurrentBestMove,CurrentBestCost,BestMove,BestCost),!.

bestSideMoveList(Player,Hand,[piece(Player,Name,C)|LPieces],Board,_,CurrentBestCost,BestMove,BestCost):-  
    bestMove(piece(Player,Name,C),Hand,Board,NewBestMove,NewBestCost),
    NewBestCost > CurrentBestCost,
    bestSideMoveList(Player,Hand,LPieces,Board,NewBestMove,NewBestCost,BestMove,BestCost).

bestSideMoveList(Player,Hand,[piece(Player,Name,C)|LPieces],Board,CurrentBestMove,CurrentBestCost,BestMove,BestCost):-  
    bestMove(piece(Player,Name,C),Hand,Board,_,NewBestCost),
    NewBestCost =< CurrentBestCost,
    bestSideMoveList(Player,Hand,LPieces,Board,CurrentBestMove,CurrentBestCost,BestMove,BestCost).

/*
* Calcul le meilleur coup parmis les meilleurs coups de toutes les pièces d'un côté
*/
bestSideMove(Player,Hand,Board,BestMove,BestCost) :-
    bestSideMoveList(Player,Hand,Board,Board,[],-1000,BestMove,BestCost).   


/*
* Donne toutes les cases libres du plateau
*/
freeSquare(Board,LSquare):- 
    findall([X,Y],(between(1,5,X),between(1,6,Y),\+member(piece(_,_,[X,Y]),Board)),LSquare).

/*
* Vérifie si le placement d'une pièce différente qu'un kodama est correcte
*/
correctPlacement(piece(_,Name,_),C2,Board) :-
    Name \= kodama,
    \+(member(piece(_, _, C2), Board)),
    correctSquare(C2).

/*
* Vérifie si le placement d'un kodama est correct
*/
correctPlacement(piece(Player,kodama,_),[X,Y],Board) :-
    \+(member(piece(_, _, [X,Y]), Board)),
    correctSquare([X,Y]),
    \+(member(piece(Player, kodama, [X,_]), Board)),
    opponent(Player,Player2),
    lastLine(Player2,LastLine),
    Y \= LastLine.
        

/*
* Prend la meilleure pièce d'une main
*/
bestPiece([],CurrentBestPiece,_,CurrentBestPiece).

bestPiece([piece(_,Name,_)|Hand],CurrentBestPiece,CurrentBestPoint,BestPiece):-
        points(Name,Point),
        Point =< CurrentBestPoint,
        bestPiece(Hand,CurrentBestPiece,CurrentBestPoint,BestPiece). 

bestPiece([piece(Player,Name,C)|Hand],_,CurrentBestPoint,BestPiece):-
        points(Name,Point),
        Point > CurrentBestPoint,
        bestPiece(Hand,piece(Player,Name,C),Point,BestPiece).  

/*
* Calcule du coût d'un placement
*/ 
computePlacementPoint(piece(Player,Name,C),Board,Cost):-
    opponent(Player,Player2),
    getCoordinate(Player2,koropokkuru,Board,C3),
    distance(C,C3,Distance),
    riskedCost(piece(Player,Name,C),Board,RiskedCost),
    Cost is 0 - Distance - RiskedCost. 


/*
* Calcul le meilleur placement sur le plateau
*/

bestPlacementComputation([],_,_,BestPlacement,BestCost,BestPlacement,BestCost).


bestPlacementComputation([C | LSquare],piece(Player,Name,_),Board,CurrentBestPlacement,CurrentBestCost,BestPlacement,BestCost):-
    \+correctPlacement(piece(Player,Name,_),C,Board),
    bestPlacementComputation(LSquare,piece(Player,Name,_),Board,CurrentBestPlacement,CurrentBestCost,BestPlacement,BestCost).


bestPlacementComputation([C | LSquare],piece(Player,Name,_),Board,CurrentBestPlacement,CurrentBestCost,BestPlacement,BestCost):-
    correctPlacement(piece(Player,Name,_),C,Board),
    computePlacementPoint(piece(Player,Name,C),Board,Cost),
    Cost =< CurrentBestCost,
    bestPlacementComputation(LSquare,piece(Player,Name,_),Board,CurrentBestPlacement,CurrentBestCost,BestPlacement,BestCost).

bestPlacementComputation([C | LSquare],piece(Player,Name,_),Board,_,CurrentBestCost,BestPlacement,BestCost):-
    correctPlacement(piece(Player,Name,_),C,Board),
    computePlacementPoint(piece(Player,Name,C),Board,Cost),
    Cost > CurrentBestCost,
    bestPlacementComputation(LSquare,piece(Player,Name,_),Board,piece(Player,Name,C),Cost,BestPlacement,BestCost).

/*
* Donne le meilleur placement avec la meilleur pièce
*/
bestPlacement([],_,_,_,-1000):-!.

bestPlacement(Hand,Board,NewHand,BestPlacement,BestCost):-
    Hand = [P | _],
    bestPiece(Hand,P,-1000,BestPiece),
    delete(Hand,BestPiece,NewHand),
    freeSquare(Board,LSquare),
    bestPlacementComputation(LSquare,BestPiece,Board,BestPiece,-1000,BestPlacement,BestCost),!.


/*
* Donne la meilleure action à faire
*/

bestAction(Player,Board, Hand, capture, P, P2) :-
    bestSideMove(Player,Hand,Board,BestMove,BestCost),
    bestPlacement(Hand,Board,_,_,BestPlacementCost),
    BestCost >= BestPlacementCost,
    BestMove = [NewHand,_,P,P2],
    NewHand \= Hand,!.
    
bestAction(Player,Board, Hand, move, P, P2) :-
    bestSideMove(Player,Hand,Board,BestMove,BestCost),
    bestPlacement(Hand,Board,_,_,BestPlacementCost),
    BestCost >= BestPlacementCost,
    BestMove = [NewHand,_,P,P2],
    NewHand == Hand,!.


bestAction(Player,Board, Hand, placement, BestPlacement, BestPlacement) :-
    bestSideMove(Player,Hand,Board,_,BestCost),
    bestPlacement(Hand,Board,_,BestPlacement,BestPlacementCost),
    BestCost < BestPlacementCost,!.

