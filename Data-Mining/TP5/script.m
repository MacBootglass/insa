%% TP 5 – Extraction de contours
% Thibault Théologien
% Ingrid Fiquet

clear;
close all;
clc;

% cd ~/MATLAB/cvx
% cvx_setup
% cd ~/Desktop/depot/insa/Data-Mining/TP5

%% 2. Rebelote

% Parametres du probleme primal
c = [3 1]';
b = [1 1 1 1]';
A = [1 1; 1 -1;-1 1;-1 -1];

% Trace de la fonction objectif et des contraintes du probleme primal
N = 150;
x = linspace(-2, 5, N);
y = linspace(-2, 5, N);
[X,Y] = meshgrid(x, y);
x = reshape(X,N*N,1);
y = reshape(Y,N*N,1);
J = 0.5*(x-c(1)).^2 + 0.5*(y-c(2)).^2;
[val, h]=contour(X, Y, reshape(J, N,N), 15, 'linewidth', 1.25);
clabel(val,h);
hold on;

% Contraintes
N = 150;
x = linspace(-1, 1, N);
y = linspace(-1, 1, N);
[X,Y] = meshgrid(x, y);
x = reshape(X,N*N,1);
y = reshape(Y,N*N,1);
ineq = (A * [x y]' - b*ones(1,N*N))';
hold on;
contour(X, Y, reshape(ineq(:,1), N,N), [0 0], 'm', 'linewidth', 2);
contour(X, Y, reshape(ineq(:,2), N,N), [0 0], 'm', 'linewidth', 2);
contour(X, Y, reshape(ineq(:,3), N,N), [0 0], 'm', 'linewidth', 2);
contour(X, Y, reshape(ineq(:,4), N,N), [0 0], 'm', 'linewidth', 2);

set(gca,'fontsize', 24);
colorbar;



% Resolution du probleme primal par cvx
% Probleme: minimize 1/2 || theta-C||^2 s.t. A*theta -b <= 0

n = 2;
fprintf( 'Calcul de la solution primale par CVX ... \n\n');
cvx_begin quiet           % quiet pour eviter l'affichage des iterations de cvx
    variable theta(n);    % declarer que theta est la variable du prob, vecteur de taille n
    minimize 0.5*quad_form(theta - c, eye(n));     % fonction objectif
    subject to
      A*theta - b <= 0;     % contraintes inegalites
cvx_end

fprintf('\n\n Fait ! \n');

% Affichage resultats.
fprintf('\n\n Solution obtenue : \n');
disp(theta);
plot(theta(1), theta(2), 'ro', 'markersize', 12, 'markerfacecolor','r' );

% Valeur de la fonction objectif pour theta optimal.
J_theta_primal = quad_form(theta - c, eye(n));


% Resolution du probleme dual
H = A*A';
q = A*c -b;

cvx_begin quiet           
    variable mu(4);    
    minimize (0.5*quad_form(mu,H)-mu'*q)     % fonction objectif
    subject to
      mu >= 0;     % contraintes inegalites
cvx_end

% D = 0.5*quadform(mu,H) - mu'*q;
fprintf('\n\n Solution duale obtenue : \n');
disp(mu);

theta2 = c - A'*mu;
fprintf('\n\n Solution du theta obtenue : \n');
disp(theta2);

plot(theta2(1), theta2(2), 'ro', 'markersize', 12, 'markerfacecolor','r' );


%% 3. Subsidiaire : bâtisseurs de cité