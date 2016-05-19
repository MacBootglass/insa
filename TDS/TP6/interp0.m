function sigSortie = interp0(sigEntree, feEntree, feSortie )
  dureeVal = fix(feSortie / feEntree);
  sigSortie = zeros(length(sigEntree) * dureeVal,1);
  
  for i=1:length(sigEntree)
      for j=1:fix(dureeVal)
          sigSortie((i-1) * dureeVal + j) = sigEntree(i);
      end
  end
end

