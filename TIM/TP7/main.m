%% TP6 TIM
% KILANI Riadh
% THEOLOGIEN Thibault


close all;
clear all;
clc;

%% MM avec Matlab
img = zeros(301,301);
img((301-63)/2:(301+63)/2, (301-63)/2:(301+63)/2) = 1;
elt = [0 1 0; 1 1 1; 0 1 0];

imgErosion = erosion(img, elt);
imgDilatation = dilatation(img, elt);

imgErosionFonction = imerode(img, elt);
imgDilatationFonction = imdilate(img, elt);

diffErosion = mean(mean(imgErosion - imgErosionFonction));
diffDilatation = mean(mean(imgDilatation - imgDilatationFonction));

elt15 = zeros(15,15);
elt15(7,:) = 1;
elt15(:,7) = 1;

imgEro15 = imerode(img, elt15);

ellipse = [ 0 1 0 ;
            1 0 1 ;
            0 1 0 ];
          
disk = [ 0 1 0 ;
         1 1 1 ;
         0 1 0 ];
          
croix = [ 1 0 1 ;
          0 1 0 ;
          1 0 1 ];

carre = [ 1 1 1 ;
          1 0 1 ;
          1 1 1 ];

imgErosionEllipse = imerode(img, ellipse);
imgErosionDisk = imerode(img, disk);
imgErosionCroix= imerode(img, croix);
imgErosionCarre = imerode(img, carre);


disp(getWhitePixels(img));
disp(getWhitePixels(imgErosion));
disp(getWhitePixels(imgDilatation));

disp(diffErosion);
disp(diffDilatation);

disp(getWhitePixels(imgEro15));

figure();
imagesc(img);
colormap(gray(2));

figure();
imagesc(imgErosion);
colormap(gray(2));

figure();
imagesc(imgDilatation);
colormap(gray(2));

figure();
imagesc(imgEro15);
colormap(gray(2));

figure();
imagesc(imgErosionEllipse);
colormap(gray(2));
disp(getWhitePixels(imgErosionEllipse));

figure();
imagesc(imgErosionDisk);
colormap(gray(2));

figure();
imagesc(imgErosionCroix);
colormap(gray(2));

figure();
imagesc(imgErosionCarre);
colormap(gray(2));
disp(getWhitePixels(imgErosionCarre));

%% Gradients Morphologiques avec Matlab


