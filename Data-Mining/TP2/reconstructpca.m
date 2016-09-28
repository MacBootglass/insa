function Xhat = reconstructpca(C, P, moy)
  D = size(C, 1);
  Xhat = C * P' + ones(D,1) * moy;
  
  
% La fonction permet de calculer X chapeau, la reconstruction de X
% connaissant C.