function [t,signal] = signalPorte(borneInf, pas, borneSup)
    if (borneSup < borneInf)
       tmp = borneInf;
       borneInf = borneSup;
       borneSup = tmp;
    end
    t = borneInf:pas:borneSup;
    nbDonnes = (abs(borneInf)+borneSup)/pas+1;
    signal = zeros(1,nbDonnes);
    T = 1;
    for i = 1:nbDonnes
       if -T/2 < t(i) && t(i) < T/2
          signal(i) = 1;
       else
          signal(i) = 0;
       end
    end
end