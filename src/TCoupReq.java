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
    private TCoup coup;
    private TPiece piece;
    private TParam param;

    public TCoupReq(TCoup coup, TPiece piece, TParam param){
        this.coup = coup;
        this.piece = piece;
        this.param = param;
    }

    public TCoup getCoup() {
        return coup;
    }

    public TParam getParam() {
        return param;
    }

    public TPiece getPiece() {
        return piece;
    }

    public void setCoup(TCoup coup) {
        this.coup = coup;
    }

    public void setParam(TParam param) {
        this.param = param;
    }

    public void setPiece(TPiece piece) {
        this.piece = piece;
    }
}
