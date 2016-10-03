clear;
close all;
addpath('images');

%% 1)

img = imread('lena_gray.tif');


imagesc(img);
colormap('gray');

pixel50_100 = img(50, 100);

figure(2)
imgQuart = img(1:(round(length(img)/2)), 1:(round(length(img)/2)));
imagesc(imgQuart);
colormap('gray');

%% 2)

N = 256;
for i=1:N
  for j=1:N
    I(i, j) = j;
  end
end

figure(3)
image(I);

figure(4)
imagesc(I);

% image n'utilise que les 64 couleurs de matlab et se retrouve "bloqué" sur
% la couleur jaune pour des valeurs > 64
% imagesc va adapter l'image pour donner l'illusion d'avoir plus de
% couleurs (bien que matlab utilise ENCORE 64 couleurs)

figure(5)
imagesc(I);
%colormap('gray');

paletteGray = colormap('gray');
figure(6)
imagesc(paletteGray);

% construction de notre palette et d'une palette avec niveau de gris
maPalette = rand(256, 3);
maPaletteGray = gray(256);

figure(7)
imagesc(I);
colormap(maPalette);

figure(8)
imagesc(I);
colormap(maPaletteGray);
% contrairement à la figure 6, on oberseve un dégradé de couleur sans
% bande, parce que la palette 'gray' standard est un dégradé de 64 couleurs
% alors que maPaletteGray en contient 256

% la figure 7 est juste une succession incohérente de bandes colorées
% puisque la palette est composé de couleurs aléatoires

maPaletteGrayInv = flipud(maPaletteGray);

figure(9)
imagesc(I);
colormap(maPaletteGrayInv);
% on osbserve bien un dégradé dans l'ordre inverse

% CONCLUSION : image et imagesc generent par défaut des images en 64
% couleurs (sur chaque composante rgb)
% colormap permet "d'indiquer" que l'image est en niveau de gris (on a
% qu'une seule composante de niveau de gris allant de 0 à 255 alors que
% les trois composantes RGB sont necessaires)
% Par défaut le paramètre 'gray' de colormap utilise une matrice 64x3 alors
% alors que nous desirons une matrice 256x3, d'ou l'utilisation de
% gray(256)


%% 3)

% pour convertir une image, on utilise la fonction im2double();

lenaColor = imread('lena_color.tif');
lenaColorDouble = im2double(lenaColor);
figure(10)
imagesc(lenaColorDouble);

lenaColorDoubleRed = lenaColorDouble(:, :, 1);
figure(11)
imagesc(lenaColorDoubleRed);
paletteRouge = [maPaletteGray(:, 1) zeros(256, 2)];
colormap(paletteRouge);

lenaColorDoubleGreen = lenaColorDouble(:, :, 2);
figure(12)
imagesc(lenaColorDoubleGreen);
paletteVerte = [zeros(256, 1) maPaletteGray(:, 1) zeros(256, 1)];
colormap(paletteVerte);


lenaColorDoubleBlue = lenaColorDouble(:, :, 3);
figure(13)
imagesc(lenaColorDoubleBlue);
paletteBleu = [zeros(256, 2) maPaletteGray(:, 1)];
colormap(paletteBleu);

lena2gray = rgb2gray(lenaColorDouble);

figure(14)
subplot(1, 2, 1);
imagesc(lena2gray);
colormap(maPaletteGray);

subplot(1, 2, 2);
alpha = 0.2989;
beta = 0.5870;
gamma = 0.1140;
I_gray = alpha * lenaColorDoubleRed + beta*lenaColorDoubleGreen + gamma*lenaColorDoubleBlue;
imagesc(I_gray);
colormap(maPaletteGray);

diff = lena2gray - I_gray;
m = mean(diff);
m2 = mean(m);

% visuellement, on ne remarque pas de différences entre les deux images
% mathématiquement, la moyenne des différences entre chaque matrice est
% infime


%% 4)
clear;
close all;

imgRice = imread('images/rice.tif');

[valPresRice, occurRice] = histogramGris(imgRice);

figure()
subplot(1,2,1);
stem(valPresRice, occurRice, '.');

subplot(1,2,2);
imhist(imgRice);
axis([0 255 0 4500]);

% les résultats semblent identiques.  

% Sur l'histogramme on observe un pic aux alentours de 100. Cela suggère
% une predominance de cette nuance de gris. De plus, il n'y a pas de pixels
% ayant une nuance de gris inférieure à 50 ou supérieure à 200
% on peut donc déterminer une plage de nuance de gris

imgLena = imread('images/lena_gray.tif');

[valPresLena, occurLena] = histogramGris(imgLena);

figure()
subplot(1,2,1);
stem(valPresLena, occurLena, '.');

subplot(1,2,2);
imhist(imgLena);
axis([0 255 0 7500]);



imgCamMan = imread('images/cameraman.tif');
[valPresCamMan, occurCamMan] = histogramGris(imgCamMan);

figure()
subplot(1,2,1);
stem(valPresCamMan, occurCamMan, '.');

subplot(1,2,2);
imhist(imgCamMan);
axis([0 255 0 2000]);

% ces deux images ont toutes les nuance de gris
% On observe sur l'histogramme de l'image Lena deux groupes majeurs de
% nuance : un vers 0/20 et l'autre entre 150 et 200. L'image est bien
% contrastée

% improfile(imgLena);
figure()
imagesc(imgLena);
improfile;

%% 5)
clear;
close all;
%imgLena = (512, 512, 8);
imgLena(: , :, 1) = imread('images/lena_gray.tif');

figure()
subplot(2,4,1);
imshow(imgLena(: , :, 1));


for i=2:8
  imgLena(: , :, i) = imgLena(: , :, 1)./2^(i-1);
  subplot(2,4,i);
  imshow(imgLena(: , :, i), [0 256/2^(i-1)]);
end

figure()
for i=1:8
  subplot(2,4,i);
  imhist(imgLena(: , :, i));

end

imgCam = imread('/images/cameleon.tif');



figure()
subplot(2,4,1);
imshow(imgCam (: , :, 1));


for i=2:8
  imgCam(: , :, i) = imgCam (: , :, 1)./2^(i-1);
  subplot(2,4,i);
  imshow(imgCam (: , :, i), [0 256/2^(i-1)]);
end

figure()
for i=1:8
  subplot(2,4,i);
  imhist(imgCam (: , :, i));

end


%% 6)

img = imread('/images/mire.bmp');
