function signal = signalExponentiel(a, tAbsolu, pas, interval)       %On admet que a puisse être négatif tandis que t restera toujours positif.
    nbDonnes = (interval*2)/pas+1;
    signal = zeros(1,nbDonnes);
    t = -interval:pas:interval;
    if tAbsolu
        t = abs(t);
    end
    signal = exp(a*t);
end

