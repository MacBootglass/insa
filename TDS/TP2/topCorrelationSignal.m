function indiceTop = topCorrelationSignal( signal, signalBalise)
    [res, lags] = xcorr(signal, signalBalise);
    [maxTop, indiceTop] = max(res);
    indiceTop = indiceTop - 2001;
end

