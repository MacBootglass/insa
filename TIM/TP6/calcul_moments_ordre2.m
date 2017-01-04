%% TP6 TIM
% KILANI Riadh
% THEOLOGIEN Thibault

function M = calcul_moments_ordre2( Coo )
  moyenne = mean(Coo(:));
  variance = 0;
  contraste = 0;
  correlation = 0;
  entropie = 0;
  homogeneite = 0;
  N = size(Coo,1);
  L = max(Coo(:));
  mx = mean(Coo);
  my = mean(Coo,2);
  ox = var(Coo);
  oy = var(Coo');
  
  for i=1:N
    for j=1:N
      variance = variance + (Coo(i,j) - moyenne).^2;
      homogeneite = homogeneite + Coo(i,j)^2;
      if Coo(i,j) ~= 0
        entropie = entropie + Coo(i,j) * log(Coo(i,j));
      end
      correlation = correlation + abs((i-mx) * (j-my) * Coo(i,j));
    end
  end
  
  %% finir calcul contraste -> A quoi correspond l'indice k dans la formule du cours ?
  
  variance = variance / N;
  homogeneite = homogeneite / N^2;
  contraste = contraste / (N * (L-1)^2);
  entropie = 1 - entropie / (N * log(N));
  correlation = correlation / (N * sqrt(ox) * sqrt(oy'));
  
  M = [moyenne variance contraste correlation entropie homogeneite];
end

