/*
 **********************************************************
 *
 *  Programme : TPiece.java
 *
 *  resume :    représente une pièces
 *
 *  date :      16 / 04 / 19
 *
 ***********************************************************
 */
public class TPiece {
    private TSensTetePiece sens;
    private TTypePiece type;


    public TPiece(TSensTetePiece sens, TTypePiece type){
        this.sens = sens;
        this.type = type;
    }

    public TSensTetePiece getSens() {
        return sens;
    }

    public TTypePiece getType() {
        return type;
    }

    public void setSens(TSensTetePiece sens) {
        this.sens = sens;
    }

    public void setType(TTypePiece type) {
        this.type = type;
    }
}
