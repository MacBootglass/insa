function ypred = reglogval( X, theta )
  ypred = zeros(length(X), 1);
  score = theta(1) + X*theta(2:end); 
  ypred(score > 0) = 1;
end

