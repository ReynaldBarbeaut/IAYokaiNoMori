/*
 **********************************************************
 *
 *  Programme : TCodeRep.java
 *
 *  resume :    contient le type d'erreur
 *
 *  date :      16 / 04 / 19
 *
 ***********************************************************
 */
public enum TCodeRep {
    ERR_OK,      /* Validation de la requete */
    ERR_PARTIE,  /* Erreur sur la demande de partie */
    ERR_COUP,    /* Erreur sur le coup joue */
    ERR_TYP ,    /* Erreur sur le type de requete */
    ERR_SHUT     /* Fin de la partie donc arrêt de la communication*/
}
