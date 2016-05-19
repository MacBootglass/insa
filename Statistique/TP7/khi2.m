function Z = khi2( echantillon, mu, sigma )
  Z = sum(((echantillon - mu) * (1/sigma)).^2);
end

