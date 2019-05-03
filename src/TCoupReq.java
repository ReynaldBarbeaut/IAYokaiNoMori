/*
 **********************************************************
 *
 *  Programme : TCoupReq.java
 *
 *  resume :    représente une requête pour un coup
 *
 *  date :      16 / 04 / 19
 *
 ***********************************************************
 */
public class TCoupReq {
    private boolean partieTerm;  /* 0 : la partie doit continuer,
                                    1 : la partie est terminee */
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


    public TCoupReq(boolean partieTerm, int action, int sensPiece, int typePiece, int caseICol, int caseILg, int caseFCol, int caseFLg) {
        this.partieTerm = partieTerm;
        this.action = action;
        this.sensPiece = sensPiece;
        this.typePiece = typePiece;
        this.caseICol = caseICol;
        this.caseILg = caseILg;
        this.caseFCol = caseFCol;
        this.caseFLg = caseFLg;
    }

    public boolean isPartieTerm() {
        return this.partieTerm;
    }

    public boolean getPartieTerm() {
        return this.partieTerm;
    }

    public void setPartieTerm(boolean partieTerm) {
        this.partieTerm = partieTerm;
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

    public TCoupReq partieTerm(boolean partieTerm) {
        this.partieTerm = partieTerm;
        return this;
    }

    public TCoupReq action(int action) {
        this.action = action;
        return this;
    }

    public TCoupReq sensPiece(int sensPiece) {
        this.sensPiece = sensPiece;
        return this;
    }

    public TCoupReq typePiece(int typePiece) {
        this.typePiece = typePiece;
        return this;
    }

    public TCoupReq caseICol(int caseICol) {
        this.caseICol = caseICol;
        return this;
    }

    public TCoupReq caseILg(int caseILg) {
        this.caseILg = caseILg;
        return this;
    }

    public TCoupReq caseFCol(int caseFCol) {
        this.caseFCol = caseFCol;
        return this;
    }

    public TCoupReq caseFLg(int caseFLg) {
        this.caseFLg = caseFLg;
        return this;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof TCoupReq)) {
            return false;
        }
        TCoupReq tCoupReq = (TCoupReq) o;
        return partieTerm == tCoupReq.partieTerm && action == tCoupReq.action && sensPiece == tCoupReq.sensPiece && typePiece == tCoupReq.typePiece && caseICol == tCoupReq.caseICol && caseILg == tCoupReq.caseILg && caseFCol == tCoupReq.caseFCol && caseFLg == tCoupReq.caseFLg;
    }

    @Override
    public int hashCode() {
        return Objects.hash(partieTerm, action, sensPiece, typePiece, caseICol, caseILg, caseFCol, caseFLg);
    }

    @Override
    public String toString() {
        return "{" +
            " partieTerm='" + isPartieTerm() + "'" +
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