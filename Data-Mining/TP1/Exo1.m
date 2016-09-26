%% TD Introduction au Data-Mining

% *OBJECTIF :* On possède un jeu de données représentant les caractéristiques
% physio-chimiques de vins. Le but est qu'à partir de ces données on puisse
% prédire la qualité d'un vin selon une méthode bien précise. 

% *DESCRIPTION DES DONNEES :* Nous avons deux matrices à notre disposition.
% La matrice X contient les caractéristiques physiques et chimiques des
% vin et la matrice Y représente la qualité du vin (1/0 : bonne/mauvaise).
% Chaques lignes des deux matrices représente un vin en particulier. 

%% 1) Prise en main des données :

clear;
close all;
load('WhiteW.mat');

%Analyse statistique de X :

moy = mean(X);
variance = var(X);
mediane = quantile(X,0.5);

% Tracé des boites à moustache pour chaque attribut des vins.
figure(1)
hold on
for i=1:11 
    subplot(4,3,i);
    boxplot(X(:,i));
end

%% 2) Mise en place de la classifications des données

%% 2.1 Découpage des données

[Xtmp Ytmp Xtest Ytest] = splitdata(X, Y, 2/3); 
[Xapp Yapp Xval Yval] = splitdata(Xtmp, Ytmp, 0.5);
clear Xtmp;
clear Ytmp;

% A l'aide de la fonction slitdata on sépare dans un premier temps
% les matrices X et Y en deux de proportions 1/3 et 2/3 et ensuite
% l'échantillon de taille 2/3 on le sépare de nouveau en 2. Ainsi on a
% séparer nos données en trois en proportion identique. 
% Ainsi on posséde un sous ensemble d'apprentissage Xapp/Yapp, un sous
% ensemble de validation Xval/Yvap et un sous ensemble de test Xtest/Ytest.


%% 2.2 Méthode des k plus proches voisins

% La méthode des k plus proches voisins consiste à prendre un point de
% référence x puis de déterminer ses k plus proches voisins (k choisi) à
% l'intérieur d'un sous ensemble. 
% La métrique utilisée ici est la distance euclidienne.
% On dispose d'une fonction kppv qui applique la méthode des k plus proches
% voisins. 

MatDistApp = [];
MatDistVal = [];
MatDistTest = [];

kVect = 3:2:70;
% Après plusieurs tests on décide de ne choisir que des k impaires, car
% lorsque le k est un nombre pair on remarque des variations importantes.
% En effet lorsque l'on regarde un nombre de voisin pair on peut avoir
% autant de point d'une classe que de point de l'autre classe, l'ordinateur
% choisissant la classe de façon aléatoire dans ce cas le résultat n'est
% pas fiable. 

%initialisation
errorApp = zeros(size(kVect));
errorVal = zeros(size(kVect));
errorTest = zeros(size(kVect));

% On applique la méthode des k plus proches voisins pour chacun des sous
% ensemble (apprentissage, valisation et test) plusieur fois avec un nombre
% de k grandissant afin de trouver la valeur du k optimal.
% Pour cela on calcul l'erreur pour chaque sous ensemble en faisant une
% comparaison terme à terme. 

for i=1:length(kVect)
    k = kVect(i);
    [YPapp,MatDistApp] = kppv(Xapp, Xapp, Yapp, k, MatDistApp);
    [YPval,MatDistVal] = kppv(Xval, Xapp, Yapp, k, MatDistVal);
    [YPtest,MatDistTest] = kppv(Xtest, Xapp, Yapp, k, MatDistTest);
    errorApp(i) = mean(Yapp ~= YPapp);
    errorVal(i) = mean(Yval ~= YPval);
    errorTest(i) = mean(Ytest ~= YPtest);
end

% On récupére l'indice de k optimal pour les sous ensemble de test et 
% de validation afin de voir s'il y a bien correspondance. 

[val, indice] = min(errorVal);
kOptiVal = kVect(indice);

[val, indice] = min(errorTest);
kOptiTest = kVect(indice);

% La meilleur valeur k* de k à choisir est 15. 
% Pour la valeur de k*=15 on a une erreur de 0.31.

% On trace maintenant l'évolution de l'erreur en fonction de la valeur de k
% pour les trois sous ensemble. 

figure(2)
subplot(1,3,1);
plot(kVect, errorApp,'m');
title('errorApp');
xlabel('Valeur de k');
ylabel('erreur');

subplot(1,3,2);
plot(kVect, errorVal,'b');
title('errorVal');
xlabel('Valeur de k');
ylabel('erreur');

subplot(1,3,3);
plot(kVect, errorTest,'g');
title('errorTest');
xlabel('Valeur de k');
ylabel('erreur');

% Meilleur représentation des erreurs pour comparaison :

figure(3)
hold on
plot(kVect, errorApp,'m');
plot(kVect, errorVal,'b');
plot(kVect, errorTest,'g');
legend('errorApp','errorVal','errorTest');
title('Comparaison des erreurs des différents sous ensemble en fonction de la valeur de k')
xlabel('Valeur de k');
ylabel('erreur');
hold off


%% 2.3 Influence de la normalisation des données

% On veut calculer la moyenne Ma et l'écart-type Sa des variables 
% exlicatives de Xapp.

Ma = mean(Xapp);
Sa = std(Xapp);

% Maintenant on normalise Xapp, Xval, Xtest à l'aide des valeurs Ma et Sa.
% On centre et réduit les variables à l'aide de la fonction
% normalisationmeanstd.m

[XappBis,XtestBis,Ma,Sa] = normalizemeanstd(Xapp,Xtest);
[XappBis,XvalBis, Ma, Sa] = normalizemeanstd(Xapp,Xval);
[XappBis,XappBis, Ma, Sa] = normalizemeanstd(Xapp,Xapp);


MatDistAppBis = [];
MatDistValBis = [];
MatDistTestBis = [];

errorAppBis = zeros(size(kVect));
errorValBis = zeros(size(kVect));
errorTestBis = zeros(size(kVect));

for i=1:length(kVect)
    k = kVect(i);
    [YPappBis,MatDistAppBis] = kppv(XappBis, XappBis, Yapp, k, MatDistAppBis);
    [YPvalBis,MatDistValBis] = kppv(XvalBis, XappBis, Yapp, k, MatDistValBis);
    [YPtestBis,MatDistTestBis] = kppv(XtestBis, XappBis, Yapp, k, MatDistTestBis);
    errorAppBis(i) = mean(Yapp ~= YPappBis);
    errorValBis(i) = mean(Yval ~= YPvalBis);
    errorTestBis(i) = mean(Ytest ~= YPtestBis);
end

[val, indice] = min(errorValBis);
kOptiValBis = kVect(indice);

[val, indice] = min(errorTestBis);
kOptiTestBis = kVect(indice);

figure(4)
subplot(1,3,1);
plot(kVect, errorAppBis,'m');
title('errorApp centré réduit');
xlabel('Valeur de k');
ylabel('erreur');

subplot(1,3,2);
plot(kVect, errorValBis,'b');
title('errorVal centré réduit');
xlabel('Valeur de k');
ylabel('erreur');

subplot(1,3,3);
plot(kVect, errorTestBis,'g');
title('errorTest centré réduit');
xlabel('Valeur de k');
ylabel('erreur');

% Meilleur représentation des erreurs pour comparaison :

figure(5)
hold on
plot(kVect, errorAppBis,'m');
plot(kVect, errorValBis,'b');
plot(kVect, errorTestBis,'g');
legend('errorApp','errorVal','errorTest');
title('Comparaison des erreurs des différents sous ensembles centrés réduits en fonction de la valeur de k')
xlabel('Valeur de k');
ylabel('erreur');
hold off



% *Conclusion : * Après avoir retracé les courbes des erreurs en fonction
% de la valeur de k pour chaque sous ensemble mais cette fois ci en
% utilisant des valeurs de Xapp, Xval, Xtest centrée réduit nous constatons
% que les valeurs d'erreur sont légérement plus faible. Ainsi nous pouvons
% conclure qu'il est meilleur de choisir le k optimal sur les données
% centrées réduites car la donnée sera plus fiable. 