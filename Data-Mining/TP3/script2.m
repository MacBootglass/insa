%% TD Clustering K-Means

% Thibault Théologien
% Ingrid Fiquet

clear;
close all;

%% 2. Test simple

vmu1 = [0 0]';
vmu2 = [3 3]';
SIGMA = eye(2);

n = 50; % nombre de points par classe

% generation de donnees aleatoires suivant lois gaussiennes
X1 =  mvnrnd(vmu1,SIGMA,n);   % classe 1
X2 =  mvnrnd(vmu2,SIGMA,n);    % classe 2
X = [X1; X2]; 
clear X1 X2;

N = size(X,1);
K = 2; %nb de clusters
MaxIter = 10;

permu = randperm(N);
C0 = X(permu(1:K), :);

[C, clusters, JwIter] = Kmoyennes(X, K, C0, MaxIter);
plotclusters(clusters, X, K);

%% 3. Comparaison n’est pas raison

%% ds2
load('data/ds2.dat');
X = ds2;
N = size(X,1);
K = 4; %nb de clusters
MaxIter = 20;

permu = randperm(N);
C0 = X(permu(1:K), :);

[C, clusters, JwIter] = Kmoyennes(X, K, C0, MaxIter);
plotclusters(clusters, X, K);

%% george
load('data/george.dat');
X = george;
N = size(X,1);
K = 6; %nb de clusters
MaxIter = 20;

permu = randperm(N);
C0 = X(permu(1:K), :);

[C, clusters, JwIter] = Kmoyennes(X, K, C0, MaxIter);
plotclusters(clusters, X, K);



%% C’est chaud mais c’est fun

%% bird_small
bird = double(imread('data/bird_small.tiff'));
[Nlig, Ncol, d] = size(bird);

% transformer la matrice 3D en 2D avec chaque ligne repr�sentant les canaux
% RGB de chaque pixel ij de l'image
X = reshape(bird, Nlig*Ncol, d);
N = size(X,1);
K = 32;
MaxIter = 10;

permu = randperm(N);
C0 = X(permu(1:K), :);

[C, clusters, JwIter] = Kmoyennes(X, K, C0, MaxIter);


% --------------- AFFICHAGE -------------------------
% --------- On suppose que les centres trouves sont dans la matrice Centres
Centres = round(C);

% afichage des centres des clusters
figure();
hold on;
for k=1:K
   col = (1/255).*Centres(k,:);
   rectangle('Position', [k, 0, 1, 1], 'FaceColor', col, 'EdgeColor', col);
end
axis off;


%% bird_large

large_image = double(imread('data/bird_large.tiff'));
figure();
imshow(uint8(large_image));
title('Image initiale', 'fontsize', 16);


% on remplace directement dans l'image la valeur rgb du pixel par le centre
% le plus proche (pour sauver de place memorire)
[Nlig, Ncol, d] = size(large_image);


for i = 1:Nlig
  for j = 1:Ncol
    r = large_image(i,j,1); 
    g = large_image(i,j,2); 
    b = large_image(i,j,3);
    x = [r, g, b]; % on recupere les valeurs RGB du pixel ij
      % ---------------- A COMPLETER  ------------
    for k=1:K
      distance(k) = (norm(x - C(k, :)))^2;
    end
    [val, indice] = min(distance);  
        
    large_image(i,j,:) = C(indice, :);
  end 
end
% on affiche l'image apres encodage avec Kmeans 
figure();
imshow(uint8(large_image));
title('Encodage de l''image via Kmeans', 'fontsize', 16)
