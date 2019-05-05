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

public class lPieces {
	private ArrayList<Piece> lPieces = null;
	
	public lPieces(boolean isBoard) {
		lPieces = new ArrayList<Piece>();
	}
	
	
	
	//Si la liste représente le plateau on peut linitialiser
	public void initBoard() {
		lPieces = new ArrayList<Piece>();
		
		lPieces.add(new Piece("south","kodama",2,3));
		lPieces.add(new Piece("south","kodama",3,3));
		lPieces.add(new Piece("south","kodama",4,3));
		
		lPieces.add(new Piece("south","oni",1,1));
		lPieces.add(new Piece("south","oni",5,1));
		
		lPieces.add(new Piece("south","kirin",2,1));
		lPieces.add(new Piece("south","kirin",4,1));
		
		lPieces.add(new Piece("south","koropokkuru",3,1));
		
		
		lPieces.add(new Piece("north","kodama",2,4));
		lPieces.add(new Piece("north","kodama",3,4));
		lPieces.add(new Piece("north","kodama",4,4));
		
		lPieces.add(new Piece("north","oni",1,6));
		lPieces.add(new Piece("north","oni",5,6));
		
		lPieces.add(new Piece("north","kirin",2,6));
		lPieces.add(new Piece("north","kirin",4,6));
		
		lPieces.add(new Piece("north","koropokkuru",3,6));
	}
	
	public void erase() {
		lPieces.removeAll(lPieces);
	}

	/*
	*	Met à jour le plateau de jeu en fonction d'une pièce
	*/
	public void updateBoard(Piece p){
		int index = checkCoordinate(p.getCol(),p.getLig());
		if(index > 0){
			lPieces.remove(index);
		}
		lPieces.add(p);
	}

	public void updateHand(int type, Piece p){
		if(type == 0){
			lPieces.add(p);
		}else {
			removePiece(p);
		}
	}


	//Retire une pièce de la liste
	public void removePiece(Piece p){
		/*
		* Ce boolean permet de gérer les doublons présent par exemple dans la main du joueur
		* par exemple si dans sa main il y a 2 kodama on va retirer que le premier
		 */
		boolean estRetirer = false;
		int i = 0;
		while(!estRetirer) {
			if (lPieces.get(i).equals(p)) {
				lPieces.remove(i);
				estRetirer = true;
			}
			i++;
		}
	}

	/*
	*	Regarde si des coordonnées correspondent à celle d'une pièce de la liste
	*   et retourne l'indice si c'est le cas
	*/

	public int checkCoordinate(int col, int lig){
		for(int i = 0; i < lPieces.size(); i++){
			if(lPieces.get(i).getCol()==col && lPieces.get(i).getLig() == lig){
				return i;
			}
		}
		return -1;
	}


	
	@Override
	public String toString() {
		if(lPieces.size()==0) {
			return "[]";
		}
		String str = "[";
		for(int i = 0; i< lPieces.size(); i++) {
			str += lPieces.get(i).toString()+",";
		}
		return str.substring(0,str.length()-1) + "]";
	}

}
