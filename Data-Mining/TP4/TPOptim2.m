
clear all
close all
clc

%% trace des lignes de niveau de J
n = 100;
[X, Y] = meshgrid(linspace(-1.25, 2.5, n), linspace(-1.75, 2, n));
ptx = reshape(X, n*n,1);
pty = reshape(Y, n*n,1);
pt = [ptx pty];

% Define the function J = f(\theta)
Jmat = (1-pt(:,1)).^2 + 100*(pt(:, 2) - pt(:, 1).^2).^2;
%exp(-0.1)*(exp(pt*a) + exp(pt*b) + exp(pt*c));

% Create the surface plot using contour command
figure(1);
contour(X, Y, reshape(Jmat, n, n), [40:-5:0 1 0], 'linewidth', 1.5);
colorbar
axis tight
set(gca, 'fontsize', 18)


% A Completer ...

% à décomenter si vous utilisez un pas fixe a chaque iteration
% pas = 0.1;

% solution initiale
theta0 = [-1; 0];

% trace de theta0
figure(1), hold on
h = plot(theta0(1,:), theta0(2,:), 'ro');
set(h, 'MarkerSize', 8, 'markerfacecolor', 'r');
text(theta0(1,1), theta0(2,1)-0.175, '\theta_0', 'fontsize', 16)


while non convergence
    
    % calcul de J
    
   
    % calcul de la direction de descente 
    direction = 
    
    
    % Determination du pas de recherche
    pas = 
    
    % mise a jour de theta = theta + alpha * direction
    theta = theta + pas*direction;
    
    
    % trace du theta courant
    
    
end

% trace du critere en fonction des iterations

