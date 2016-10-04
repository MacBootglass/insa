%% Exercice 5
% ASI 4 - Thibault THEOLOGIEN - Eliott RENAUD

clear;
close all;
clc;
addpath('../images');

% Quantification de Lena
imgLena(: , :, 1) = imread('lena_gray.tif');

figure();
for i=1:8
  imgLena(: , :, i) = imgLena(: , :, 1)./2^(i-1);
  subplot(2,4,i);
  imshow(imgLena(: , :, i), [0 256/2^(i-1)]);
  title(strcat('Image avec', {' '},  num2str(256/2^(i-1)), {' '}, 'niveaux de gris'));
end

figure();
for i=1:8
  subplot(2,4,i);
  imhist(imgLena(: , :, i));
  axis([0 2^(9-i) 0 8000*i]);
  title(strcat('Histogramme avec', {' '},  num2str(256/2^(i-1)), {' '}, 'niveaux de gris'));
end


% Quantification de Cameleon
imgCam = imread('images/cameleon.tif');

figure();
for i=1:8
  imgCam(: , :, i) = imgCam (: , :, 1)./2^(i-1);
  subplot(2,4,i);
  imshow(imgCam (: , :, i), [0 256/2^(i-1)]);
  title(strcat('Image avec', {' '},  num2str(256/2^(i-1)), {' '}, 'niveaux de gris'));
end

figure();
for i=1:8
  subplot(2,4,i);
  imhist(imgCam (: , :, i));
  axis([0 2^(9-i) 0 6000*i]);
  title(strcat('Histogramme avec', {' '},  num2str(256/2^(i-1)), {' '}, 'niveaux de gris'));
end