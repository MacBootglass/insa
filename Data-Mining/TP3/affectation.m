function [ clusters, Jw ] = affectation( X, C, K )
  N = size(X, 1);
  Jw = 0;
  clusters = zeros(N, 1);
  distance = zeros(K, 1);
  for i=1:N
    for k=1:K
      distance(k) = (norm(X(i, :) - C(k, :)))^2;
    end
    [val, indice] = min(distance);
    clusters(i) = indice;
    Jw = Jw + val;
  end
end

