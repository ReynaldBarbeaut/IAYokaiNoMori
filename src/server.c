/*
 **********************************************************
 *
 *  Programme : server.c
 *
 *  resume :    serveur de jeu Yokau no-mori avec 2 joueurs
 *
 *  date :      avril 2019
 *
 ***********************************************************
 */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include "../include/protocole.h"
#include "../include/fctCom.h"
#include "../include/fctServer.h"
#include "../include/validation.h"

int main(int argc, char** argv) {
  
  struct sockaddr_in addServ;	/* adresse socket connex serveur */
  struct sockaddr_in addClient;	/* adresse de la socket client connectee */

  fd_set readSet;         /* ensemble de file descriptors */
  int splay1, splay2;     /* scokets de com pour les 2 joueurs */
  int sizeAddr;
  bool termine;           /* indique si une partie est terminee */
  
  /*
   * verification des arguments
   */
  if (argc != 2) {
    printf ("usage : %s port\n", argv[0]);
    return -1;
  }
  
  int port  = atoi(argv[1]);

  /* 
   * creation du socket
   */
  int sserv = socketServeur(port);
  if (sserv < 0) {
    perror("(serveur) erreur sur socket");
    return -2;
  }

  /* 
   * attente de connexion des 2 joueurs
   */
  splay1 = accept(sserv, (struct sockaddr *)&addClient, (socklen_t *)&sizeAddr);
  splay2 = accept(sserv, (struct sockaddr *)&addClient, (socklen_t *)&sizeAddr);

  /*******************/
  /* DEBUT DE PARTIE */
  /*******************/

  /* 
   * traitement des requêtes de partie
   */
  traite_req_init(splay1, splay2);


  /*****************/
  /* BOUCLE DE JEU */
  /*****************/
  for (int i = 1; i < 3; i++) {

    /* 
     * initialisation du plateau de jeu
     */
    initialiserPartie();
    termine = false;

    /********************/
    /* BOUCLE DE PARTIE */
    /********************/
    while (!termine) {
        traite_req_coup(splay1);
        traite_req_coup(splay2);
    }
  }

  /* 
   * arret de la connexion
   */
  shutdown(splay1, SHUT_RDWR); close(splay1);
  shutdown(splay2, SHUT_RDWR); close(splay2);
  close(sserv);
  
  return 0;
}
