#include <assert.h>
#include "echanger.h"

void partitionner(long int tab[], long int borneInf, long int borneSup, long int *indicePivot) {
  long int pivot = tab[borneInf];
  long int i     = borneInf;
  long int j     = borneSup;

  while (i <= j)
    if (tab[i] <= pivot)
      i++;
    else if (tab[j] > pivot)
      j--;
    else
      echanger(&tab[i], &tab[j]);

  *indicePivot = j;
  echanger(&tab[borneInf], &tab[j]);
}

void trierEntiersRapideRecursif(long int tab[] , long int borneInf, long int borneSup ){
  long int indicePivot;
  if (borneInf < borneSup) {
    partitionner(tab, borneInf, borneSup, &indicePivot);
    trierEntiersRapideRecursif(tab, borneInf, indicePivot-1);
    trierEntiersRapideRecursif(tab, indicePivot+1, borneSup);
  }
}

void trierEntiersRapide(long int tab[] , long int nbElements ){
  assert (nbElements > 0);
  trierEntiersRapideRecursif(tab, 0, nbElements-1);
}
