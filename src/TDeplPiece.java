/*
 **********************************************************
 *
 *  Programme : TDeplPiece.java
 *
 *  resume :    représente le déplacement d'une pièce
 *
 *  date :      16 / 04 / 19
 *
 ***********************************************************
 */
public class TDeplPiece extends TParam {
    private TCase caseDepart;
    private TCase caseArrive;
    private boolean estCapture;


    public TDeplPiece(TCase caseArrive, TCase caseDepart, boolean estCapture){
        this.caseArrive = caseArrive;
        this.caseDepart = caseDepart;
        this.estCapture = estCapture;
    }


    public boolean isEstCapture() {
        return estCapture;
    }

    public TCase getCaseArrive() {
        return caseArrive;
    }

    public TCase getCaseDepart() {
        return caseDepart;
    }

    public void setCaseArrive(TCase caseArrive) {
        this.caseArrive = caseArrive;
    }

    public void setCaseDepart(TCase caseDepart) {
        this.caseDepart = caseDepart;
    }

    public void setEstCapture(boolean estCapture) {
        this.estCapture = estCapture;
    }
}
