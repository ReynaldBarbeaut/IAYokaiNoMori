/*
 **********************************************************
 *
 *  Programme : Piece.java
 *
 *  resume :    représente une pièce
 *
 *  date :      03 / 05 / 19
 *
 ***********************************************************
 */
public class Piece {
	
	private String team; // Equipe : north ou south
	private String name; // Nom : un parmis tout ceux disponibles
	private char col; // Colonne entre A et E
	private int lig; // Ligne entre 1 et 6
	
	public Piece(String team, String name, char col, int lig) {
		this.team = team;
		this.name= name;
		this.col = col;
		this.lig = lig;
	}
	
	
	@Override
	public String toString() {
		return "piece("+team+","+name+"["+((int) col-64)+","+lig+"])";
	}
	
	//Différent getter et setter
	
	public void setTeam(String team) {
		this.team = team;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setCol(char col) {
		this.col = col;
	}
	
	public void setLig(int lig) {
		this.lig = lig;
	}
	
	
	public String getTeam() {
		return team;
	}
	
	public String getName() {
		return name;
	}
	
	public char getCol() {
		return col;
	}
	
	public int getLig() {
		return lig;
	}
	
	

}
