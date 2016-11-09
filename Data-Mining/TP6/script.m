%% TP 6 – Théorie Bayesienne de la décision
% Thibault Théologien
% Ingrid Fiquet

clear;
close all;
clc;

%% I. On s'échauffe

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
Y1 = ones(n1, 1);
% classe 2
X2 =  mvnrnd(vmu2, vSIGMA2,n2);    
Y2 = 2*ones(n2, 1);

% Affichage
figure();
plot(X1(:,1), X1(:,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r');
hold on;
plot(X2(:,1), X2(:,2), 'bv', 'markersize', 8, 'markerfacecolor', 'b');


% Dans la suite on ne travaillera qu'avec X et Y
% matrice des donnees
X = [X1; X2]; 
clear X1 X2;

% vecteur des labels
Y = [Y1; Y2]; 
clear Y1 Y2;

%% Implémentation de la LDA

p1 = n1/(n1+n2);
p2 = n2/(n1+n2);

index1 = find(Y == 1);
mu1 = mean(X(index1,:))';

index2 = find(Y == 2);
mu2 = mean(X(index2,:))';

sigma1 = cov(X(index1,:));
sigma2 = cov(X(index2,:));

sigmaLDA = (n1*sigma1+n2*sigma2)/(n1+n2-1);

w = sigmaLDA^-1 * (mu1-mu2);
b = -w'*(mu1+mu2)/2 + log(p1/p2);

fx = X*w+b;
yChapo = zeros(n1+n2,1) + 2;
indexpos = find(fx > 0);
yChapo(indexpos) = 1;

% err = sum(abs(Y-yChapo))/(n1+n2);                  % ne fonctionnera pas s'il y a plus de 2 classes 
err = mean(yChapo ~= Y);

%% Trace de la frontiere de decision de la LDA connaissant le vecteur w et le scalaire w0
w0 = b;
M = 50;
% definition du maillage du plan
[auxdim1, auxdim2] = meshgrid(linspace(-8, 8, M)); 
auxdata = [reshape(auxdim1,M*M,1) reshape(auxdim2,M*M,1)]; 

% trace frontiere LDA
gx = auxdata*w + w0;
[c,h]=contour(auxdim1, auxdim2, reshape(gx,M,M), [0 0]);
set(h, 'linewidth', 2, 'color', 'g')
clabel(c,h)

%% II. La tête dans les étoiles
clear;
close all;
clc;

load('astrodata.mat');

N = length(Y);
N1 = length(find(Y == 1));
N2 = length(find(Y == 2));

% Découpage des données en un ensemble d’apprentissage et un ensemble de test
[Xapp, Yapp, Xtest, Ytest] = splitdata(X, Y, 0.5);

% Normalisation du jeu de données
[Xapp, Xtest, Ma, Sa] = normalizemeanstd(Xapp,Xtest);

% Mise en oeuvre de la méthode LDA
Napp = length(Yapp);
N1app = length(find(Yapp == 1));
N2app = length(find(Yapp == 2));

P1 = N1app/Napp;
P2 = N2app/Napp;

index1 = find(Yapp == 1);
mu1 = mean(Xapp(index1,:))';

index2 = find(Yapp == 2);
mu2 = mean(Xapp(index2,:))';

sigma1 = cov(Xapp(index1,:));
sigma2 = cov(Xapp(index2,:));

sigmaLDA = (N1app*sigma1+N2app*sigma2)/(Napp-1);

w = sigmaLDA^-1 * (mu1-mu2);
b = -w'*(mu1+mu2)/2 + log(P1/P2);

fx = Xapp*w+b;
yChapo = zeros(Napp,1) + 2;
indexpos = find(fx > 0);
yChapo(indexpos) = 1;
 
err = mean(yChapo ~= Yapp);