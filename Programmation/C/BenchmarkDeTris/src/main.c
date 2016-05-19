#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "triParMinSuccessif.h"
#include "triParInsertion.h"
#include "triRapide.h"
#include "triFusion.h"

#define MAX 2147483647

int saisieNbEntiers(long int max) {
  long int resultat;
  do {
    printf("Nb d'entiers :");
    scanf("%ld",&resultat);
  } while ((resultat<=0) || (resultat>max));
  return resultat;
}

void remplirAuHasard(long int tab[], long int nbElements) {
  long int i;
  for (i=0;i<nbElements;i++)
    tab[i]=random()%nbElements;
  /* Remplacer la ligne precedente par la ligne suivante pour montrer que
     dans le pire des cas le tri rapide est en n^2 lorsque
     la valeur pivot est le 1er element du tableau
     tab[i]=i;
  */
}

double benchmarkerUnTri(long int tab[],  long int nbElements, void (*trier)(long int*,long int)){
  long int *tabTmp = (long int *)malloc(nbElements * sizeof(long int));
  memcpy(tabTmp , tab , nbElements*sizeof(long int));
  double chrono = clock() / (double) CLOCKS_PER_SEC;
  trier(tabTmp, nbElements);
  chrono = clock() / ((double) CLOCKS_PER_SEC) - chrono;
  free(tabTmp);
  return chrono;
}

int main(int nbparams,char** params) {
  long int nbEntiers;
  long int *entiers;
  nbEntiers=saisieNbEntiers(MAX);
  entiers=(long int*)malloc(nbEntiers*sizeof(long int));
  remplirAuHasard(entiers,nbEntiers);
  printf("Tri Par Minimum Successif : %fs (temps CPU)\n",benchmarkerUnTri(entiers,nbEntiers,trierEntiersParMinSuccessif));
  printf("Tri Par Insertion : %fs (temps CPU)\n",benchmarkerUnTri(entiers,nbEntiers,trierEntiersParInsertion));
  printf("Tri Rapide : %fs (temps CPU)\n",benchmarkerUnTri(entiers,nbEntiers,trierEntiersRapide));
  printf("Tri Par Fusion : %fs (temps CPU)\n",benchmarkerUnTri(entiers,nbEntiers,trierEntiersParFusion));
  free(entiers);
  return EXIT_SUCCESS;
}
