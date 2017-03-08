%% TP4 - MultiClass SVM
% MARTIN Florian
% THEOLOGIEN Thibault

clear all;
close all;
clc;

%% 1
ni = 15;
of = 1;
X1 = rand(ni,2);
X1(:,1) = 2*X1(:,1)-.5;
X2 = rand(ni,2) + of*ones(ni,1)*[.55 1.05];
X3 = rand(ni,2) + of*ones(ni,1)*[-.55 1.05];
Xi = [X1 X2 X3];
% Xi = X1;
[n,p] = size(Xi);
yi = [[ones(n,1) ; -ones(n,1) ; -ones(n,1)] , [-ones(n,1) ; ones(n,1) ; -ones(n,1)] , [-ones(n,1) ; -ones(n,1) ; ones(n,1)]];
yii = [ones(n,1) ; 2*ones(n,1) ; 3*ones(n,1)];
nt = 1000;
X1t = rand(nt,2);
X1t(:,1) = 2*X1t(:,1)-.5;
X2t = rand(nt,2) + of*ones(nt,1)*[.55 1.05];
X3t = rand(nt,2) + of*ones(nt,1)*[-.55 1.05];
Xt = [X1t;X2t;X3t];
yt = [ones(nt,1) ; 2*ones(nt,1) ; 3*ones(nt,1)];
plot(X1(:,1),X1(:,2),'+m','LineWidth',2); hold on
plot(X2(:,1),X2(:,2),'ob','LineWidth',2);
plot(X3(:,1),X3(:,2),'xg','LineWidth',2);


%% 2

% a)
kernel='poly'; d=1;
C = 1000000000;
lambda = 1e-12;
[xsup1,w1,w01,ind_sup1,a1] = svmclass(Xi,yi(:,1),C,lambda,kernel,d,0);
[xsup2,w2,w02,ind_sup2,a2] = svmclass(Xi,yi(:,2),C,lambda,kernel,d,0);
[xsup3,w3,w03,ind_sup3,a3] = svmclass(Xi,yi(:,3),C,lambda,kernel,d,0);

% b)


% c)


% d)


% e)
