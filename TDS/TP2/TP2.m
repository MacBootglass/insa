load('tp_tds_data.mat');


%Visualisaton des signaux
subplot(2,2,1);
plot(t, signal);
title('Signal temporel');
xlabel('Temps');
ylabel('Signal');

subplot(2,2,2);
plot(id1);
title('Signal balise 1');

subplot(2,2,3);
plot(id2);
title('Signal balise 2');

subplot(2,2,4);
plot(id3);
title('Signal balise 3');



%Detection des tops de chacun des signaux des balises
indiceTop1 = topCorrelationSignal(signal, id1);
indiceTop2 = topCorrelationSignal(signal, id2);
indiceTop3 = topCorrelationSignal(signal, id3);

subplot(2,2,1);
hold on;
plot([t(indiceTop1), t(indiceTop1)], [-2,2], '-r');
plot([t(indiceTop2), t(indiceTop2)], [-2,2], '-g');
plot([t(indiceTop3), t(indiceTop3)], [-2,2], '-y');

fprintf('indiceTop1: %d\n', indiceTop1);
fprintf('indiceTop2: %d\n', indiceTop2);
fprintf('indiceTop3: %d\n', indiceTop3);



%Calcul de la distance de chaque balise avec le robot
distanceBalise1 = distanceBalise(v_son, t(indiceTop1));
distanceBalise2 = distanceBalise(v_son, t(indiceTop2));
distanceBalise3 = distanceBalise(v_son, t(indiceTop3));

fprintf('distanceBalise1: %f\n', distanceBalise1);
fprintf('distanceBalise2: %f\n', distanceBalise2);
fprintf('distanceBalise3: %f\n', distanceBalise3);



%Calcul des coordonnés du robot
xB1 = 100;
xB2 = -50;
xB3 = -75;
yB1 = 50;
yB2 = 150;
yB3 = -90;

[xnew, ynew] = intersectionTroisCercles(xB1, xB2, xB3, yB1, yB2, yB3, distanceBalise1, distanceBalise2, distanceBalise3);
fprintf('Coordonnées du robot: %f %f\n', xnew, ynew);



%Affichage de l'intercorrélation des signaux issus des balises
figure;

subplot(3,2,1);
plot(xcorr(id1, id2));
title('Intercorrelation id1-id2');

subplot(3,2,2);
plot(xcorr(id2, id1));
title('Intercorrelation id2-id1');

subplot(3,2,3);
plot(xcorr(id2, id3));
title('Intercorrelation id2-id3');

subplot(3,2,4);
plot(xcorr(id3, id2));
title('Intercorrelation id3-id2');

subplot(3,2,5);
plot(xcorr(id1, id3));
title('Intercorrelation id1-id3');

subplot(3,2,6);
plot(xcorr(id3,id1));
title('Intercorrelation id3-id1');

