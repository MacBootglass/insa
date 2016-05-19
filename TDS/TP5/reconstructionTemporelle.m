function fx = reconstructionTemporelle( fxe, fe, pas )
    c = round((1/fe)/pas);
    fx = conv(fxe, ones(1,c), 'same');
end

