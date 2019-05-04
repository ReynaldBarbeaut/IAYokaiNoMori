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
	
	public lPieces() {
		lPieces = new ArrayList<Piece>();
	}
	
	
	
	//Si la liste représente le plateau on peut l'initialiser
	public void initBoard() {
		lPieces = new ArrayList<Piece>();
		
		lPieces.add(new Piece("south","kodama",'2',3));
		lPieces.add(new Piece("south","kodama",'3',3));
		lPieces.add(new Piece("south","kodama",'4',3));
		
		lPieces.add(new Piece("south","oni",'1',1));
		lPieces.add(new Piece("south","oni",'5',1));
		
		lPieces.add(new Piece("south","kirin",'2',1));
		lPieces.add(new Piece("south","kirin",'4',1));
		
		lPieces.add(new Piece("south","koropokkuru",'3',1));
		
		
		lPieces.add(new Piece("north","kodama",'2',4));
		lPieces.add(new Piece("north","kodama",'3',4));
		lPieces.add(new Piece("north","kodama",'4',4));
		
		lPieces.add(new Piece("north","oni",'1',6));
		lPieces.add(new Piece("north","oni",'5',6));
		
		lPieces.add(new Piece("north","kirin",'2',6));
		lPieces.add(new Piece("north","kirin",'4',6));
		
		lPieces.add(new Piece("north","koropokkuru",'3',6));		
	}
	
	public void erase() {
		lPieces.removeAll(lPieces);
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
