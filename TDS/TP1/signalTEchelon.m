function signal = signalTEchelon(decalageT, decalageEchelon, tPositif, pas, interval)
    nbDonnes = (interval*2)/pas+1;
    signal = zeros(1,nbDonnes);
    t = -interval:pas:interval;
    if ~tPositif
       t = -t;
    end
    
    for i = 1:nbDonnes
        if t(i) < decalageEchelon
            signal(i) = 0;
        else
            signal(i) = t(i)-decalageT;
        end
    end
end