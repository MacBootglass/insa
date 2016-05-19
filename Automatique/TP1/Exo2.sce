s = %s;
R = 10*10^3;
C = 10*10^-9;
to = R*C;
num = 1;
dem = 1 + 3 * to * s + (to * s)^2;
sys = syslin('c', num/dem);
t = (0:to/100:10*to)';
y = csim('step', t, sys);

tmp = find(y>=0.95);
tr5 = t(tmp(1));

t1 = (-3 - sqrt(5)) / (2 * R * C);
to1 = -1 / t1;
f1 =  1 / (2 * %pi * to1); 

t2 = (-3 + sqrt(5)) / (2 * R * C);
to2 = -1 / t2;
f2 =  1 / (2 * %pi * to2); 

figure(1);
plot2d(t, y');

figure(2);
bode(sys, 10, 10^8);
bode_asymp(sys);
