%% TP 8 – SVM linéaire
% Thibault Théologien
% Ingrid Fiquet

clear;
close all;
clc;

load('uspsasi.mat');
CSvm = 10;

[w, bSvm, alphaAll] = monsvmclass(x, y, CSvm);