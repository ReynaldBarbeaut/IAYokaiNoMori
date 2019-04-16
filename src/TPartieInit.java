/*
 **********************************************************
 *
 *  Programme : TPartieInit.java
 *
 *  resume :    requête reçue par l'IA en java en début de partie
 *
 *  date :      16 / 04 / 19
 *
 ***********************************************************
 */
public class TPartieInit {
    private TSensTetePiece sensJeu;


    public TPartieInit(TSensTetePiece sensJeu){
        this.sensJeu = sensJeu;
    }


    public TSensTetePiece getSensJeu(){
        return this.sensJeu;
    }

}
