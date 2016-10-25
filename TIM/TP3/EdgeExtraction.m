function C = EdgeExtraction(I, methode, seuil)
  if strcmp(methode,'sobel') == 0 || strcmp(methode,'prewitt') == 0 || strcmp(methode,'laplacian') == 0 || strcmp(methode,'gaussian') == 0 
      filter = fspecial(methode);
      filterH = filter2(-filter', I);
      filterV = filter2(flipud(filter), I);
      C = sqrt(filterH.^2 + filterV.^2);
      C = ((C / max(max(C))) > seuil);
  else 
    C = I;
  end
end

