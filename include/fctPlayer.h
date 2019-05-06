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

/* Fonction de com avec l'IA pour la construction du coup à jouer */
int cstrCoup(int socket, TCoupReq *r, int numPartie);

/* Fonction de com avec l'IA pour lui coommuniquer la coup adverse */
int enregCoupA(int socket, TCoupReq *c);


/* Fonctions de com avec l'IA pour une partie */
int debutPartie(int socket, char sens);
int finPartie(int socket);