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

tReponse1 = t1(min(find(y1>=(0.95*max(y1)))));
tMontee1 = t1(min(find(y1>=0.9*max(y1))))- t1(max(find(y1<=0.1*max(y1))));
depassement1 = (max(y1)-y1(length(y1)))/y1(length(y1))*100;


//Affichage
figure(1);
title("Réponse indicielle de H(p)");
xlabel("Temps (s)");
ylabel("amplit1ude");
plot2d(t1, y1');

disp("---PARTIE 1---");
disp(tReponse1, "Temps de réponse en seconde pour atteindre 95% de amplitude max :");
disp(tMontee1, "Temps de montée en seconde:");
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
t2 = (0:1/(wBF*10):20/wBF);


HBF = K / ((p/w0)^2 + 2*m*p/w0 + 1 + K);
HBF2 = KBF / ((p/wBF)^2 + 2*mBF*p/wBF + 1);
sys2 = syslin('c', HBF2);
y2 = csim('step', t2, sys2);

tReponse2 = t2(min(find(y2>=(0.95*max(y2)))));
tMontee2 = t2(min(find(y2>=0.9*max(y2))))- t2(max(find(y2<=0.1*max(y2))));
depassement2 = (max(y2)-y2(length(y2)))/y2(length(y2))*100;

HBOC = Kp * H;
sys3 = syslin('c', HBOC);

[phase,freqCoupure] = p_margin(sys3);
wc0 = 2 * %pi * freqCoupure;
[gain,ph]=dbphi(repfreq(sys3,freqCoupure));
margePhase = ph + 180;


//Affichage
figure(2);
title("Réponse indicielle de HBF(p)");
xlabel("Temps (s)");
ylabel("amplit1ude");
plot2d(t2, y2');

disp(Kp, "Kp :");
disp(tReponse2, "Temps de réponse en seconde pour atteindre 95% de amplitude max :");
disp(tMontee2, "Temps de montée en seconde:");
disp(depassement2, "Dépassement en pourcentage:")

figure(3);
bode(sys3, 0.01, 1000);
title('Diagramme de Bode de HBOC');
xlabel('fréquence');
ylabel('gain');

disp("---PARTIE 3---");
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
t3 = (0:1/(wBF*10):20/wBF);

sys4 = syslin('c', HBOC2);
y4 = csim('step', t3, sys4)

tReponse3 = t3(min(find(y4>=(0.95*max(y4)))));
tMontee3 = t3(min(find(y4>=0.9*max(y4))))- t3(max(find(y4<=0.1*max(y4))));
depassement3 = (max(y4)-y4(length(y4)))/y4(length(y4))*100;


//Affichage
figure(4);
title("Réponse indicielle de HBOC2(p)");
xlabel("Temps (s)");
ylabel("amplit1ude");
plot2d(t3, y4');


figure(5)
bode(sys4, 0.01, 1000);
title('Diagramme de Bode de HBOC2');
xlabel('fréquence');
ylabel('gain');

figure(6)
black(sys4, 0.01, 10000);
title('Diagramme de Black de HBOC2');
xlabel('fréquence');
ylabel('gain');

disp("---PARTIE 4---");
disp(phiMax, "phiMax :");
disp(a, "a :");
disp(Kp2, "Kp2 :");
disp(T, "T :");
disp(tReponse3, "Temps de réponse en seconde pour atteindre 95% de amplitude max :");
disp(tMontee3, "Temps de montée en seconde:");
disp(depassement3, "Dépassement en pourcentage:")
