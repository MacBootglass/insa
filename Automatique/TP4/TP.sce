clear;
clc();
xdel(winsid());

function [tm, tmBis, tr5, depassement] = cara(y, t, K)
    tr5 = max([t(max(find(y>=(1.05*K)))), t(max(find(y<=(0.95*K))))]);
    tm = t(min(find(y>=0.9*max(y))))- t(max(find(y<=0.1*max(y))));
    tmBis = t(min(find(y>=K)));
    depassement = ((max(y)-K)/K)*100;
endfunction

function [wc0, fc0, margePhase, margeGain] = perf(sys)
    [phase,fc0] = p_margin(sys);
    wc0 = 2 * %pi * fc0;
    //[gain,ph] = dbphi(repfreq(sys,fc0));
    margePhase = 180 - abs(phase);
    [margeGain, freqG] = g_margin(sys); 
endfunction

function affCara(tr5, tm, tmBis, depassement)
    disp(tr5, "Temps de réponse en seconde pour laquelle le signal ne dépasse plus  5% de sa valeur finale: ");
    disp(tm, "Temps de montée en seconde (passage de 10% à 90% de la valeur finale):");
    disp(tmBis, "Temps de montée en seconde (temps pour atteindre la valeur finale):");
    disp(depassement, "Dépassement en pourcentage:");
endfunction

function affPerf(wc0, fc0,  margePhase, margeGain)
    disp(wc0,'Pulsation de coupure wc0:');
    disp(fc0, 'Fréquence de coupure fc0:');
    disp(margePhase,'Marge de phase :');
    disp(margeGain,'Marge de gain:');
endfunction



// PARTIE 1.1

//Calcul
K2 = 20;
T1 = 0.1;
T2 = 0.01;
T3 = 0.001;
p = %s;
H2 = (K2*(1+T1*p)) / ((1+T2*p)*(1+T3*p));
t1 = (0:T3/100:100*T3);

sys1 = syslin('c', H2);
y1 = csim('step', t1, sys1);

[tm1, tmBis1, tr1, depassement1] = cara(y1, t1, K2);
[wc0_1, fc0_1, margePhase1, margeGain1] = perf(sys1);

//Affichage
figure(1);
title("Réponse indicielle de H2(p)");
xlabel("Temps (s)");
ylabel("amplitude");
plot2d(t1, y1');

figure(2);
bode(sys1, 10^-2, 10^4);

disp("Partie 1.1");
affCara(tr1, tm1, tmBis1, depassement1);
affPerf(wc0_1, fc0_1, margePhase1, margeGain1);
disp("--------------------------------------");


//Partie 1.2

//Calcul
wc0 = 10000;
Ti = 0.001;
Kp = (T3*wc0*sqrt(1+(T2*wc0)^2))/(K2*sqrt(1+(T1*wc0)^2));
C = Kp*((1+Ti*p)/(Ti*p));
HBO = H2*C;
HBF = HBO/(1+HBO);
t2 = (0:Ti/100:Ti);

sys2 = syslin('c', HBF);
sys3 = syslin('c', HBO);
y2 = csim('step', t2, sys2);

KBF = y2(length(y2));

[tm2, tmBis2, tr2, depassement2] = cara(y2, t2, KBF);
[wc0_2, fc0_2, margePhase2, margeGain2] = perf(sys3);

//Affichage
figure(3)
title("Réponse indicielle de HBF(p)");
xlabel("Temps (s)");
ylabel("amplitude");
plot2d(t2, y2');

figure(4)
bode(sys3);



disp("Partie 1.2");
affCara(tr2, tm2, tmBis2, depassement2);
affPerf(wc0_2, fc0_2, margePhase2, margeGain2);
disp("--------------------------------------");


//Partie 2.1

//Calcul
K1 = 93;
m = 0.12;
w0 = 1.8;
H1 = K1/(1+(2*m*p)/w0+(p^2)/(w0^2));
t3 = (0:w0/10:10*w0);

sys5 = syslin('c', H1);
y3 = csim('step', t3, sys5);

[wc0_3, fc0_3, margePhase3, margeGain3] = perf(sys5);
clear sys2
sys2 = syslin('c', HBF);
[wc0_4, fc0_4, margePhase4, margeGain4] = perf(sys2);


//Affichage
figure(6)
bode(sys5);

figure(7)
bode(sys2);

disp("Partie 2.1");
//affCara(tr2, tm2, tmBis2, depassement2);
disp("Performances H1:");
affPerf(wc0_3, fc0_3, margePhase3, margeGain3);
disp("Performances H2BF:");
affPerf(wc0_4, fc0_4, margePhase4, margeGain4);
disp("--------------------------------------");


//Partie 2.2

//Calcul
m = 0.12;
//m = 0.038;
K1 = 93;
//K1 = 172;
w0 = 1.8;
//w0 = 2.25;
 
wc0 = 6.925;
Ti = 10/wc0;
phiH1 = -atan(((2*m*wc0)/(w0))/(1-(wc0/w0)^2));
mPhase = (60/180)*%pi;
Td = tan(mPhase - %pi/2 - atan(10) - phiH1)/wc0;
numKp = abs(Ti*wc0)*sqrt(((2*m*wc0)/w0)^2 + (1-(wc0/w0)^2)^2);
denKp = abs(K1)*sqrt(1+(Ti*wc0)^2)*sqrt(1+(Td*wc0)^2);
Kp = numKp/denKp;
Kp = 0.207;
t4 = (0:Ti/100:Ti);

C1 = (Kp * (1+Td*p) * (1+Ti*p)) /(Ti*p);
H1BO = H1*C1;
H1BF = H1BO/(1+H1BO);
KH1BO = Kp * KBF * K1;
KH1BF = KH1BO / (1 + KH1BO);


sys6 = syslin('c', H1BO);
sys7 = syslin('c', H1BF);

y4 = csim('step', t4, sys7);

[tm4, tmBis4, tr4, depassement4] = cara(y4, t4, KH1BF);
[wc0_5, fc0_5, margePhase5, margeGain5] = perf(sys6);


//Affichage
disp("Partie 2.2");
disp(phiH1, "phiH1:");
disp(Ti, "Ti:");
disp(Td, "Td:");
disp(Kp, "Kp:");

affCara(tr4, tm4, tmBis4, depassement4);
affPerf(wc0_5, fc0_5, margePhase5, margeGain5);

figure(8)
bode(sys7);

figure(9)
plot2d(t4, y4');
