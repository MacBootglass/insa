%% TP6 TIM
% KILANI Riadh
% THEOLOGIEN Thibault

function M = creer_coocurrence( P, L )
  M = zeros(L, L);
  for k=1:L
    for l=1:L
      for i=1:size(P,1)
        for j=1:size(P,2)-1
          if P(i,j) == k && P(i,j+1) == l
            M(k,l) = M(k,l)+1;
          end
        end
      end
    end
  end
end

