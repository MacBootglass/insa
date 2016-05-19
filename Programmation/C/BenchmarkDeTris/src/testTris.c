#include <stdlib.h>
#include <CUnit/Basic.h>
#include "triParMinSuccessif.h"
#include "triParInsertion.h"
#include "triRapide.h"
#include "triFusion.h"
#define TRUE 1
#define FALSE 0
#define TAILLE 20


int init_suite_success(void) {
  return 0;
}

int clean_suite_success(void) {
  return 0;
}

void creerTableau(long int tab[]) {
  long int tableau[TAILLE] = { 8, 15, 25, 65, 95, 75, 52, 58, 45, 35 , 35 , 73 ,85 ,78 , 8 , 95 , 8 , 43 , 24 , 10 };
  memcpy(tab , tableau , TAILLE*sizeof(long int));
}

int comparerTableau(long int  tab1[]){
  long int tab2[TAILLE] = { 8 , 8 , 8 , 10 , 15 , 24 , 25 , 35 , 35 , 43 , 45 , 52 , 58 , 65 , 73 , 75 , 78 , 85 , 95 , 95 };
  int retour = TRUE;
  int i = 0 ;
  while(retour == TRUE && i < TAILLE)
    if(tab1[i] != tab2[i])
      retour = FALSE ;
    else
      i++ ;
  return retour ;
}


void testTriMinSuccessif(void){
  long int* tab = (long int*)malloc(TAILLE*sizeof(long int)) ;
  creerTableau(tab);
  trierEntiersParMinSuccessif(tab, TAILLE);
  CU_ASSERT_TRUE(comparerTableau(tab) == TRUE);
  free(tab);
}

void testTriInsertion(void){
  long int* tab = (long int*)malloc(TAILLE*sizeof(long int)) ;
  creerTableau(tab);
  trierEntiersParInsertion(tab, TAILLE);
  CU_ASSERT_TRUE(comparerTableau(tab) == TRUE);
  free(tab);
}

void testTriRapide(void){
  long int* tab = (long int*)malloc(TAILLE*sizeof(long int)) ;
  creerTableau(tab);
  trierEntiersRapide(tab, TAILLE);
  CU_ASSERT_TRUE(comparerTableau(tab) == TRUE);
  free(tab);
}

void testTriFusion(void){
  long int* tab = (long int*)malloc(TAILLE*sizeof(long int)) ;
  creerTableau(tab);
  trierEntiersParFusion(tab, TAILLE);
  CU_ASSERT_TRUE(comparerTableau(tab) == TRUE);
  free(tab);
}

int main(int argc, char** argv){
  CU_pSuite pSuite = NULL;

  /* initialisation du registre de tests */
  if (CUE_SUCCESS != CU_initialize_registry())
    return CU_get_error();

  /* ajout d'une suite de test */
  pSuite = CU_add_suite("Tests boite noire : Tris", init_suite_success, clean_suite_success);
  if (NULL == pSuite) {
    CU_cleanup_registry();
    return CU_get_error();
  }

  /* Ajout des tests à la suite de tests boite noire */
  if ((NULL == CU_add_test(pSuite, "Tri minimum successif ", testTriMinSuccessif))
      || (NULL == CU_add_test(pSuite, "Tri par insertion", testTriInsertion))
      || (NULL == CU_add_test(pSuite, "Tri rapide", testTriRapide))
      || (NULL == CU_add_test(pSuite, "Tri fusion", testTriFusion))
      )
    {
      CU_cleanup_registry();
      return CU_get_error();
    }

  /* Lancement des tests */
  CU_basic_set_mode(CU_BRM_VERBOSE);
  CU_basic_run_tests();
  printf("\n");
  CU_basic_show_failures(CU_get_failure_list());
  printf("\n\n");

  /* Nettoyage du registre */
  CU_cleanup_registry();
  return CU_get_error();
}
