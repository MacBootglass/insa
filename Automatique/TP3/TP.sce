//Paramèt1res
m = 0.9;
f0 = 30;
w0 = 2*%pi*f0;
K0 = 0.8;
p = %s;
t1 = (0:1/(w0*10):10/w0)


//Partie 1
H = K0 / (1 + 2*m*(p/w0) + (p^2)/(w0^2));
sys1 = syslin('c', H);
y1 = csim('step', t1, sys1);

tReponse1 = t1(min(find(y1>=(0.95*max(y1)))));
tMontee1 = t1(min(find(y1>=0.9*max(y1))))- t1(max(find(y1<=0.1*max(y1))));
depassement1 = (max(y1)-y1(length(y1)))/y1(length(y1))*100;

figure(1);
title("Réponse indicielle de H(p)");
xlabel("Temps (s)");
ylabel("amplit1ude");
plot2d(t1, y1');

disp(tReponse1, "Temps de réponse en seconde pour atteindre 95% de amplitude max :");
disp(tMontee1, "Temps de montée en seconde:");
disp(depassement1, "Dépassement en pourcentage:")


//Partie 3
mBF = -0.59;
wBF = 581.68;
Kp = ((wBF/w0)^2-1)/K0;
K = Kp * K0;
KBF = K / (1+K);
t2 = (0:1/(wBF*10):20/wBF);


HBF = K / ((p/w0)^2 + 2*m*p/w0 + 1 + K);
HBF2 = KBF / ((p/wBF)^2 + 2*mBF*p/wBF + 1);
sys2 = syslin('c', HBF);
y2 = csim('step', t2, sys2);

tReponse2 = t2(min(find(y2>=(0.95*max(y2)))));
tMontee2 = t2(min(find(y2>=0.9*max(y2))))- t2(max(find(y2<=0.1*max(y2))));
depassement2 = (max(y2)-y2(length(y2)))/y2(length(y2))*100;

HBOC = Kp * H;
sys3 = syslin('c', HBOC);

[phase,freqCoupure] = p_margin(sys3);
wc0 = 2 * %pi * freqCoupure;
[gain, ph] = dbphi(repfreq(sys3, freqCoupure));
Mphase = ph + 180;

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
bode(sys3);
title('Diagramme de Bode de HBOC');
xlabel('fréquence');
ylabel('gain');

disp(Mphase,'Marge de phase :');
disp(wc0,'wc0 :');
