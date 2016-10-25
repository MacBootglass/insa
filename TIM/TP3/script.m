%% TP 4 – Extraction de contours
% Thibault Théologien
% Riadh Kilani

clear;
close all;
clc;
addpath('../images');

%% 1- Cas mono-dimensionnel
N = 20;
ech = echellon(N);
toit = toit(N);

dech = diff(ech);
ddech = diff(dech);
dtoit = diff(toit);
ddtoit = diff(dtoit);

figure();
subplot(1,3,1);
plot(ech);
title('Signal echellon');

subplot(1,3,2);
plot(dech);
title('Dérivée première signal echellon');

subplot(1,3,3);
plot(ddech);
title('Dérivée seconde signal echellon');

figure();
subplot(1,3,1);
plot(toit);
title('Signal toit');

subplot(1,3,2);
plot(dtoit);
title('Dérivée première signal toit');

subplot(1,3,3);
plot(ddtoit);
title('Dérivée seconde signal toit');

%% 2- Les opérateurs dérivatifs du premier ordre

cameraman = double(imread('cameraman.tif'));
cameraman = cameraman / 255;
gray = gray(256);

% Norme du gradient
[dXcam, dYcam] = gradient(im2double(cameraman));
camGrad = sqrt(dXcam.^2 + dYcam.^2);

figure();
imagesc(camGrad);
colormap(gray);

% Sobel
sobel = [1 2 1; 0 0 0;  -1 -2 -1];
sobelH = -sobel';
sobelV = flipud(sobel);

camSobelO = filter2(sobel, cameraman);
camSobelH = filter2(sobelH, cameraman);
camSobelV = filter2(sobelV, cameraman);
camSobel = sqrt(camSobelH.^2 + camSobelV.^2);

figure();
subplot(2,2,1);
imagesc(camSobelO);
title('Sobel original');

subplot(2,2,2);
imagesc(camSobelH);
title('Sobel horizontal');

subplot(2,2,3);
imagesc(camSobelV);
title('Sobel vertical');

subplot(2,2,4);
imagesc(camSobel);
title('Sobel normé');
colormap(gray);

% Prewitt
prewitt = [1 1 1; 0 0 0; -1 -1 -1];
prewittH = -prewitt';
prewittV = flipud(prewitt);

camPrewittO = filter2(prewitt, cameraman);
camPrewittH = filter2(prewittH, cameraman);
camPrewittV = filter2(prewittV, cameraman);
camPrewitt = sqrt(camPrewittH.^2 + camPrewittV.^2);

figure();
subplot(2,2,1);
imagesc(camPrewittO);
title('Prewitt original');

subplot(2,2,2);
imagesc(camPrewittH);
title('Prewitt horizontal');

subplot(2,2,3);
imagesc(camPrewittV);
title('Prewitt vertical');

subplot(2,2,4);
imagesc(camPrewitt);
title('Prewitt normé');
colormap(gray);

%% Les opérateurs dérivatifs du second ordre

% A partir des dérivées
[ddXcam, dYdXcam] = gradient(dXcam);
[dXdYcam, ddYcam] = gradient(dYcam);
camLap = abs(ddXcam + ddYcam);

figure()
imagesc(camLap);
title('Laplacien par dérivées');
colormap(gray);

% Avec l'opérateur laplacien sur voisinage réduit :
laplace = [0 -1 0; -1 4 -1; 0 -1 0];
camLaplace = abs(filter2(laplace, cameraman));

figure();
imagesc(camLaplace);
title('Laplacien par opérateur');
colormap(gray);

% Différence de gaussienne
gauss1 = fspecial('gaussian',3,0.6);
gauss2 = fspecial('gaussian',3,0.96);

camGauss1 = filter2(gauss1, cameraman);
camGauss2 = filter2(gauss2, cameraman);

camGauss = abs(camGauss1 - camGauss2);

figure();
imagesc(camGauss);
title('DOG');
colormap(gray);

%% 4- Extraction de contours par seuillage.

seuilSobel = 0.3;
seuilGauss = 0.1;
seuillageCamSobel = ((camSobel / max(max(camSobel))) > seuilSobel);
seuillageCamGauss = ((camGauss / max(max(camGauss))) > seuilGauss);

figure();
subplot(1,2,1);
imagesc(seuillageCamSobel);
title('Seuillage dun operateur du premier ordre');

subplot(1,2,2);
imagesc(seuillageCamGauss);
title('Seuillage dun operateur du second ordre');
colormap(gray);

%% 5- Mise en situation
clear all;
close all;

gray = gray(256);
p = 0.1;
filterSize = 3;
seuilSobel = 0.2;
seuilPrewitt = 0.2;
seuilLaplacian = 0.2;
seuilGaussian = 0.4;
cameraman = double(imread('cameraman.tif'))/255;
cameramanBruit = imnoise(cameraman,'salt & pepper', p);
cameramanDebruite = filter2(fspecial('average', filterSize), cameramanBruit);

cameramanSobel = EdgeExtraction(cameramanDebruite, 'sobel', seuilSobel);
affichage(cameraman, cameramanBruit, cameramanDebruite, cameramanSobel, gray, 'sobel');

cameramanPrewitt = EdgeExtraction(cameramanDebruite, 'prewitt', seuilPrewitt);
affichage(cameraman, cameramanBruit, cameramanDebruite, cameramanPrewitt, gray, 'prewitt');

cameramanLaplacian = EdgeExtraction(cameramanDebruite, 'laplacian', seuilLaplacian);
affichage(cameraman, cameramanBruit, cameramanDebruite, cameramanLaplacian, gray, 'laplacian');

cameramanGaussian = EdgeExtraction(cameramanDebruite, 'gaussian', seuilGaussian);
affichage(cameraman, cameramanBruit, cameramanDebruite, cameramanGaussian, gray, 'gaussian');