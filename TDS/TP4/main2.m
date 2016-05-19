[xt, Fs] = audioread('test.wav');
Xf = fft(xt)/Fs;
vF = linspace(-Fs/2, Fs/2,length(xt));

k  = 1;
Fc = 1500;
H = k ./ (1+1j+vF/Fc);

xt_fil = real(ifft(Xf .* H') * Fs);

figure(1)
plot(vF, abs(fftshift(Xf)));

audiowrite('output_fit_sound.wav', xt_fil, Fs);