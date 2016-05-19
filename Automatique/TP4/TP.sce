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
    printf("\t- Temps de réponse en seconde pour laquelle le signal ne dépasse plus 5 pourcents de sa valeur finale: %f \n", tr5);
    printf("\t- Temps de montée en seconde (passage de 10 à 90 pourcents de la valeur finale): %f \n", tm);
    printf("\t- Temps de montée en seconde (temps pour atteindre la valeur finale): %f \n", tmBis);
    printf("\t- Dépassement en pourcentage: %f \n", depassement);
endfunction

function affPerf(wc0, fc0,  margePhase, margeGain)
    printf('\t- Pulsation de coupure wc0: %f \n', wc0);
    printf('\t- Fréquence de coupure fc0: %f \n', fc0);
    printf('\t- Marge de phase : %f \n', margePhase);
    printf('\t- Marge de gain: %f \n', margeGain);
endfunction



// PARTIE 1.1

//Calcul
K2 = 20;
T1 = 0.1;
T2 = 0.01;
T3 = 0.001;
p = %s;

H2 = (K2*(1+T1*p)) / ((1+T2*p)*(1+T3*p));
tH2 = (0:T3/100:100*T3);

sysH2 = syslin('c', H2);
yH2 = csim('step', tH2, sysH2);

[tmH2, tmBisH2, trH2, depassementH2] = cara(yH2, tH2, K2);
[wc0_H2, fc0_H2, margePhaseH2, margeGainH2] = perf(sysH2);

//Affichage
figure(1);
title("Réponse indicielle de H2(p)");
xlabel("Temps (s)");
ylabel("Amplitude");
plot2d(tH2, yH2');

figure(2);
title("Réponse fréquentielle de H2(p)");
bode(sysH2, 10^-2, 10^4);

printf("\n--------------------------------------\n");
printf("Partie 1.1\n");
printf("--------------------------------------\n");
affCara(trH2, tmH2, tmBisH2, depassementH2);
affPerf(wc0_H2, fc0_H2, margePhaseH2, margeGainH2);



//Partie 1.2

//Calcul
wc0 = 10000;
Ti = 10/wc0;
Kp2 = (T3*wc0*sqrt(1+(T2*wc0)^2))/(K2*sqrt(1+(T1*wc0)^2));
C2 = Kp2*((1+Ti*p)/(Ti*p));
H2BO = H2*C2;
H2BF = H2BO/(1+H2BO);
tH2BF = (0:Ti/100:Ti);

sysH2BO = syslin('c', H2BO);
sysH2BF = syslin('c', H2BF);

yH2BF = csim('step', tH2BF, sysH2BF);

K2BF = yH2BF(length(yH2BF));

[tmH2BF, tmBisH2BF, trH2BF, depassementH2BF] = cara(yH2BF, tH2BF, K2BF);
[wc0_H2BO, fc0_H2BO, margePhaseH2BO, margeGainH2BO] = perf(sysH2BO);

//Affichage
figure(3)
title("Réponse fréquentielle de H2BO(p)");
bode(sysH2BO);

figure(4)
title("Réponse indicielle de H2BF(p)");
xlabel("Temps (s)");
ylabel("Amplitude");
plot2d(tH2BF, yH2BF');

printf("\n--------------------------------------\n");
printf("Partie 1.2\n");
printf("--------------------------------------\n");
affCara(trH2BF, tmH2BF, tmBisH2BF, depassementH2BF);
affPerf(wc0_H2BO, fc0_H2BO, margePhaseH2BO, margeGainH2BO);


//Partie 2.1

//Calcul
K1 = 93;
m = 0.12;
w0 = 1.8;
H1 = K1/(1+(2*m*p)/w0+(p^2)/(w0^2));
tH1 = (0:w0/10:10*w0);

sysH1 = syslin('c', H1);
yH1 = csim('step', tH1, sysH1);

[wc0_H1, fc0_H1, margePhaseH1, margeGainH1] = perf(sysH1);
[wc0_H2BF, fc0_H2BF, margePhaseH2BF, margeGainH2BF] = perf(sysH2BF);


//Affichage
figure(5)
title("Réponse fréquentielle de H1(p)");
bode(sysH1);

figure(6)
title("Réponse fréquentielle de H2BF(p)");
bode(sysH2BF, 10^-2, 10^4);

printf("\n--------------------------------------\n");
printf("Partie 2.1\n");
printf("--------------------------------------\n");
printf("Performances H1:\n");
affPerf(wc0_H1, fc0_H1, margePhaseH1, margeGainH1);
printf("Performances H2BF:\n");
affPerf(wc0_H2BF, fc0_H2BF, margePhaseH2BF, margeGainH2BF);



//Partie 2.2 et 2.3
function partie2_3(m, K1, w0, wc0, fig, affFig)
    //Calcul
    Ti = 10/wc0;
    phiH1 = -atan(((2*m*wc0)/(w0))/(1-(wc0/w0)^2));
    mPhase = (60/180)*%pi;
    
    Td = tan(mPhase - %pi/2 - atan(10) - phiH1)/wc0;
    num = abs(Ti*wc0)*sqrt(((2*m*wc0)/w0)^2 + (1-(wc0/w0)^2)^2);
    den = abs(K1)*sqrt(1+(Ti*wc0)^2)*sqrt(1+(Td*wc0)^2);
    Kp1Bis = num/den;
    Kp1 = 0.207;
    t = (0:Ti/100:5*Ti);
    
    C1 = (Kp1Bis * (1+Td*p) * (1+Ti*p)) /(Ti*p);
    H1BO = H1*C1;
    H1BF = H1BO/(1+H1BO);
    
    sysH1BO = syslin('c', H1BO);
    sysH1BF = syslin('c', H1BF);
    
    yH1BF = csim('step', t, sysH1BF);
    
    KH1BF = yH1BF(length(yH1BF));
    
    [tm, tmBis, tr, depassement] = cara(yH1BF, t, KH1BF);
    [wc_0, fc0, margePhase, margeGain] = perf(sysH1BO);
    
        
    //Affichage
    printf("\nSynthèse du régulateur de traction pour m=%f, K1=%f, w0=%f \n", m, K1, w0);
    printf("\t- phiH1: %f \n", phiH1);
    printf("\t- Ti: %f \n", Ti);
    printf("\t- Td: %f \n", Td);
    printf("\t- Kp1 trouvé: %f\n", Kp1Bis);

    affCara(tr, tm, tmBis, depassement);
    affPerf(wc_0, fc0, margePhase, margeGain);

    if  affFig == 1 then
        figure(fig(1));
        title("Réponse fréquentielle de H1B0(p)");
        bode(sysH1BO);
        
        figure(fig(2));
        title("Réponse indicielle de H1BF(p)");
        xlabel("Temps (s)");
        ylabel("Amplitude");
        plot2d(t, yH1BF');
        plot2d(t, KH1BF*ones(1,length(yH1BF)), 21);
    end
endfunction

printf("\n--------------------------------------\n");
printf("Partie 2.2 et 2.3\n");
printf("--------------------------------------\n");

partie2_3(0.12, 93, 1.8, 6.925, [7,8], 1);

partie2_3(0.038, 172, 2.25, 6.925, [9,10], 1);

partie2_3(0.27, 74.7, 1.1, 6.925, [11, 12], 1);
