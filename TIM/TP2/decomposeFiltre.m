function [ imgFiltre, fonctionne ] = decomposeFiltre( img, filtre )
  [U, S, V] = svds(filtre, 1);
  a = U*S;
  b = V;
  
  fonctionne = 0;
  imgFiltre = img;
  
  if isreal(a) && isreal(b)
   fonctionne = 1;
   imgStep1 = filter2(b', img);
   imgFiltre = filter2(a, imgStep1);
  end
end

