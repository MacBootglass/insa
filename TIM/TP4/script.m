%% TP 4 – Extraction de contours
% Thibault Théologien
% Riadh Kilani

clear;
close all;
clc;
addpath('../images');

%% Filtre de Cany
% * Appliquer un filtre Gaussien à l'image
% * Calculer l'intensité du Gradient
%   |G| = |Gx| + |Gy|
% * Calculer les directions du Gradient
%   theta = arctan(Gy/Gx)
%   arrondir au multiples de 45°

lena = double(imread('lena_gray.tif'));
rice = double(imread('rice.tif'));
cameraman = double(imread('cameraman.tif'));
gray = gray(256);
gauss = fspecial('gaussian', 3, 0.5);

lenaGauss = filter2(gauss, lena);
[lenaGx, lenaGy] = gradient(lenaGauss);
lenaG = abs(lenaGx) + abs(lenaGy);
lenaTheta = atan(lenaGy./lenaGx) * 180 / pi;
lenaTheta = round(lenaTheta/45) * 45;
lenaIndices = find(lenaTheta < 0);
lenaTheta(lenaIndices) = lenaTheta(lenaIndices) + 360;

lenaCany = cany(lenaTheta, lenaG);

figure();
subplot(2,2,1);
imagesc(lena);
title('Lena originale');

subplot(2,2,2);
imagesc(lenaGauss);
title('Lena Gauss');

subplot(2,2,3);
imagesc(lenaG);
title('Lena Gradient');

subplot(2,2,4);
imagesc(lenaCany);
title('Lena Cany');

colormap(gray);



lenaCany = lenaCany / 255;
seuilMax = 0.72;
seuilMin = 0.6;

lenaSeuil = lenaCany;

lenaSupSeuilMax = find(lenaCany >= seuilMax);
lenaSeuil(lenaSupSeuilMax) = 1;

lenaInfSeuilMin = find(lenaCany <= seuilMin);
lenaSeuil(lenaInfSeuilMin) = 0;

tmp = find(lenaCany >= seuilMax);
[x, y] = find(lenaCany > seuilMin);
x = x(1:length(x)-length(tmp));
y = y(1:length(y)-length(tmp));

for k=1:length(x)
  for i=x-1:x+1
    for j=y-1:y+1
      if i > 0 && i <= length(lenaCany) && j > 0 && j <= length(lenaCany)
        if lenaCany(i,j) >= seuilMax
          lenaSeuil(x(k), y(k)) = 1;
        end
      end
    end
  end
end

figure();
imagesc(lenaSeuil);
colormap(gray);
title('Lena Seuil');