R = 10 * 10^3;
C1 = 10 * 10^-9;
C2 = 470 * 10^-9;

s = %s;
wo = 1 / (R * sqrt(C1 * C2));
to = 1 / wo;
m = (3 / 2) * sqrt(C1 / C2);

num = 1;
dem = 1 + 2 * m * s * to + (s * to)^2; 
sys = syslin('c', num/dem);
t = (0:to/100:20*to)';
y = csim('step', t, sys);

tmp = find(y>=0.95);
tr5 = t(tmp(1));

figure(1);
plot2d(t, y');

figure(2);
bode(sys, 10, 10^4);
bode_asymp(sys);
