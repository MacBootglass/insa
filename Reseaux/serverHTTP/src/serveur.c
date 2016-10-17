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
  char *adresseServeur=NULL;
  char *portServeur="8080";
  char *repertoireServeur="www";

  int socketServeur;

  if ( argc >= 2 ) {
    adresseServeur=argv[1];
  } else {
    adresseServeur="127.0.0.1";
  }
  if ( argc >= 3 )
    portServeur=argv[2];

  socketServeur=creerSocketTCPServeur(construireAdresseTCPUDPDepuisChaine(adresseServeur, portServeur));

  if (socketServeur!=-1)
    ecouter(socketServeur,10,repertoireServeur);
  return 1;
}

void obtenirConfiguration(char * adresseServeur, char * portServeur, char * repertoireServeur) {
  FILE * fp;
  char * line = NULL;
  size_t len = 0;
  ssize_t read;

  fp = fopen("etc/config.txt", "r");
  if (fp == NULL){
    fprintf(stderr, "ERREUR: Impossible d'ouvrir le fichier de configuration.");
    exit(EXIT_FAILURE);
  }

  while ((read = getline(&line, &len, fp)) != -1) {
    printf("Réception d'une ligne de longueur %zu :\n", read);
    printf("%s", line);
  }
  if (line)
    free(line);

  exit(EXIT_SUCCESS);
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
  memset(buffer, 0, TAILLE_BUFFER);
  memset(result, 0, TAILLE_BUFFER);

  // char * buffer;
  // char * result;

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


  fp = fopen(pwd, "rb");

  if (fp != NULL) {

    //Détermination de la longueur du fichier
    fseek(fp, 0, SEEK_END);
    nbCaracteres = ftell(fp)+1;
    rewind(fp);

    // result = (char*)malloc(100+nbCaracteres);
    // memset(result, 0, 100+nbCaracteres);
    //
    // buffer = (char*)malloc(nbCaracteres);
    // memset(buffer, 0, nbCaracteres);

    // Recuperation du contenu du fichier
    fread(buffer, nbCaracteres, 1, fp);

    // Ajout de l'entête en fonction de l'extension du fichier
    if (strcmp(extension, "html") == 0 || strcmp(extension, "htm") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: text/html; charset=utf-8\nContent-Length:%d \n\n", nbCaracteres);
    }

    if (strcmp(extension, "css") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: text/css; charset=utf-8\nContent-Length:%d \n\n", nbCaracteres);
    }

    if (strcmp(extension, "jpg") == 0 || strcmp(extension, "jpeg") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: image/jpeg\nContent-Length:%d \n\n", nbCaracteres);
    }

    if (strcmp(extension, "png") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: image/png\nContent-Length:%d \n\n", nbCaracteres);
    }

    // Calcul de la longueur total de l'envoi
    nbCaracteres += strlen(result);

    // Concaténation de l'entête avec le contenu
    memcpy(result + strlen(result), buffer, nbCaracteres);
  }
  else {
    // result = (char*)malloc(100);
    // memset(result, 0, 100);
    strcpy(result, "HTTP/1.0 404 Not Found\n\n<h1>Error 404: Page Not Found</h1>"); // Fichier non trouvé
    nbCaracteres += strlen(result);
  }


  // free(buffer);
  // free(result);
  return write(socket,result,nbCaracteres);
}
