function fxEch = echantillonnageIdeal( fx, pas, vt)
    hx = zeros(size(fx));
    for i=1:length(vt)
        if mod(i-1, pas) == 0
            hx(i) = 1;
        end
    end
    fxEch = hx .* fx;
end

