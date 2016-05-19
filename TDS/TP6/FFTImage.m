%DISCLAIMER
%!!! THIS IS JUST MY IMPLEMENTATION. THEREFORE IT IS JUST ONE POSSIBLE SOLUTION
%!!! IT IS FOR YOU TO UNDERSTAND AND IMPLEMENT YOUR OWN WAY

close all;
clear all;

img = imread('lena_gray.tif');

imshow(img,[]);
frequencyImage = fftshift(fft2(img));
amplitudeImage = log(abs(frequencyImage));
minValue = min(min(amplitudeImage))
maxValue = max(max(amplitudeImage))

figure(2);
amplitudeThreshold = 10.7;
brightSpikes = amplitudeImage > amplitudeThreshold; % Binary image.
imshow(brightSpikes,[]);
axis on;

figure(3);
% Filter/mask the spectrum.
frequencyImage(brightSpikes) = 0;
% Take log magnitude so we can see it better in the display.
amplitudeImage2 = log(abs(frequencyImage));
minValue = min(min(amplitudeImage2));
maxValue = max(max(amplitudeImage2));
imshow(amplitudeImage2, [minValue maxValue]);
axis on;

figure(4);
filteredImage = ifft2(fftshift(frequencyImage));
amplitudeImage3 = abs(filteredImage);
minValue = min(min(amplitudeImage3));
maxValue = max(max(amplitudeImage3));
imshow(amplitudeImage3, [minValue maxValue]);

msgbox('Did you implemented yourself or just copy/paste?');
sound(randn(409600, 1), 8192)

figure(5)

ed = edge(img,'sobel');
imshow(ed);