/*
 **********************************************************
 *
 *  Programme : TCoupRep.java
 *
 *  resume :    représente la réponse d'une requête de type coup
 *
 *  date :      16 / 04 / 19
 *
 ***********************************************************
 */
public class TCoupRep {
    private TCodeRep code;
    private boolean val;//Permet de savoir si un coup était valide


    public TCoupRep(TCodeRep code, boolean val){
        this.code = code;
        this.val = val;
    }

    public boolean isVal() {
        return val;
    }

    public TCodeRep getCode() {
        return code;
    }

    public void setCode(TCodeRep code) {
        this.code = code;
    }

    public void setVal(boolean val) {
        this.val = val;
    }
}
