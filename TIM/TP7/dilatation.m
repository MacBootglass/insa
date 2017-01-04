function M = dilatation( img, elt )
Nimg = size(img,1);
M = zeros(size(img));
  for i=1:Nimg
    for j=1:Nimg
      pixel = img(i,j);
      for k=-1:1
        for l=-1:1
          if elt(k+2,l+2) == 1
            if i+k > 0 && i+k <= Nimg && j+l > 0 && j+l <= Nimg
              pixel = pixel | (img(i+k,j+l) & elt(k+2,l+2));
            end
          end
        end
      end
      M(i,j) = pixel;
    end
  end
end

