function [ valPresentes, occurences ] = histogramGris( A )
  valPresentes = unique(A);
  occurences = zeros(size(valPresentes));
  for i=1:length(occurences);
    occurences(i,1) = length(find(A == valPresentes(i, 1)));
  end
end

