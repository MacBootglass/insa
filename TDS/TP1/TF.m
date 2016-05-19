pas = 0.01;
interval = 5;
t = -interval:pas:interval;
nbDonnes = (interval*2)/pas+1;
a = 1;
f0 = 5;

xT = signalExponentiel(-a, true, pas, interval);

tf = ones(1, nbDonnes);
for i = 1:nbDonnes
    tf(i) = 2*a/(a^2+(2*pi*t(i))^2);
end

mTf = abs(tf);
aTf = angle(tf);



tfMatLab = fftshift(pas * fft(xT));
absTfMatLab = abs(tfMatLab);
invTfMatLab = ifft(tfMatLab)/pas;
absInvTfMatLab = abs(invTfMatLab);


tfDecale = fftshift(pas * fft(xT .* exp(1i*2*pi*f0*t)));
absTfDecale = abs(tfDecale);
imgTfDecale = imag(tfDecale);
reelTfDecale = real(tfDecale);

[matWav, time] = wavread('lpdlh.wav');
t2=-2.5:5/time:2.5;
tfMatWav = abs(fftshift(pas * fft(matWav)));

subplot(2,2,1);
plot(t, xT);
title('Function exp');
xlabel('Temps');
ylabel('Signal');

subplot(2,2,2);
plot(t,tf);
title('Transformee de Fourrier calculee');
xlabel('Frequence');
ylabel('Signal');

subplot(2,2,3);
plot(t, mTf);
title('Module');
xlabel('Frequence');
ylabel('Module');

subplot(2,2,4);
plot(t, aTf);
title('Phase');
xlabel('Frequence');
ylabel('Phase');



figure

subplot(2,2,1);
plot(t, tfMatLab);
title('Transformee de Fourrier Matlab');
xlabel('Frequence');
ylabel('Signal');

subplot(2,2,2);
plot(t, absTfMatLab);
title('Module TF');
xlabel('Frequence');
ylabel('Module');

subplot(2,2,3);
plot(t, invTfMatLab);
title('Inverse TF');
xlabel('Frequence');
ylabel('Signal');


subplot(2,2,4);
plot(t, absInvTfMatLab);
title('Module Inv TF');
xlabel('Frequence');
ylabel('Module');


figure

subplot(2,2,1);
plot(t, tfDecale);
title('ftDecale');
xlabel('Frequence');
ylabel('Signal');

subplot(2,2,2);
plot(t, absTfDecale);
title('Module ftDecale');
xlabel('Frequence');
ylabel('Module');

subplot(2,2,3);
plot(t, imgTfDecale);
title('Imaginaire ftDecale');
xlabel('Frequence');
ylabel('Signal');

subplot(2,2,4);
plot(t, reelTfDecale);
title('Reels ftDecale');
xlabel('Frequence');
ylabel('Signal');


figure

subplot(1,2,1);
plot(tfMatWav);

