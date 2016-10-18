function X = toit(N)
  if (mod(N,2) ~= 0)
    N = N+1;
  end
  ech = echellon(N);
  tmp = conv(ech, ech);
  X = [ tmp(N/2+1:N*2-1) tmp(1:N/2)];
end

