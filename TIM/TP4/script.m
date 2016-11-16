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
gauss = fspecial('gaussian', 3, 0.7);

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


seuilMax = 15;
seuilMin = 1;

lenaSeuil = lenaCany;

lenaSupSeuilMax = find(lenaCany >= seuilMax);
lenaSeuil(lenaSupSeuilMax) = 1;

lenaInfSeuilMin = find(lenaCany <= seuilMin);
lenaSeuil(lenaInfSeuilMin) = 0;

[x, y] = find(lenaCany > seuilMin & lenaCany < seuilMax);
disp(length(x));
for k=1:length(x)
  tmp = 1;
  for i=x(k)-1:x(k)+1
    for j=y(k)-1:y(k)+1
      if i > 0 && i <= length(lenaCany) && j > 0 && j <= length(lenaCany) && tmp == 1;
        if lenaCany(i,j) >= seuilMax
          lenaSeuil(x(k), y(k)) = 1;
          tmp = 0;
        else
          lenaSeuil(x(k), y(k)) = 0;
        end
      end
    end
  end
end

figure();
imagesc(lenaSeuil);
colormap(gray);
title('Lena Seuil');