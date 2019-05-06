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
  int err;                /* code de retour des fonctions utilitaires du serveur */
  bool termine;           /* indique si une partie est terminee */
  char sens;              /* sens de la tête du joueur dont la demande de partie
                             est recue en premier */
  
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

  printf("zé bartiii!\n");

  /*******************/
  /* DEBUT DE PARTIE */
  /*******************/

  /* 
   * traitement des requêtes de partie
   */
  err = traite_req_init(splay1, splay2, &sens);
  if (err < 0) {
    perror("(serveur) erreur traitement requete init");
    return -3;
  }

  /*****************/
  /* BOUCLE DE JEU */
  /*****************/
  for (int i = 1; i < 3; i++) {

    /* 
     * initialisation du plateau de jeu
     */
    initialiserPartie();
    termine = false;
    printf("Debut de la partie numero %d\n", i);

    /********************/
    /* BOUCLE DE PARTIE */
    /********************/
    int j = 0; // compteur de coups
    while (!termine) {
        if (i == 1) { // 1ere partie
          if (j % 2 == 0) { // la parité de j indique quel joueur joue
            if (sens == 's') {
              err = traite_req_coup(splay1, splay2, 1, i);
            }
            else {
              err = traite_req_coup(splay2, splay1, 2, i);
            }
          }
          else {
            if (sens == 's') {
              err = traite_req_coup(splay2, splay1, 2, i);
            }
            else {
              err = traite_req_coup(splay1, splay2, 1, i);
            }
          }
        }
        if (i == 2) { // 2e partie
          if (j % 2 == 0) {
            if (sens == 's') {
              err = traite_req_coup(splay2, splay1, 2, i);
            }
            else {
              err = traite_req_coup(splay1, splay2, 1, i);
            }
          }
          else {
            if (sens == 's') {
              err = traite_req_coup(splay1, splay2, 1, i);
            }
            else {
              err = traite_req_coup(splay2, splay1, 2, i);
            }
          }
        }

        switch (err) {
          case -1 : printf("TIMEOUT : fin de partie\n"); termine = true; break;
          case 0 : termine = false; break;
          case 1 : printf("Le joueur 1 gagne la partie !\n"); termine = true; break;
          case 2 : printf("Le joueur 2 gagne la partie !\n"); termine = true; break;
          case 3 : printf("Match nul pour cette partie !\n"); termine = true; break;
          default : perror("(serveur) erreur traitement requete coup"); return -4; break;
        }
        
        j++;
        if (j >= 60) {
          termine = 0;
        }
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
