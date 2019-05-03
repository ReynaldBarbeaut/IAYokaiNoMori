#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <arpa/inet.h>
#include "../include/protocole.h"
#include "../include/fctCom.h"

/*
 **********************************************************
 *
 *  Programme : fctPlayer.c
 *
 *  resume :    fonctions utiitaires pour le joueur de Yokai
 *
 *  date :      mars 2019
 *
 ***********************************************************
 */

int cstrCoup(int spIA, TCoupReq *r, int numPartie) {

    int err;

    /* 
     * reception de l'action joueur depuis l'IA
     */
    int action;
	err = recv(spIA, &action, sizeof(int), 0);
	if (err <= 0) {
	  perror("(client - fctPlayer) erreur sur le recv");
	  shutdown(spIA, SHUT_RDWR);
	  return -4;
	}
	action = ntohl(action);

    r->idRequest = COUP;
    r->numPartie = numPartie;
    switch (action) {
        case 0 : r->typeCoup = DEPLACER; break;
        case 1 : r->typeCoup = DEPOSER; break;
        case 2 : r->typeCoup = AUCUN; break; 
        default : perror("(client - fctPlayer) erreur reception action"); return -1;
    }

    /* 
     * reception du sens de la piece depuis l'IA
     */
    int sensPiece;
	err = recv(spIA, &sensPiece, sizeof(int), 0);
	if (err <= 0) {
	  perror("(client - fctPlayer) erreur sur le recv");
	  shutdown(spIA, SHUT_RDWR);
	  return -4;
	}
	sensPiece = ntohl(sensPiece);
    
    if (sensPiece == 0 || sensPiece == 1) {
        r->piece.sensTetePiece = (sensPiece == 0 ? NORD : SUD);
    } else {
        perror("(client - fctPlayer) erreur reception sens piece"); return -1;
    }

    /* 
     * reception du type de piece depuis l'IA
     */
    int typePiece;
	err = recv(spIA, &typePiece, sizeof(int), 0);
	if (err <= 0) {
	  perror("(client - fctPlayer) erreur sur le recv");
	  shutdown(spIA, SHUT_RDWR);
	  return -4;
	}
	typePiece = ntohl(typePiece);

    switch (typePiece) {
        case 0 : r->piece.typePiece = KODAMA; break;
        case 1 : r->piece.typePiece = KODAMA_SAMOURAI; break;
        case 2 : r->piece.typePiece = KIRIN; break;
        case 3 : r->piece.typePiece = KOROPOKKURU; break;
        case 4 : r->piece.typePiece = ONI; break;
        case 5 : r->piece.typePiece = SUPER_ONI; break;
        default : perror("(client - fctPlayer) erreur reception type piece"); return -1;
    }

    if (r->typeCoup == DEPLACER) { // si le coup est un déplacement
        /* 
         * reception de la colonne de la case initiale depuis l'IA
         */
        int caseICol;
        err = recv(spIA, &caseICol, sizeof(int), 0);
        if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le recv");
        shutdown(spIA, SHUT_RDWR);
        return -4;
        }
        caseICol = ntohl(caseICol);

        switch (caseICol) {
            case 0 : r->params.deplPiece.caseDep.c = 'A'; break;
            case 1 : r->params.deplPiece.caseDep.c = 'B'; break;
            case 2 : r->params.deplPiece.caseDep.c = 'C'; break;
            case 3 : r->params.deplPiece.caseDep.c = 'D'; break;
            case 4 : r->params.deplPiece.caseDep.c = 'E'; break;
            default : perror("(client - fctPlayer) erreur reception colonne case initiale"); return -1;
        }

        /* 
         * reception de la ligne de la case initiale depuis l'IA
         */
        int caseILg;
        err = recv(spIA, &caseILg, sizeof(int), 0);
        if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le recv");
        shutdown(spIA, SHUT_RDWR);
        return -4;
        }
        caseILg = ntohl(caseILg);

        if (caseILg >= 1 && caseILg <= 6) {
            r->params.deplPiece.caseDep.l = caseILg;
        } else {
            perror("(client - fctPlayer) erreur reception ligne case initiale"); return -1;
        }


        /* 
         * reception de la colonne de la case finale depuis l'IA
         */
        int caseFCol;
        err = recv(spIA, &caseFCol, sizeof(int), 0);
        if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le recv");
        shutdown(spIA, SHUT_RDWR);
        return -4;
        }
        caseFCol = ntohl(caseFCol);

        switch (caseFCol) {
            case 0 : r->params.deplPiece.caseDep.c = 'A'; break;
            case 1 : r->params.deplPiece.caseDep.c = 'B'; break;
            case 2 : r->params.deplPiece.caseDep.c = 'C'; break;
            case 3 : r->params.deplPiece.caseDep.c = 'D'; break;
            case 4 : r->params.deplPiece.caseDep.c = 'E'; break;
            default : perror("(client - fctPlayer) erreur reception colonne case finale"); return -1;
        }

        /* 
         * reception de la ligne de la case finale depuis l'IA
         */
        int caseFLg;
        err = recv(spIA, &caseFLg, sizeof(int), 0);
        if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le recv");
        shutdown(spIA, SHUT_RDWR);
        return -4;
        }
        caseFLg = ntohl(caseFLg);

        if (caseFLg >= 1 && caseFLg <= 6) {
            r->params.deplPiece.caseDep.l = caseFLg;
        } else {
            perror("(client - fctPlayer) erreur reception ligne case finale"); return -1;
        }
    }


    else if (r->typeCoup == DEPOSER) { // si le coup est un dépôt
        /* 
         * reception de la colonne de la case depuis l'IA
         */
        int caseICol;
        err = recv(spIA, &caseICol, sizeof(int), 0);
        if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le recv");
        shutdown(spIA, SHUT_RDWR);
        return -4;
        }
        caseICol = ntohl(caseICol);

        switch (caseICol) {
            case 0 : r->params.deposerPiece.c = 'A'; break;
            case 1 : r->params.deposerPiece.c = 'B'; break;
            case 2 : r->params.deposerPiece.c = 'C'; break;
            case 3 : r->params.deposerPiece.c = 'D'; break;
            case 4 : r->params.deposerPiece.c = 'E'; break;
            default : perror("(client - fctPlayer) erreur reception colonne case depos"); return -1;
        }

        /* 
         * reception de la ligne de la case depuis l'IA
         */
        int caseILg;
        err = recv(spIA, &caseILg, sizeof(int), 0);
        if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le recv");
        shutdown(spIA, SHUT_RDWR);
        return -4;
        }
        caseILg = ntohl(caseILg);

        if (caseILg >= 1 && caseILg <= 6) {
            r->params.deposerPiece.l = caseILg;
        } else {
            perror("(client - fctPlayer) erreur reception ligne case depos"); return -1;
        }
        
        
    } 
    return 0;
}

int enregCoupA(int spIA, TCoupReq *c) {
    if (c->typeCoup == DEPLACER) {

    } 
    else if (c->typeCoup == DEPOSER) {
        
    }
    else if (c->typeCoup == AUCUN) {
        
    }
    return 0;
}

void finDuJeu() {
    
}