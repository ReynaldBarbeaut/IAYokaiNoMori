/*
 **********************************************************
 *
 *  Programme : fctServer.h
 *
 *  ecrit par : Nicolas Bouchard / Reynald Barbeaut
 *
 *  resume : entete pour les fonctions utilitaires du joueur
 *
 *  date :      avril 2019
 *  modifie : 
 ***********************************************************
 */

#include "protocole.h"

void cstrPiece(TPiece *p);
void cstrParamsDepl(TDeplPiece *d);
void cstrParamsDepos(TDeposerPiece *d);
int cstrCoup(TCoupReq *r, int numPartie);

int enregCoupA(TCoupReq *c);

void finDuJeu();