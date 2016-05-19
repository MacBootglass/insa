f1 = 500;
f2 = 400;
f3 = 50;
Te = 0.0001;
vT = 0:Te:5;
vF = linspace(-1/(2*Te), 1/(2*Te),length(vT));
K  = 1;
wc = 2000;
xt = zeros(size(vT));
Hf = zeros(size(vF));

for t=1:length(vT)
    xt(t) = sin(2*pi*f1*vT(t)) + sin(2*pi*f2*vT(t)) + sin(2*pi*f3*vT(t));
end

Xf = fft(xt, length(xt)) * Te;

for f=1:length(vF)
    w = 2*pi*vF(f);
    Hf(f) = (K*1j*w/wc)/(1+1j*w/wc);
end

Yf = Xf .* Hf; 
yt = ifft(Yf)/Te;
xt_fil= real(yt);




figure(1);

subplot(2,1,1);
plot(vT,xt);
title('Signal x(t)');

subplot(2,1,2);
plot(vF, abs(fftshift(Xf)));
hold on;
plot(vF, abs(Hf), 'r');
title('TF du signal x(t) et module de H(f)');
xlim([-600,600]);



figure(2);

semilogx( 20*log(abs(Hf)));
title('20*log(abs(Hf))');



figure(3);

subplot(2,1,1);
plot(vF, Yf);
title('Y(f)');
xlim([-600,600]);

subplot(2,1,2);
plot(vT, xt_fil);
title('x(t) fil');

