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

void cstrPiece(TPiece *p) {
    // p->sensTetePiece = NORD;
    // p->typePiece = KIRIN;
}

void cstrParamsDepl(TDeplPiece *d) {
    // d->caseDep.c = B;
    // d->caseDep.l = SIX;
    // d->caseDep.c = B;
    // d->caseDep.l = CINQ;
}

void cstrParamsDepos(TDeposerPiece *d) {
    // d->c = A;
    // d->l = CINQ;
}

int cstrCoup(TCoupReq *r, int numPartie) {
    r->idRequest = COUP;
    r->numPartie = numPartie;
    // r->typeCoup = DEPLACER;

    TPiece p;
    cstrPiece(&p);
    r->piece = p;

    if (true) { // si le coup est un déplacement
        TDeplPiece d;
        cstrParamsDepl(&d);
        r->params.deplPiece = d;
    }
    else if (true) { // si le coup est un dépôt
        TDeposerPiece d;
        cstrParamsDepos(&d);
        r->params.deposerPiece = d;
    } 
    else if (true) { // si le coup est sans action
        
    }
    return 0;
}

int enregCoupA(TCoupReq *c) {
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