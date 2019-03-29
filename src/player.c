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
#include "protocole.h"
#include "fctCom.h"


int main(int argc, char **argv) {

  TPartieReq partieReq;  /* structure pour l'envoi d'une demande de partie */
  TPartieRep partieRep;  /* structure pour la réception à la suite d'une demande de partie */
  TCoupReq coupReq;      /* structure pour l'envoi d'un coup */
  TCoupRep coupRep;      /* structure pour la réception à la suite d'un coup */ 

  int sock,                     /* descripteur de la socket locale */
      port,                     /* variables de lecture */
      err;                      /* code d'erreur */
  char* ipMachServ;             /* pour solution inet_aton */
  char* nomMachServ;            /* pour solution getaddrinfo */


  struct addrinfo hints;   /* parametre pour getaddrinfo */
  struct addrinfo *result; /* les adresses obtenues par getaddrinfo */ 

  /* verification des arguments */
  if (argc != 3) {
    printf("usage : %s nom/IPServ port\n", argv[0]);
    return -1;
  }
  
  ipMachServ = argv[1]; nomMachServ = argv[1];
  port = atoi(argv[2]);

  /* 
   * creation du socket
   */
  sock = socketClient(nomMachServ, port);
  if (sock < 0) {
    perror("(client) erreur sur socketClient");
    return -1;
  }

  /* 
   * création de la structure pour l'envoi d'une demande de partie
   */
  // TO DO

  /* 
   * envoi de la demande de partie
   */
  err = send(sock, &partieReq, sizeof(TPartieReq), 0);
  if (err <= 0) {
    perror("(client) erreur sur le send");
    shutdown(sock, SHUT_RDWR); close(sock);
    return -5;
  }
  printf("(client) envoi realise\n");

   /*
   * reception du retour suite à la demande de partie
   */
  err = recv(sock, &partieRep, sizeof(TPartieRep), 0);
  if (err <= 0) {
    perror("(client) erreur dans la reception");
    shutdown(sock, SHUT_RDWR); close(sock);
    return -6;
  }

  if (partieRep.err == ERR_OK) {
    printf("(client) partie commencee");
  }
  else {
    printf("(client) erreur sur la demande de partie");
  }
  

  // TO DO : boucle de jeu


  /* 
   * fermeture de la connexion et de la socket 
   */
  shutdown(sock, SHUT_RDWR);
  close(sock);

  return 0;
}
 

