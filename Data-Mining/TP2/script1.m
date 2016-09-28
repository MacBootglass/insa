%% TD ACP

% OBJECTIF : Dans un premier temps il s'agit de coder les fonctions de
% bases qui nous seront utile pour utiliser la méthode de l'ACP sur les 
%données fournies. 
% Ainsi nous avons à notre disposition trois fonctions (mypca() /
%projpca() / reconstructpca() ). 


clear;
close all;

%% Exercice 2

load('data_iris_usps_asi/uspsasi.mat');

%On choisi le caractère 3 donc on récupére les données correspondantes. 
indices = find(y==3);
xChif = x(indices, :);

% Matrice de corrélation
matCorr = corrcoef(xChif);
figure()
imagesc(matCorr);
colormap('gray');

%On test la méthode ACP sur les données : 

%on choisi 2 comme dimensions. 
d = 2;

[valprop, U, moy] = mypca(xChif);
p = U(:,1:d);
C = projpca(xChif, moy, p);

figure()
plot(C(:,1), C(:,2), 'r.');
title('Projection en 2D par ACP');
xlabel('Composante principale 1');
ylabel('Composante principale 2');

xhat = reconstructpca(C, p, moy);

figure()
subplot(1,2,1);
image(reshape(xhat(1,:), 16, 16)' * 100);
title('Image reconstituée');
colormap('gray');
subplot(1,2,2);
imagesc(reshape(xChif(1,:), 16, 16)' * 100);
title('Image originelle');
colormap('gray');
