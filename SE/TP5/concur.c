/* ==================================================== concur.c */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void main(){
  int pid, i ;
  pid=fork() ;

  if (pid != 0){
    for (i=0; i<10; i++) {
      printf("\n je suis le processus père %d", i);
      sleep(1);
    }
  }

  if (pid == 0){
    for (i=0; i<10; i++){
      printf("\n je suis le processus fils %d", i);
      execlp("./essai", "./essai", NULL);
      sleep(1);
    }
  }
}
