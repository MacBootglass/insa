//TP3
//Théologien Thibault Groupe 1
//ASI 3.2

//Exercice 1
A = 1;
Km = 10;
Tm  = 75 * 10^-3;
kVis = 1.33 * 10^-2;
p = %s;
kCapteur = 2;
t = (0:5E-2:20);

num = A * Km * kVis;
dem = p + Tm * p^2;
HBO = num/dem;
sys1 = syslin('c', HBO);
y1 = csim('step', t, sys1);


//Exercice 2
HBF = (HBO * kCapteur) / (1 + HBO * kCapteur);
sys2 = syslin('c', HBF);
y2 = csim('step', t, sys2);

vRapidite1 = find(y2 >=0.99);
rapidite1 = vRapidite1(1) * 5E-2;


//Exercice 3
A = 5;
k = A * Km * kVis * kCapteur;
HBF2 = (1 + (Tm/k)*p^2 + p/k)^-1; 
sys3 = syslin('c', HBF2);
y3 = csim('step', t, sys3);
vRapidite2 = find(y3 >=0.99);
rapidite2 = vRapidite2(1) * 5E-2;

A = 15;
k = A * Km * kVis * kCapteur;
HBF3 = (1 + (Tm/k)*p^2 + p/k)^-1;
sys4 = syslin('c', HBF3);
y4 = csim('step', t, sys4);
vRapidite3 = find(y4 >=0.99);
rapidite3 = vRapidite3(1) * 5E-2;

A = 30;
k = A * Km * kVis * kCapteur;
HBF4 = (1 + (Tm/k)*p^2 + p/k)^-1;
sys5 = syslin('c', HBF4);
y5 = csim('step', t, sys5);
vRapidite4 = find(y5 >=0.99);
rapidite4 = vRapidite4(1) * 5E-2;




//Tracés
figure(1);
plot2d(t,y1');

figure(2)
plot2d(t,y2');

figure(3)
subplot(221);
plot2d(t,y3');
title("A = 5");

subplot(222);
plot2d(t,y4');
title("A = 10");

subplot(223);
plot2d(t,y5');
title("A = 30");

figure(4);
subplot(221);
bode(sys3, 10E-4, 10E4, 'rad');
title("A = 5");

subplot(222);
bode(sys4, 10E-4, 10E4, 'rad');
title("A = 10");
subplot(223);

bode(sys5, 10E-4, 10E4, 'rad');
title("A = 30");

disp(rapidite1);
disp(rapidite2);
disp(rapidite3);
disp(rapidite4);
