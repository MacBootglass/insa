
% bout de code pour tracer la frontiere de decision d'un modele de
% regression logistique en 2D. 
% theta est le vecteur de parametres du modele

figure(1)
M = 200;
[aux1,aux2]=meshgrid(linspace(-5,5,M));
aux=[reshape(aux1,M*M,1) reshape(aux2,M*M,1)];
Score = [ones(M*M, 1) aux]*theta;
figure(1), hold on
[c,h]=contour(aux1,aux2,reshape(Score, M,M), [0 0], 'g', 'Linewidth',2);
clabel(c,h);