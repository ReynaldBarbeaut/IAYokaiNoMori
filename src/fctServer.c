#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <arpa/inet.h>
#include "protocole.h"
#include "fctServer.h"

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

int traite_req_init(int sockTrans) {
	int err;
	TPartieReq req;      /* structure pour l'envoi de la requ�te */
	TPartieRep rep;      /* structure pour la r�ception de la r�ponse */

	/*
	 * reception de la requ�te en provenance du client
	 */
	err = recv(sockTrans, &req, sizeof(TPartieReq), 0);
	if (err <= 0) {
		perror("(serveur) erreur dans la reception");
		shutdown(sockTrans, SHUT_RDWR); close(sockTrans);
		return -6;
	}
	printf("(serveur) re�u requete init");

	/*
	 * traitement serveur
	 */
	// TO DO

	 /*
	  * envoi de la r�ponse
	  */
	err = send(sockTrans, &rep, sizeof(TPartieRep), 0);
	if (err <= 0) { // if (err != strlen(chaine)+1) {
		perror("(serveur) erreur sur le send");
		shutdown(sockTrans, SHUT_RDWR); close(sockTrans);
		return -5;
	}
	printf("(serveur) envoi de la structure r�sultat r�alis�\n");

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
	printf("(serveur) re�u requete coup");

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
	printf("(serveur) envoi de la structure r�sultat r�alis�\n");

	return 0;
}