function imgEch = echantillonageImage( img, facteur )
  imgEch = uint8(ones(int16(size(img)/facteur)));
  
  for i=1:size(imgEch,1)
    for j=1:size(imgEch,2)
      imgEch(i,j) = img((i-1)*facteur+1, (j-1)*facteur+1);
    end
  end
end

