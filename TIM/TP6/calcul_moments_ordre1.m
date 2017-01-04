%% TP6 TIM
% KILANI Riadh
% THEOLOGIEN Thibault

function M = calcul_moments_ordre1( P )
  moyenne = mean(P(:));
  variance = 0;
  skewness = 0;
  kurtosis = 0;
  
  for i=1:size(P,1)
    for j=1:size(P,2)
      variance = variance + (P(i,j) - moyenne).^2;
      skewness = skewness + (P(i,j) - moyenne).^3;
      kurtosis = kurtosis + (P(i,j) - moyenne).^4;
    end
  end  
  variance = variance / size(P,1);
  skewness = skewness / size(P,1);
  kurtosis = kurtosis / size(P,1);
  snr = moyenne / sqrt(variance);
  M = [moyenne variance skewness kurtosis snr];
end

