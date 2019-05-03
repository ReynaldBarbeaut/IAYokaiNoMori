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
    private int code;           /* 200 : ERR_OK
                                   400 : ERR_PARTIE, 
                                   403 : ERR_COUP,
                                   405 : ERR_TYP,
                                   500 : ERR_SHUT (fin de partie) */

    private boolean val;        /* Permet de savoir si un coup était valide */

    public TCoupRep(int code, boolean val) {
        this.code = code;
        this.val = val;
    }

    public int getCode() {
        return this.code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public boolean isVal() {
        return this.val;
    }

    public boolean getVal() {
        return this.val;
    }

    public void setVal(boolean val) {
        this.val = val;
    }

    public TCoupRep code(int code) {
        this.code = code;
        return this;
    }

    public TCoupRep val(boolean val) {
        this.val = val;
        return this;
    }

    @Override
    public String toString() {
        return "{" +
            " code='" + getCode() + "'" +
            ", val='" + isVal() + "'" +
            "}";
    }

}
