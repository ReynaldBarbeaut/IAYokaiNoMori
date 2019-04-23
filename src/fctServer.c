#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <arpa/inet.h>
#include "../include/protocole.h"
#include "../include/fctServer.h"

/*
 **********************************************************
 *
 *  Programme : fctCom.c
 *
 *  resume :    fonctions de traitement des requ�te pour le
 *				serveur de jeu
 *
 *  date :      mars 2019
 *
 ***********************************************************
 */

int traite_req_init(int splay1, int splay2) {
	int err;
	TPartieReq req1;      /* structure requete */
	TPartieRep rep1;      /* structure reponse */
	TPartieReq req2;
	TPartieRep rep2;

	/*
	 * reception de la requete en provenance de chaque client
	 */
	err = recv(splay1, &req1, sizeof(TPartieReq), 0);
	if (err <= 0) {
		perror("(serveur) erreur dans la reception");
		shutdown(splay1, SHUT_RDWR); close(splay1);
		return -6;
	}
	printf("(serveur) recu requete init");

	err = recv(splay2, &req2, sizeof(TPartieReq), 0);
	if (err <= 0) {
		perror("(serveur) erreur dans la reception");
		shutdown(splay2, SHUT_RDWR); close(splay2);
		return -6;
	}
	printf("(serveur) recu requete init");

	/*
	 * traitement serveur
	 */
	if (req1.idReq != PARTIE) {
		rep1.err = ERR_TYP;
	}
	else {
		rep1.err = ERR_OK;
	}

	if (req2.idReq != PARTIE) {
		rep2.err = ERR_TYP;
	}
	else {
		rep2.err = ERR_OK;
	}

	rep1.validSensTete = OK;
	if (req2.piece == req1.piece) {
		rep2.validSensTete = KO;
	} else {
		rep2.validSensTete = OK;
	}

	strcpy(rep1.nomAdvers, req2.nomJoueur);
	strcpy(rep2.nomAdvers, req1.nomJoueur);


	 /*
	  * envoi des reponses
	  */
	err = send(splay1, &rep1, sizeof(TPartieRep), 0);
	if (err <= 0) { // if (err != strlen(chaine)+1) {
		perror("(serveur) erreur sur le send");
		shutdown(splay1, SHUT_RDWR); close(splay1);
		return -5;
	}
	printf("(serveur) envoi de la reponse partie realise\n");

	err = send(splay2, &rep2, sizeof(TPartieRep), 0);
	if (err <= 0) { // if (err != strlen(chaine)+1) {
		perror("(serveur) erreur sur le send");
		shutdown(splay2, SHUT_RDWR); close(splay2);
		return -5;
	}
	printf("(serveur) envoi de la reponse partie realise\n");

	return 0;
}

int traite_req_coup(int sockTrans) {
	int err;
	TCoupRep req;       /* structure pour l'envoi de la requ�te */
	TCoupReq rep;      /* structure pour la r�ception de la r�ponse */

	/*
	 * reception et affichage du calcul en provenance du client
	 */
	err = recv(sockTrans, &req, sizeof(TCoupReq), 0);
	if (err <= 0) {
		perror("(serveur) erreur dans la reception");
		shutdown(sockTrans, SHUT_RDWR); close(sockTrans);
		return -6;
	}
	printf("(serveur) recu requete coup");

	/*
	 * traitement serveur
	 */
	// TO DO

	 /*
	  * envoi du r�sulat du calcul
	  */
	err = send(sockTrans, &rep, sizeof(TCoupRep), 0);
	if (err <= 0) {
		perror("(serveur) erreur sur le send");
		shutdown(sockTrans, SHUT_RDWR); close(sockTrans);
		return -5;
	}
	printf("(serveur) envoi de la reponse coup realise\n");

	return 0;
}