function [alpha,pos,b] = SVM3Class( Xi,yi,C,kernel,kerneloption)
  %kernel ='gaussian';
  %kerneloption = .25;
  [n p] = size(Xi);
  ni = n/3;
  e = ones(2*n,1);
  A = [1 1 -1 0 -1 0 ; -1 0 1 1 0 -1];
  A = kron(A,ones(1,ni));
  l = 10^-4;

  K = svmkernel(Xi,kernel,kerneloption); % kernel matrix
  M = [1 -1 0; 1 0 -1 ; -1 1 0 ; 0 1 -1; -1 0 1; 0 -1 1];
  MM = M*M';
  MM = kron(MM,ones(ni));
  Un23 = [1 0 0;1 0 0 ; 0 1 0 ; 0 1 0; 0 0 1 ; 0 0 1];
  Un23 = kron(Un23,eye(ni));
  G = MM.*(Un23*K*Un23');

  tic
  [alpha, b, pos] = monqp(G,e,A',[0;0],inf,100*l,0);
  t5 = toc;

  n23 = 2*ni;
  yp = G(:,pos)*alpha;
  b1 = 1 - yp(pos(1));
  p2 = (find((pos > n23)&(pos<=2*n23)));
  b2 = 1 - yp(pos(p2(1)));
  b3 = 1 - yp(pos(end));

  b = [b1;b2;b3];
end

