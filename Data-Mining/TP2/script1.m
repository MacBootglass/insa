clear;
close all;


%% Exercice 2

load('data_iris_usps_asi/uspsasi.mat');

indices = find(y==3);
xChif = x(indices, :);

d = 2;

[valprop, U, moy] = mypca(xChif);
p = U(:,1:d);
C = projpca(xChif, moy, p);

figure(1)
plot(C(:,1), C(:,2), 'r.');
title('Projection en 2D par ACP');
xlabel('Composante principale 1');
ylabel('Composante principale 2');

xhat = reconstructpca(C, p, moy);

figure(2)
subplot(1,2,1);
image(reshape(xhat(1,:), 16, 16)' * 100);
title('Image reconstituée');
colormap('gray');
subplot(1,2,2);
imagesc(reshape(xChif(1,:), 16, 16)' * 100);
title('Image originelle');
colormap('gray');
