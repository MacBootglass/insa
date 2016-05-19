sigImg = imread('lena_gray.tif');
sigImgTF = fft2(sigImg);

newImgTF = filtrer(fftshift(sigImgTF), 35000);
newImg = ifft2(fftshift(newImgTF));

figure(1);
imshow(blackAndWhite(newImg,17), []);
figure(2);
edg
