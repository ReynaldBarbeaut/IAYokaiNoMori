import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.io.OutputStream;
import java.io.InputStream;
import java.io.ObjectOutputStream;

/*
 **********************************************************
 *
 *  Programme : IAClient.java
 *
 *  resume :    programme java qui va communiquer avec le
 *  client c pour jouer au Yokai-No-Mori
 *
 *  date :      03 / 05 / 19
 *
 ***********************************************************
 */
public class IAClient {
	static IASictus ia;	//L'ia qui va calculer les coups
	static lPieces jeu; //Représente le plateau de jeu et la main du jouer

	public static void main(String[] args) {
		//Déclaration et initialisation
		int cpt = 0, sens,port, nbCoup, action;
		boolean partieTermine = false;
		String nomMachine;
		Socket comm;
		InputStream is;
		OutputStream os;
		DataInputStream in;
		ObjectOutputStream out;
		TCoupReq req;
		String[] team = {"north","south"};
		jeu = new lPieces();
		ia = new IASictus("./iaYokai.pl");
		
		//Test du bon nombre d'arguments
		if(args.length != 2) {
			System.out.println("usage : "+args[0]+" IPServ port");
		}
		nomMachine = args[0];
		port = Integer.parseInt(args[1]);
		
		//On essaye de se connecter au serveur toutes les secondes
		try {
			System.out.println("Trying to connect ...");
			comm = new Socket(nomMachine,port);
			while(!comm.isConnected()) {
				try {
					Thread.sleep(1000);
					comm = new Socket(nomMachine,port);
				} catch (InterruptedException e) {
					System.out.println("Error while sleeping.");
					e.printStackTrace();
				}
			}
			System.out.println("Connected !");
			
			
			//Initialisation des streams
			is = comm.getInputStream();
			in = new DataInputStream(is);
			
			os = comm.getOutputStream();
			out = new ObjectOutputStream(os);
						
			
			//On récupére le sens dans lequel on va jouer
			sens = in.readInt();
			
			while(cpt<2) {
				//On réinitialise le plateau et la main à chaque partie
				jeu.erase();
				jeu.initBoard();
				nbCoup = 0;
				
				//Changement de sens après la première partie
				if(cpt == 1) {
					if(sens == 0) {
						sens = 1;
					}else {
						sens = 0;
					}
				}
				//Boucle de jeu
				while(!partieTermine) {
					//Si on est un nombre paire de tour on commence à jouer
					if(nbCoup%2 == 0) {
						//Fonction de jeu
						jouerCoup(sens,team,out);
					}
					//Une fois notre coup fait on regarde si la partie n'est pas finie
					partieTermine = in.readBoolean();
					if(!partieTermine) {
						//Si la partie continue le coup est validé alors on mets à jour
						jeu.updateBoard(ia.getP2());
						if(ia.getType().equals("placement")){
							jeu.updateHand(1,ia.getP2());
						}

						action = in.readInt();
						if(action != 2){
							int rep = traitementReponse(action,in);
						}
						
						//On joue si on est à un nombre impair de coup
						if(nbCoup%1 == 0) {
							jouerCoup(sens,team,out);
						}						
					}
					nbCoup++;
					
				}
				
				cpt++;
			}
			
		//Fermeture des streams
		in.close();
		out.close();
		is.close();
		os.close();
		comm.close();
			
		}catch(IOException e) {
			System.out.println(e.toString());
		}
		
	}
	
	/*
	 * Cette méthode peremet de jouer un coup grâce à l'IA
	 * elle à besoin du sens du joueur et du stream pour envoyer sa réponse
	 */
	public static void jouerCoup(int sens,String[] team,ObjectOutputStream os) {
		try {
			os.flush();
			//On cherche un mouvement
			ia.searchSolution("bestAction("+team[sens]+","+jeu.toString(jeu.getBoard())+","+jeu.toString(jeu.getHand())+",Type,P1,P2)");
			
			//Si aucun mouvement ou une erreur à eu lieu on envoie au client qu'aucun mouvement n'a été fait
			if(ia.getError()<=0) {				
					os.writeInt(2);
					return;
			}
			//Sinon on envoie un objet avec toutes les informations sur le coup
			TCoupRep rep = new TCoupRep(ia.typeToInt(),sens,ia.getP2().nameToInt(),ia.getP1().getCol(),ia.getP1().getLig(),ia.getP2().getCol(),ia.getP2().getLig());
			os.writeObject(rep);
			
		} catch (IOException e) {
			System.out.println("Error because of output stream.");
			e.printStackTrace();
		}
		
	}

	/*
	 * Cette méthode s'occupe tu traitement de la réponse faite du client
	 */
	public static int traitementReponse(int action, DataInputStream in) {
		try {
			int sensPiece, typePiece, lig1, col1;
			sensPiece = in.readInt();
			typePiece = in.readInt();
			col1 = in.readInt();
			lig1 = in.readInt();
			if(typePiece == 1){
				Piece p = new Piece(intToTeam(sensPiece),intToName(typePiece),col1,lig1);
				jeu.updateBoard(p);
			}else{
				int col2 = in.readInt();
				int lig2 = in.readInt();
				Piece p = new Piece(intToTeam(sensPiece),intToName(typePiece),col2,lig2);
				int index = jeu.checkCoordinate(col1,lig1);
				if(index >= 0){
					jeu.getBoard().remove(index);
				}
				index = jeu.checkCoordinate(col2,lig2);
				if(index >= 0){
					jeu.getBoard().remove(index);
				}

				jeu.getBoard().add(p);

			}


		} catch (IOException e) {
			e.printStackTrace();
			return -1;
		}

		return 1;
	}


	/*
	 *	Transforme un entier en nom de pièce
	 */
	public static String intToName(int n){
		switch(n) {
			case 0:
				return "kodama";
			case 1:
				return "kodamaSamourai";
			case 2:
				return "kirin";
			case 3:
				return "koropokkuru";
			case 4:
				return "oni";
			default:
				return "superOni";
		}

	}

	/*
	 *	Transforme un int en nom d'équipe
	 */
	public static String intToTeam(int n){
		if(n == 0){
			return "north";
		}
		return "south";
	}





	
}
