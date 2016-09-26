clear;
close all;

%% Exercice 3
load('YaleFace/Subset1YaleFaces.mat');

d = 9;

[valprop, U, moy] = mypca(X);
p = U(:,1:d);
C = projpca(X, moy, p);

figure(1);
imagesc(reshape(moy, 50, 50)); 
colormap(gray);
title('Visage Moyen');

figure(2);
for i=1:9
  subplot(3,3,i);
  imagesc(reshape(U(:,i), 50, 50)); 
  colormap(gray);
end