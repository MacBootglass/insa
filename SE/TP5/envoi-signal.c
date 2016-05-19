/* ==================================================== demo-signal.c */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void main(int argc, char ** argv){
  if (argc == 3 )
    execlp("kill", "kill", argv[1], argv[2], NULL);
}
