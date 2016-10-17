#define _GNU_SOURCE

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include "reseau.h"
#define TAILLE_BUFFER 100000

int ecouter(int socketServeur, int longueurFileDAttente, char * repertoireServeur);
int traiterRequete(int socketClient, char * repertoireServeur);
int lireRequete(int socket, char formatRequete[]);
int envoyerResultat(int socket, char formatRequete[], char * repertoireServeur);
void obtenirConfiguration(char * adresseServeur, char * portServeur, char * repertoireServeur);

int main(int argc,char **argv) {
  char *adresseServeur;
  char *portServeur;
  char *repertoireServeur;

  FILE * fp;
  size_t len = 0;
  ssize_t read;
  char * line = NULL;
  char keyword[30];
  char tmp[30];
  char * token;
  char * delimiter = "=";
  int unknow = 0;

  fp = fopen("etc/config.txt", "r");
  if (fp == NULL){
    fprintf(stderr, "ERREUR: Impossible d'ouvrir le fichier de configuration.");
    exit(EXIT_FAILURE);
  }

  while ((read = getline(&line, &len, fp)) != -1) {
    token = strtok(line, delimiter);

    while( token != NULL ) {
      if (strcmp(token, "server_ip") == 0 || strcmp(token, "server_port_TCP") == 0 || strcmp(token, "server_root_directory") == 0){
        strcpy(keyword, token);
        unknow = 0;
      }
      else if (unknow == 0) {
        strcpy(tmp, token);
        tmp[strlen(tmp)-1] = '\0';

        if (strcmp(keyword, "server_ip") == 0){
          adresseServeur = (char*)malloc(strlen(tmp));
          strcpy(adresseServeur, tmp);
        }
        else if (strcmp(keyword, "server_port_TCP") == 0){
          portServeur = (char*)malloc(strlen(tmp));
          strcpy(portServeur, tmp);
        }
        else if (strcmp(keyword, "server_root_directory") == 0){
          repertoireServeur = (char*)malloc(strlen(tmp));
          strcpy(repertoireServeur, tmp);
        }
      }
      else{
        unknow = 1;
      }
      token = strtok(NULL, delimiter);
    }
  }
  if (line)
    free(line);

  int socketServeur;
  socketServeur=creerSocketTCPServeur(construireAdresseTCPUDPDepuisChaine(adresseServeur, portServeur));

  if (socketServeur!=-1)
    ecouter(socketServeur,10,repertoireServeur);
  return 1;
}


int ecouter(int socketServeur, int longueurFileDAttente, char * repertoireServeur) {
  socklen_t longueurAdresseClient;
  struct sockaddr_in adresseClient;
  int socketClient;
  int erreur=0; erreur=listen(socketServeur,longueurFileDAttente);

  while (erreur!=-1) {
    longueurAdresseClient = sizeof adresseClient;
    socketClient = accept(socketServeur,(struct sockaddr *)&adresseClient,&longueurAdresseClient);
    if (socketClient!=-1) {
        if (traiterRequete(socketClient, repertoireServeur))
          close(socketClient);
        else
          erreur=-1;
    } else
      erreur=-1;
    }
  return erreur;
}


int traiterRequete(int socketClient, char * repertoireServeur) {
  char formatRequete[TAILLE_BUFFER];
  if (lireRequete(socketClient,formatRequete)!=-1)
    return envoyerResultat(socketClient,formatRequete,repertoireServeur);
    else
      return -1;
}


int lireRequete(int socket, char formatRequete[]) {
  int nbCaracteres=0;
  nbCaracteres = read(socket,formatRequete,TAILLE_BUFFER-1);
  if (nbCaracteres!=-1)
    formatRequete[nbCaracteres]='\0';
  return nbCaracteres;
}


int envoyerResultat(int socket, char formatRequete[], char * repertoireServeur) {
  FILE * fp;
  char buffer[TAILLE_BUFFER];
  char result[TAILLE_BUFFER];
  char requete[20], file[20], httpVersion[20], pwd[20];
  int nbCaracteres = TAILLE_BUFFER;

  // Si aucun fichier n'est demandé, (uniquement requete localhost:8080), on envoi la page index.html
  sscanf(formatRequete, "%s %s %s", requete, file, httpVersion);
  if (strcmp(file, "/") == 0) {
    strcpy(file, "/index.html");
  }
  strcpy(pwd, repertoireServeur);
  strcat(pwd, file);

  // On récupère l'extension du fichier demandé afin de déterminer le Content-Type
  int i = 0;
  char delimiter[2] = ".";
  char extension[4];
  char *token;
  token = strtok(file, delimiter);
  while( token != NULL ) {
    if (++i == 2) {
      strcpy(extension, token);
    }
    token = strtok(NULL, delimiter);
  }


  memset(buffer, 0, TAILLE_BUFFER);
  memset(result, 0, TAILLE_BUFFER);
  fp = fopen(pwd, "rb");

  if (fp != NULL) {
    //Détermination de la longueur du fichier
    fseek(fp, 0, SEEK_END);
    nbCaracteres = ftell(fp);
    rewind(fp);

    // Recuperation du contenu du fichier
    fread(buffer, nbCaracteres, 1, fp);

    // Ajout de l'entête en fonction de l'extension du fichier
    if (strcmp(extension, "html") == 0 || strcmp(extension, "htm") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: text/html; charset=utf-8\nContent-Length:%d \n\n", nbCaracteres);
    }
    else if (strcmp(extension, "css") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: text/css; charset=utf-8\nContent-Length:%d \n\n", nbCaracteres);
    }
    else if (strcmp(extension, "jpg") == 0 || strcmp(extension, "jpeg") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: image/jpeg\nContent-Length:%d \n\n", nbCaracteres);
    }
    else if (strcmp(extension, "png") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: image/png\nContent-Length:%d \n\n", nbCaracteres);
    }
    else if (strcmp(extension, "ico") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: image/x-icon\nContent-Length:%d \n\n", nbCaracteres);
    }

    // Calcul de la longueur total de l'envoi
    nbCaracteres += strlen(result);

    // Concaténation de l'entête avec le contenu
    memcpy(result + strlen(result), buffer, nbCaracteres);
  }
  else {
    strcpy(result, "HTTP/1.0 404 Not Found\n\n<h1>Error 404: Page Not Found</h1>"); // Fichier non trouvé
    nbCaracteres = strlen(result);
  }

  return write(socket,result,nbCaracteres);
}
