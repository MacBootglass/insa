function fx = createFunction(vt, f0)
    fx = zeros(size(vt));
    for i=1:length(vt)
        fx(i) = sin(pi * f0 * vt(i)) / (pi * vt(i));
    end
    fx(int16(4001/2)) = f0;
end
