function [ y_pred ] = SVM3Val(Xtest,Xi,alpha,pos,b,kernel, kerneloption);
  [n,p] = size(Xi);
  ni = n/3;
  n23 = 2*ni;

  al = zeros(2*n,1);
  al(pos) = alpha;
  al12 = al(1:n/3);
  al13 = al(n/3+1:n23);
  al21 = al(n23+1:n23+n/3);
  al23 = al(n23+n/3+1:2*n23);
  al31 = al(2*n23+1:2*n23+n/3);
  al32 = al(2*n23+n/3+1:end);

  K = svmkernel(Xtest,kernel,kerneloption,Xi);

  K1 = K(:,1:n/3);
  K2 = K(:,n/3+1:n23);
  K3 = K(:,n23+1:end);
  % w1 = X1 + X1 - x2 - X3
  ypred1 = K1*al12 + K1*al13 - K2*al21 - K3*al31 + b(1);
  ypred2 = K2*al21 + K2*al23 - K1*al12 - K3*al32 + b(2);
  ypred3 = K3*al31 + K3*al32 - K1*al13 - K2*al23 + b(3);
  [v y_pred] = max([ypred1 , ypred2 , ypred3]');
end

