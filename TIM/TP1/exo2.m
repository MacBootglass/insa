%% Exercice 2
% ASI 4 - Thibault THEOLOGIEN - Eliott RENAUD

clear;
close all;
clc;

N = 256;
I = zeros(N, N);

for i=1:N
  for j=1:N
    I(i, j) = j;
  end
end

figure();
subplot(2,1,1);
image(I);
title('Visualisation avec fonction image()');

subplot(2,1,2);
imagesc(I);
title('Visualisation avec fonction imagesc()');

% La fonction image() n'utilise que les 64 couleurs de matlab et se retrouve 
% "bloqué" surla couleur jaune pour des valeurs > 64
% imagesc va adapter l'image pour donner l'illusion d'avoir plus de
% couleurs (bien que matlab utilise ENCORE 64 couleurs)

figure();
imagesc(I);
colormap('gray');
title('Visualisation avec fonctions imagesc() et colormap(gray)');

paletteGray = colormap('gray');
figure();
imagesc(paletteGray);
title('Visualisation de la palette colormap(gray)');

paletteRand256 = rand(256, 3);
figure();
imagesc(I);
colormap(paletteRand256);
title('Visualistion de I avec une palette de 256 niveaux de gris générés aléatoirement');

paletteGray256 = gray(256);
figure();
imagesc(I);
colormap(paletteGray256);
title('Visualistion de I avec une palette de 256 niveaux de gris');

% La figure 4 est juste une succession incohérente de bandes colorées
% puisque la palette est composé de couleurs aléatoires.
% Contrairement à la figure 2, on observe un dégradé de couleurs sans
% bande, parce que la palette 'gray' standard est un dégradé de 64 couleurs
% alors que paletteGray256 en contient 256.


paletteInvGray256 = flipud(paletteGray256);

figure();
imagesc(I);
colormap(paletteInvGray256);
title('Visualistion de I avec une palette de 256 niveaux de gris inversée');
% On osbserve bien un dégradé de gris dans l'ordre inverse

% CONCLUSION : image et imagesc generent par défaut des images en 64
% couleurs (sur chaque composante rgb)
% La fonction colormap() permet "d'indiquer" que l'image est en niveau de 
% gris (on a qu'une seule composante de niveau de gris allant de 0 à 255 
% alors que les trois composantes RGB sont necessaires).
% Par défaut le paramètre 'gray' de colormap utilise une matrice 64x3 alors
% alors que nous desirons une matrice 256x3, d'ou l'utilisation de
% gray(256)