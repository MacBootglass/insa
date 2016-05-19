#include <assert.h>
#include "echanger.h"

long int obtenirIndiceInsertion(long int tab[], long int borneSup) {
  long int tmp;
  long int borneInf = 0;
  long int valIndiceInitial = tab[borneSup];

  while (borneInf < borneSup) {
    tmp = (borneInf + borneSup) / 2;
    if (tab[tmp] > valIndiceInitial)
      borneSup = tmp;
    else if (tab[tmp] < valIndiceInitial)
      borneInf = tmp+1;
    else {
      borneInf = tmp;
      borneSup = tmp;
    }
  }
  return borneInf;
}

void decaler(long int tab[], long int borneInf, long int borneSup) {
  for(int i = borneSup ; i > borneInf ; i--)
    tab[i] = tab[i-1];
}

void trierEntiersParInsertion(long int tab[] , long int nbElements ){
  assert (nbElements > 0);
  long int indiceInsertion;
  long int tmp;

  for (int i = 2; i < nbElements; i++) {
    indiceInsertion = obtenirIndiceInsertion(tab, i);
    tmp = tab[i];
    decaler(tab, indiceInsertion, i);
    tab[indiceInsertion] = tmp;
  }
}
