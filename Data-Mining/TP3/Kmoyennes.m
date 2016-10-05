function [C, clusters, JwIter] = Kmoyennes(X, K, C0, MaxIter)
  C = C0;
  JwIter = zeros(MaxIter, 1);
  for i=1:MaxIter
    [clusters, Jw] = affectation(X, C, K);
    JwIter(i) = Jw;
    C = nouveaux_centres(X, clusters);
  end
end

