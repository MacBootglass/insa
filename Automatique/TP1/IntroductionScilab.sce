//Question 3
t1 = (0:0.01:6)';
y1 = sin(3*t1^2);
figure(1);
plot2d(t1,y1);

//Question 5
num = 2;
s = %s;
dem = 1 + 3*s;
sys = syslin('c', num/dem);
t2 = (0:0.1:20)';
y2 = csim('step', t2, sys);
figure(2);
plot2d(t2, y2');
