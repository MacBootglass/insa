%% TP 5 
% Thibault Théologien

clear;
close all;
clc;

addpath('../images');
lena = double(imread('lena_gray.tif'));
Seuil = median(lena(:));
Variance = var(lena(:));



img = Split_Merge(lena,Seuil, 0.1);
disp(mean(mean(lena - img)));

figure(1);
imagesc(img);
colormap(gray(256));