/*
 **********************************************************
 *
 *  Programme : fctCom.h
 *
 *  ecrit par : Nicolas Bouchard / Reynald Barbeaut
 *
 *  resume : entete pour les fonctions de com
 *
 *  date :      avril 2019
 *  modifie : 
 ***********************************************************
 */

int socketServeur(ushort port);

int socketClient(char* ipMachServ, ushort port);

int socketUDP(ushort port);

