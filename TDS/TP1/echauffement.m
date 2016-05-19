pas = 0.01;
interval = 10;
t = -interval:pas:interval;

sPorte = signalPorte(1,1,pas,interval);                    %T, decalage, pas, interval
plot(t,sPorte);

hold on;

sTEchelon1 = signalTEchelon(0, 0, true, pas,interval);     %decalageT, decalageEchelon, tPositif, pas, interval
plot(t, sTEchelon1, 'r');

hold on;

sTEchelon2 = signalTEchelon(2, 3, true, pas,interval);     %decalageT, decalageEchelon, tPositif, pas, interval
plot(t, sTEchelon2, 'g');

hold on;

sTEchelon3 = signalTEchelon(-3, -3, false, pas,interval);
sTEchelon4 = signalTEchelon(0,2,true, pas, interval);
sTriangle = sTEchelon3.*sTEchelon4;
plot(t, sTriangle, 'k');

hold on;

sTEchelon5 = signalTEchelon(0,1,true, pas, interval);
sExponentiel = signalExponentiel(-1, false, pas, interval);        %a, pas, inteval
sExpEchelon = sTEchelon5.*sExponentiel;
plot(t, sExpEchelon, 'm');