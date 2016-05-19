f0 = 5;
pas = 0.001;
vt = -2:pas:2;
dt = 0.01;

fe1 = 5;
fe2 = 10;
fe3 = 20;

pas1 = (1/fe1)/pas; 
pas2 = (1/fe2)/pas;
pas3 = (1/fe3)/pas;

fx = createFunction(vt, f0);
fxEchI1 = echantillonnageIdeal(fx, pas1, vt);
fxEchI2 = echantillonnageIdeal(fx, pas2, vt);
fxEchI3 = echantillonnageIdeal(fx, pas3, vt);

fxEchR1 = echantillonnageReel(fx, fe1, pas, dt);
fxEchR2 = echantillonnageReel(fx, fe2, pas, dt);
fxEchR3 = echantillonnageReel(fx, fe3, pas, dt);

fxRec  = fft(fx) * pas;
fx1Rec = fft(fxEchR1) / fe1;
fx2Rec = fft(fxEchR2) / fe2;
fx3Rec = fft(fxEchR3) / fe3;
freq = linspace(-1/(2*pas), 1/(2*pas), length(fx));

figure(1);
plot(vt, fx);
title('Signal Réel');



figure(2);
subplot(3,1,1);
plot(vt, fxEchI1);
title('Signal echantillonné idéal avec Fe1');

subplot(3,1,2);
plot(vt, fxEchI2);
title('Signal echantillonné idéal avec Fe2');

subplot(3,1,3);
plot(vt, fxEchI3);
title('Signal echantillonné idéal avec Fe3');



figure(3);
subplot(3,1,1);
plot(vt, fxEchR1);
title('Signal echantillonné réel avec Fe1');

subplot(3,1,2);
plot(vt, fxEchR2);
title('Signal echantillonné réel avec Fe2');

subplot(3,1,3);
plot(vt, fxEchR3);
title('Signal echantillonné réel avec Fe3');



figure(4)

subplot(4,1,1);
plot(freq, abs(fftshift(fxRec)));
title('Signal fx reconstruit');

subplot(4,1,2);
plot(freq, abs(fftshift(fx1Rec)));
title('Signal fxEchR1 reconstruit');

subplot(4,1,3);
plot(freq, abs(fftshift(fx2Rec)));
title('Signal fxEchR2 reconstruit');

subplot(4,1,4);
plot(freq, abs(fftshift(fx3Rec)));
title('Signal fxEchR3 reconstruit');

figure(5);
plot(vt, interp1(-2:1/Fe3:2, fxEchR3, vt));