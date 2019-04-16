/*
 **********************************************************
 *
 *  Programme : TCase.java
 *
 *  resume :    représente une case
 *
 *  date :      16 / 04 / 19
 *
 ***********************************************************
 */
public class TCase {
    private TCol colonne;
    private TLg ligne;


    public TCase(TLg ligne, TCol colonne){
        this.colonne = colonne;
        this.ligne = ligne;
    }

    public TCol getColonne() {
        return colonne;
    }

    public TLg getLigne() {
        return ligne;
    }

    public void setColonne(TCol colonne) {
        this.colonne = colonne;
    }

    public void setLigne(TLg ligne) {
        this.ligne = ligne;
    }
}

