function Ct = projpca(X, moy, P)
  D = size(X, 1);
  X = X - ones(D, 1) * moy; %on centre X
  Ct = X * P;
  
  
% La fonction permet de projeter une matrice de données X sur les d
% premiers vecteurs propres. 