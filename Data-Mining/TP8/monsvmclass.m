function [ w, bSvm, alphaAll ] = monsvmclass( x, y, CSvm )
  K = x*x';
  N = size(K, 1);
  q = ones(N,1);
  Y = diag(y);
  H = Y*K*Y;
  verbose = 1;
  
  [alphaNew, bSvm, pos] = monqp(H, q, y, 0, CSvm*q, 1e-8, verbose);
  alphaAll = zeros(N, 1);
  alphaAll(pos) = alphaNew;

  for i=1:N
    w = alphaAll(i)*y(i)*x(i,:)';
  end
end