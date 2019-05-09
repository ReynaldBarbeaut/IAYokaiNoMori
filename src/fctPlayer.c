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

	printf("Nb receved bytes : %d \n",err);
	action = ntohl(action);
	printf("%d",action);

    r->idRequest = COUP;
    r->numPartie = numPartie;
    switch (action) {
        case 0 : r->typeCoup = DEPLACER; break;
        case 1 : r->typeCoup = DEPOSER; break;
        case 2 : r->typeCoup = AUCUN; break; 
        default : perror("(client - fctPlayer) erreur reception action"); return -1;
    }

    if (r->typeCoup == DEPLACER) { // si le coup est un déplacement

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

    int err;

    /* 
     * envoi boooleen partie non terminee
     */
    int term = 0;
    int reqN = htonl(term);
    err = send(spIA, &term, sizeof(int), 0);
    if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le send");
        shutdown(spIA, SHUT_RDWR); close(spIA);
        return -3;
    }

    /* 
     * envoi action adverse à l'IA
     */
    int action;
    switch (c->typeCoup) {
        case DEPLACER : action = 0; break;
        case DEPOSER : action = 1; break;
        case AUCUN : action = 2; break;
        default : perror("(client - fctPlayer) enreg coup adverse : erreur type coup"); return -1;
    }
    action = htonl(action);
    err = send(spIA, &action, sizeof(int), 0);
    if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le send");
        return -3;
    }

    if (c->typeCoup == DEPLACER) {

        /* 
         * envoi sens tete piece adverse à l'IA
         */
        int sensPiece;
        switch (c->piece.sensTetePiece) {
            case NORD : sensPiece = 0; break;
            case SUD : sensPiece = 1; break;
            default : perror("(client - fctPlayer) enreg coup adverse : erreur sens piece"); return -1;
        }
        sensPiece = htonl(sensPiece);
        err = send(spIA, &sensPiece, sizeof(int), 0);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur sur le send");
            return -3;
        }

        /* 
         * envoi type piece adverse à l'IA
         */
        int typePiece;
        switch (c->piece.typePiece) {
            case KODAMA :           typePiece = 0; break;
            case KODAMA_SAMOURAI :  typePiece = 1; break;
            case KIRIN :            typePiece = 2; break;
            case KOROPOKKURU :      typePiece = 3; break;
            case ONI :              typePiece = 4; break;
            case SUPER_ONI :        typePiece = 5; break;
            default : perror("(client - fctPlayer) enreg coup adverse : erreur type piece"); return -1;
        }
        typePiece = htonl(typePiece);
        err = send(spIA, &typePiece, sizeof(int), 0);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur sur le send");
            return -3;
        }

        /* 
         * envoi colonne case init adverse à l'IA
         */
        int caseICol;
        switch (c->params.deplPiece.caseDep.c) {
            case 'A' : caseICol = 0; break;
            case 'B' : caseICol = 1; break;
            case 'C' : caseICol = 2; break;
            case 'D' : caseICol = 3; break;
            case 'E' : caseICol = 4; break;
            default : perror("(client - fctPlayer) enreg coup adverse : erreur colonne case init"); return -1;
        }
        caseICol = htonl(caseICol);
        err = send(spIA, &caseICol, sizeof(int), 0);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur sur le send");
            return -3;
        }

        /* 
         * envoi ligne case init adverse à l'IA
         */
        int caseILg;
        switch (c->params.deplPiece.caseDep.c) {
            case UN :       caseILg = 1; break;
            case DEUX :     caseILg = 2; break;
            case TROIS :    caseILg = 3; break;
            case QUATRE :   caseILg = 4; break;
            case CINQ :     caseILg = 5; break;
            case SIX :      caseILg = 6; break;
            default : perror("(client - fctPlayer) enreg coup adverse : erreur ligne case init"); return -1;
        }
        caseILg = htonl(caseILg);
        err = send(spIA, &caseILg, sizeof(int), 0);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur sur le send");
            return -3;
        }

        /* 
         * envoi colonne case finale adverse à l'IA
         */
        int caseFCol;
        switch (c->params.deplPiece.caseArr.c) {
            case 'A' : caseFCol = 0; break;
            case 'B' : caseFCol = 1; break;
            case 'C' : caseFCol = 2; break;
            case 'D' : caseFCol = 3; break;
            case 'E' : caseFCol = 4; break;
            default : perror("(client - fctPlayer) enreg coup adverse : erreur colonne case finale"); return -1;
        }
        caseFCol = htonl(caseFCol);
        err = send(spIA, &caseFCol, sizeof(int), 0);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur sur le send");
            return -3;
        }

        /* 
         * envoi ligne case finale adverse à l'IA
         */
        int caseFLg;
        switch (c->params.deplPiece.caseArr.c) {
            case UN :       caseFLg = 1; break;
            case DEUX :     caseFLg = 2; break;
            case TROIS :    caseFLg = 3; break;
            case QUATRE :   caseFLg = 4; break;
            case CINQ :     caseFLg = 5; break;
            case SIX :      caseFLg = 6; break;
            default : perror("(client - fctPlayer) enreg coup adverse : erreur ligne case finale"); return -1;
        }
        caseFLg = htonl(caseFLg);
        err = send(spIA, &caseFLg, sizeof(int), 0);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur sur le send");
            return -3;
        }
    } 
    else if (c->typeCoup == DEPOSER) {

        /* 
         * envoi sens tete piece adverse à l'IA
         */
        int sensPiece;
        switch (c->piece.sensTetePiece) {
            case NORD : sensPiece = 0; break;
            case SUD : sensPiece = 1; break;
            default : perror("(client - fctPlayer) enreg coup adverse : erreur sens piece"); return -1;
        }
        sensPiece = htonl(sensPiece);
        err = send(spIA, &sensPiece, sizeof(int), 0);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur sur le send");
            return -3;
        }

        /* 
         * envoi type piece adverse à l'IA
         */
        int typePiece;
        switch (c->piece.typePiece) {
            case KODAMA :           typePiece = 0; break;
            case KODAMA_SAMOURAI :  typePiece = 1; break;
            case KIRIN :            typePiece = 2; break;
            case KOROPOKKURU :      typePiece = 3; break;
            case ONI :              typePiece = 4; break;
            case SUPER_ONI :        typePiece = 5; break;
            default : perror("(client - fctPlayer) enreg coup adverse : erreur type piece"); return -1;
        }
        typePiece = htonl(typePiece);
        err = send(spIA, &typePiece, sizeof(int), 0);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur sur le send");
            return -3;
        }

        /* 
         * envoi colonne case adverse à l'IA
         */
        int caseICol;
        switch (c->params.deplPiece.caseDep.c) {
            case 'A' : caseICol = 0; break;
            case 'B' : caseICol = 1; break;
            case 'C' : caseICol = 2; break;
            case 'D' : caseICol = 3; break;
            case 'E' : caseICol = 4; break;
            default : perror("(client - fctPlayer) enreg coup adverse : erreur colonne case depos"); return -1;
        }
        caseICol = htonl(caseICol);
        err = send(spIA, &caseICol, sizeof(int), 0);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur sur le send");
            return -3;
        }

        /* 
         * envoi ligne case adverse à l'IA
         */
        int caseILg;
        switch (c->params.deplPiece.caseDep.c) {
            case UN :       caseILg = 1; break;
            case DEUX :     caseILg = 2; break;
            case TROIS :    caseILg = 3; break;
            case QUATRE :   caseILg = 4; break;
            case CINQ :     caseILg = 5; break;
            case SIX :      caseILg = 6; break;
            default : perror("(client - fctPlayer) enreg coup adverse : erreur ligne case depos"); return -1;
        }
        caseILg = htonl(caseILg);
        err = send(spIA, &caseILg, sizeof(int), 0);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur sur le send");
            return -3;
        }
    }
    else if (c->typeCoup == AUCUN) {
        
    }
    return 0;
}

int debutPartie(int spIA, char sens) {
    int err, sensI;

    if (sens == 'n') {
        sensI = 0;
    }
    else if (sens == 's') {
        sensI = 1;
    }
    else {
        perror("(client - fctPlayer) erreur debut partie - sens recu incorrect");
        return -2;
    }

    sensI = htonl(sensI);
    err = send(spIA, &sensI, sizeof(int), 0);
    if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le send");
        return -3;
    }

    return 0;
}

int finPartie(int spIA) {
    int err, term;

    /* 
     * envoi boooleen partie non terminee
     */
    term = 1;
    int reqN = htonl(term);
    err = send(spIA, &term, sizeof(int), 0);
    if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le send");
        shutdown(spIA, SHUT_RDWR); close(spIA);
        return -3;
    }


    return 0;
}