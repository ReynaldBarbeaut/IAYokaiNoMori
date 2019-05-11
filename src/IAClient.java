import java.io.*;
import java.net.Socket;

/*
 **********************************
 * ************************
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
	static int c;

	public static void main(String[] args) {
		//Déclaration et initialisation
		int cpt = 0, sens,port, action, ret = 0,rep = 0;
		int partieTermine = 0;
		boolean joue = true;
		String nomMachine;
		Socket comm;
		InputStream is;
		OutputStream os;
		DataInputStream in;
		DataOutputStream out;
		TCoupReq req;
		String[] team = {"north","south"};
		jeu = new lPieces();
		ia = new IASictus("./iaYokai.pl");
		
		//Test du bon nombre d'arguments
		if(args.length < 2) {
			System.out.println("usage : "+args[0]+" IPServ port");
			return;
		}
		nomMachine = args[0];
		port = Integer.parseInt(args[1]);
		
		//On essaye de se connecter au serveur toutes les secondes
		try {
			System.out.println("Trying to connect ...");
			comm = new Socket(nomMachine,port);
			System.out.println("Connected !");
			
			
			//Initialisation des streams
			is = comm.getInputStream();
			in = new DataInputStream(is);
			
			os = comm.getOutputStream();
			out = new DataOutputStream(os);
						
			
			//On récupére le sens dans lequel on va jouer
			sens = in.readInt();
			if(sens == 1){
				joue = false;
				System.out.println("Je commence.");
			}
			
			while(cpt<2) {
				//On réinitialise le plateau et la main à chaque partie
				jeu.erase();
				jeu.initBoard();
				c=0;
				ia.erase();
				System.out.println("Game number : "+cpt);
				partieTermine = 0;
				ret = 0;

				//Changement de premier joueur après la première partie
				if(cpt == 1) {
					if(sens == 1) {
						joue = true;
						System.out.println("J'attends avant de jouer.");
					}else {
						joue = false;
						System.out.println("Je commence maintenant.");
					}
				}
				//Boucle de jeu
				while(partieTermine == 0) {
					joue = !joue;

					//Si on est un nombre paire de tour on commence à jouer
					if(joue) {
						//Fonction de jeu
						if(cpt == 1){
							System.out.println("Je joues.");
						}
						ret = jouerCoup(sens,team,out);
					}

					joue = ! joue;
					//Une fois notre coup fait on regarde si la partie n'est pas finie
					partieTermine = in.readInt();
					if(partieTermine == 0) {
						//Si la partie continue le coup est validé alors on mets à jour

						if(ret > 0) {

							if(ia.getType().equals("move")){
								jeu.removeBoard(ia.getP1().getCol(),ia.getP1().getLig());
								jeu.addToBoard(ia.getP2());

							}else if(ia.getType().equals("capture")){
								jeu.removeBoard(ia.getP1().getCol(),ia.getP1().getLig());

								int index = jeu.checkCoordinate(ia.getP2().getCol(),ia.getP2().getLig());

								Piece p = new Piece(jeu.getBoard().get(index).getTeam(),jeu.getBoard().get(index).getName(),jeu.getBoard().get(index).getCol(),jeu.getBoard().get(index).getLig());


								jeu.addHand(p);

								jeu.removeBoard(ia.getP2().getCol(),ia.getP2().getLig());
								jeu.addToBoard(ia.getP2());

							}else if(ia.getType().equals("placement")){
								jeu.removeHand(ia.getP1());
								jeu.addToBoard(ia.getP2());
							}
						}

						action = in.readInt();
						System.out.println("Opponent action "+ action);
						if(action != 3){
							rep = traitementReponse(action,in);
						}
						//On joue si on est à un nombre impair de coup
						if(joue) {
							ret = jouerCoup(sens,team,out);
						}						
					}
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
			System.out.println("Error while with communication.");
			System.out.println(e.toString());
		}

	}
	
	/*
	 * Cette méthode peremet de jouer un coup grâce à l'IA
	 * elle à besoin du sens du joueur et du stream pour envoyer sa réponse
	 */
	public static int jouerCoup(int sens,String[] team,DataOutputStream os) {
		try {
			c++;
			//On cherche un mouvement
			ia.searchSolution("bestAction("+team[sens]+","+jeu.toString(jeu.getBoard())+","+jeu.toString(jeu.getHand())+",Type,P1,P2).");

			//Si aucun mouvement ou une erreur à eu lieu on envoie au client qu'aucun mouvement n'a été fait
			if(ia.getError()<=0) {
			        System.out.println("No action done.");
					os.writeInt(3);
					return -1;
			}
			//Sinon on envoie un objet avec toutes les informations sur le coup

			System.out.println("Action number : "+ c);
			System.out.println("Our move : "+ ia.typeToInt());
			System.out.println("From : "+ia.getP1().toString());
			System.out.println("To : " + ia.getP2().toString());

			System.out.println("Sending informations.");

			os.writeInt(ia.typeToInt());
			os.writeInt(sens);
			os.writeInt(ia.getP1().nameToInt());
			os.writeInt(ia.getP1().getCol());
			os.writeInt(ia.getP1().getLig());

			if(ia.typeToInt() != 2){
				os.writeInt(ia.getP2().getCol());
				os.writeInt(ia.getP2().getLig());
			}

			System.out.println("Informations sended.");
			return 1;
			
		} catch (IOException e) {
			System.out.println("Error because of output stream.");
			e.printStackTrace();
			return -2;
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
			if(action == 2){
				Piece p = new Piece(intToTeam(sensPiece),intToName(typePiece),col1,lig1);
				jeu.addToBoard(p);
			}else{
				int col2 = in.readInt();
				int lig2 = in.readInt();
				Piece p = new Piece(intToTeam(sensPiece),intToName(typePiece),col2,lig2);
				p.promote();
				int index = jeu.checkCoordinate(col1,lig1);
				if(index >= 0){
					jeu.removeBoard(col1,lig1);
				}
				index = jeu.checkCoordinate(col2,lig2);
				if(index >= 0){
					jeu.removeBoard(col2,lig2);
				}

				jeu.addToBoard(p);

			}


		} catch (IOException e) {
			System.out.println("Error while receiving piece.");
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
