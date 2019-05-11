/*
 **********************************************************
 *
 *  Programme : lPieces.java
 *
 *  resume :    représente une liste de pièces
 *
 *  date :      03 / 05 / 19
 *
 ***********************************************************
 */
import java.util.ArrayList;
import java.util.List;

public class lPieces {
	private ArrayList<Piece> board = null;
	private ArrayList<Piece> hand = null;
	
	public lPieces() {
		board = new ArrayList<Piece>();
		hand = new ArrayList<Piece>();
	}
	
	
	
	//Si la liste représente le plateau on peut linitialiser
	public void initBoard() {
		board.add(new Piece("south","kodama",2,3));
		board.add(new Piece("south","kodama",3,3));
		board.add(new Piece("south","kodama",4,3));

		board.add(new Piece("south","oni",1,1));
		board.add(new Piece("south","oni",5,1));

		board.add(new Piece("south","kirin",2,1));
		board.add(new Piece("south","kirin",4,1));

		board.add(new Piece("south","koropokkuru",3,1));


		board.add(new Piece("north","kodama",2,4));
		board.add(new Piece("north","kodama",3,4));
		board.add(new Piece("north","kodama",4,4));

		board.add(new Piece("north","oni",1,6));
		board.add(new Piece("north","oni",5,6));
		board.add(new Piece("north","kirin",2,6));
		board.add(new Piece("north","kirin",4,6));

		board.add(new Piece("north","koropokkuru",3,6));
	}

	/*
	* Efface la main du joueur et le plateau de jeu
	*/
	public void erase() {
		board.removeAll(board);
		hand.removeAll(hand);
	}

	/*
	*	Retire une pièce du plateau
	*/
	public void removeBoard(int col, int lig){
		board.remove(checkCoordinate(col,lig));
	}

	/*
	*	Ajout une pièce au plateau
	*/
	public void addToBoard(Piece p){
		board.add(p);
	}

	/*
	*	Ajout d'une pièce à la main
	*/
	public void addHand(Piece p){
		p.demote();
		hand.add(p);
	}

	/*
	*	Retire une pièce de la main
	*/
	public void removeHand(Piece p){
		hand.remove(findPieceInHand(p));
	}

	/*
	*	Regarde si une pièce est dans la main et retourne son indice si
	* 	elle est trouvée
	*/
	public int findPieceInHand(Piece p){
		for(int i = 0; i < hand.size(); i++){
			if(hand.get(i).getName() == p.getName()){
				return i;
			}
		}
		return -1;

	}

	/*
	*	Regarde si des coordonnées correspondent à celle d'une pièce de la liste
	*   et retourne l'indice si c'est le cas
	*/

	public int checkCoordinate(int col, int lig){
		for(int i = 0; i < board.size(); i++){
			if(board.get(i).getCol()==col && board.get(i).getLig() == lig){
				return i;
			}
		}
		return -1;
	}


	public String toString(ArrayList<Piece>lpieces) {
		if(lpieces.size()==0) {
			return "[]";
		}
		String str = "[";
		for(int i = 0; i< lpieces.size(); i++) {
			str += lpieces.get(i).toString()+",";
		}
		return str.substring(0,str.length()-1) + "]";
	}

	public ArrayList<Piece> getBoard() {
		return board;
	}

	public ArrayList<Piece> getHand() {
		return hand;
	}
}
