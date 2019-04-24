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
#include "../include/validation.h"

#define TIME_MAX 6

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

int traite_req_init(int splay1, int splay2, char *sens) {
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
		perror("(serveur - init) erreur sur la reception");
		shutdown(splay1, SHUT_RDWR); close(splay1);
		return -6;
	}
	printf("(serveur - init) recu requete init\n");

	err = recv(splay2, &req2, sizeof(TPartieReq), 0);
	if (err <= 0) {
		perror("(serveur - init) erreur sur la reception");
		shutdown(splay2, SHUT_RDWR); close(splay2);
		return -6;
	}
	printf("(serveur - init) recu requete init\n");

	/*
	 * traitement serveur - init
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

	if (req1.piece == SUD) {
		*sens = 's';
	}
	else {
		*sens = 'n';
	}

	 /*
	  * envoi des reponses
	  */
	err = send(splay1, &rep1, sizeof(TPartieRep), 0);
	if (err <= 0) { // if (err != strlen(chaine)+1) {
		perror("(serveur - init) erreur sur le send");
		shutdown(splay1, SHUT_RDWR); close(splay1);
		return -5;
	}
	printf("(serveur - init) envoi de la reponse partie realise\n");

	err = send(splay2, &rep2, sizeof(TPartieRep), 0);
	if (err <= 0) { // if (err != strlen(chaine)+1) {
		perror("(serveur - init) erreur sur le send");
		shutdown(splay2, SHUT_RDWR); close(splay2);
		return -5;
	}
	printf("(serveur - init) envoi de la reponse partie realise\n");

	return 0;
}

int traite_req_coup(int sCurrent, int sAdvers, int player, int partie) {
	int err;
	bool valid;
	int ret = 0;			/* code de retour */
	TCoupReq req;       	/* structure requete */
	TCoupRep rep;       	/* structure reponse */
	TPropCoup propCoup; 	/* structure propriete du coup */

	/*
	 * application de la limite de temps pour le recv
	 */
	struct timeval timeout;      
    timeout.tv_sec = TIME_MAX;
    timeout.tv_usec = 0;

    if (setsockopt(sCurrent, SOL_SOCKET, SO_RCVTIMEO, (char *)&timeout,
	               sizeof(timeout)) < 0) {
        perror("(serveur - coup) erreur sur setsockopt\n");
		return -4;
	}

	/*
	 * reception requete coup
	 */
	err = recv(sCurrent, &req, sizeof(TCoupReq), 0);
	if (err <= 0 && err != -1) {
		perror("(serveur - coup) erreur sur la reception");
		printf("\n err : %d", err);
		shutdown(sCurrent, SHUT_RDWR); close(sCurrent);
		return -6;
	}
	if (err == -1) {
		rep.validCoup = TIMEOUT;
		printf("(serveur - coup) TIMEOUT pour le joueur %d\n", player);
	}

	/*
	 * traitement serveur - coup
	 */
	if (rep.validCoup == TIMEOUT) {
		rep.err = ERR_COUP;
		rep.propCoup = PERDU;
		ret = -1;
	}
	else {
		printf("(serveur - coup) recu requete coup\n");
		if (req.idRequest == PARTIE) {
			rep.err = ERR_TYP;
		}
		if (req.numPartie != partie) {
			rep.err = ERR_PARTIE;
		}

		valid = validationCoup(player, req, &propCoup);
		if (!valid) {
			rep.err = ERR_COUP;
			rep.validCoup = TRICHE;
		}
		else {
			rep.err = ERR_OK;
			rep.validCoup = VALID;
			rep.propCoup = propCoup;

			if (propCoup == CONT) {
				ret = 0;
			}
			else if (propCoup == GAGNE) {
				ret = player;
			}
			else if (propCoup == PERDU) {
				ret = (player == 1 ? 2 : 1);
			}
		}
	}
	
	/*
	 * envoi reponse coup au joueur courant
	 */
	err = send(sCurrent, &rep, sizeof(TCoupRep), 0);
	if (err <= 0) {
		perror("(serveur - coup) erreur sur le send");
		shutdown(sCurrent, SHUT_RDWR); close(sCurrent);
		return -5;
	}
	printf("(serveur - coup) envoi de la reponse coup au joueur courant realise\n");

	/*
	 * envoi reponse coup au joueur adverse
	 */
	err = send(sAdvers, &rep, sizeof(TCoupRep), 0);
	if (err <= 0) {
		perror("(serveur - coup) erreur sur le send");
		shutdown(sAdvers, SHUT_RDWR); close(sAdvers);
		return -5;
	}
	printf("(serveur - coup) envoi de la reponse coup au joueur adverse realise\n");

	/*
	 * envoi coup joue au joueur adverse
	 */
	if (rep.validCoup == VALID && rep.propCoup == CONT) { 
		err = send(sAdvers, &req, sizeof(TCoupReq), 0);
		if (err <= 0) {
			perror("(serveur - coup) erreur sur le send");
			shutdown(sAdvers, SHUT_RDWR); close(sAdvers);
			return -5;
		}
		printf("(serveur - coup) envoi du coup joue au joueur adverse realise\n");
	}

	return ret;
}