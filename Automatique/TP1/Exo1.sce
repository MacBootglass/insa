s = %s;
to = 10^-4;
num = 1;
dem = 1 + to*s;
sys = syslin('c', num/dem);
t = (0:to/100:7*to)';
y = csim('step', t, sys);
plot2d(t, y');

tmp = find(y>=0.95);
tr5 = t(tmp(1));
