%% Exercice 3
% ASI 4 - Thibault THEOLOGIEN - Eliott RENAUD

clear;
close all;
clc;
addpath('../images');

% CALCULS
paletteGray256 = gray(256);
lenaColor = imread('lena_color.tif');

% Conversion de l'image à l'aide de la fonction im2Double()
lenaColorDouble = im2double(lenaColor);

% Extraction des composantes
lenaColorDoubleRed = lenaColorDouble(:, :, 1);
lenaColorDoubleGreen = lenaColorDouble(:, :, 2);
lenaColorDoubleBlue = lenaColorDouble(:, :, 3);

% Creation des palettes
paletteRouge = [paletteGray256(:, 1) zeros(256, 2)];
paletteVerte = [zeros(256, 1) paletteGray256(:, 1) zeros(256, 1)];
paletteBleu = [zeros(256, 2) paletteGray256(:, 1)];

% Création de l'image de Lena en niveaux de gris
lenaGray = rgb2gray(lenaColorDouble);

% Reconstruction en couleurs de l'image à partir des compsantes
alpha = 0.2989;
beta = 0.5870;
gamma = 0.1140;
lenaGrayReconstitue = alpha * lenaColorDoubleRed + beta*lenaColorDoubleGreen + gamma*lenaColorDoubleBlue;

% Calcul de la moyenne de la différence entre l'image reconstitutée et
% l'originale
moyenDiff = mean(mean(lenaGray - lenaGrayReconstitue));




% VISUALISATION
figure();
imagesc(lenaColorDouble);
title('Visualisation de Lena en couleurs');

figure();
imagesc(lenaColorDoubleRed);
colormap(paletteRouge);
title('Visualisation de la composante rouge de Lena');

figure();
imagesc(lenaColorDoubleGreen);
colormap(paletteVerte);
title('Visualisation de la composante verte de Lena');

figure();
imagesc(lenaColorDoubleBlue);
colormap(paletteBleu);
title('Visualisation de la composante bleue de Lena');

figure();
imagesc(lenaGray);
colormap(paletteGray256);
title('Visualisation de Lena en niveaux de gris');

figure();
imagesc(lenaGrayReconstitue);
colormap(paletteGray256);
title('Visualisation de Lena en niveaux de gris reconstitués');


% Visuellement, on ne remarque pas de différences entre les deux images
% Mathématiquement, la moyenne des différences entre chaque matrice est
% infime.