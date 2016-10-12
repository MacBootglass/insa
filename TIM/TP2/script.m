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
% Thibault Théologien

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
% Thibault Théologien

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
% Thibault Théologien

filtreMoy = fspecial('average', N_filtre);
filtreMoyCirc = fspecial('disk', N_filtre);

imgFiltre2MoySame = filter2(filtreMoy, imgBruit, 'same');
imgFiltre2MoyCircSame = filter2(filtreMoyCirc, imgBruit, 'same');

imgFiltre2MoyValid = filter2(filtreMoy, imgBruit, 'valid');
imgFiltre2MoyCircValid = filter2(filtreMoyCirc, imgBruit, 'valid');

imgFiltre2MoyFull = filter2(filtreMoy, imgBruit, 'full');
imgFiltre2MoyCircFull = filter2(filtreMoyCirc, imgBruit, 'full');

figure();
subplot(2,2,1);
imagesc(imgFiltre2MoySame);
title('Effet de bord same');
colormap(gray(256));

subplot(2,2,2);
imagesc(imgFiltre2MoyValid);
title('Effet de bord valid');
colormap(gray(256));

subplot(2,2,3);
imagesc(imgFiltre2MoyFull);
title('Effet de bord full');
colormap(gray(256));


figure();
subplot(2,2,1);
imagesc(imgFiltre2MoyCircSame);
title('Effet de bord same');
colormap(gray(256));

subplot(2,2,2);
imagesc(imgFiltre2MoyCircValid);
title('Effet de bord valid');
colormap(gray(256));

subplot(2,2,3);
imagesc(imgFiltre2MoyCircFull);
title('Effet de bord full');
colormap(gray(256));

%% 5. Filtrage gaussien
% Thibault Théologien
% Riadh Kilani
p = 0.1;
lenaBruit = imnoise(imread('lena_gray.tif'), 'salt & pepper', p);
cameramanBruit = imnoise(imread('cameraman.tif'), 'salt & pepper', p);
riceBruit = imnoise(imread('rice.tif'), 'salt & pepper', p);

sigma = 0.8;
filtreGauss = fspecial('gaussian', N_filtre, sigma);

lenaFiltreGauss = filter2(filtreGauss, lenaBruit);
cameramanFiltreGauss = filter2(filtreGauss, cameramanBruit);
riceFiltreGauss = filter2(filtreGauss, riceBruit);

% Lena
figure();
subplot(2,1,1);
imagesc(lenaBruit);
title('Lena avant filtre gauss');

subplot(2,1,2);
imagesc(lenaFiltreGauss);
title('Lena après filtre gauss');
colormap(gray(256));

% Cameraman
figure();
subplot(2,1,1);
imagesc(cameramanBruit);
title('Cameraman avant filtre gauss');

subplot(2,1,2);
imagesc(cameramanFiltreGauss);
title('Cameraman après filtre gauss');
colormap(gray(256));

% Rice
figure();
subplot(2,1,1);
imagesc(riceBruit);
title('Rice avant filtre gauss');

subplot(2,1,2);
imagesc(riceFiltreGauss);
title('Rice après filtre gauss');
colormap(gray(256));

% Plus la valeur de sigma (<1) est importante, plus le filtrage est
% efficace. On constate cependant un effet de flou.

%% 6. Filtrage pair et filtrage impair
% Thibault Théologien
% Riadh Kilani
param = 'full';

M = ones(6,6);
H1 = [0 1 0; 1 1 1; 0 1 0];
H2 = [0 1 1 0; 1 1 1 1; 0 1 1 0];
H3 = [0 1 1 0; 1 1 1 1; 1 1 1 1; 0 1 1 0];

M1 = filter2(H1, M, param);
M2 = filter2(H2, M, param);
M3 = filter2(H3, M, param);

lenaH1 = filter2(H1, lenaBruit, param);
lenaH2 = filter2(H2, lenaBruit, param);
lenaH3 = filter2(H3, lenaBruit, param);

% Image M
figure();
subplot(2,2,1);
imagesc(M);
title('Image avant filtre');

subplot(2,2,2);
imagesc(M1);
title('Image après filtre H1');

subplot(2,2,3);
imagesc(M2);
title('Image après filtre H2');

subplot(2,2,4);
imagesc(M3);
title('Image après filtre H3');

colormap('gray');

% Lena
figure();
subplot(2,2,1);
imagesc(lenaBruit);
title('Lena avant filtre');

subplot(2,2,2);
imagesc(lenaH1);
title('Lena après filtre H1');

subplot(2,2,3);
imagesc(lenaH2);
title('Lena après filtre H2');

subplot(2,2,4);
imagesc(lenaH3);
title('Lena après filtre H3');

colormap(gray(256));

% Plus le filtre est grand, meilleur est le degradé / la séparation des
% niveau de gris

%% 7. Filtre décomposable
% Thibault Théologien
% Riadh Kilani

N_filtre = 3;
filtreMoy = (1/N_filtre^2)*ones(N_filtre, N_filtre);
[lenaFiltreDecomp, fonctionne] = decomposeFiltre(lenaBruit, filtreMoy);

figure();
imagesc(lenaFiltreDecomp);
title('Lena après fitre moy decomposé');
colormap(gray(256));

% a filtre verticalement tandis que b filtre horizontalement.
% svds est utilisable sur toutes les matrices sauf si il posséde une valeur
% complexe.

%% 8. Filtrage dans le domaine fréquentiel
% Thibault Théologien
% Riadh Kilani

lenaFreq = log(abs(fftshift(fft2(imread('lena_gray.tif')))));
cameranFreq = log(abs(fftshift(fft2(imread('cameraman.tif')))));
riceFreq = log(abs(fftshift(fft2(imread('rice.tif')))));

figure();
imagesc(lenaFreq);
title('Densité spectrale de Lena');
colormap(gray(256));

figure();
imagesc(cameranFreq);
title('Densité spectrale du Cameraman');
colormap(gray(256));

figure();
imagesc(riceFreq);
title('Densité spectrale de Rice');
colormap(gray(256));






% function [ imgFiltre, fonctionne ] = decomposeFiltre( img, filtre )
%   [U, S, V] = svds(filtre, 1);
%   a = U*S;
%   b = V;
%   
%   fonctionne = 0;
%   imgFiltre = img;
%   
%   if isreal(a) && isreal(b)
%    fonctionne = 1;
%    imgStep1 = filter2(b', img);
%    imgFiltre = filter2(a, imgStep1);
%   end
% end