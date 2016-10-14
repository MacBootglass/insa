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
#define TAILLE_BUFFER 70000


int ecouter(int socketServeur, int longueurFileDAttente);
int traiterRequete(int socketClient);
int lireRequete(int socket, char formatRequete[]);
int envoyerResultat(int socket, char formatRequete[]);

int main(int argc,char **argv) {
  char *adresseServeur=NULL;
  char *portServeur="8080";
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
    ecouter(socketServeur,10);
  return 1;
}

int ecouter(int socketServeur, int longueurFileDAttente) {
  socklen_t longueurAdresseClient;
  struct sockaddr_in adresseClient;
  int socketClient;
  int erreur=0; erreur=listen(socketServeur,longueurFileDAttente);

  while (erreur!=-1) {
    longueurAdresseClient = sizeof adresseClient;
    socketClient = accept(socketServeur,(struct sockaddr *)&adresseClient,&longueurAdresseClient);
    if (socketClient!=-1) {
        if (traiterRequete(socketClient))
          close(socketClient);
        else
          erreur=-1;
    } else
      erreur=-1;
    }
  return erreur;
}

int traiterRequete(int socketClient) {
  char formatRequete[TAILLE_BUFFER];
  if (lireRequete(socketClient,formatRequete)!=-1)
    return envoyerResultat(socketClient,formatRequete);
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


int envoyerResultat(int socket, char formatRequete[]) {
  FILE * fp;
  char * line = NULL;
  char buffer[TAILLE_BUFFER];
  char result[TAILLE_BUFFER];
  char requete[20], file[20], httpVersion[20], pwd[20];
  int nbCaracteres = TAILLE_BUFFER;
  size_t len = 0;
  ssize_t read;

  memset(buffer, 0, TAILLE_BUFFER);
  // Si aucun fichier n'est demandé, (uniquement requete localhost:8080), on envoi la page index.html
  sscanf(formatRequete, "%s %s %s", requete, file, httpVersion);
  if (strcmp(file, "/") == 0) {
    strcpy(file, "/index.html");
  }
  strcpy(pwd, "www");
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


  fp = fopen(pwd, "r");
  strcpy(buffer, "");
  if (fp != NULL) {

    // Recuperation des lignes du fichier
    while ((read = getline(&line, &len, fp)) != -1) {
      strcat(buffer, line);
    }
    if (line) {
      free(line);
    }

    nbCaracteres = strlen(buffer);

    // Ajout de l'entête en fonction de l'extension du fichier
    if (strcmp(extension, "html") == 0 || strcmp(extension, "htm") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: text/html; charset=utf-8\nContent-Length:%d \n\n%s", nbCaracteres, buffer);
    }
    if (strcmp(extension, "png") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: image/png; charset=utf-8\nContent-Length:%d \n\n%s", nbCaracteres, buffer);
    }
    if (strcmp(extension, "jpeg") == 0 || strcmp(extension, "jpg") == 0) {
      sprintf(result, "HTTP/1.0 200 OK\nContent-Type: image/jpeg; charset=utf-8\nContent-Length:%d \n\n%s", nbCaracteres, buffer);
    }
  }
  else {                                                                        // Fichier non trouvé
    strcpy(result, "HTTP/1.0 404 Not Found\n\n<h1>Error 404: Page Not Found</h1>");
  }

  nbCaracteres = strlen(result);

  return write(socket,result,nbCaracteres);
}
