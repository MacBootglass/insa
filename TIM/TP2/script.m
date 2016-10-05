%% 1. Génération de bruit "poivre et sel"
% Thibault Théologien

clear;
close all;
clc;
addpath('../images');

p = 0;
img = imread('lena_gray.tif');


figure();
for i=1:4
  subplot(2,2,i);
  imagesc(imnoise(img,'salt & pepper', p));
  title(strcat('Lena avec', {' '}, int2str(p*100), {' '}, 'pourcents de bruit'));
  p = p+0.05;
end


colormap(gray(256));

%% 2. Filtrage Moyenneur
p = 0.1;
imgBruit = imnoise(img,'salt & pepper', p);
N_filtre = 3;
filtre = (1/N_filtre^2)*ones(N_filtre, N_filtre);
k = N_filtre - 1;
imgFiltreMoy = zeros(size(imgBruit,1) + 2*k, size(imgBruit,2) + 2*k);
imgFiltreMoy(k+1:size(imgFiltreMoy,1)-k, k+1:size(imgFiltreMoy,2)-k) = imgBruit;

tic;
for i=1:size(imgFiltreMoy, 1)-2*k
  for j=1:size(imgFiltreMoy, 2)-2*k
    imgFiltreMoy(i+k, j+k) = sum(sum(filtre.*imgFiltreMoy(i+k-1:i+k+1, j+k-1:j+k+1)));
  end
end
tmpFiltreMoy = toc;

figure();
imagesc(imgFiltreMoy);
colormap(gray(256));

%% 3. Filtrage Médian
imgFiltreMed = zeros(size(imgBruit,1) + 2*k, size(imgBruit,2) + 2*k);
imgFiltreMed(k+1:size(imgFiltreMed,1)-k, k+1:size(imgFiltreMed,2)-k) = imgBruit;

tic;
for i=1:size(imgFiltreMed, 1)-2*k
  for j=1:size(imgFiltreMed, 2)-2*k
    imgFiltreMed(i+k, j+k) = median(median(imgFiltreMed(i+k-1:i+k+1, j+k-1:j+k+1)));
  end
end
tmpFiltreMed = toc;

figure();
imagesc(imgFiltreMed);
colormap(gray(256));

%% 4. Synthèse de filtres
filtreMoy = fspecial('average', N_filtre);
filtreMoyCirc = fspecial('disk', N_filtre);

imgFiltre2Moy = filter2(filtreMoy, imgBruit);
imgFiltre2MoyCirc = filter2(filtreMoyCirc, imgBruit);

figure();
imagesc(imgFiltre2Moy);
colormap(gray(256));

figure();
imagesc(imgFiltre2MoyCirc);
colormap(gray(256));