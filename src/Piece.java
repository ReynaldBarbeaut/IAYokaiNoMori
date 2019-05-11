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
	private int col; // Colonne entre 1 et 5
	private int lig; // Ligne entre 1 et 6
	
	public Piece(String team, String name, int col, int lig) {
		this.team = team;
		this.name= name;
		this.col = col;
		this.lig = lig;
	}


	/*
	*	Transforme le nom de la pièce en entier
	*/
	public int nameToInt() {
		switch(name) {
			case "kodama":
				return 0;
			case "kodamaSamourai":
				return 1;
			case "kirin":
				return 2;
			case "koropokkuru":
				return 3;
			case "oni":
				return 4;
			default:
				return 5;
		}
	}

	/*
	* Fait passe une pièce d'un niveau
	*/
	public void promote(){
		if(inPromoteArea()){
			if(this.name.equals("kodama")){
				this.name = "kodamaSamourai";
			}
			if(this.name.equals("oni")){
				this.name = "superOni";
			}

		}
	}


	/*
	*	Retourne la zone de promotion en fonction
	* 	d'une équipe.
	*/

	public boolean inPromoteArea(){
		if(team.equals("north") && (this.lig == 1 || this.lig == 2)){
			return true;
		}else if(team.equals("south") && (this.lig == 5 || this.lig == 6)){
			return true;
		}
		return false;
	}


	/*
	*	Rétrograde une pièce et la met à zéro
	*/
	public void demote(){
		this.lig = 0;
		this.col = 0;
		if(this.team.equals("north")){
			this.team = "south";
		}else{
			this.team = "north";
		}


		if(nameToInt() == 1){
			this.name = "kodama";
		}else if(nameToInt() == 5){
			this.name = "oni";
		}


	}

	@Override
	public String toString() {
		return "piece("+team+","+name+",["+col+","+lig+"])";
	}

	@Override
	public boolean equals(Object o) {
		if (o == this)
			return true;
		if (!(o instanceof TCoupReq)) {
			return false;
		}
		Piece piece = (Piece) o;
		return this.name.equals(((Piece) o).getName()) && this.col == ((Piece) o).getCol() && this.lig == ((Piece) o).getLig() && this.team.equals(((Piece) o).getTeam());


	}
	
	//Différent getter et setter
	
	public void setTeam(String team) {
		this.team = team;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setCol(int col) {
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
	
	public int getCol() {
		return col;
	}
	
	public int getLig() {
		return lig;
	}
	
	

}
