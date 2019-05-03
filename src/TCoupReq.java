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
    private int action;          /* 0 : deplacer,
                                    1 : deposer,
                                    2 : aucun */
    private char sensPiece;      /* 'n' : nord,
                                    's' : sud */
    private int typePiece;       /* 0 : KODAMA,
                                    1 : KODAMA_SAMOURAI,
                                    2 : KIRIN,
                                    3 : KOROPOKKURU,
                                    4 : ONI,
                                    5 : SUPER_ONI */
                                    
    private char caseICol;       /* 'A', 'B', 'C', 'D', 'E' */ 
    private int caseILg;         /* 1, 2, 3, 4, 5, 6 */

    private char caseFCol;       /* 'A', 'B', 'C', 'D', 'E' */ 
    private int caseFLg;         /* 1, 2, 3, 4, 5, 6 */

    public TCoupReq(int action, char sensPiece, int typePiece, char caseICol, int caseILg, char caseFCol, int caseFLg) {
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

    public char getSensPiece() {
        return this.sensPiece;
    }

    public void setSensPiece(char sensPiece) {
        this.sensPiece = sensPiece;
    }

    public int getTypePiece() {
        return this.typePiece;
    }

    public void setTypePiece(int typePiece) {
        this.typePiece = typePiece;
    }

    public char getCaseICol() {
        return this.caseICol;
    }

    public void setCaseICol(char caseICol) {
        this.caseICol = caseICol;
    }

    public int getCaseILg() {
        return this.caseILg;
    }

    public void setCaseILg(int caseILg) {
        this.caseILg = caseILg;
    }

    public char getCaseFCol() {
        return this.caseFCol;
    }

    public void setCaseFCol(char caseFCol) {
        this.caseFCol = caseFCol;
    }

    public int getCaseFLg() {
        return this.caseFLg;
    }

    public void setCaseFLg(int caseFLg) {
        this.caseFLg = caseFLg;
    }

    public TCoupReq action(int action) {
        this.action = action;
        return this;
    }

    public TCoupReq sensPiece(char sensPiece) {
        this.sensPiece = sensPiece;
        return this;
    }

    public TCoupReq typePiece(int typePiece) {
        this.typePiece = typePiece;
        return this;
    }

    public TCoupReq caseICol(char caseICol) {
        this.caseICol = caseICol;
        return this;
    }

    public TCoupReq caseILg(int caseILg) {
        this.caseILg = caseILg;
        return this;
    }

    public TCoupReq caseFCol(char caseFCol) {
        this.caseFCol = caseFCol;
        return this;
    }

    public TCoupReq caseFLg(int caseFLg) {
        this.caseFLg = caseFLg;
        return this;
    }

    @Override
    public String toString() {
        return "{" +
            " action='" + getAction() + "'" +
            ", sensPiece='" + getSensPiece() + "'" +
            ", typePiece='" + getTypePiece() + "'" +
            ", caseICol='" + getCaseICol() + "'" +
            ", caseILg='" + getCaseILg() + "'" +
            ", caseFCol='" + getCaseFCol() + "'" +
            ", caseFLg='" + getCaseFLg() + "'" +
            "}";
    }
}
