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

int cstrCoup(int socket, TCoupReq *r, int numPartie);

int enregCoupA(int socket, TCoupReq *c);

void finDuJeu();