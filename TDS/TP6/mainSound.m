[sigPur, fePur]   = audioread('Voice.wav');
[sig2000, fe2000] = audioread('Voice2000.wav');
[sig3000, fe3000] = audioread('Voice3000.wav');
[sig4000, fe4000] = audioread('Voice4000.wav');

sig2000Interp0 = interp0(sig2000, fe2000, fePur);
sig3000Interp0 = interp0(sig3000, fe3000, fePur);
sig4000Interp0 = interp0(sig4000, fe4000, fePur);

tPur = 0:1/fePur:length(sigPur)/fePur;
t2000 = 0:1/fe2000:length(sig2000)/fe2000;
t3000 = 0:1/fe3000:length(sig3000)/fe3000;
t4000 = 0:1/fe4000:length(sig4000)/fe4000;

sig2000Interp1 = interp1(t2000(1:end-1)', sig2000(:,1), tPur, 'linear', 'extrap');
sig3000Interp1 = interp1(t3000(1:end-1)', sig3000(:,1), tPur, 'linear', 'extrap');
sig4000Interp1 = interp1(t4000(1:end-1)', sig4000(:,1), tPur, 'linear', 'extrap');

distSigPurSig2000I0 = norm(sigPur(1:length(sig2000Interp0)) - sig2000Interp0');
distSigPurSig3000I0 = norm(sigPur(1:length(sig3000Interp0)) - sig3000Interp0');
distSigPurSig4000I0 = norm(sigPur(1:length(sig4000Interp0)) - sig4000Interp0');
distSigPurSig2000I1 = norm(sigPur(1:length(sig2000Interp1)) - sig2000Interp1);
distSigPurSig3000I1 = norm(sigPur(1:length(sig3000Interp1)) - sig3000Interp1);
distSigPurSig4000I1 = norm(sigPur(1:length(sig4000Interp1)) - sig4000Interp1);




[sigDonjon, feDonjon]   = audioread('dungeon.wav');
[sigChurch, feChurch]   = audioread('church.wav');
[sigSinging, feSinging] = audioread('singing.wav');

sigSingDonj = conv(sigDonjon(:,1), sigSinging, 'same');
sigSingChur = conv(sigChurch(:,1), sigSinging, 'same');

sigVoiceDonj = conv(sigDonjon(:,1), sigPur(:,1), 'same');
sigVoiceChur = conv(sigChurch(:,1), sigPur(:,1), 'same');

subplot(3,1,1);
plot(sigPur, 'r');
hold on;
plot(sig2000Interp0, 'b');
title('Interpolation0 sig2000');

subplot(3,1,2);
plot(sigPur, 'r');
hold on;
plot(sig3000Interp0, 'b');
title('Interpolation0 sig3000');

subplot(3,1,3);
plot(sigPur, 'r');
hold on;
plot(sig4000Interp0, 'b');
title('Interpolation0 sig4000');


figure(2);

subplot(3,1,1);
plot(sigPur, 'r');
hold on;
plot(sig2000Interp1, 'b');
title('Interpolation1 sig2000');

subplot(3,1,2);
plot(sigPur, 'r');
hold on;
plot(sig3000Interp1, 'b');
title('Interpolation1 sig3000');

subplot(3,1,3);
plot(sigPur, 'r');
hold on;
plot(sig4000Interp1, 'b');
title('Interpolation1 sig4000');