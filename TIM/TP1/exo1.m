%% Exercice 1
% ASI 4 - Thibault THEOLOGIEN - Eliott RENAUD

clear;
close all;
addpath('images');

img = imread('lena_gray.tif');
imgQuart = img(1:(round(length(img)/2)), 1:(round(length(img)/2)));


figure();
subplot(1,2,1);
imagesc(img);
title('Lena gray');
colormap('gray');

subplot(1,2,2);
imagesc(imgQuart);
title('Quart de Lena gray');
colormap('gray');