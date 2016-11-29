close all
clear all;
clc;
close all;

% Chargement image
I1 = double(rgb2gray(imread('brique.png'))); 
I2 = double(rgb2gray(imread('graine.png'))); 
I3 = double(rgb2gray(imread('points.png')));
I4 = double(rgb2gray(imread('random1.png'))); 

I1 = I1(50:250,50:250);
I2 = I2(50:250,50:250);
I3 = I3(50:250,50:250);
I4 = I4(100:300,100:300);

% Passage en 32 niveau de gris differents
N_lvl = 8;
P1 = double(floor(I1/N_lvl));
P2 = double(floor(I2/N_lvl));
P3 = double(floor(I3/N_lvl));
P4 = double(floor(I4/N_lvl));


% affichage des imagettes
figure, colormap(gray(16))
subplot 221, imagesc(P1), axis equal
subplot 222, imagesc(P2), axis equal
subplot 223, imagesc(P3), axis equal
subplot 224, imagesc(P4), axis equal

% calcul des moments d'ordre 1
M1 = calcul_moments_ordre1(P1);
M2 = calcul_moments_ordre1(P2);
M3 = calcul_moments_ordre1(P3);
M4 = calcul_moments_ordre1(P4);
M1a = [M1' M2' M3' M4'];

% affichage des histogrammes
figure
subplot 221, histogram(P1)
subplot 222, histogram(P2)
subplot 223, histogram(P3)
subplot 224, histogram(P4)

% test de la création de la matrice de coocurrence
imgTest = [4 4 3 1; 4 2 3 2; 1 2 3 2; 1 2 1 4; 1 2 1 3];
cooTest = creer_coocurrence(imgTest, 4);

% calcul de la matrice de cooccurrence
Mat1 = creer_coocurrence(P1, 32);
Mat2 = creer_coocurrence(P2, 32);
Mat3 = creer_coocurrence(P3, 32);
Mat4 = creer_coocurrence(P4, 32);

% calcul des moments d'ordre 2
M2_1 = calcul_moments_ordre2(P1);
M2_2 = calcul_moments_ordre2(P2);
M2_3 = calcul_moments_ordre2(P3);
M2_4 = calcul_moments_ordre2(P4);
M2 = [M2_1' M2_2' M2_3' M2_4'];


