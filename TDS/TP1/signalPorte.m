function signal = signalPorte(T, decalage, pas, interval)
    t = -interval:pas:interval;
    nbDonnes = (interval*2)/pas+1;
    signal = zeros(1,nbDonnes);
    for i = 1:nbDonnes
       if -T/2 < t(i)-decalage && t(i)-decalage < T/2
          signal(i) = 1;
       else
          signal(i) = 0;
       end
    end
end