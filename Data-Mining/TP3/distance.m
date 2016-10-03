function D = distance( X )
  N = length(X);
  M = X*X';
  ps = diag(M);
  D = ps*ones(1,N) + ones(N,1)*ps' - 2*M;
  
%   Dbis = zeros(N, N);
%   Dbis2 = Dbis;
%   for i=1:N
%     for j=1:N
%       Dbis(i,j) = (X(i,:) - X(j,:)) * (X(i,:) - X(j, :))';
%       Dbis2(i,j) = (2*X(i,1)*X(i,2) - 2*X(j,1)*X(j,2))^2;
%     end
%   end
  

  for i=1:N
    D(i,i) = inf;
  end
  
end

