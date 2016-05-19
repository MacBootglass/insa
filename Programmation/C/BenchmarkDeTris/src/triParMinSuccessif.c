#include <assert.h>
#include "echanger.h"

long int getIndiceMin(long int tab[], long int nbElements, int indiceDebut) {
  long int indiceMin = indiceDebut;
  for (int j = indiceDebut+1; j < nbElements; j++)
    if (tab[j] < tab[indiceMin])
      indiceMin = j;
  return indiceMin;
}

void trierEntiersParMinSuccessif(long int tab[] , long int nbElements ){
  assert (nbElements > 0);
  int i = 0;
  long int indiceMin;

  while (i < nbElements) {
    indiceMin = getIndiceMin(tab, nbElements, i);
    if (indiceMin > i)
      echanger(&tab[indiceMin], &tab[i]);
    i++;
  }
}
