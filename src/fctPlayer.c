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

int readInt(int spIA, int *res) {
    char buff[sizeof(int)];
    char *pBuff = buff;
    int bytesLeft = sizeof(int);

    int err;
    while (bytesLeft > 0){
        err = read(spIA, pBuff, bytesLeft);
        if(err <= 0){
            perror("(client) erreur sur le recv");
            return -1;
        }

        pBuff += err;
        bytesLeft -= err;
    }

   *res = ((buff[0]<<24)|(buff[1]<<16)|(buff[2]<<8)|(buff[3]));
   return 1;
}

int cstrCoup(int spIA, TCoupReq *r, int numPartie) {

    int err;

    /* 
     * reception de l'action joueur depuis l'IA
     */
    int action;
	err = readInt(spIA, &action);

    if(numPartie == 2){
	    printf("Action : %d",action);
    }
    if (err <= 0) {
	  perror("(client - fctPlayer) erreur recv - action");
	  shutdown(spIA, SHUT_RDWR);
	  return -4;
	}

    r->idRequest = COUP;
    r->numPartie = numPartie;
    switch (action) {
        case 0 : r->typeCoup = DEPLACER; break; // déplacement sans capture
        case 1 : r->typeCoup = DEPLACER; break; // déplacement avec capture
        case 2 : r->typeCoup = DEPOSER; break;
        case 3 : r->typeCoup = AUCUN; break; 
        default : perror("(client - fctPlayer) erreur reception action"); return -1;
    }

    if (r->typeCoup == DEPLACER) { // si le coup déplacement prévoit une capture
        if (action == 1) {
            r->params.deplPiece.estCapt = true;
        } else {
            r->params.deplPiece.estCapt = false;
        }
    }

    if (r->typeCoup == DEPLACER) { // si le coup est un déplacement

        /* 
         * reception du sens de la piece depuis l'IA
         */
        int sensPiece;
        err = readInt(spIA, &sensPiece);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur recv - sensPiece");
            shutdown(spIA, SHUT_RDWR);
            return -4;
        }
        
        if (sensPiece == 0 || sensPiece == 1) {
            r->piece.sensTetePiece = (sensPiece == 0 ? NORD : SUD);
        } else {
            perror("(client - fctPlayer) erreur reception sens piece"); return -1;
        }

        /* 
         * reception du type de piece depuis l'IA
         */
        int typePiece;
        err = readInt(spIA, &typePiece);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur recv - typePiece");
            shutdown(spIA, SHUT_RDWR);
            return -4;
        }

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
        err = readInt(spIA, &caseICol);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur recv - caseICol");
            shutdown(spIA, SHUT_RDWR);
            return -4;
        }

        switch (caseICol) {
            case 1 : r->params.deplPiece.caseDep.c = A; break;
            case 2 : r->params.deplPiece.caseDep.c = B; break;
            case 3 : r->params.deplPiece.caseDep.c = C; break;
            case 4 : r->params.deplPiece.caseDep.c = D; break;
            case 5 : r->params.deplPiece.caseDep.c = E; break;
            default : perror("(client - fctPlayer) erreur reception colonne case initiale"); return -1;
        }

        /* 
         * reception de la ligne de la case initiale depuis l'IA
         */
        int caseILg;
        err = readInt(spIA, &caseILg);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur recv - caseILg");
            shutdown(spIA, SHUT_RDWR);
            return -4;
        }

        switch (caseILg) {
            case 1 : r->params.deplPiece.caseDep.l = UN; break;
            case 2 : r->params.deplPiece.caseDep.l = DEUX; break;
            case 3 : r->params.deplPiece.caseDep.l = TROIS; break;
            case 4 : r->params.deplPiece.caseDep.l = QUATRE; break;
            case 5 : r->params.deplPiece.caseDep.l = CINQ; break;
            case 6 : r->params.deplPiece.caseDep.l = SIX; break;
            default : perror("(client - fctPlayer) erreur reception ligne case initiale"); return -1;
        }



        /* 
         * reception de la colonne de la case finale depuis l'IA
         */
        int caseFCol;
        err = readInt(spIA, &caseFCol);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur recv - caseFCol");
            shutdown(spIA, SHUT_RDWR);
            return -4;
        }

        switch (caseFCol) {
            case 1 : r->params.deplPiece.caseArr.c = A; break;
            case 2 : r->params.deplPiece.caseArr.c = B; break;
            case 3 : r->params.deplPiece.caseArr.c = C; break;
            case 4 : r->params.deplPiece.caseArr.c = D; break;
            case 5 : r->params.deplPiece.caseArr.c = E; break;
            default : perror("(client - fctPlayer) erreur reception colonne case finale"); return -1;
        }

        /* 
         * reception de la ligne de la case finale depuis l'IA
         */
        int caseFLg;
        err = readInt(spIA, &caseFLg);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur recv - caseFLg");
            shutdown(spIA, SHUT_RDWR);
            return -4;
        }

         switch (caseFLg) {
            case 1 : r->params.deplPiece.caseArr.l = UN; break;
            case 2 : r->params.deplPiece.caseArr.l = DEUX; break;
            case 3 : r->params.deplPiece.caseArr.l = TROIS; break;
            case 4 : r->params.deplPiece.caseArr.l = QUATRE; break;
            case 5 : r->params.deplPiece.caseArr.l = CINQ; break;
            case 6 : r->params.deplPiece.caseArr.l = SIX; break;
            default : perror("(client - fctPlayer) erreur reception ligne case finale"); return -1;
        }
    }


    else if (r->typeCoup == DEPOSER) { // si le coup est un dépôt

        /* 
         * reception du sens de la piece depuis l'IA
         */
        int sensPiece;
        err = readInt(spIA, &sensPiece);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur recv - sensPiece");
            shutdown(spIA, SHUT_RDWR);
            return -4;
        }
        
        if (sensPiece == 0 || sensPiece == 1) {
            r->piece.sensTetePiece = (sensPiece == 0 ? NORD : SUD);
        } else {
            perror("(client - fctPlayer) erreur reception sens piece"); return -1;
        }

        /* 
         * reception du type de piece depuis l'IA
         */
        int typePiece;
        err = readInt(spIA, &typePiece);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur recv - typePiece");
            shutdown(spIA, SHUT_RDWR);
            return -4;
        }

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
        err = readInt(spIA, &caseICol);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur recv - caseICol");
            shutdown(spIA, SHUT_RDWR);
            return -4;
        }

        switch (caseICol) {
            case 1 : r->params.deposerPiece.c = A; break;
            case 2 : r->params.deposerPiece.c = B; break;
            case 3 : r->params.deposerPiece.c = C; break;
            case 4 : r->params.deposerPiece.c = D; break;
            case 5 : r->params.deposerPiece.c = E; break;
            default : perror("(client - fctPlayer) erreur reception colonne case depos"); return -1;
        }

        /* 
         * reception de la ligne de la case depuis l'IA
         */
        int caseILg;
        err = readInt(spIA, &caseILg);
        if (err <= 0) {
            perror("(client - fctPlayer) erreur recv - caseILg");
            shutdown(spIA, SHUT_RDWR);
            return -4;
        }

         switch (caseILg) {
            case 1 : r->params.deposerPiece.l = UN; break;
            case 2 : r->params.deposerPiece.l = DEUX; break;
            case 3 : r->params.deposerPiece.l = TROIS; break;
            case 4 : r->params.deposerPiece.l = QUATRE; break;
            case 5 : r->params.deposerPiece.l = CINQ; break;
            case 6 : r->params.deposerPiece.l = SIX; break;
            default : perror("(client - fctPlayer) erreur reception ligne initiale"); return -1;
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
    term = htonl(term);
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
        case DEPLACER : if (c->params.deplPiece.estCapt == true) {action = 1;} else {action = 0;} break;
        case DEPOSER : action = 2; break;
        case AUCUN : action = 3; break;
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
            case A : caseICol = 1; break;
            case B : caseICol = 2; break;
            case C : caseICol = 3; break;
            case D : caseICol = 4; break;
            case E : caseICol = 5; break;
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
        switch (c->params.deplPiece.caseDep.l) {
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
            case A : caseFCol = 1; break;
            case B : caseFCol = 2; break;
            case C : caseFCol = 3; break;
            case D : caseFCol = 4; break;
            case E : caseFCol = 5; break;
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
        switch (c->params.deplPiece.caseArr.l) {
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
        switch (c->params.deposerPiece.c) {
            case A : caseICol = 1; break;
            case B : caseICol = 2; break;
            case C : caseICol = 3; break;
            case D : caseICol = 4; break;
            case E : caseICol = 5; break;
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
        switch (c->params.deposerPiece.l) {
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
     * envoi boooleen partie terminee
     */
    term = 1;
    term = htonl(term);
    err = send(spIA, &term, sizeof(int), 0);
    if (err <= 0) {
        perror("(client - fctPlayer) erreur sur le send");
        shutdown(spIA, SHUT_RDWR); close(spIA);
        return -3;
    }


    return 0;
}