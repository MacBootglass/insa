clear;
close all;
clc;

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

% on concatene les donn�es (on suppose qu'on ne sait pas quel point est de la classe 1 ou 2
% Dans la suite on ne travaillera qu'avec X1
X = [X1; X2]; clear X1 X2
M = distance(X);
K = 2;
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


%% Part2
clear;

load('data/george.dat');
step = 5;
X = mydownsampling(george, step);
M = distance(X);
K = 2;
N = length(X);

clustMax = aggclust(M, 'complete');
plotclusters(clustMax(N-K+1).cluster, X, K);