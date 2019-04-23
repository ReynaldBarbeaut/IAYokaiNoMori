/*
 **********************************************************
 *
 *  Programme : player.c
 *
 *  resume :    joue une partie de Yokai no-mori à l'aide
 *              d'une intelligence artificelle Prolog
 *
 *  date :      mars 2019
 *
 ***********************************************************
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <errno.h>
#include "../include/protocole.h"
#include "../include/fctCom.h"
#include "../include/fctPlayer.h"

int main(int argc, char **argv) {

  TPartieReq partieReq;    /* structure pour l'envoi d'une demande de partie */
  TPartieRep partieRep;    /* structure pour la réception à la suite d'une demande de partie */
  TCoupReq coupReq;        /* structure pour l'envoi d'un coup */
  TCoupRep coupRep;        /* structure pour la réponse à la suite d'un coup */ 
  TCoupReq coupReqA;       /* structure pour le coup adverse */
  TCoupRep coupRepA;       /* structure pour la réponse à la suite d'un coup adverse */ 

  int sock,                /* descripteur de la socket locale */
      port,                /* variables de lecture */
      err;                 /* code d'erreur */
  char* ipMachServ;        /* pour solution inet_aton */
  char* nomMachServ;       /* pour solution getaddrinfo */
  char* nomJoueur;         /* nom de joueur */
  char* nomAdvers;         /* nom de l'adversaire */
  char sens;               /* sens du joueur : 'n' ou 's' */
  bool termine = false;    /* détermine si une partie est terminée */
  int gagne = 0;           /* détermine si l'on a gagné la partie
                              -1 : perdu ; 0 : nul ; 1 : gagne */

  struct addrinfo hints;   /* parametre pour getaddrinfo */
  struct addrinfo *result; /* les adresses obtenues par getaddrinfo */ 

  /* verification des arguments */
  if (argc != 5) {
    printf("usage : %s IPServ port nomJoueur sens\n", argv[0]);
    return -1;
  }
  
  ipMachServ = argv[1]; nomMachServ = argv[1];
  port = atoi(argv[2]);
  nomJoueur = argv[3];
  sens = argv[4][0];

  /* 
   * creation du socket
   */
  sock = socketClient(nomMachServ, port);
  if (sock < 0) {
    perror("(client) erreur sur socketClient");
    return -2;
  }


  /*******************/
  /* DEBUT DE PARTIE */
  /*******************/

  /* 
   * création de la structure pour l'envoi d'une demande de partie
   */
  partieReq.idReq = PARTIE;
  strncpy(partieReq.nomJoueur, nomJoueur, sizeof(partieReq.nomJoueur) - 1);
  partieReq.piece = (sens == 'n' ? NORD : SUD);

  /* 
   * envoi de la demande de partie
   */
  err = send(sock, &partieReq, sizeof(TPartieReq), 0);
  if (err <= 0) {
    perror("(client) erreur sur le send");
    shutdown(sock, SHUT_RDWR); close(sock);
    return -3;
  }
  printf("(client) envoi d'une demande de partie realise\n");

  /*
   * reception du retour suite à la demande de partie
   */
  err = recv(sock, &partieRep, sizeof(TPartieRep), 0);
  if (err <= 0) {
    perror("(client) erreur dans la reception");
    shutdown(sock, SHUT_RDWR); close(sock);
    return -4;
  }

  if (partieRep.err == ERR_OK) {
    if (partieRep.validSensTete == KO) {
      if (sens == 'n') {
        sens = 's';
      } else {
        sens = 'n';
      }
    }
    printf("(client) partie commencee dans le sens %c avec l'adversaire %s\n", sens, partieRep.nomAdvers);
  }
  else {
    perror("(client) erreur sur la demande de partie\nfin de partie");
    shutdown(sock, SHUT_RDWR); close(sock);
    return -5;
  }


  /*****************/
  /* BOUCLE DE JEU */
  /*****************/
  
  for (int i = 1; i < 3; i++) {

    /* 
     * si on n'est pas le premier à jouer
     */
    if (i == 1 && sens == 'n' || i == 2 && sens == 's') {

      /* 
       * on reçoit la validation du coup adverse...
       */
      err = recv(sock, &coupRepA, sizeof(TCoupRep), 0);
      if (err <= 0) {
        perror("(client) erreur dans la reception");
        shutdown(sock, SHUT_RDWR); close(sock);
        return -4;
      }

      if (coupRepA.err != ERR_OK) {
        printf("(client) erreur sur le coup adverse\n");
        printf("(client) code d'erreur : %d\n", coupRepA.err);
        printf("(client) fin de la partie\n");
        continue;
      }
      if (coupRepA.validCoup != VALID) {
        printf("(client) erreur sur la validation du coup adverse\n");
        printf("(client) code d'erreur : %d\n", coupRepA.validCoup);
        printf("(client) fin de la partie\n");
        continue;
      }

      /* 
       * ...puis le coup adverse lui-même 
       */
      err = recv(sock, &coupReqA, sizeof(TCoupReq), 0);
      if (err <= 0) {
        perror("(client) erreur dans la reception");
        shutdown(sock, SHUT_RDWR); close(sock);
        return -4;
      }

      err = enregCoupA(&coupReqA);
      if (err < 0) {
        perror("(client) erreur lors de l'enregistrement du coup adverse");
        shutdown(sock, SHUT_RDWR); close(sock);
        return -5;
      }
    }

    /********************/
    /* BOUCLE DE PARTIE */
    /********************/
    while (!termine) {
      
      /* 
       * création de la structure pour l'envoi d'un coup
       */
      err = cstrCoup(&coupReq, i);
      if (err < 0) {
        perror("(client) erreur lors de la construction du coup");
        shutdown(sock, SHUT_RDWR); close(sock);
        return -6;
      }

      /* 
       * envoi du coup
       */
      err = send(sock, &coupReq, sizeof(TCoupReq), 0);
      if (err <= 0) {
        perror("(client) erreur sur le send");
        shutdown(sock, SHUT_RDWR); close(sock);
        return -3;
      }
      printf("(client) envoi du coup realise\n");

      /* 
       * réception de la validation du coup
       */
      err = recv(sock, &coupRep, sizeof(TCoupRep), 0);
      if (err <= 0) {
        perror("(client) erreur dans la reception");
        shutdown(sock, SHUT_RDWR); close(sock);
        return -4;
      }

      if (coupRep.err != ERR_OK) {
        printf("(client) erreur sur le coup\n");
        printf("(client) code d'erreur : %d\n", coupRep.err);
        printf("(client) fin de la partie\n");
        continue;
      }
      if (coupRep.validCoup != VALID) {
        printf("(client) erreur sur la validation du coup\n");
        printf("(client) code d'erreur : %d\n", coupRep.validCoup);
        printf("(client) fin de la partie\n");
        continue;
      }

      if (coupRep.propCoup == GAGNE) {
        termine = true;
        gagne = 1;
        break;
      }
      else if (coupRep.propCoup == PERDU) {
        termine = true;
        gagne = -1;
        break;
      }
      else if (coupRep.propCoup == NUL) {
        termine = true;
        gagne = 0;
        break;
      }

      /* 
       * réception de la validation du coup adverse...
       */
      err = recv(sock, &coupRepA, sizeof(TCoupRep), 0);
      if (err <= 0) {
        perror("(client) erreur dans la reception");
        shutdown(sock, SHUT_RDWR); close(sock);
        return -4;
      }

      if (coupRepA.err != ERR_OK) {
        printf("(client) erreur sur le coup adverse\n");
        printf("(client) code d'erreur : %d\n", coupRepA.err);
        printf("(client) fin de la partie\n");
        continue;
      }
      if (coupRepA.validCoup != VALID) {
        printf("(client) erreur sur la validation du coup adverse\n");
        printf("(client) code d'erreur : %d\n", coupRepA.validCoup);
        printf("(client) fin de la partie\n");
        continue;
      }

      if (coupRepA.propCoup == GAGNE) {
        termine = true;
        gagne = -1;
        break;
      }
      else if (coupRepA.propCoup == PERDU) {
        termine = true;
        gagne = 1;
        break;
      }
      else if (coupRepA.propCoup == NUL) {
        termine = true;
        gagne = 0;
        break;
      }

      /* 
       * ...puis le coup adverse lui-même 
       */
      err = recv(sock, &coupReqA, sizeof(TCoupReq), 0);
      if (err <= 0) {
        perror("(client) erreur dans la reception");
        shutdown(sock, SHUT_RDWR); close(sock);
        return -4;
      }

      err = enregCoupA(&coupReqA);
      if (err < 0) {
        perror("(client) erreur lors de l'enregistrement du coup adverse");
        shutdown(sock, SHUT_RDWR); close(sock);
        return -5;
      }

    }

    /*****************/
    /* FIN DE PARTIE */
    /*****************/ 
    if (gagne == 1) {
      printf("Partie gagnée !\n");
    } else if (gagne == 0) {
      printf("Match nul pour cette partie !\n");
    } else if (gagne == -1) {
      printf("Partie perdue !\n");
    }
  }

  finDuJeu();

  /* 
   * fermeture de la connexion et de la socket 
   */
  shutdown(sock, SHUT_RDWR);
  close(sock);

  return 0;
}
