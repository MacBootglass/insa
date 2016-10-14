#ifndef __RESEAU_h__
#define __RESEAU_h__
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
struct sockaddr_in
construireAdresseTCPUDPDepuisChaine(char* adresseIP, char* port);
int creerSocketTCPClient(struct sockaddr_in adresse);
int creerSocketTCPServeur(struct sockaddr_in adresse);
int creerSocketUDPServeur(struct sockaddr_in adresse);
#endif
