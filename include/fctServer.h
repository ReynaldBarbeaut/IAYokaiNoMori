/*
 **********************************************************
 *
 *  Programme : fctServer.h
 *
 *  ecrit par : Nicolas Bouchard / Reynald Barbeaut
 *s
 *  resume : entete pour les fonctions utilitaires du serveur
 *
 *  date :      avril 2019
 *  modifie : 
 ***********************************************************
 */

int traite_req_init(int splay1, int splay2, char *sens);
int traite_req_coup(int sCurrent, int sAdvers, int player, int partie);