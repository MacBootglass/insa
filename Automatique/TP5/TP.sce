clear;
clc();
xdel(winsid());

function affNewPart(partie)
    printf("\n--------------------------------------\n");
    printf("Partie %d\n", partie);
    printf("--------------------------------------\n");
endfunction


//PARTIE 1

//Calculs
Mc = 1000;
Mb = 4000;
l = 10;
g = 9.81;

a = (g*Mb)/Mc;
b = -g*(Mb+Mc)/(Mc*l);
c = 1/Mc;
d = -1/(Mc*l);

A = [0 1 0 0; 0 0 a 0; 0 0 0 1; 0 0 b 0]
B = [0; c; 0; d]
C = eye(4,4);
D = zeros(4,1);

sys = syslin('c',A,B,C,D);
t = (0:0.1:50)';
[Y,X] = csim('step',t,sys);

//Affichage
figure(1);
for i=1:4
  subplot(2,2,i);
  plot2d(t,X(i,:));
  if(i==1)
    xtitle('Variation de la position');
  end
  if(i==2)
    xtitle('Variation de la vitesse du chariot');
  end
  if(i==3)
    xtitle('Variation de la position angulaire');
  end
  if(i==4)
    xtitle('Variation de la vitesse angulaire');
  end
end



// PARTIE 2

// Calculs
ctr = cont_mat(A,B);
rang_ctr = rank(ctr);

obsC1 = obsv_mat(A,C(1,:));
rang_obsC1 = rank(obsC1);

obsC3 = obsv_mat(A,C(3,:));
rang_obsC3 = rank(obsC3);

//Affichage
affNewPart(2);
printf("Commandabilité: %d\n", rang_ctr);
printf("Observabilité (cas de la position du chariot seule -> C1): %d\n", rang_obsC1);
printf("Observabilité (cas de l angle du filin seul -> C3): %d\n", rang_obsC3);
