/* ==================================================== demo-signal.c */
#include <signal.h>

static int nbSIGUSR1;

void handler(int sig){
    if (sig == SIGUSR1)
      nbSIGUSR1++;
    else if (sig == SIGUSR2)
      printf("%d signaux SIGUSR1 recu\n",nbSIGUSR1 );
    signal(sig, handler) ;
}

void main(){
    nbSIGUSR1 = 0;
    signal (SIGUSR1,handler) ;
    signal (SIGUSR2,handler) ;
    for (;;) {}
}
