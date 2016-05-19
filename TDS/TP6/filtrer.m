function  Xf  = filtrer( Xf , freq )
    taille = length(Xf) ;
    for i=1:1:taille
        for j=1:1:taille
           if abs(Xf(i , j)) > freq
               Xf(i ,j) = 0 ;
           end
        end
    end 
end

