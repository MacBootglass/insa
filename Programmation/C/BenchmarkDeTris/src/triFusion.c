#include <assert.h>
#include "echanger.h"

void fusionner(long int tab[], long int borneInf, long int milieu, long int borneSup, long int nbElements) {
  long int i = borneInf;
  long int j = milieu+1;
  long int tabTmp[nbElements];

  for (int k=1; k <= borneSup-borneInf+1; k++) {
    if (i <= milieu && j <= borneSup)
      if (tab[i] <= tab[j])
        tabTmp[k] = tab[i++];
      else
        tabTmp[k] = tab[j++];
    else
      if (i <= milieu)
        tabTmp[k] = tab[i++];
      else
        tabTmp[k] = tab[j++];
  }

    for (int k=1; k <= borneSup-borneInf+1; k++)
      tab[borneInf+k-1] = tabTmp[k];
}

void trierEntiersParFusionRecursif(long int tab[], long int borneInf, long int borneSup, long int nbElements) {
  if (borneInf < borneSup) {
    trierEntiersParFusionRecursif(tab, borneInf, (borneInf + borneSup)/2, nbElements);
    trierEntiersParFusionRecursif(tab, (borneInf + borneSup)/2 + 1, borneSup, nbElements);
    fusionner(tab, borneInf, (borneInf + borneSup)/2, borneSup, nbElements);
  }
}

void trierEntiersParFusion(long int tab[] , long int nbElements ){
  assert (nbElements > 0);
  trierEntiersParFusionRecursif(tab, 0, nbElements-1, nbElements);
}
