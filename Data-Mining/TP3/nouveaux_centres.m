function C = nouveaux_centres( X, clusters )
  clust_code = unique(clusters);
  K = length(clust_code);
  d = size(X, 2);
  C = zeros(K, d);
  for k=1:K
    index = find(clusters == clust_code(k));
    muk = mean(X(index, :));
    C(k, :) = muk;
  end
end

