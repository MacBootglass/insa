pas = 0.01;
borneInf = -1;
borneSup = 5;
% Création du signal porte
[t, signal] = signalPorte(borneInf, pas, borneSup);
% Affecte de nombre d'echantillons equivalent à notre interval
N = length(t);

% Auto-corrélation du signal
[signalCorr, lags] = xcorr(signal);
% Correction de l'interval de la corrélation
lags = lags*pas;
signalCorr = signalCorr*pas;

% Auto-convolution du signal
signalConv = conv(signal, signal);
signalConv = signalConv*pas;

% Calcul des transformées de Fourier centrées en 0
signalTF = fftshift(fft(signal, N) * pas);
signalConvTF = fftshift(fft(signalConv, N) * pas);

% Amplitudes des transformées de Fourier
amplitudeSignalConvTF = abs(signalConvTF);
amplitudeProduitSignalTF = abs(signalTF .* signalTF);


% Affichage des signaux

subplot(3,1,1);
plot(t, signal);
title('Signal porte');

subplot(3,1,2);
plot(lags, signalCorr);
title('Autocorrelation signal porte');

subplot(3,1,3);
plot(borneInf*2:pas:borneSup*2, signalConv);
title('Autoconvolution signal porte');

figure;

subplot(3,1,1);
plot(t-2, signalTF);
title('Transformee de fourrier signal porte');

subplot(3,1,2);
plot(t-2, signalConvTF);
title('Transformee de fourrier signal porte');

subplot(3,1,3);
plot(t-2, amplitudeSignalConvTF, 'r');
hold on;
plot(t-2, amplitudeProduitSignalTF, 'g');
title('Amplitude des TF des signaux convolués et de leur produit');