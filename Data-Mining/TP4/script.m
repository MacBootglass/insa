%% TD Optimisation sans contraintes

% Thibault Théologien
% Ingrid Fiquet

% OBJECTIF : 

clear all;
close all;
clc;

%% 1. Méthode du gradient

% 1) La direction de descente dk est l'opposé du gradient. 

% 2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %% FONCTION mongradient(theta) :
% % 
% % function d = monGradient( theta )
% %   d = [ 2*(theta(1)-1)-400*theta(1)*(theta(2)-theta(1)^2); 200*
% %   (theta(2)-theta(1)^2)];
% % end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %% FONCTION moncritere(theta) :
% %
% % function J = monCritere( theta )
% %   J = (1 - theta(1))^2 + 100 * (theta(2) - theta(1)^2)^2;
% % end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 4) Implementation de la méthode du gradient : 


% tracé des lignes de niveau de J
n = 100;
[X, Y] = meshgrid(linspace(-1.25, 2.5, n), linspace(-1.75, 2, n));
ptx = reshape(X, n*n,1);
pty = reshape(Y, n*n,1);
pt = [ptx pty];

% Define the function J = f(\theta)
Jmat = (1-pt(:,1)).^2 + 100*(pt(:, 2) - pt(:, 1).^2).^2;
%exp(-0.1)*(exp(pt*a) + exp(pt*b) + exp(pt*c));

% Create the surface plot using contour command
figure();
contour(X, Y, reshape(Jmat, n, n), [40:-5:0 1 0], 'linewidth', 1.5);
colorbar;
axis tight;
set(gca, 'fontsize', 18);

% solution initiale
theta0 = [-1; 0];

% trace de theta0
hold on;
h = plot(theta0(1,:), theta0(2,:), 'ro');
set(h, 'MarkerSize', 8, 'markerfacecolor', 'r');
text(theta0(1,1), theta0(2,1)-0.175, '\theta_0', 'fontsize', 16);

k = 1;
maxIter = 3000;  %15000
theta = theta0;
alpha = 1/norm(-monGradient(theta));
J = monCritere(theta);
histCritere = inf(maxIter, 1);
histCritere(k) = J;

while norm(monGradient(theta)) > 10^-3 && k < maxIter
    
    direction = -monGradient(theta);
    % Determination du pas de recherche
    % pas = 
    theta = theta + alpha*direction;
    
    J = monCritere(theta);
    k = k + 1;
    histCritere(k) = J;
    
%     alpha = 2*(histCritere(k) - histCritere(k-1))/dot(monGradient(theta), direction);

    hold on;
    plot(theta(1), theta(2), 'ro');

end

hold off;

% trace du critere en fonction des iterations
figure();
plot(histCritere);
title('Visualisation du critére J au fil des itérations')

%% 2. Méthode de Newton

% 1) Calcul de la matrice hessienne : 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %% FONCTION monHessien(theta) :
% %
% % function H = monHessien(theta)
% %   H=[2-400*theta(2)+1200*theta(1)^2, -400*theta(1);-400*theta(1),200];
% % end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2) 

n = 100;
[X, Y] = meshgrid(linspace(-1.25, 2.5, n), linspace(-1.75, 2, n));
ptx = reshape(X, n*n,1);
pty = reshape(Y, n*n,1);
pt = [ptx pty];

% Define the function J = f(\theta)
Jmat = (1-pt(:,1)).^2 + 100*(pt(:, 2) - pt(:, 1).^2).^2;
%exp(-0.1)*(exp(pt*a) + exp(pt*b) + exp(pt*c));

% Create the surface plot using contour command
figure();
contour(X, Y, reshape(Jmat, n, n), [40:-5:0 1 0], 'linewidth', 1.5);
colorbar;
axis tight;
set(gca, 'fontsize', 18);

% solution initiale
theta0 = [-1; 0];

% trace de theta0
hold on;
h = plot(theta0(1,:), theta0(2,:), 'ro');
set(h, 'MarkerSize', 8, 'markerfacecolor', 'r');
text(theta0(1,1), theta0(2,1)-0.175, '\theta_0', 'fontsize', 16);


i = 1;
maxIter = 5000;  %15000
theta = theta0;

pas = 0.1;
J = monCritere(theta);
histCritere = inf(maxIter, 1);
histCritere(k) = J;

while norm(monGradient(theta)) > 10^-3 && k < maxIter
    
    J = monCritere(theta);
    i = i + 1;
    histCritere(i) = J;
    grad = monGradient(theta);
    
    H = monHessien(theta);
    
    direction = H\grad;
    direction = - direction;

    theta = theta + pas*direction;
    
    plot(theta(1), theta(2), 'ro');

end


% trace du critere en fonction des iterations
figure();
plot(histCritere);
title('Visualisation du critére J au fil des itérations')



% La méthode de Newton est donc meilleur.  

