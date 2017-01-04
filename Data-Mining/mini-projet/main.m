%% Mini-Projet
% FIQUET Ingrid
% THEOLOGIEN Thibault

addpath('./fonctions/kppv');
addpath('./fonctions/regression');
addpath('./fonctions/svm');
addpath('./fonctions');

close all;
clear all;
clc;

load('seismic.mat');

% Avec toutes les informations renseignées dans X, on sait si le seisme est dangereux ou non dans labels


%% Découpage des données en trois ensembles
Y = labels;
indices = find(labels == 0);
Y(indices) = -1;

[X_tmp, Y_tmp, X_test, Y_test] = splitdata(X, Y, 2/3); 
[X_app, Y_app, X_val, Y_val] = splitdata(X_tmp, Y_tmp, 0.5);
clear X_tmp;
clear Y_tmp;


%% SVM
disp('Début SVM');

C = 10;

[w,b,alpha] = monsvmclass(X_app, Y_app, C);

% On applique sur le SVM sur les ensembles app et val
Y_chapo_app_svm = monsvmval(X_app, w, b);
Y_chapo_val_svm = monsvmval(X_val, w, b);
Y_chapo_test_svm = monsvmval(X_test, w, b);

% On détermine l'erreur moyenne pour le modèle SVM
err_app_svm = mean(Y_chapo_app_svm ~= Y_app);
err_val_svm = mean(Y_chapo_val_svm ~= Y_val);
err_test_svm = mean(Y_chapo_test_svm ~= Y_test);
err_svm = mean([err_app_svm, err_test_svm]);


%% K-ppv
disp('Début K-means');

dist_app = [];
dist_val = [];

k_vect = 3:2:70;
err_app_kppv = zeros(size(k_vect));
err_val_kppv = zeros(size(k_vect));

for i=1:length(k_vect)
k = k_vect(i);
  [Y_chapo_app_kppv, dist_app] = kppv(X_app, X_app, Y_app, k, dist_app);
  [Y_chapo_val_kppv, dist_val] = kppv(X_val, X_app, Y_app, k, dist_val);

  err_app_kppv(i) = mean(Y_app ~= Y_chapo_app_kppv);
  err_val_kppv(i) = mean(Y_val ~= Y_chapo_val_kppv);
end

[err_kppv, indice] = min(err_val_kppv);
k_opti = k_vect(indice);


%% Regréssion logistique
disp('Début Régression logistique');
indices = Y_app == -1;
Y_app(indices) = 0;

indices = Y_val == -1;
Y_val(indices) = 0;
lambda = 10^-5;

% Détermination du vecteur theta et du vecteur de prédiction
[theta, allJ] = reglogclass(X_app, Y_app, lambda);
Y_app_pred = reglogval(X_app, theta);

err_regression = mean(Y_app ~= Y_app_pred);


%% Affichage
disp(sprintf('\n\nTaux erreur SVM: %d', err_svm));
disp(sprintf('Taux erreur K-ppv: %d', err_kppv));
disp(sprintf('Taux erreur regression: %d', err_regression));


