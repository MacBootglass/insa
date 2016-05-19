/* ================================================== demo-semaphore.c */
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

void P(int semid){
  struct sembuf op ;
  op.sem_num = 0;
  op.sem_op = -1;
  op.sem_flg = 0;
  semop(semid,&op,1) ;
}

void V(int semid){
  struct sembuf op ;
  op.sem_num = 0;
  op.sem_op = 1;
  op.sem_flg = 0;
  semop(semid,&op,1);
}

void Z(int semid){
  struct sembuf op ;
  op.sem_num = 0;
  op.sem_op = 0;
  op.sem_flg = 0 ;
  semop(semid,&op,1);
}

void init_sem(int semid, int *valeur){
  semctl(semid,1,SETALL,valeur);
}

void main(){
  key_t key = ftok("un chemin vers le programme",1);
  int semid = semget(key,1,IPC_CREAT|0666);
  for (;;) {}
}
