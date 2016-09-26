function Xhat = reconstructpca(C, P, moy)
  D = size(C, 1);
  Xhat = C * P' + ones(D,1) * moy;