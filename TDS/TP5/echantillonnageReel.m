function fxE = echantillonnageReel(fx, fe, pas, dt)
    Te = 1/fe;
    c = round(dt/pas);
    bloq_moy = conv(fx, ones(1,c), 'same')/c;
    idx = 1:round(Te/pas):length(fx);
    fxE = zeros(size(fx));
    fxE(idx) = bloq_moy(idx);   
    % fxE = conv(fx, signalPorte(vt, deltaT, 0));
end

