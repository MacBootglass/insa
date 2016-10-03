%% TD CLASSIFICATION HIERARCHIQUE ASCENDANTE

% Thibault Théologien
% Ingrid Fiquet

% OBJECTIF : L'objectif est de traiter des données à l'aide de la
% classification hiérarchique ascendante. 


clear;
close all;
clc;

%% 1) Mise en bouche

%%% les donnees
vmu1 = [0 0]';
vmu2 = [3 3]';
SIGMA = eye(2);

n = 50; % nombre de points par classe

% generation de donnees aleatoires suivant lois gaussiennes
X1 =  mvnrnd(vmu1,SIGMA,n);   % classe 1
X2 =  mvnrnd(vmu2,SIGMA,n);    % classe 2


figure, plot(X1(:,1), X1(:,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r')
hold on
plot(X2(:,1), X2(:,2), 'bv', 'markersize', 8, 'markerfacecolor', 'b')
title('La vérité vraie','fontsize', 14)

% on concatene les données (on suppose qu'on ne sait pas quel point est de 
% la classe 1 ou 2 dans la suite on ne travaillera qu'avec X1

X = [X1; X2]; clear X1 X2

%% 2) Classification hiérarchique ascendante

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %% FONCTION : Distance(X)

% % function D = distance( X )
% %   N = length(X);
% %   M = X*X';
% %   ps = diag(M);
% %   D = ps*ones(1,N) + ones(N,1)*ps' - 2*M;
% %   
% %   for i=1:N
% %     D(i,i) = inf;
% %   end
% %   
% % end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = distance(X);
K = 2; % On construit 2 classes sur les données. 
N = length(X);

clustMax = aggclust(M, 'complete');
clustMin = aggclust(M, 'single');

figure();
dendro(clustMax);
title('Cluster Maximal');

figure();
dendro(clustMin);
title('Cluster Minimal');

plotclusters(clustMax(N-K+1).cluster, X, K);
title('Cluster Maximal');

plotclusters(clustMin(N-K+1).cluster, X, K);
title('Cluster Minimal');

% Le saut maximal est plus performant. 

%% 3) Pour aller plus loin

% On test notre programme sur les données george.dat :

load('data/george.dat');

% On échantillonne d'abord les données
step = 15;  %8
X = mydownsampling(george, step);
M = distance(X);
K = 6;
N = length(X);
clustMax = aggclust(M, 'complete');
plotclusters(clustMax(N-K+1).cluster, X, K);


% On utilise maintenant les données ds2.dat :

load('data/ds2.dat');

% On échantillonne les données
step = 15; %10
X = mydownsampling(ds2, step);
M = distance(X);
K = 4;
N = length(X);
clustMax = aggclust(M, 'complete');
plotclusters(clustMax(N-K+1).cluster, X, K);

%% 4) Généralisation sur des données USPS :

load('data_iris_usps_asi/uspsasi.mat');

%On choisi le caractère 2, 4 et 6 puis on récupére les données 
%correspondantes :

indices = find(y==2);
xdeux = x(indices, :);

indices = find(y==4);
xquatre = x(indices, :);

indices = find(y==6);
xsix = x(indices, :);



% /////INUTILE\\\\\

% Représentation des données
% figure()
% hold on
% for i=1:256
%     plot(xdeux(:,i), 'ro', 'markersize', 8, 'markerfacecolor', 'r')
%     plot(xquatre(:,i), 'bv', 'markersize', 8, 'markerfacecolor', 'g')
%     plot(xsix(:,i), '+', 'markersize', 8, 'markerfacecolor', 'k')
%     title('La vérité vraie','fontsize', 14)
% end
% hold off



MatX = [xdeux; xquatre; xsix];
clear xdeux xquatre xsix;

% Premièrement ACP et ensuite méthode des clusters

d = 2;

[valprop, U, moy] = mypca(MatX);
p = U(:,1:d);
C = projpca(MatX, moy, p);

figure()
plot(C(:,1), C(:,2), 'r.');
title('Projection en 2D par ACP');
xlabel('Composante principale 1');
ylabel('Composante principale 2');

 
% On échantillonne d'abord les données

step = 1;  %8
Xnb = mydownsampling(C, step);
M = distance(Xnb);
K = 3;
N = length(Xnb);
clustMax = aggclust(M, 'complete');
plotclusters(clustMax(N-K+1).cluster, Xnb, K);

% PAREIL ICI pour mydownsampling