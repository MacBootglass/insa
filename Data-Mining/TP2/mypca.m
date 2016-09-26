function [valprop, U, moy] = mypca(X)
  D = size(X, 1);
  moy = mean(X);
  X = X - ones(D, 1) * moy; %on centre X
  
  cov = (X'*X) / D;
  [U, valprop] = eig(cov); 
  
  % * valprop est une matrice dont les valprop sont sur la diagonale ->
  % utilisation de diag()
  % * sort() trie par défaut par ordre croissant, or nous voulons un tri
  % décroissant. On inverse donc les signes du vecteur.
  [valprop, ind] = sort(-diag(valprop)); 
  valprop = -valprop;
  U = U(:, ind);