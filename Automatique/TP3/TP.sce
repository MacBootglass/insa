clear;
clc();
xdel(winsid());

//----------------------------------------------------------------------------//
//Paramètres------------------------------------------------------------------//
//----------------------------------------------------------------------------//
m = 0.9;
f0 = 30;
w0 = 2*%pi*f0;
K0 = 0.8;
p = %s;
t1 = (0:1/(w0*10):10/w0)





//----------------------------------------------------------------------------//
//Partie 1--------------------------------------------------------------------//
//----------------------------------------------------------------------------//

//Calculs
H = K0 / (1 + 2*m*(p/w0) + (p^2)/(w0^2));
sys1 = syslin('c', H);
y1 = csim('step', t1, sys1);


tReponse1 = max([t1(max(find(y1>=(1.05*K0)))), t1(max(find(y1<=(0.95*K0))))]);
tMontee1 = t1(min(find(y1>=0.9*max(y1))))- t1(max(find(y1<=0.1*max(y1))));
tMontee1Bis = t1(min(find(y1>=K0)));
depassement1 = ((max(y1)-K0)/K0)*100;


//Affichage
figure(1);
title("Réponse indicielle de H(p)");
xlabel("Temps (s)");
ylabel("amplit1ude");
plot2d(t1, y1');

disp("---PARTIE 1---");
disp(tReponse1, "Temps de réponse en seconde pour laquelle le signal ne dépasse plus  5% de sa valeur finale: ");
disp(tMontee1, "Temps de montée en seconde (passage de 10% à 90% de la valeur finale):");
disp(tMontee1Bis, "Temps de montée en seconde (temps pour atteindre la valeur finale):");
disp(depassement1, "Dépassement en pourcentage:")





//----------------------------------------------------------------------------//
//Partie 3--------------------------------------------------------------------//
//----------------------------------------------------------------------------//

//Calculs
mBF = 0.6;
wBF = 1384 ;
Kp = ((wBF/w0)^2-1)/K0;
K = Kp * K0;
KBF = K / (1+K);
HBOC = Kp * H;
t2 = (0:1/(wBF*10):60/wBF);

HBF = HBOC / (HBOC + 1);

sys2 = syslin('c', HBF);
sys3 = syslin('c', HBOC);

y2 = csim('step', t2, sys2);

tReponse2 = max([t2(max(find(y2>=(1.05*KBF)))), t2(max(find(y2<=(0.95*KBF))))]);
tMontee2 = t2(min(find(y2>=0.9*max(y2))))- t2(max(find(y2<=0.1*max(y2))));
tMontee2Bis = t2(min(find(y2>=KBF)));
depassement2 = ((max(y2)-KBF)/KBF)*100;

[phase,freqCoupure] = p_margin(sys3);
wc0 = 2 * %pi * freqCoupure;
[gain,ph]=dbphi(repfreq(sys3,freqCoupure));
margePhase = ph + 180;


//Affichage
disp("---PARTIE 3---");

figure(2);
title("Réponse indicielle de HBF(p)");
xlabel("Temps (s)");
ylabel("amplit1ude");
plot2d(t2, y2');

disp(Kp, "Kp :");
disp(tReponse2, "Temps de réponse en seconde pour laquelle le signal ne dépasse plus  5% de sa valeur finale: ");
disp(tMontee2, "Temps de montée en seconde (passage de 10% à 90% de la valeur finale):");
disp(tMontee2Bis, "Temps de montée en seconde (temps pour atteindre la valeur finale):");
disp(depassement2, "Dépassement en pourcentage:")

figure(3);
bode(sys3, 0.1, 100000);
title('Diagramme de Bode de HBOC');
xlabel('fréquence');
ylabel('gain');


disp(margePhase,'Marge de phase :');
disp(wc0,'wc0 :');
disp(freqCoupure,'Fréquence de coupure:');





//----------------------------------------------------------------------------//
//Partie 4--------------------------------------------------------------------//
//----------------------------------------------------------------------------//

//Calculs
phiMax = (60 - margePhase) * %pi / 180;
a = (1 + sin(phiMax))/(1 - sin(phiMax));
Kp2 = 1/sqrt(a);
T = 1/(freqCoupure * 2 * %pi * sqrt(a));
C = Kp2 * (1 + a*T*p) / (1 + T*p);
HBOC2 = H * C * Kp;
HBFC2 = HBOC2 / (HBOC2 + 1);
KBFC2 = (K0*Kp*Kp2)/(1+K0*Kp*Kp2);
t4 = (0:1/(wBF*10):20/wBF);

sys4 = syslin('c', HBFC2);
sys5 = syslin('c', HBOC2);

y4 = csim('step', t4, sys4)

[phase2,freqCoupure2] = p_margin(sys5);
wc02 = 2 * %pi * freqCoupure2;
[gain2,ph2]=dbphi(repfreq(sys5,freqCoupure2));
margePhase2 = ph2 + 180;

tReponse4 = max([t4(max(find(y4>=(1.05*max(y4))))), t4(max(find(y4<=(0.95*max(y4)))))]);
tMontee4 = t4(min(find(y4>=0.9*max(y4)))) - t4(max(find(y4<=0.1*max(y4))));
tMontee4Bis = t4(min(find(y4>=KBFC2)));
depassement4 = ((max(y4)-KBFC2)/KBFC2)*100;


//Affichage
figure(4);
title("Réponse indicielle de HBFC2(p)");
xlabel("Temps (s)");
ylabel("amplit1ude");
plot2d(t4, y4');


figure(5)
bode(sys5, 0.1, 100000);
title('Diagramme de Bode de HBOC2');
xlabel('fréquence');
ylabel('gain');

figure(6)
black(sys5, 0.1, 100000);
title('Diagramme de Black de HBOC2');
xlabel('fréquence');
ylabel('gain');

disp("---PARTIE 4---");
disp(phiMax, "phiMax :");
disp(a, "a :");
disp(Kp2, "Kp2 :");
disp(T, "T :");
disp(margePhase2,'Marge de phase :');
disp(wc02,'wc0 :');
disp(freqCoupure2,'Fréquence de coupure:');
disp(tReponse4, "Temps de réponse en seconde pour laquelle le signal ne dépasse plus  5% de sa valeur finale: ");
disp(tMontee4, "Temps de montée en seconde (passage de 10% à 90% de la valeur finale):");
disp(tMontee4Bis, "Temps de montée en seconde (temps pour atteindre la valeur finale):");
disp(depassement4, "Dépassement en pourcentage:");

