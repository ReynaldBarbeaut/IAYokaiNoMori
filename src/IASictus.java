/*
 **********************************************************
 *
 *  Programme : IASictus.java
 *
 *  resume :    programme java qui va communiquer avec le
 *  prolog pour chercher les solutions
 *
 *  date :      03 / 05 / 19
 *
 ***********************************************************
 */

// importation des classes utiles à Jasper
import se.sics.jasper.*;

// pour les lectures au clavier
import java.io.*;

// pour utiliser les HashMap 
import java.util.*;


public class IASictus {
	
	private SICStus sp;
	private int error;
	private String type;
	private Piece p1,p2;
	private String pathToPlFile;
	
	public IASictus(String pathToPlFile) {
		this.pathToPlFile = pathToPlFile;
		sp = null;
		error = 0;
		try {
			// Création et chargement du fichier
			sp = new SICStus(null);
			sp.load(pathToPlFile);
		
		}catch (SPException e) {
			System.err.println("Exception SICStus Prolog : " + e);
			e.printStackTrace();
			error = -1;
		}
	}
	
	//Cette méthode prend un prédicat et choisit la meilleure action possible
	public void searchSolution(String predicate) {	
		error = 0;
		type = "";
		p1 = null;
		p2 = null;
	
		//Cette HashMap sert à stocker les résultats
		HashMap results = new HashMap();
		        
		try {
			//Création d'un requête
			Query qu = sp.openQuery(predicate,results);
			//On prend la première solution
			qu.nextSolution();
			   
			//results.forEach((key,value) -> System.out.println(key + " = " + value.toString()));
			
			//On stocke les informations utiles
			type = results.get("Type").toString();
			if(type.equals("placement") || type.equals("capture") || type.equals("move")) {
				p1 = stringToPiece(results.get("P1").toString());
				p2 = stringToPiece(results.get("P2").toString());
				error = 1;
			}
			  
			//Fermeture de la requête et traitement des exception
			qu.close();
		}catch (SPException e) {
			System.err.println("Exception prolog\n" + e);
			error = -1;
		}catch (Exception e) {
			System.err.println("Other exception : " + e);
			error = -2;
		}     
	}
	
	
	/*Transforme une chaine de caractère dans un format donné
	 * par la HashMap en un objet Piece
	 */
	public Piece stringToPiece(String piece) {
		String team = piece.split(",")[0].replace("piece(", "");
		String name = piece.split(",")[1];
		char col = (char) (Integer.parseInt(piece.split(",")[2].replace(".(", ""))+64);
		int lig = Integer.parseInt(piece.split(",")[3].replace(".(", ""));
		return new Piece(team,name,col,lig);		
	}
	
	//Différents getter
	
	public String getType() {
		return type;
	}
	
	public Piece getP1() {
		return p1;
	}
	
	public Piece getP2() {
		return p2;
	}
	
	public int getError() {
		return error;
	}
	
	
}