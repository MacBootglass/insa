function img = blackAndWhite( img, seuil )
    for i=1:length(img)
        for j=1:length(img)
            if img(i,j) > seuil
                img(i,j) = 255;
            else
                img(i,j) = 0;
            end
        end
    end
end

