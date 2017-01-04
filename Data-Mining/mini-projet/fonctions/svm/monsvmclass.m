function [ w, bSvm, alphaAll ] = monsvmclass( x, y, CSvm )
  K = x*x';
  N = size(K, 1);
  q = ones(N, 1);
  Y = diag(y);
  H = Y*K*Y;
  verbose = 0;
  
  % De manière empirique, nous sommes arrivé à la constatation que monqp ne
  % fonctionne qu'avec lambda valant 10. Pourquoi ? Aucune idée ...
  [alphaNew, bSvm, pos] = monqp(H, q, y, 0, CSvm*q, 10, verbose);
  alphaAll = zeros(N, 1);
  alphaAll(pos) = alphaNew;
  
  w = 0;
  for i=1:N
    w = w + alphaAll(i) * y(i) * x(i,:)';
  end
end