/*
 **********************************************************
 *
 *  Programme : serveurCalcul.c
 *
 *  resume :    execute un calcul en réponse à une demande d'un client
 *
 *  date :      8 / 01 / 18
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
#include "protocole.h"
#include "fctCom.h"
#include "validation.h"

#define MAX_CL 2           /* nombre maximum de clients connectés */

int main(int argc, char** argv) {
  
  struct sockaddr_in addServ;	/* adresse socket connex serveur */
  struct sockaddr_in addClient;	/* adresse de la socket client connectee */

  fd_set readSet;         /* ensemble de file descriptors */
  int tSockCl[MAX_CL];    /* tableau de scokets de com */
  int nbCl;               /* nombre de clients connectés */
  int i, sizeAddr, sd, activity, max_sd, new_socket, empty;

  for (i = 0; i < MAX_CL; i++) {   
    tSockCl[i] = 0;   
  }
  
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

  // TO DO

  /* 
   * arret de la connexion
   */
  close(sserv);
  
  return 0;
}
