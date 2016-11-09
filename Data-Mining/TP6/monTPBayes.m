% Script à compléter pour réalise le TP 

randn('state', 1200)

% Géneration des donnees
vmu1 = [0; 2];
vmu2 = [-2; -1];
vSIGMA1 = 1.5*[1 0.1; 0.1 1];
vSIGMA2 = 3.5*[1 -0.25; -0.25 1/2];


n1 = 100; % nombre de points classe 1
n2 = 150; % nombre de points classe 2

% generation de donnees aleatoires suivant lois gaussiennes
% classe 1
X1 =  mvnrnd(vmu1, vSIGMA1,n1);   
Y1 = ones(n1, 1);
% classe 2
X2 =  mvnrnd(vmu2, vSIGMA2,n2);    
Y2 = 2*ones(n2, 1);


figure, plot(X1(:,1), X1(:,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r')
hold on
plot(X2(:,1), X2(:,2), 'bv', 'markersize', 8, 'markerfacecolor', 'b')


% Dans la suite on ne travaillera qu'avec X et Y
% matrice des donnees
X = [X1; X2]; clear X1 X2

% vecteur des labels
Y = [Y1; Y2]; clear Y1 Y2


%%  A COMPLETER : VOTRE IMPLEMENTATION DE LA LDA 


%% A DECOMMENTER : trace de la frontiere de decision de la LDA connaissant le vecteur w et le scalaire w0
% M = 50;
% % definition du maillage du plan
% [auxdim1, auxdim2]=meshgrid(linspace(-8, 8, M)); 
% auxdata = [reshape(auxdim1,M*M,1) reshape(auxdim2,M*M,1)]; 
% 
% % trace frontiere LDA
% gx = auxdata*w + w0;
% [c,h]=contour(auxdim1, auxdim2, reshape(gx,M,M), [0 0]);
% set(h, 'linewidth', 2, 'color', 'g')
% clabel(c,h)