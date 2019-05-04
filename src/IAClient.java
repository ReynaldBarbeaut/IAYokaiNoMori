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
	static lPieces board; //Le plateau de jeu
	static lPieces hand; //La main du joueur (les pièces qu'il a capturée)

	public static void main(String[] args) {
		//Déclaration et initialisation
		int cpt = 0, sens,port, nbCoup;
		boolean partieTermine = false;
		String nomMachine;
		Socket comm;
		InputStream is;
		OutputStream os;
		DataInputStream in;
		ObjectOutputStream out;
		TCoupReq req;
		String[] team = {"north","south"};
		board = new lPieces();
		hand = new lPieces();
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
				board.erase();
				hand.erase();
				board.initBoard();
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
						//Si ce n'est pas le cas on traite la réponse
						
						
						
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
			ia.searchSolution("bestAction("+team[sens]+","+board.toString()+","+hand.toString()+",Type,P1,P2)");
			
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
	public void traitementReponse(DataInputStream in) {
		try {
			boolean coupValide = in.readBoolean();
			
			
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
