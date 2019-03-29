#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <arpa/inet.h>
#include "protocole.h"
#include "fctCom.h"

/*
 **********************************************************
 *
 *  Programme : fctCom.c
 *
 *  resume :    crée un socket client et un socket serveur pour TCP et UDP
 *
 *  date :      8 / 01 / 18
 *
 ***********************************************************
 */

int socketServeur(ushort port) {

  int  sockConx,        /* descripteur socket connexion */
       sockTrans,       /* descripteur socket transmission */
       sizeAddr,        /* taille de l'adresse d'une socket */
       err;         /* code d'erreur */

  struct sockaddr_in addServ; /* adresse socket connex serveur */

  /* 
   * creation de la socket, protocole TCP 
   */
  sockConx = socket(AF_INET, SOCK_STREAM, 0);
  if (sockConx < 0) {
    perror("(serveurTCP) erreur de socket");
    return -2;
  }
  
  /* 
   * initialisation de l'adresse de la socket 
   */
  addServ.sin_family = AF_INET;
  addServ.sin_port = htons(port); // conversion en format réseau (big endian)
  addServ.sin_addr.s_addr = INADDR_ANY; 
  // INADDR_ANY : 0.0.0.0 (IPv4) donc htonl inutile ici, car pas d'effet
  bzero(addServ.sin_zero, 8);
  
  sizeAddr = sizeof(struct sockaddr_in);

  /* 
   * attribution de l'adresse a la socket
   */  
  err = bind(sockConx, (struct sockaddr *)&addServ, sizeAddr);
  if (err < 0) {
    perror("(serveurTCP) erreur sur le bind");
    close(sockConx);
    return -3;
  }
  
  /* 
   * utilisation en socket de controle, puis attente de demandes de 
   * connexion.
   */
  err = listen(sockConx, 1);
  if (err < 0) {
    perror("(serveurTCP) erreur dans listen");
    close(sockConx);
    return -4;
  }

  return sockConx;
}
 

int socketClient(char* ipMachServ, ushort port) {

  int sock,                /* descripteur de la socket locale */
      err;                 /* code d'erreur */
  struct sockaddr_in addSockServ;  
                           /* adresse de la socket connexion du serveur */
  socklen_t sizeAdd;       /* taille d'une structure pour l'adresse de socket */
    /* 
   * creation d'une socket, domaine AF_INET, protocole TCP 
   */
  sock = socket(AF_INET, SOCK_STREAM, 0);
  if (sock < 0) {
    perror("(client) erreur sur la creation de socket");
    return -2;
  }
  
  /* 
   * initialisation de l'adresse de la socket - version inet_aton
   */
  addSockServ.sin_family = AF_INET;
  err = inet_aton(ipMachServ, &addSockServ.sin_addr);
  if (err == 0) { 
    perror("(client) erreur obtention IP serveur");
    close(sock);
    return -3;
  }
  
  addSockServ.sin_port = htons(port);
  bzero(addSockServ.sin_zero, 8);
  
  sizeAdd = sizeof(struct sockaddr_in);

  
  /* 
   * connexion au serveur 
   */
  err = connect(sock, (struct sockaddr *)&addSockServ, sizeAdd); 

  if (err < 0) {
    perror("(client) erreur a la connection de socket");
    close(sock);
    return -4;
  }

  return sock;
  
}


int socketUDP(ushort port) {

 int sock,               /* descripteur de la socket locale */
      sizeAddr,     /* taille de l'adresse d'une socket */
      err;                /* code d'erreur */
  char chaine[257];
  
  char ipMachDest[100];   /* ip de la machine dest */
  
  struct sockaddr_in adrLocal;    /* adresse de la socket locale */

   /* creation de la socket, protocole UDP */
  sock = socket(AF_INET, SOCK_DGRAM, 0);
  if (sock < 0) {
    perror("(emetteur) erreur de socket");
    return -2;
  }

  /* 
   * initialisation de l'adresse de la socket 
   */
  adrLocal.sin_family = AF_INET;
  adrLocal.sin_port = htons(port);
  adrLocal.sin_addr.s_addr = INADDR_ANY;
    // INADDR_ANY : 0.0.0.0 (IPv4) donc htonl inutile ici, car pas d'effet
  bzero(adrLocal.sin_zero, 8);
 
  sizeAddr = sizeof(struct sockaddr_in);
 
  /* 
   * attribution de l'adresse a la socket
   */
  err = bind(sock, (struct sockaddr *)&adrLocal, sizeAddr);
  if (err < 0) {
    perror("(emetteur) erreur sur le bind");
    return -3;
  }

  return sock;

 }

