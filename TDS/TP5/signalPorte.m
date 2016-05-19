function fx = signalPorte( vt, largeur, decalage )
    fx = zeros(size(vt));
    for i=1:length(fx)
       if vt(i) >= decalage - largeur/2 && vt(i) <= decalage + largeur/2
           fx(i) = 1;
       end
    end
end

