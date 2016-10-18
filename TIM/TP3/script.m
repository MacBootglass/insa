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

cameraman = imread('cameraman.tif');
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
camLap = ddXcam + ddYcam;

figure()
imagesc(camLap);
title('Laplacien par dérivées');
colormap(gray);

% Avec l'opérateur laplacien sur voisinage réduit :
laplace = [0 -1 0; -1 4 -1; 0 -1 0];
camlaplace = filter2(laplace, cameraman);

figure();
imagesc(camlaplace);
title('Laplacien par opérateur');
colormap(gray);

% Différence de gaussienne
gauss1 = fspecial('gaussian',3,0.6);
gauss2 = fspecial('gaussian',3,0.96);

camGauss1 = filter2(gauss1, cameraman);
camGauss2 = filter2(gauss2, cameraman);

camGauss = camGauss1 - camGauss2;

figure();
imagesc(camGauss);
title('DOG');
colormap(gray);

%% 4- Extraction de contours par seuillage.
cameraman = cameraman / 255;
