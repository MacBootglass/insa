%% TP 7 – Régression logistique
% Thibault Théologien
% Ingrid Fiquet

clear;
close all;
clc;

%% Premiers tests

randn('state', 1200);
% Géneration des donnees
vmu1 = [0; 2];
vmu2 = [-2; -1];
vSIGMA1 = 1.5*[1 0.1; 0.1 1];
vSIGMA2 = 3.5*[1 -0.25; -0.25 1/2];

n1 = 100; % nombre de points classe 1
n2 = 150; % nombre de points classe 2

% Generation de donnees aleatoires suivant lois gaussiennes
% classe 1
X1 =  mvnrnd(vmu1, vSIGMA1,n1);   
Y1 = zeros(n1, 1);
% classe 2
X2 =  mvnrnd(vmu2, vSIGMA2,n2);    
Y2 = ones(n2, 1);

% Affichage des points en fonction de leur classe.
figure(1);
plot(X1(:,1), X1(:,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r');
hold on;
plot(X2(:,1), X2(:,2), 'bv', 'markersize', 8, 'markerfacecolor', 'b');

% matrice des donnees
X = [X1; X2]; 
clear X1 X2;

% vecteur des labels
Y = [Y1; Y2]; 
clear Y1 Y2;

% Détermination du vecteur theta et du vecteur de prédiction.
[theta, allJ] = reglogclass(X, Y, 1e-5);
ypred = reglogval(X, theta);

% Calcul de l'erreur
err = mean(Y ~= ypred); 
% L'erreur est de 0.08 avec randn('state', 1200) tandis que sur la methode
% LDA on obtient environ 0.02

% Affichage de la frontière calculée
figure(1)
M = 250;
[aux1, aux2] = meshgrid(linspace(-5,5,M));
aux = [reshape(aux1,M*M,1) reshape(aux2,M*M,1)];
Score = [ones(M*M, 1) aux]*theta;
figure(1);
hold on;
[c,h] = contour(aux1, aux2, reshape(Score, M,M), [0 0], 'g', 'Linewidth',2);
clabel(c,h);

% Affichage de J
figure(2);
plot(allJ);

%% Classification de chiffres manuscripts

clear;
close all;
clc;
load('mnist-app.mat');
load('mnist-test.mat');

% Tour de chauffe
% On veut chercher les 2 et les 4
X2 = Xa(Ya == 2,:);
X4 = Xa(Ya == 4,:);
X = [X2; X4];
Y = [zeros(length(X2),1); ones(length(X4),1)];

[theta, allJ] = reglogclass(X, Y, 1e-5);
ypred = reglogval(X, theta);
err = mean(Y ~= ypred); 