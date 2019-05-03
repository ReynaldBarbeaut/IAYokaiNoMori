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
		
		lPieces.add(new Piece("south","kodama",'B',3));
		lPieces.add(new Piece("south","kodama",'C',3));
		lPieces.add(new Piece("south","kodama",'D',3));
		
		lPieces.add(new Piece("south","oni",'A',1));
		lPieces.add(new Piece("south","oni",'E',1));
		
		lPieces.add(new Piece("south","kirin",'B',1));
		lPieces.add(new Piece("south","kirin",'D',1));
		
		lPieces.add(new Piece("south","koropokkuru",'C',1));
		
		
		lPieces.add(new Piece("north","kodama",'B',4));
		lPieces.add(new Piece("north","kodama",'C',4));
		lPieces.add(new Piece("north","kodama",'D',4));
		
		lPieces.add(new Piece("north","oni",'A',6));
		lPieces.add(new Piece("north","oni",'E',6));
		
		lPieces.add(new Piece("north","kirin",'B',6));
		lPieces.add(new Piece("north","kirin",'D',6));
		
		lPieces.add(new Piece("north","koropokkuru",'C',6));		
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
