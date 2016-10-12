%% TD Optimisation sans contraintes

% Thibault Théologien
% Ingrid Fiquet

% OBJECTIF : 

clear all;
close all;
clc;

%% 1. Méthode du gradient

%1. Opposé du gradient

%% tracé des lignes de niveau de J
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
maxIter = 15000;
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

% trace du critere en fonction des iterations
figure();
plot(histCritere);

