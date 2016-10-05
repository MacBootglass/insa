%% Exercice 6
% ASI 4 - Thibault THEOLOGIEN - Eliott RENAUD

clear;
close all;
clc;
addpath('../images');

facteur = 4;

imgMire = imread('mire.png');
imgEch1 = echantillonageImage(imgMire, facteur);
imgEch2 = imgMire((1:facteur:size(imgMire,1)), (1:facteur:size(imgMire,2)));

figure();
imshow(imgMire);
title('Image Originelle');

figure();
subplot(2,1,1);
imshow(imgEch1);
title('Image echantillonée avec fonction');

subplot(2,1,2);
imshow(imgEch2);
title('Image echantillonée en une ligne');

% En echantillonant l'image nous perdons de la qualité 