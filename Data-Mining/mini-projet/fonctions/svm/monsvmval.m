function yPred = monsvmval( X, w, b )
  yPred = ones(length(X), 1);
  modele = X * w + b;
  yPred(modele < 0) = -1;
end

