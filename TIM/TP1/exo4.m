%% Exercice 4
% ASI 4 - Thibault THEOLOGIEN - Eliott RENAUD

clear;
close all;

% CALCULS

imgRice = imread('images/rice.tif');
[valPresRice, occurRice] = histogramGris(imgRice);

imgLena = imread('images/lena_gray.tif');
[valPresLena, occurLena] = histogramGris(imgLena);

imgCamMan = imread('images/cameraman.tif');
[valPresCamMan, occurCamMan] = histogramGris(imgCamMan);


% VISUALISATION

figure()
subplot(1,2,1);
bar(valPresRice, occurRice);
ylim([0 4500]);
xlim([0 255]);
title('Histogramme de Rice avec bar()');

subplot(1,2,2);
imhist(imgRice);
axis([0 255 0 4500]);
title('Histogramme de Rice avec imhist()');

% Les resultats sont graphiquement identiques 

% Sur l'histogramme on observe un pic aux alentours de 100. Cela suggère
% une predominance de cette nuance de gris. De plus, il n'y a pas de pixels
% ayant une nuance de gris inférieure à 50 ou supérieure à 200
% on peut donc déterminer une plage de nuance de gris

figure()
subplot(1,2,1);
bar(valPresLena, occurLena);
ylim([0 7500]);
xlim([0 255]);
title('Histogramme de Lena avec bar()');

subplot(1,2,2);
imhist(imgLena);
axis([0 255 0 7500]);
title('Histogramme de Lena avec imhist()');

figure()
subplot(1,2,1);
bar(valPresCamMan, occurCamMan);
ylim([0 2000]);
xlim([0 255]);
title('Histogramme de cameraman avec bar()');

subplot(1,2,2);
imhist(imgCamMan);
axis([0 255 0 2000]);
title('Histogramme de cameraman avec imhist()');

% Ces deux images ont toutes les nuance de gris
% On observe sur l'histogramme de l'image Lena deux groupes majeurs de
% nuance : un vers 0/20 et l'autre entre 150 et 200. L'image est fortement
% contrastée

figure()
imagesc(imgLena);
improfile;
