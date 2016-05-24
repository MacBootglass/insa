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
F = 1000;

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
consigne = F * ones(1, length(t));;
[Y,X] = csim(consigne, t, sys);

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


//PARTIE 3

//Calculs
m = 0.7;
tm = 25;
wn = 3.29/tm;
poles_BO = spec(A);

l1BF = -m*wn - wn*sqrt(m^2-1);
l2BF = -m*wn + wn*sqrt(m^2-1);
l3BF = 5*real(l1BF);
l4BF = 5*real(l2BF);
poles_BF = [l1BF l2BF l3BF l4BF];

K = ppol(A, B, poles_BF);
S = 1/(C(1,:)*inv(-A+B*K)*B);

A_BF = A-B*K;
B_BF = B*S;
C_BF = C;

r = 50;
sys_BF = syslin('c', A_BF, B_BF, C_BF, D);
t_BF = (0:0.1:100)';
consigne_BF = r * ones(1, length(t_BF));

[Y_BF,X_BF] = csim(consigne_BF, t_BF, sys_BF);

//Affichage
affNewPart(3);

printf("Système en BO:\n")
printf("\t- Pole1: %f + %f i\n", poles_BO(1), imag(poles_BO(3)));
printf("\t- Pole2: %f + %f i\n", poles_BO(2), imag(poles_BO(4)));

printf("Système en BF:\n")
printf("\t- Pole1: %f + %f i\n", l1BF, imag(l1BF));
printf("\t- Pole2: %f + %f i\n", l2BF, imag(l2BF));
printf("\t- Pole3: %f\n", l3BF);
printf("\t- Pole4: %f\n", l4BF);

printf("Matrice de gain K du régulateur par retour d état: [%d %d %d %d]\n", K(1), K(2), K(3), K(4));
printf("Coefficient S du précompensateur: %d", S);

figure(2);
for i=1:4
  subplot(2,2,i);
  plot2d(t_BF,X_BF(i,:));
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
