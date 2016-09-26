function Ct = projpca(X, moy, P)
  D = size(X, 1);
  X = X - ones(D, 1) * moy; %on centre X
  Ct = X * P;
  