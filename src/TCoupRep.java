import java.util.Objects;

/*
 **********************************************************
 *
 *  Programme : TCoupRep.java
 *
 *  resume :    représente une requête pour un coup
 *
 *  date :      16 / 04 / 19
 *
 ***********************************************************
 */
public class TCoupRep {
    private int action;          /* 0 : deplacer,
                                    1 : deposer,
                                    2 : aucun */
    private int sensPiece;       /* 0 : nord,
                                    1 : sud */
    private int typePiece;       /* 0 : KODAMA,
                                    1 : KODAMA_SAMOURAI,
                                    2 : KIRIN,
                                    3 : KOROPOKKURU,
                                    4 : ONI,
                                    5 : SUPER_ONI */

    private int caseICol;        /* 0:'A', 1:'B', 2:'C', 3:'D', 4:'E' */ 
    private int caseILg;         /* 1, 2, 3, 4, 5, 6 */

    private int caseFCol;        /* 0:'A', 1:'B', 2:'C', 3:'D', 4:'E' */ 
    private int caseFLg;         /* 1, 2, 3, 4, 5, 6 */


    public TCoupRep(int action, int sensPiece, int typePiece, int caseICol, int caseILg, int caseFCol, int caseFLg) {
        this.action = action;
        this.sensPiece = sensPiece;
        this.typePiece = typePiece;
        this.caseICol = caseICol;
        this.caseILg = caseILg;
        this.caseFCol = caseFCol;
        this.caseFLg = caseFLg;
    }
    public int getAction() {
        return this.action;
    }

    public void setAction(int action) {
        this.action = action;
    }

    public int getSensPiece() {
        return this.sensPiece;
    }

    public void setSensPiece(int sensPiece) {
        this.sensPiece = sensPiece;
    }

    public int getTypePiece() {
        return this.typePiece;
    }

    public void setTypePiece(int typePiece) {
        this.typePiece = typePiece;
    }

    public int getCaseICol() {
        return this.caseICol;
    }

    public void setCaseICol(int caseICol) {
        this.caseICol = caseICol;
    }

    public int getCaseILg() {
        return this.caseILg;
    }

    public void setCaseILg(int caseILg) {
        this.caseILg = caseILg;
    }

    public int getCaseFCol() {
        return this.caseFCol;
    }

    public void setCaseFCol(int caseFCol) {
        this.caseFCol = caseFCol;
    }

    public int getCaseFLg() {
        return this.caseFLg;
    }

    public void setCaseFLg(int caseFLg) {
        this.caseFLg = caseFLg;
    }


    public TCoupRep action(int action) {
        this.action = action;
        return this;
    }

    public TCoupRep sensPiece(int sensPiece) {
        this.sensPiece = sensPiece;
        return this;
    }

    public TCoupRep typePiece(int typePiece) {
        this.typePiece = typePiece;
        return this;
    }

    public TCoupRep caseICol(int caseICol) {
        this.caseICol = caseICol;
        return this;
    }

    public TCoupRep caseILg(int caseILg) {
        this.caseILg = caseILg;
        return this;
    }

    public TCoupRep caseFCol(int caseFCol) {
        this.caseFCol = caseFCol;
        return this;
    }

    public TCoupRep caseFLg(int caseFLg) {
        this.caseFLg = caseFLg;
        return this;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof TCoupRep)) {
            return false;
        }
        TCoupRep TCoupRep = (TCoupRep) o;
        return action == TCoupRep.action && sensPiece == TCoupRep.sensPiece && typePiece == TCoupRep.typePiece && caseICol == TCoupRep.caseICol && caseILg == TCoupRep.caseILg && caseFCol == TCoupRep.caseFCol && caseFLg == TCoupRep.caseFLg;
    }

    @Override
    public int hashCode() {
        return Objects.hash(action, sensPiece, typePiece, caseICol, caseILg, caseFCol, caseFLg);
    }

    @Override
    public String toString() {
        return "{" +
            ", action='" + getAction() + "'" +
            ", sensPiece='" + getSensPiece() + "'" +
            ", typePiece='" + getTypePiece() + "'" +
            ", caseICol='" + getCaseICol() + "'" +
            ", caseILg='" + getCaseILg() + "'" +
            ", caseFCol='" + getCaseFCol() + "'" +
            ", caseFLg='" + getCaseFLg() + "'" +
            "}";
    }

}
